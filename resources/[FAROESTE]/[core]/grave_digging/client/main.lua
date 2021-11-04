gClusterVolumes = { }

gIsMainThreadRunning = false
gOnMainThreadStop = nil

MAX_DIG_POINT_DETECTION_RANGE = 10.0

gClusterSitesState = { }

gCurrentCluster = nil
gActiveSite = nil

ENABLED_DEBUG = false

SITE_INTERACTION_MAX_DISTANCE = 0.8

function getSiteFromPlayerPosition()
	local playerPed = PlayerPedId()
	local playerPos = GetEntityCoords(playerPed)

	local collidingSite

	local collidingVolumeDistance

	for diggingSiteIndex, volume in ipairs(gClusterVolumes) do
		local volumeCenter, volumeRadius = volume[1], volume[2]

		local distanceToVolume = #(playerPos - volumeCenter)

		if distanceToVolume <= volumeRadius and (collidingVolumeDistance == nil or distanceToVolume < collidingVolumeDistance) then
			collidingSite = diggingSiteIndex

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

		local promptDig
		local promptDigReenableAt

		gOnMainThreadStop = function()
			gIsMainThreadRunning = false
	
			if promptDig then
				PromptDelete(promptDig)
				promptDig = nil
			end

			gOnMainThreadStop = nil
		end

		while gCurrentCluster and gIsMainThreadRunning do

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

				-- Distancia máxima para verificar a distancia do ponto.
				local lowestinteractableSiteDistance = SITE_INTERACTION_MAX_DISTANCE

				-- Pegar o ponto mais próximo nesse cluster...
				for site, sitePos in ipairs(DIGGING_CLUSTERS[gCurrentCluster].sites) do
					local distance = #(playerPos - sitePos)

					if distance < lowestinteractableSiteDistance then
						lowestinteractableSiteDistance = distance

						interactableSite = site
					end
				end

				if interactableSite and not gActiveSite then
					-- O prompt vai ser usado, criar caso não exista.
					if not promptDig then
						promptDig = createPromptDig()
					end

					local knownState = getClusterSiteState(interactableSite)

					local shouldPromptBeDisabled = (knownState and (knownState > eDiggingSitePointState.INVALID and knownState < eDiggingSitePointState.EMPTY))
						or IsPedRagdoll(playerPed)

					-- A cova tem um estado, está em progresso, desabilitar o prompt
					PromptSetEnabled(promptDig, not shouldPromptBeDisabled)
				else
					-- O prompt não vai ser mais usado, então vai ser deletado.
					if promptDig then
						PromptDelete(promptDig)
						promptDig = nil
					end
				end
			end

			if interactableSite then

				-- Reabilitar o prompt caso tenha sido desabilitado
				-- na ultima vez que foi pressionado.
				if promptDigReenableAt and GetGameTimer() >= promptDigReenableAt then
					PromptSetEnabled(promptDig, true)

					promptDigReenableAt = nil
				end

				if PromptIsJustPressed(promptDig) then

					-- Desabilitar o prompt por X segundos...
					PromptSetEnabled(promptDig, false)
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
				end
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

function onPlayerEnterDiggingSite(diggingSiteIndex)
	TriggerServerEvent('net.playerEnterDiggingSite', diggingSiteIndex)

	ensureMainThread()
end

function onPlayerLeaveDiggingSite(diggingSiteIndex)
	TriggerServerEvent('net.playerLeaveDiggingSite', diggingSiteIndex)

	gClusterSitesState = { }
end

CreateThread(function()
	createDiggingSiteVolumes()

	while true do
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
end)

function createPromptDig()
	prompt = Citizen.InvokeNative(0x04F97DE45A519419)

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

--[[
RegisterCommand(
	"dig",
	function(source, args, rawCommand)
		local chestModelHash = GetHashKey("P_TRUNK02X")
		chestModelHash = GetHashKey("P_STRONGBOX_MUDDY_01X")
		local lootModelHash = GetHashKey("p_cs_ropehandssplit_sml_2")
		local dressingModelHash = GetHashKey("MP005_P_DRESSINGLBMHAY04X")
		local moundModelHash = GetHashKey("MP005_P_DIRTPILE_BIG01_BURIED")

		RequestModel(chestModelHash)
		RequestModel(lootModelHash)
		RequestModel(dressingModelHash)
		RequestModel(moundModelHash)

		while not HasModelLoaded(dressingModelHash) or not HasModelLoaded(lootModelHash) or not HasModelLoaded(chestModelHash) or not HasModelLoaded(moundModelHash) do
			Wait(0)
		end

		local ped = PlayerPedId()

		local pedPosition = GetOffsetFromEntityInWorldCoords(ped, 2.0, 0.0, 0.0)

		local _, groundZ, normal = GetGroundZAndNormalFor_3dCoord(pedPosition.x, pedPosition.y, pedPosition.z)
		pedPosition = vec3(pedPosition.xy, groundZ - 0.05)

		local chest = CreateObjectNoOffset(chestModelHash, pedPosition + vec3(0.0, 0.0, -1.5), true, true, false, true) -- + vec3(-10.0, 0.0, 0.0)
		-- local loot = CreateObjectNoOffset(lootModelHash, pedPosition, false, true, false, true) -- + vec3(-15.0, 0.0, 0.0)
		-- local dressing = CreateObjectNoOffset(dressingModelHash, pedPosition, true, true, false, true) -- + vec3(-20.0, 0.0, 0.0)
		-- local mound = CreateObjectNoOffset(moundModelHash, pedPosition, true, true, false, true) -- + vec3(-10.0, 0.0, 0.0)

		-- local animscene = CreateAnimScene("script@mech@treasure_hunting@chest", 64, "PBL_CHEST_01", true, true)
		local animscene = CreateAnimScene("script@mech@treasure_hunting@grab", 64, "PBL_GRAB_01", true, true)

		LoadAnimScene(animscene)

		while not Citizen.InvokeNative(0x477122B8D05E7968, animscene) do
			print('still loadingg')

			Wait(0)
		end

		SetAnimSceneOrigin(animscene, pedPosition, 0.0, 0.0, 0.0, 2)

		SetAnimSceneEntity(animscene, "player", ped, 0)
		-- SetAnimSceneEntity(animscene, "LOOT", loot, 0)
		-- SetAnimSceneEntity(animscene, "MOUND", mound, 0)

		-- SetAnimSceneEntity(animscene, "CHEST", chest, 0)
		-- SetAnimSceneEntity(animscene, "DRESSING", dressing, 0)

		-- StartAnimScene(animscene)

		-- Wait(2000)

		-- Citizen.InvokeNative(0x8245C1F3262F4AC2, animscene)

		-- TaskEnterAnimScene(ped, animscene, "player", "PBL_CHEST_01", 1069379748, 1, 128, 20000, -1082130432)
		TaskEnterAnimScene(ped, animscene, "player", "PBL_GRAB_01", 1.48, 1, 128, 20000, -1.0)

		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(0)
				-- local AnimTime = Citizen.InvokeNative(0x61BE7D6186260002, animscene, Citizen.ResultAsFloat())
				-- local hasEnded = Citizen.InvokeNative(0xD8254CB2C586412B, animscene, 0)

				-- if AnimTime >= 5 then
				-- 	ClearPedTasks(ped)
				-- 	ClearPedSecondaryTask(ped)
				-- 	SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
				--	Citizen.InvokeNative(0xD6824B7D24DC0CE0 , animscene, 1)
				-- end

				print("abc", Citizen.InvokeNative(0xE5822422197BBBA3, animscene, "player", 1))

				-- if hasEnded == 1 then
				-- 	Citizen.InvokeNative(0x188F8071F244B9B8, chest, 1) -- SET_RANSACK_AS_OPEN

				-- 	SetEntityAsNoLongerNeeded(chest)
				-- 	SetEntityAsNoLongerNeeded(dressing)
				-- 	SetEntityAsNoLongerNeeded(mound)

				-- 	DeleteEntity(loot)

				-- 	cAPI.notify("item", "gold", 20)

				-- 	break
				-- end
			end
		end)
	end
)
]]

-- CreateThread(function()
--     Wait(2000)
--     print('convar', GetConvar('teste', 'alo'))
-- end)A

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