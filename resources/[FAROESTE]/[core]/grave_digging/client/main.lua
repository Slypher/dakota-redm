Proxy = module('_core', 'lib/Proxy')

HandheldShovelItem = Proxy.getInterface('HandheldShovelItem')
GroundDigging = Proxy.getInterface('GroundDigging')

ENABLED_DEBUG = false
SITE_INTERACTION_MAX_DISTANCE = 1.0
MAX_DIG_POINT_DETECTION_RANGE = 10.0

gClusterVolumes = { }

gIsMainThreadRunning = false
gOnMainThreadStop = nil

gClusterSitesState = { }

gCurrentCluster = nil
gActiveSite = nil

gEnableScript = false

function getSiteFromPlayerPosition()
	local playerPed = PlayerPedId()
	local playerPos = GetEntityCoords(playerPed)

	local collidingSite

	local collidingVolumeDistance

	for site, volume in ipairs(gClusterVolumes) do
		local volumeCenter, volumeRadius = volume[1], volume[2]

		local distanceToVolume = #(playerPos - volumeCenter)

		if distanceToVolume <= volumeRadius and (collidingVolumeDistance == nil or distanceToVolume < collidingVolumeDistance) then
			collidingSite = site

			collidingVolumeDistance = distanceToVolume
		end
	end

	return collidingSite
end

function ensureMainThread()
	if gIsMainThreadRunning then
		return
	end

	CreateThread(function()

		gIsMainThreadRunning = true

		local playerPed = PlayerPedId()

		local activeDiggingPointPos

		local upVector = vec3(0.0, 0.0, 5.0)

		local interactableSite
		local noInteractableSiteThisFrame = false

		local promptDig
		local promptDigReenableAt

		GroundDigging.setEnabled(false)

		local onDigPromptIsPressedHandler = AddEventHandler('onHandheldShovelItemDigPromptIsPressed', function()
			if not interactableSite then
				return
			end

			-- Desabilitar o prompt por X segundos...
			HandheldShovelItem.setDigPromptEnabled(false)

			promptDigReenableAt = GetGameTimer() + 500

			-- Already playing the scene.
			if gActiveSite then
				return
			end

			local cluster = gCurrentCluster
			local site = interactableSite

			local knownState = getClusterSiteState(site)

			-- A cova não possui nenhum estado ou está em estado de cooldown, então o player pode fazer um request
			-- para começar a animação...
			if not knownState or (knownState and (knownState <= eDiggingSitePointState.INVALID or knownState == eDiggingSitePointState.EMPTY)) then
				requestInitDigging(cluster, site)
			end
		end)

		gOnMainThreadStop = function()
			gIsMainThreadRunning = false

			GroundDigging.setEnabled(true)

			RemoveEventHandler(onDigPromptIsPressedHandler)

			gOnMainThreadStop = nil
		end

		while gCurrentCluster and gIsMainThreadRunning and gEnableScript do

			-- Debug, pode remover:
			if ENABLED_DEBUG then
				for digPoint, sitePos in ipairs(DIGGING_CLUSTERS[gCurrentCluster].sites) do
					Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, sitePos, sitePos + upVector, 0, 255, 0, 255)
				end
			end

			if GetFrameCount() % 30 == 0 then

				-- Atualizar a ped de vez em quando :P
				playerPed = PlayerPedId()

				local playerPos = GetEntityCoords(playerPed)

				-- Zerar o interágivel nesse frame, será re-setado caso necessário...
				interactableSite = nil
				noInteractableSiteThisFrame = true

				-- Distancia máxima para verificar a distancia do ponto.
				local lowestinteractableSiteDistance = SITE_INTERACTION_MAX_DISTANCE

				-- Pegar o ponto mais próximo nesse cluster...
				for site, sitePos in ipairs(DIGGING_CLUSTERS[gCurrentCluster].sites) do
					local distance = #(playerPos - sitePos)

					if distance < lowestinteractableSiteDistance then
						lowestinteractableSiteDistance = distance

						interactableSite = site
						noInteractableSiteThisFrame = false
					end
				end

				local enableDigPrompt = true

				local knownState = getClusterSiteState(interactableSite)

				if knownState and (knownState > eDiggingSitePointState.INVALID and knownState < eDiggingSitePointState.EMPTY) then
					enableDigPrompt = false
				end

				if promptDigReenableAt then
					enableDigPrompt = false

					if GetGameTimer() >= promptDigReenableAt then
						promptDigReenableAt = nil
					end
				end

				if not interactableSite then
					enableDigPrompt = false
				end

				HandheldShovelItem.setDigPromptEnabled(enableDigPrompt)

				HandheldShovelItem.setCancelPromptEnabled(gActiveSite == nil)

				noInteractableSiteThisFrame = false
			end

			Wait(0)
		end

		gOnMainThreadStop()
	end)
end

function computePlayerHeadingForSite(sitePos)
	-- Um pouquinho abaixo do ponto de cavar,
	-- assumindo que os pontos são pegos a partir do meio do ped do player.
	local rayStartPos = sitePos + vec3(0.0, 0.0, -0.40)
	
	local rayLenght = 4.0

	local playerPed = PlayerPedId()

	local cX, cY, cZ = rayStartPos.x, rayStartPos.y, rayStartPos.z

	local debugHitIdx

	for idx = 0, 360, 20.0 do
		i = math.rad(idx)

		local X_deg0 = cX + (rayLenght * math.cos(i))
		local Y_deg0 = cY + (rayLenght * math.sin(i))

		local rayEndPos = vec3(X_deg0, Y_deg0, cZ)

		-- -1
		-- 3167
		-- 339

		-- StartExpensiveSynchronousShapeTestLosProbe
		-- local rayHandle = Citizen.InvokeNative(0x377906D8A31E5586, rayStartPos, rayEndPos, -1, playerPed, 7)

		local rayHandle = StartShapeTestSweptSphere(rayStartPos, rayEndPos, 0.2, -1, playerPed, 8)

		local retval, hit, endCoords, surfaceNormal, entityHit

		while true do
			retval, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

			Wait(0)

			if retval ~= 1 then
				break
			end
		end

		-- print(retval, hit, endCoords, surfaceNormal, entityHit)

		if hit == 1 then
			local distanceToStart = #(rayStartPos - endCoords)

			if not lowestDistanceToStart or distanceToStart < lowestDistanceToStart then
				lowestDistanceToStart = distanceToStart
				closestHitPos = endCoords

				if ENABLED_DEBUG then
					debugHitIdx = idx
				end
			end
		end
	end

	if ENABLED_DEBUG then
		CreateThread(function()
			while true do
				Wait(0)
				for idx = 0, 360, 20.0 do
					i = math.rad(idx)
			
					local X_deg0 = cX + (rayLenght * math.cos(i))
					local Y_deg0 = cY + (rayLenght * math.sin(i))
			
					local circlePoint = vec3(X_deg0, Y_deg0, cZ)
			
					Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, rayStartPos, circlePoint, idx == debugHitIdx and 255 or 0, 0, 0, 255)
				end
			end
		end)
	end

	if not closestHitPos then
		return nil
	end

	local playerPos = GetEntityCoords(playerPed)

	local dX = closestHitPos.x - playerPos.x
	local dY = closestHitPos.y - playerPos.y

	return GetHeadingFromVector_2d(dX, dY)
end

function updateMetalDetectorBlackboardBasedOnDistance(distance)
	local detectionValue = ( (MAX_DIG_POINT_DETECTION_RANGE - distance) / MAX_DIG_POINT_DETECTION_RANGE )

	-- Range between 0.0 - 1.0
	detectionValue = math.min(detectionValue, 1.0)
	detectionValue = math.max(detectionValue, 0.0)

	-- SetPedBlackboardFloat
	Citizen.InvokeNative(0x437C08DB4FEBE2BD, playerPed, 'MetalDetectorDistanceToDigSite', MAX_DIG_POINT_DETECTION_RANGE, 10)

	-- SetPedBlackboardFloat
	Citizen.InvokeNative(0x437C08DB4FEBE2BD, playerPed, 'MetalDetectorDetectionValue', detectionValue, 10)
end

function onPlayerEnterDiggingSite(site)
	TriggerServerEvent('net.playerEnterDiggingSite', site)

	ensureMainThread()
end

function onPlayerLeaveDiggingSite(site)
	TriggerServerEvent('net.playerLeaveDiggingSite', site)

	gClusterSitesState = { }
end

function init()
	gEnableScript = true

	createDiggingSiteVolumes()

	while gEnableScript do
		Wait(1000)

		local collidingSite = getSiteFromPlayerPosition()

		if gCurrentCluster ~= collidingSite then

			if gCurrentCluster == nil then
				onPlayerEnterDiggingSite(collidingSite)
			else
				onPlayerLeaveDiggingSite(gCurrentCluster)
			end

			gCurrentCluster = collidingSite
		end
	end
end

-- Quando o script iniciar, verificar se
-- o player está segurando uma pá, e assim iniciar o script.
CreateThread(function()
	if HandheldShovelItem.isActive() then
		init()
	end
end)

function createPromptDig()
	local prompt = Citizen.InvokeNative(0x04F97DE45A519419)

	PromptSetControlAction(prompt, 0x7F8D09B8)
	PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', 'Cavar'))

	PromptSetEnabled(prompt, true)
	PromptSetVisible(prompt, true)
	
	-- PromptSetHoldMode(prompt, true)
	PromptSetStandardMode(prompt, true)

	PromptSetGroup(prompt, TreeGroup)

	PromptRegisterEnd(prompt)

	return prompt
end

function getClusterSiteState(site)
    return gClusterSitesState[site]
end

RegisterNetEvent('net.setSitesStateForCurrentCluster', function(sitesStateMap)
	gClusterSitesState = sitesStateMap
end)

AddEventHandler('onInitHandheldShovelItem', function()
	init()
end)

AddEventHandler('onStopHandheldShovelItem', function()
	gEnableScript = false
end)

RegisterNetEvent('net.digSiteStateUpdateAck', function(digCluster, digSite, digSiteState)
	if gCurrentCluster ~= digCluster then
		return
	end

	gClusterSitesState[digSite] = digSiteState

	if digSiteState == eDiggingSitePointState.EMPTY then
		gActiveSite = nil
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if gOnMainThreadStop then
			gOnMainThreadStop()
		end
	end
end)