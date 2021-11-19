local Proxy = module('_core', 'lib/Proxy')
local Tunnel = module('_core', 'lib/Tunnel')

HandheldShovelItemProxy = { }
HandheldShovelItemTunnel = { }

Proxy.addInterface('HandheldShovelItem', HandheldShovelItemProxy)
Tunnel.bindInterface('HandheldShovelItem', HandheldShovelItemTunnel)

local GenericHandheldItem = Proxy.getInterface('GenericHandheldItem')

local gGroupPrompt

local gPromptDig
local gPromptCancel

RegisterNetEvent('onInitHandheldItem', function(handheldItemId)
    if handheldItemId ~= 'pa' then
        return
    end

    initHandheldShovelItem()
end)

RegisterNetEvent('onStopHandheldItem', function(handheldItemId)
    if handheldItemId ~= 'pa' then
        return
    end
    
    stopHandheldShovelItem()
end)

function createPromptNoGroup(controlHash, text)
    local prompt = Citizen.InvokeNative(0x04F97DE45A519419)

	PromptSetControlAction(prompt, controlHash)
	PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', text))

	PromptSetEnabled(prompt, true)
	PromptSetVisible(prompt, true)

	PromptSetStandardMode(prompt, true)

	PromptSetGroup(prompt, TreeGroup)

	PromptRegisterEnd(prompt)

    return prompt
end

function createDigAndDropPrompts()

    -- 0x7F8D09B8

    gGroupPrompt = GetRandomIntInRange(0, 0xffffff)

    gPromptDig = createPromptNoGroup(`INPUT_NEXT_CAMERA`, 'Cavar')
    gPromptCancel = createPromptNoGroup(`INPUT_FRONTEND_CANCEL`, 'Soltar')

    PromptSetGroup(gPromptDig, gGroupPrompt)
    PromptSetGroup(gPromptCancel, gGroupPrompt)
end

function drawPrompts()
    CreateThread(function()
        while gGroupPrompt do
            Wait(0)

            PromptSetActiveGroupThisFrame(gGroupPrompt, CreateVarString(10, 'LITERAL_STRING', 'Pá'))

            if PromptIsJustPressed(gPromptDig) then
                TriggerEvent('onHandheldShovelItemDigPromptIsPressed')
            end

            if PromptIsJustPressed(gPromptCancel) then
                GenericHandheldItem.stopHandheldItem(false)
            end
        end
    end)
end

function initHandheldShovelItem()
    createDigAndDropPrompts()

    drawPrompts()

    TriggerEvent('onInitHandheldShovelItem')
end

function stopHandheldShovelItem()
    PromptDelete(gPromptDig)
    PromptDelete(gPromptCancel)

    gGroupPrompt = nil

    gPromptDig = nil
    gPromptCancel = nil

    TriggerEvent('onStopHandheldShovelItem')
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        GenericHandheldItem.stopHandheldItem(false)
    end
end)

function HandheldShovelItemProxy.isActive()
    return GenericHandheldItem.getHandheldItemId() == 'pa'
end

function HandheldShovelItemProxy.setDigPromptEnabled(enabled)
    if gPromptDig then
        PromptSetEnabled(gPromptDig, enabled)
    end
end

function HandheldShovelItemProxy.setCancelPromptEnabled(enabled)
    if gPromptCancel then
        PromptSetEnabled(gPromptCancel, enabled)
    end
end

function HandheldShovelItemTunnel.init()
    GenericHandheldItem.initHandheldItem('pa',
    {
        handheldPropHash = `MP005_P_COLLECTORSHOVEL01`,

        useLocomotion = true,

        locomotionArch = 'arthur_healthy',
        locomotionType = 'carry_pitchfork',

        locomotionUnk = 'PITCH_FORKS',
    })
end