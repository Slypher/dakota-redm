gDiggingSiteVolumeCenterAndRadius = { }
gCurrentDigCluster = nil

gIsMainThreadRunning = false
gOnMainThreadStop = nil

MAX_DIG_POINT_DETECTION_RANGE = 10.0

gCurrentDigClusterSitesState = { }

gActiveDigSite = nil

function getDiggingSiteIndexCollidingWithPlayer()
	local playerPed = PlayerPedId()
	local playerPos = GetEntityCoords(playerPed)

	local collidingSiteIndex

	local collidingVolumeDistance

	for diggingSiteIndex, volume in ipairs(gDiggingSiteVolumeCenterAndRadius) do
		local volumeCenter, volumeRadius = volume[1], volume[2]

		local distanceToVolume = #(playerPos - volumeCenter)

		if distanceToVolume <= volumeRadius and (collidingVolumeDistance == nil or distanceToVolume < collidingVolumeDistance) then
			collidingSiteIndex = diggingSiteIndex

			collidingVolumeDistance = distanceToVolume
		end
	end

	return collidingSiteIndex
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

		local interactableDigPoint

		local promptDig
		local promptDigReenableAt

		gOnMainThreadStop = function()
			gIsMainThreadRunning = false

			print('main thread is stopping')
	
			if promptDig then
				PromptDelete(promptDig)
				promptDig = nil
			end

			gOnMainThreadStop = nil
		end

		while gCurrentDigCluster and gIsMainThreadRunning do

			-- if GetFrameCount() % 30 == 0 then
			-- 	-- Atualizar a ped de vez em quando :P
			-- 	playerPed = PlayerPedId()

			-- 	local activeDiggingPointIndex = GlobalState[ ('digSiteActivePoint__%d'):format(gCurrentDigCluster) ]

			-- 	activeDiggingPointPos = DIGGING_SITES[gCurrentDigCluster].positions[activeDiggingPointIndex]
			-- end

			-- if activeDiggingPointPos then
			-- 	Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, activeDiggingPointPos, activeDiggingPointPos + vec3(0.0, 0.0, 5.0), 0, 255, 0, 255)

			-- 	local distanceToDigPoint = #(GetEntityCoords(playerPed) - activeDiggingPointPos)

			-- 	updateMetalDetectorBlackboardBasedOnDistance(distanceToDigPoint)

			-- 	-- E Key.
			-- 	if distanceToDigPoint <= 2.5 and IsControlJustPressed(0, 0xDFF812F9) then
			-- 		if gIsPlayingAnimScene then
			-- 			return
			-- 		end
				
			-- 		gIsPlayingAnimScene = true
				
			-- 		local animScene = createTreasureDiggingGrabAnimScene(activeDiggingPointPos)
				
			-- 		enterTreasureDiggingGrabAnimScene(animScene)
			-- 	end
			-- end

			-- Debug, pode remover:
			for digPoint, digPointPos in ipairs(DIGGING_SITES[gCurrentDigCluster].positions) do
				Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, digPointPos, digPointPos + upVector, 0, 255, 0, 255)
			end

			if GetFrameCount() % 30 == 0 then

				-- Atualizar a ped de vez em quando :P
				playerPed = PlayerPedId()

				local playerPos = GetEntityCoords(playerPed)

				-- Zerar o interágivel nesse frame, será re-setado caso necessário...
				interactableDigPoint = nil

				-- Distancia máxima para verificar a distancia do ponto.
				local lowestInteractableDigPointDistance = 1.5

				-- Pegar o ponto mais próximo nesse cluster...
				for digPoint, digPointPos in ipairs(DIGGING_SITES[gCurrentDigCluster].positions) do
					local distanceToDigPoint = #(playerPos - digPointPos)

					if distanceToDigPoint < lowestInteractableDigPointDistance then
						lowestInteractableDigPointDistance = distanceToDigPoint

						interactableDigPoint = digPoint
					end
				end
				
				if interactableDigPoint and not gActiveDigSite then
					-- O prompt vai ser usado, criar caso não exista.
					if not promptDig then
						promptDig = createPromptDig()
					end
				else
					-- O prompt não vai ser mais usado, então vai ser deletado.
					if promptDig then
						PromptDelete(promptDig)
						promptDig = nil
					end
				end
			end

			if interactableDigPoint then

				-- Reabilitar o prompt caso tenha sido desabilitado
				-- na ultima vez que foi pressionado.
				if promptDigReenableAt and GetGameTimer() >= promptDigReenableAt then
					PromptSetEnabled(promptDig, true)
				end

				if PromptIsJustPressed(promptDig) then

					-- Desabilitar o prompt por X segundos...
					PromptSetEnabled(promptDig, false)
					promptDigReenableAt = GetGameTimer() + 500

					-- Already playing the scene.
					if gActiveDigSite then
						return
					end

					requestInitDigging(gCurrentDigCluster, interactableDigPoint)
				end
			end

			Wait(0)
		end

		gOnMainThreadStop()
	end)
end

function computePlayerHeadingFromDigPoint(digPointPos)
	-- Um pouquinho abaixo do ponto de cavar,
	-- assumindo que os pontos são pegos a partir do meio do ped do player.
	local rayStartPos = digPointPos + vec3(0.0, 0.0, -0.30)
	
	local rayLenght = 4.0

	local playerPed = PlayerPedId()

	local cX, cY, cZ = rayStartPos.x, rayStartPos.y, rayStartPos.z

	for i = 0, 360, 20.0 do
		i = math.rad(i)

		local X_deg0 = cX + (rayLenght * math.cos(i))
		local Y_deg0 = cY + (rayLenght * math.sin(i))

		local rayEndPos = vec3(X_deg0, Y_deg0, cZ)

		-- StartExpensiveSynchronousShapeTestLosProbe
		local rayHandle = Citizen.InvokeNative(0x377906D8A31E5586, rayStartPos, rayEndPos, -1, playerPed, 4)

		local retval, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

		if hit == 1 then
			local distanceToStart = #(rayStartPos - endCoords)

			if not lowestDistanceToStart or distanceToStart < lowestDistanceToStart then
				lowestDistanceToStart = distanceToStart
				closestHitPos = endCoords
			end
		end
	end

	-- CreateThread(function()
	-- 	while true do
	-- 		Wait(0)
	-- 		for i = 0, 360, 20.0 do
	-- 			i = math.rad(i)
		
	-- 			local X_deg0 = cX + (rayLenght * math.cos(i))
	-- 			local Y_deg0 = cY + (rayLenght * math.sin(i))
		
	-- 			local circlePoint = vec3(X_deg0, Y_deg0, cZ)
		
	-- 			Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, rayStartPos, circlePoint, closestHitPos == circlePoint and 255 or 0, 0, 0, 255)
	-- 		end
	-- 	end
	-- end)

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
	TriggerServerEvent('playerEnterDiggingSite', diggingSiteIndex)

	ensureMainThread()
end

function onPlayerLeaveDiggingSite(diggingSiteIndex)
	TriggerServerEvent('playerLeaveDiggingSite', diggingSiteIndex)
end

CreateThread(function()
	createDiggingSiteVolumes()

	while true do
		Wait(1000)

		local collidingSiteIndex = getDiggingSiteIndexCollidingWithPlayer()

		if gCurrentDigCluster ~= collidingSiteIndex then

			if gCurrentDigCluster == nil then
				onPlayerEnterDiggingSite(collidingSiteIndex)
			else
				onPlayerLeaveDiggingSite(gCurrentDigCluster)
			end

			gCurrentDigCluster = collidingSiteIndex
			gCurrentDigClusterSitesState = { }
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
	if gCurrentDigCluster ~= digCluster then
		return
	end

	gCurrentDigClusterSitesState[digSite] = digSiteState
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if gOnMainThreadStop then
			gOnMainThreadStop()
		end
	end
end)