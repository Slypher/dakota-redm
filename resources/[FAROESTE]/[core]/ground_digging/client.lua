-- local Proxy = module('_core', 'lib/Proxy')

-- local HandheldShovelItem = Proxy.getInterface('HandheldShovelItem')

local Proxy = module('_core', 'lib/Proxy')

HandheldShovelItem = Proxy.getInterface('HandheldShovelItem')

GroundDiggingProxy = { }

Proxy.addInterface('GroundDigging', GroundDiggingProxy)

local gOnDigPromptIsPressedHandler 

CreateThread(function()
	if HandheldShovelItem.isActive() then
		init()
	end
end)

AddEventHandler('onInitHandheldShovelItem', function()    
    init()
end)

AddEventHandler('onStopHandheldShovelItem', function()
    stop()
end)

function init()
    gOnDigPromptIsPressedHandler = AddEventHandler('onHandheldShovelItemDigPromptIsPressed', onHandheldShovelItemDigPromptIsPressed)
end

function stop()
    RemoveEventHandler(gOnDigPromptIsPressedHandler)

    gOnDigPromptIsPressedHandler = nil
end

function onHandheldShovelItemDigPromptIsPressed()
    local hooks = {
        onFinish = function()
            TriggerServerEvent('net.playerDigRandomGroundSite')
        end,
    }

    startDiggingAnimScene('grab', nil, nil, hooks)
end

--[[
    type:
        'grab'
        'nothing'

    hooks: {
        onCreate: () => void
        onLoad: () => void
        onStart: () => void
        onFinish: () => void
    }
]]
function startDiggingAnimScene(type, animScenePos, animSceneHeading, hooks)
    local shovelModelHash = `MP005_P_COLLECTORSHOVEL01`

	RequestModel(shovelModelHash)

	while not HasModelLoaded(shovelModelHash) do
		Wait(0)
	end

	local playerPed = PlayerPedId()

    animScenePos = animScenePos or GetEntityCoords(playerPed)

	local _, groundZ, _ = GetGroundZAndNormalFor_3dCoord(animScenePos.x, animScenePos.y, animScenePos.z)
	animScenePos = vec3(animScenePos.xy, groundZ --[[ - 0.05 ]] --[[ Magic number? ]])

    local animSceneDict = 'script@mech@treasure_hunting@grab'
    local animSceneAnim = 'PBL_GRAB_01'

    if type == 'nothing' then
        animSceneDict = 'script@mech@treasure_hunting@nothing'
        animSceneAnim = 'PBL_NOTHING_01'
    end

	local animScene = CreateAnimScene(animSceneDict, 64, animSceneAnim, true, true)

	LoadAnimScene(animScene)

    if hooks?.onCreate then
        hooks.onCreate()
    end

	-- IsAnimSceneLoaded
	while not Citizen.InvokeNative(0x477122B8D05E7968, animScene) do
		Wait(0)
	end

    if hooks?.onLoad then
        hooks.onLoad()
    end

	SetAnimSceneOrigin(animScene, animScenePos, 0.0, 0.0, animSceneHeading or GetEntityHeading(playerPed), 2)

	SetAnimSceneEntity(animScene, 'player', playerPed, 0)

    if IsPedOnMount(playerPed) then
		TaskDismountAnimal(playerPed, 0, 0, 0, 0, 0)
	end

	-- HidePedWeapons
	Citizen.InvokeNative(0xFCCC886EDE3C63EC, playerPed, 2, false)

    TaskEnterAnimScene(playerPed, animScene, 'player', animSceneAnim, 1.48, 1, 128, 20000, -1.0)

    if hooks?.onStart then
        hooks.onStart()
    end

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

        if hooks?.onFinish then
            hooks.onFinish()
        end
	end)
end

GroundDiggingProxy.startDiggingAnimScene = startDiggingAnimScene

-- startDiggingAnimScene()