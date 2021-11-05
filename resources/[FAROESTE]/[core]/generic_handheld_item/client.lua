local Proxy = module('_core', 'lib/Proxy')
local Tunnel = module('_core', 'lib/Tunnel')

Interface = { }

Proxy.addInterface('GenericHandheldItem', Interface)
Tunnel.bindInterface('GenericHandheldItem', Interface)

local gCurrentHandheldItemId
local gCurrentHandheldEntity

function initHandheldItem(itemId)
    local handheldModelHash

    local handheldLocoArch = 'arthur_healthy'
    local handheldLocoType = 'carry_pitchfork'

    local handheldUnknown = 'PITCH_FORKS'

    -- Melhorar isso :P
    if itemId == 'pa' then
        handheldModelHash = `MP005_P_COLLECTORSHOVEL01`
    end

    if not handheldModelHash then
        return false
    end

    if not HasModelLoaded(handheldModelHash) then
        RequestModel(handheldModelHash)

        while not HasModelLoaded(handheldModelHash) do
            Wait(0)
        end
    end

    gCurrentHandheldItemId = itemId

    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)

    local handheldEntity = CreateObject(handheldModelHash, playerPos, true, false, false)

    SetModelAsNoLongerNeeded(handheldModelHash)

    gCurrentHandheldEntity = handheldEntity

    AttachEntityToEntity(
        handheldEntity,
        playerPed,
        GetPedBoneIndex(playerPed, 7966),
        vec3(0.0, 0.0, 0.0),
        vec3(0.0, 0.0, 0.0),
        false,
        false,
        false,
        false,
        2,
        true,
        false,
        false
    )

	Citizen.InvokeNative(0x923583741DC87BCE, playerPed, handheldLocoArch)
    Citizen.InvokeNative(0x89F5E7ADECCCB49C, playerPed, handheldLocoType)

    Citizen.InvokeNative(0x3A50753042B6891B, playerPed, handheldUnknown)

    ForceEntityAiAndAnimationUpdate(playerPed, true, true)
    ForceEntityAiAndAnimationUpdate(handheldEntity, true)

    handleDetachConditions(handheldEntity)

    TriggerEvent('onInitHandheldItem', itemId)

    return true
end

function stopHandheldItem(forcefully)
    if not gCurrentHandheldEntity then
        return
    end

    DetachEntity(gCurrentHandheldEntity)

    if forcefully then
        DeleteEntity(gCurrentHandheldEntity)
    else
        SetEntityAsNoLongerNeeded(gCurrentHandheldEntity)
    end

    local playerPed = PlayerPedId()

    -- Stop locomotion
    Citizen.InvokeNative(0x58F7DB5BD8FA2288, playerPed)

    TriggerEvent('onStopHandheldItem', gCurrentHandheldItemId)

    gCurrentHandheldItemId = nil
    gCurrentHandheldEntity = nil
end

function handleDetachConditions(handheldEntity)
    CreateThread(function()

        local playerPed = PlayerPedId()

        while gCurrentHandheldEntity == handheldEntity do
            Wait(0)

            if GetFrameCount() % 30 == 0 then
                playerPed = PlayerPedId()
            end

            if IsPedRagdoll(playerPed) then
                stopHandheldItem(false)
            end
        end
    end)
end

Interface.initHandheldItem = initHandheldItem
Interface.stopHandheldItem = stopHandheldItem

function Interface.getHandheldItemId()
    return gCurrentHandheldItemId
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        stopHandheldItem(true)
    end
end)