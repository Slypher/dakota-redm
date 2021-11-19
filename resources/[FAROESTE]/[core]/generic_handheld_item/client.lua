local Proxy = module('_core', 'lib/Proxy')
local Tunnel = module('_core', 'lib/Tunnel')

Interface = { }

Proxy.addInterface('GenericHandheldItem', Interface)
Tunnel.bindInterface('GenericHandheldItem', Interface)

local gCurrentThreadHandle

local gCurrentHandheldItemId
local gCurrentHandheldEntity

local gCurrentHandheldAnimationDictionary
local gCurrentHandheldAnimationClipset

function initHandheldItem(itemId, options)
    if gCurrentHandheldEntity then
        stopHandheldItem()
    end

    gCurrentHandheldItemId = itemId

    local playerPed = PlayerPedId()

    -- AttachEntityToEntity(
    --     handheldEntity,
    --     playerPed,
    --     GetPedBoneIndex(playerPed, 7966),
    --     vec3(-0.2, 0.1, 0.0),
    --     0.0, 80.0, -30.0, false, false, false, true, 2, true
    -- )

    -- TaskPlayAnim(PlayerPedId(), 'amb_wander@code_human_2handshovel_wander@base', 'base', 4.0, -4.0, -1, 25, 0.0, false, 0, false, 'RightArmOnly_filter', false)

    if options.useLocomotion then

        local locomotionArch = options.locomotionArch
        local locomotionType = options.locomotionType
        local locomotionUnk = options.locomotionUnk

        Citizen.InvokeNative(0x923583741DC87BCE, playerPed, locomotionArch)
        Citizen.InvokeNative(0x89F5E7ADECCCB49C, playerPed, locomotionType)

        Citizen.InvokeNative(0x3A50753042B6891B, playerPed, locomotionUnk)

        ForceEntityAiAndAnimationUpdate(playerPed, true, true)
        ForceEntityAiAndAnimationUpdate(handheldEntity, true)
    end

    if options.useAnimation then
        local animationDictionary = options.animationDictionary
        local animationClipset = options.animationClipset

        local animationFlags = options.animationFlags or 0
        local animationFilter = options.animationFilter or ''

        if not animationDictionary or not animationClipset then
            return false
        end

        RequestAnimDict(animationDictionary)

        while not HasAnimDictLoaded(animationDictionary) do
            Wait(0)
        end

        TaskPlayAnim(playerPed, animationDictionary, animationClipset, 4.0, -4.0, -1, animationFlags, 0.0, false, 0, false, animationFilter, false)

        gCurrentHandheldAnimationDictionary = animationDictionary
        gCurrentHandheldAnimationClipset = animationClipset
    end

    if options.handheldPropHash then
        local handheldPropHash = options.handheldPropHash

        local handheldPropOffset = options.handheldPropOffset or vec3(0.0, 0.0, 0.15)
        local handheldPropRotation = options.handheldPropRotation or vec3(-1.0, 1.0, -30.0)

        if not HasModelLoaded(handheldPropHash) then
            RequestModel(handheldPropHash)

            while not HasModelLoaded(handheldPropHash) do
                Wait(0)
            end
        end

        local playerPos = GetEntityCoords(playerPed)

        local handheldEntity = CreateObject(handheldPropHash, playerPos, true, false, false)

        SetModelAsNoLongerNeeded(handheldPropHash)

        gCurrentHandheldEntity = handheldEntity

        -- HidePedWeapons
        Citizen.InvokeNative(0xFCCC886EDE3C63EC, playerPed, 0, true)

        AttachEntityToEntity(
            handheldEntity,
            playerPed,
            GetPedBoneIndex(playerPed, 7966),
            handheldPropOffset,
            handheldPropRotation,
            false,
            false,
            false,
            true,
            2,
            true
        )
    end

    TriggerEvent('onInitHandheldItem', itemId)

    gCurrentThreadHandle = { }

    processStuff(gCurrentThreadHandle)

    return true
end

function stopHandheldItem(forcefully)
    if not gCurrentThreadHandle then
        return
    end

    gCurrentThreadHandle.finish()
    gCurrentThreadHandle = nil
    
    DetachEntity(gCurrentHandheldEntity, true, true)

    if forcefully then
        DeleteEntity(gCurrentHandheldEntity)
    else
        SetEntityAsNoLongerNeeded(gCurrentHandheldEntity)
    end

    SetEntityDynamic(gCurrentHandheldEntity, true)

    local playerPed = PlayerPedId()

    if gCurrentHandheldAnimationDictionary and gCurrentHandheldAnimationClipset then
        ClearPedTasks(playerPed, true, true)

        RemoveAnimDict(gCurrentHandheldAnimationDictionary)

        gCurrentHandheldAnimationDictionary = nil
        gCurrentHandheldAnimationClipset = nil
    end

    -- Stop locomotion
    Citizen.InvokeNative(0x58F7DB5BD8FA2288, playerPed)

    TriggerEvent('onStopHandheldItem', gCurrentHandheldItemId)

    gCurrentHandheldItemId = nil
    gCurrentHandheldEntity = nil
end

function processStuff(threadHandle)
    CreateThread(function()
        local playerPed = PlayerPedId()

        local keepRunning = true

        threadHandle.finish = function()
            keepRunning = false
        end

        while keepRunning do
            Wait(0)

            if not keepRunning then
                break
            end

            if GetFrameCount() % 30 == 0 then
                playerPed = PlayerPedId()

                local _, weaponHash = GetCurrentPedWeapon(playerPed, 0, 0, 0)

                if weaponHash ~= `WEAPON_UNARMED` then
                    stopHandheldItem(false)
                end
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


function Interface.getHandheldEntity()
    return gCurrentHandheldEntity
end

function Interface.setHandheldItemVisible(visible)
    SetEntityVisible(gCurrentHandheldEntity, visible)
end

function Interface.overrideHandheldItemAttachmentOffsetAndRotation(offset, rotation, boneName)
    local playerPed = PlayerPedId()

    AttachEntityToEntity(
        gCurrentHandheldEntity,
        playerPed,
        boneName and GetEntityBoneIndexByName(playerPed, boneName) or GetPedBoneIndex(playerPed, 7966),
        offset,
        rotation,
        false,
        false,
        false,
        true,
        2,
        true
    )
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        stopHandheldItem(true)
    end
end)