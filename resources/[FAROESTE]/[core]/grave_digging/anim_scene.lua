function createTreasureDiggingGrabAnimScene(position, heading)

	-- STREAMING::REQUEST_MODEL(joaat("MP005_P_COLLECTORSHOVEL01"), false);

	-- requestUpdateActiveDigSiteState(eDiggingSitePointState.CREATE_ENTITIES)

	local _, groundZ, _ = GetGroundZAndNormalFor_3dCoord(position.x, position.y, position.z)
	position = vec3(position.xy, groundZ --[[ - 0.05 ]] --[[ Magic number? ]])

	local animScene = CreateAnimScene('script@mech@treasure_hunting@grab', 64, 'PBL_GRAB_01', true, true)

	LoadAnimScene(animScene)

	requestUpdateActiveDigSiteState(eDiggingSitePointState.LOAD_ANIM_SCENE)

	-- IsAnimSceneLoaded
	while not Citizen.InvokeNative(0x477122B8D05E7968, animScene) do
		Wait(0)
	end

	requestUpdateActiveDigSiteState(eDiggingSitePointState.PLAY_ANIM_SCENE_WAIT)

	local playerPed = PlayerPedId()

	SetAnimSceneOrigin(animScene, position, 0.0, 0.0, heading or 0.0, 2)

	SetAnimSceneEntity(animScene, 'player', playerPed, 0)

	return animScene
end

function enterTreasureDiggingGrabAnimScene(animScene)
    local playerPed = PlayerPedId()

	if IsPedOnMount(playerPed) then
		TaskDismountAnimal(playerPed, 0, 0, 0, 0, 0)
	end

	-- HidePedWeapons
	Citizen.InvokeNative(0xFCCC886EDE3C63EC, playerPed, 2, false)

    TaskEnterAnimScene(playerPed, animScene, 'player', 'PBL_GRAB_01', 1.48, 1, 128, 20000, -1.0)

	requestUpdateActiveDigSiteState(eDiggingSitePointState.WAIT_TO_BE_DONE)

	CreateThread(function()

		print('starting...')

		-- IsAnimSceneRunning
		while not Citizen.InvokeNative(0xCBFC7725DE6CE2E0, animScene, false) do
			Wait(0)
		end

		print('started')

		-- IsAnimSceneFinished
		while not Citizen.InvokeNative(0xD8254CB2C586412B, animScene, false) do
			Wait(0)
		end

		print('finished')

		requestUpdateActiveDigSiteState(eDiggingSitePointState.DONE)

		gActiveDigSite = nil
	end)
end