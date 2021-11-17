local Proxy = module('_core', 'lib/Proxy')
local Tunnel = module('_core', 'lib/Tunnel')

local GenericHandheldItem = Proxy.getInterface('GenericHandheldItem')
local HandheldMiningpanItem = { }

Proxy.addInterface('HandheldMiningpanItem', HandheldMiningpanItem)
Tunnel.bindInterface('HandheldMiningpanItem', HandheldMiningpanItem)

local DICT = 'script_re@gold_panner@gold_success'
local ANIM = 'panning_idle_no_water'

local FAIL_CLIPSET = 'pile_of_nothing' -- 'no_luck_here_n' -- 'fail'

local CELEBRATE_DICTIONARY = DICT -- 'script_mp@emotes@biting_gold_coin@male@unarmed@full'
local CELEBRATE_CLIPSET = 'success_front' -- 'fullbody'

local gState -- = eGoldPanningState.IDLE

local gKeepRunning = false

RegisterNetEvent('onStopHandheldItem', function(handheldItemId)
    if handheldItemId == 'miningpan' then
        stop()
    end
end)

function init()
    GenericHandheldItem.initHandheldItem('miningpan',
    {
        handheldPropHash = `s_interact_miningpan`,

        -- Rotação enquanto estiver andando
        handheldPropOffset = vec3(-0.05, -0.05, 0.05),
        handheldPropRotation = vec3(-10.0, 30.0, 0.0),
        
        -- Rotação enquanto estiver fazendo animação dentro da agua.
        -- handheldPropOffset = vec3(-0.05, -0.05, 0.0),
        -- handheldPropRotation = vec3(-10.0, 15.0, 0.0),

        useAnimation = true,

        animationDictionary = 'script_re@gold_panner@gold_success',
        animationClipset = 'panning_idle',

        animationFlags = 21,

        animationFilter = 'RightArmOnly_filter',
    })

    gState = eGoldPanningState.IDLE

    startScriptThread()
end

RegisterNetEvent('net.playerGoldPanningFoundNothing', function()
    if gKeepRunning then
        gState = eGoldPanningState.FAILED

        -- print('playerGoldPanningFoundNothing -> FAILED')
    end
end)

RegisterNetEvent('net.playerGoldPanningFoundGold', function()
    if gKeepRunning then
        gState = eGoldPanningState.CELEBRATE

        -- print('playerGoldPanningFoundGold -> CELEBRATE')
    end
end)

function startScriptThread()
    RequestAnimDict(CELEBRATE_DICTIONARY)

    CreateThread(function()

        gKeepRunning = true

        while gKeepRunning do
            Wait(0)

            if not gKeepRunning then
                return
            end

            local playerPed = PlayerPedId()

            if gState == eGoldPanningState.IDLE then
                if canTransitionToStatePanning(playerPed) then
                    gState = eGoldPanningState.PANNING

                    TriggerServerEvent('net.playerStartedGoldPanning')

                    -- print('IDLE -> PANNING')

                    ClearPedTasks(playerPed)
                else
                    if not IsEntityPlayingAnim(playerPed, DICT, 'panning_idle', 3) then
                        TaskPlayAnim(playerPed, DICT, 'panning_idle', -8.0, -8.0, -1, 21, 0.0, false, 0, false, 'RightArmOnly_filter', false)
                    end
                end
            end

            if gState == eGoldPanningState.PANNING then
                if not canTransitionToStatePanning(playerPed) then
                    gState = eGoldPanningState.IDLE

                    TriggerServerEvent('net.playerStoppedGoldPanning')

                    -- print('PANNING -> IDLE')

                    GenericHandheldItem.overrideHandheldItemAttachmentOffsetAndRotation(
                        vec3(-0.05, -0.05, 0.05),
                        vec3(-10.0, 30.0, 0.0)
                    )

                    ClearPedTasks(playerPed)
                else
                    if not IsEntityPlayingAnim(playerPed, DICT, 'panning_idle', 3) then
                        GenericHandheldItem.overrideHandheldItemAttachmentOffsetAndRotation(
                            vec3(-0.05, -0.05, 0.0),
                            vec3(-10.0, 15.0, 0.0)
                        )

                        TaskPlayAnim(playerPed, DICT, 'panning_idle', -8.0, -8.0, -1.0, 29, 0.0, false, 4096, false, '', false)
                    end
                end
            end

            if gState == eGoldPanningState.FAILED then
                if IsEntityPlayingAnim(playerPed, DICT, FAIL_CLIPSET, 3) then
                    gState = eGoldPanningState.FAILING

                    -- print('FAILED -> FAILING')
                else
                    TaskPlayAnim(playerPed, DICT, FAIL_CLIPSET, 8.0, -2.0, -1, 28, 0.0, false, 0, false, '', false)
                end
            end

            if gState == eGoldPanningState.FAILING then
                local isPlayingFailAnim = IsEntityPlayingAnim(playerPed, DICT, FAIL_CLIPSET, 3)

                -- GetEntityAnimCurrentTime
                if not isPlayingFailAnim -- then
                or (isPlayingFailAnim and Citizen.InvokeNative(0x627520389E288A73, playerPed, DICT, FAIL_CLIPSET, Citizen.ResultAsFloat()) >= 0.28 ) then
                    gState = eGoldPanningState.PANNING

                    -- print('FAILING -> PANNING')
                end
            end

            if gState == eGoldPanningState.CELEBRATE then
                if IsEntityPlayingAnim(playerPed, CELEBRATE_DICTIONARY, CELEBRATE_CLIPSET, 3) then
                    gState = eGoldPanningState.CELEBRATING

                    -- print('CELEBRATE -> CELEBRATING')

                    GenericHandheldItem.overrideHandheldItemAttachmentOffsetAndRotation(
                        vec3(0.10, -0.00, 0.20),
                        vec3(-100.0, 0.0, 0.0),
                        'SKEL_L_HAND'
                    )
                else
                    if IsEntityPlayingAnim(playerPed, DICT, 'panning_idle', 3) then
                        -- Precisa porque o 'panning_idle' tá com o filtro de RightArmOnly.
                        ClearPedTasks(playerPed)
                    end

                    TaskPlayAnim(playerPed, CELEBRATE_DICTIONARY, CELEBRATE_CLIPSET, -8.0, -8.0, -1, 0, 0.0, false, 0, false, '', false)
                end
            end

            if gState == eGoldPanningState.CELEBRATING then
                local isPlayingCelebrateAnim = IsEntityPlayingAnim(playerPed, CELEBRATE_DICTIONARY, CELEBRATE_CLIPSET, 3)

                if isPlayingCelebrateAnim then
                    
                    DisableAllControlActions(0)

                    EnableControlAction(0, `INPUT_LOOK_UD`, true)
                    EnableControlAction(0, `INPUT_LOOK_LR`, true)
                    
                    if Citizen.InvokeNative(0x627520389E288A73, playerPed, CELEBRATE_DICTIONARY, CELEBRATE_CLIPSET, Citizen.ResultAsFloat()) >= 0.15 then
                        GenericHandheldItem.setHandheldItemVisible(false)
                    end
                end

                if not isPlayingCelebrateAnim then
                    gState = eGoldPanningState.PANNING

                    -- print('CELEBRATING -> PANNING')

                    GenericHandheldItem.setHandheldItemVisible(true)
                end
            end

            if IsPedSwimming(playerPed) then
                GenericHandheldItem.stopHandheldItem(false)
            end
        end
    end)
end

function stop()
    gKeepRunning = false

    if gState ~= eGoldPanningState.IDLE then
        TriggerServerEvent('net.playerStoppedGoldPanning')
    end

    RemoveAnimDict(DICT)

    ClearPedTasks(playerPed)
end

CreateThread(function()
    -- Citizen.InvokeNative(0x923583741DC87BCE, playerPed, 'gold_panner')

    -- Citizen.InvokeNative(0x89F5E7ADECCCB49C, playerPed, 'default')

    -- ClearPedTasks(playerPed)

    -- RequestAnimDict(DICT)

    -- while not HasAnimDictLoaded(DICT) do
    --     Wait(0)
    -- end

    -- Wait(3000)

    -- local handheldItemEntity = GenericHandheldItem.getHandheldEntity()
    -- PlayEntityAnim(handheldItemEntity, DICT, 'alerted_r_enter_pan', 16.0, false, true, false, 0.0, 0);

    -- TaskPlayAnim(playerPed, DICT, ANIM, 8.0, -8.0, -1, 21, 0.0, false, 0, false, 'RightArmOnly_filter', false)
    -- 8.0, -8.0, -1, 25, 0.0, false, 0, false, 'RightArmOnly_filter', false
end)

function canTransitionToStatePanning(playerPed)
    local submergedLevel = GetEntitySubmergedLevel(playerPed)

    if (submergedLevel >= 0.35 --[[ and submergedLevel <= 0.40 ]]) then
        local playerPos = GetEntityCoords(playerPed)

        -- local animHandPos = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.60, -0.90)

        local hasWater, waterHeightZAtAnimPos = TestVerticalProbeAgainstAllWater(playerPos.x, playerPos.y, playerPos.z + 1.0, 1)

        if hasWater then -- and waterHeightZAtAnimPos >= animHandPos.z then
            return true
        end
    end

    return false
end

HandheldMiningpanItem.init = init

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if GenericHandheldItem.getHandheldItemId() == 'miningpan' then
            GenericHandheldItem.stopHandheldItem(false)
        end
    end
end)