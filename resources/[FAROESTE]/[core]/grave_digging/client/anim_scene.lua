function createTreasureDiggingGrabAnimScene(position, heading, useNothingScenario)

	-- STREAMING::REQUEST_MODEL(joaat("MP005_P_COLLECTORSHOVEL01"), false);

	-- requestUpdateActiveDigSiteState(eDiggingSitePointState.CREATE_ENTITIES)

	local shovelModelHash = `MP005_P_COLLECTORSHOVEL01`

	RequestModel(shovelModelHash)

	while not HasModelLoaded(shovelModelHash) do
		Wait(0)
	end

	local _, groundZ, _ = GetGroundZAndNormalFor_3dCoord(position.x, position.y, position.z)
	position = vec3(position.xy, groundZ --[[ - 0.05 ]] --[[ Magic number? ]])

	local animSceneDict = useNothingScenario and 'script@mech@treasure_hunting@nothing' or 'script@mech@treasure_hunting@grab'
	local animSceneAnim = useNothingScenario and 'PBL_NOTHING_01' or 'PBL_GRAB_01'

	local animScene = CreateAnimScene(animSceneDict, 64, animSceneAnim, true, true)

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

	return animScene, animSceneAnim
end

function enterTreasureDiggingGrabAnimScene(animScene, animSceneAnim)
    local playerPed = PlayerPedId()

	if IsPedOnMount(playerPed) then
		TaskDismountAnimal(playerPed, 0, 0, 0, 0, 0)
	end

	-- HidePedWeapons
	Citizen.InvokeNative(0xFCCC886EDE3C63EC, playerPed, 2, false)

    TaskEnterAnimScene(playerPed, animScene, 'player', animSceneAnim, 1.48, 1, 128, 20000, -1.0)

	requestUpdateActiveDigSiteState(eDiggingSitePointState.WAIT_TO_BE_DONE)

	CreateThread(function()
		-- IsAnimSceneRunning
		while not Citizen.InvokeNative(0xCBFC7725DE6CE2E0, animScene, false) do
			Wait(0)
		end

		-- IsAnimSceneFinished
		while not Citizen.InvokeNative(0xD8254CB2C586412B, animScene, false) do
			Wait(0)
		end

		-- DeleteAnimScene
		Citizen.InvokeNative(0x84EEDB2C6E650000, animScene)

		requestUpdateActiveDigSiteState(eDiggingSitePointState.DONE)

		gActiveDigSite = nil
	end)
end