local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 0x8CC9CD42) then
                local playerPed = PlayerPedId()
                if not IsEntityDead(playerPed) and not Citizen.InvokeNative(0x9682F850056C9ADE, playerPed) then
                    local animDict = "script_proc@robberies@homestead@lonnies_shack@deception"

                    if not IsEntityPlayingAnim(playerPed, animDict, "hands_up_loop", 3) then
                        if not HasAnimDictLoaded(animDict) then
                            RequestAnimDict(animDict)

                            while not HasAnimDictLoaded(animDict) do
                                Citizen.Wait(0)
                            end
                        end

                        TaskPlayAnim(playerPed, animDict, "hands_up_loop", 2.0, -2.0, -1, 67109393, 0.0, false, 1245184, false, "UpperbodyFixup_filter", false)

                        RequestAnimDict(animDict)
                    else
                        -- ClearPedTasks(playerPed)
                        ClearPedSecondaryTask(playerPed)
                    end
                end
            end
        end
    end
)

-- Cancelar animações pelo BACKSPACE
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (IsControlJustPressed(0,0x156F7119))  then
            ClearPedTasks(PlayerPedId())

            Proxy.getInterface('GenericHandheldItem').stopHandheldItem(false)
        end
    end
end)

---------------------------------------------------------------------------------
local gShouldRagdoll = false

function handleUpdatePlayerRagdollState()
    Citizen.CreateThread(function()
        while gShouldRagdoll do
            Citizen.Wait(0)

            local playerPedId = PlayerPedId()

            if not IsPedRagdoll(playerPedId) then
                SetPedToRagdoll(playerPedId, 0, 1, 0, false, false, false)
            end

            ResetPedRagdollTimer(playerPedId)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        -- Z Key.
        if IsControlJustPressed(0, `INPUT_GAME_MENU_TAB_LEFT_SECONDARY`) then
            gShouldRagdoll = not gShouldRagdoll

            if gShouldRagdoll then
                handleUpdatePlayerRagdollState()
            end
        end
    end
end)
------------------------------------------------------------------------------

--[[Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            --[[if IsControlPressed(0, 0x26E9DC00) then -- Z
                Citizen.InvokeNative(0xAE99FB955581844A, PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
               
            end]]
--[[
            if IsControlPressed(1, 0xA65EBAB4) then
                RequestAnimDict("mech_loco_m@generic@reaction@pointing@unarmed@stand")
                while not HasAnimDictLoaded("mech_loco_m@generic@reaction@pointing@unarmed@stand") do
                    Citizen.Wait(100)
                end
                TaskPlayAnim(PlayerPedId(), "mech_loco_m@generic@reaction@pointing@unarmed@stand", "point_fwd_0", 8.0, 8.0, 3000, 31, 0, true, 0, false, 0, false)
            end

            if IsControlPressed(0, 0x43CDA5B0) then -- U | Cancelar animação
                local ped = PlayerPedId()

                if not IsPlayerFreeAiming(ped) then
                    ClearPedTasks(ped)
                    ClearPedSecondaryTask(ped)
                    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                end
            end
            --   if IsControlPressed(1, 0x4CC0E2FE) then -- B
            --     print("apertou")
            --     RequestAnimDict("script_hideout@six_point_cabin@rob_discuss")
            --     while not HasAnimDictLoaded("script_hideout@six_point_cabin@rob_discuss") do
            --         Citizen.Wait(100)
            --     end
            --     TaskPlayAnim(PlayerPedId(), "script_hideout@six_point_cabin@rob_discuss", "conversation_1_1_pedc", 8.0, 8.0, 3000, 31, 0, true, 0, false, 0, false)
            --   end
        end
    end
)]]

RegisterCommand(
    "clipset",
    function(source, args, rawCommand)
        N_0x03ddbf2d73799f9e("CLIPSET@MECH_GRAPPLE@UNARMED@_MALE@_AMBIENT@_HEALTHY@MOUNTED@INTIMIDATION@LOCO@ATTACKER")
        local retval, clipset = N_0x85b8f04555ab49b8("CLIPSET@MECH_GRAPPLE@UNARMED@_MALE@_AMBIENT@_HEALTHY@MOUNTED@INTIMIDATION@LOCO@ATTACKER")

        print(clipset)
    end
)

RegisterCommand(
    "c",
    function(source)
        local ped = PlayerPedId()
        if not IsPlayerFreeAiming(ped) then
            ClearPedTasks(ped)
            ClearPedSecondaryTask(ped)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
        end
    end
)

-- Citizen.CreateThread(
--     function()
--         local ply = PlayerPedId()
--         local plyped = GetPlayerPed(ply)

--         while true do
--             Citizen.Wait(0)
--             if IsControlJustPressed(0, 0xD8F73058) then --[U]
--                 ClearPedTasks(ply)
--             end
--         end
--     end
-- )

RegisterCommand(
    "anotar",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_WRITE_NOTEBOOK"), 200000, false, false, false, false)
    end
)

-- RegisterCommand(
--     "bandana",
--     function(source, args, rawCommand)
--         RequestAnimDict("mech_inventory@equip_facemask@fallbacks")
--         while not HasAnimDictLoaded("mech_inventory@equip_facemask@fallbacks") do
--             Citizen.Wait(100)
--         end

--         TaskPlayAnim(PlayerPedId(), "mech_inventory@equip_facemask@fallbacks", "bandana_enter_r", 8.0, 8.0, 3000, 31, 0, true, 0, false, 0, false)
--     end
-- )

local Bandana = false
RegisterCommand(
    "bandana",
    function(source, args, rawCommand)
        if cAPI.IsWanted() then
            TriggerEvent("FRP:NOTIFY:Simple", "Você ainda está como procurado, não pode retirar a bandana. ", 10000)
            return
        end

        local playerPed = PlayerPedId()

        local bandanaMale   = 0xC580526C
        local bandanaFemale = 0xE58F5BD4

        local defaultBandanaComponent = IsPedMale(playerPed) == 1 and bandanaMale or bandanaFemale

        if not Bandana then
            -- Animação.
            Citizen.InvokeNative(0xAE72E7DF013AAA61, playerPed, GetHashKey("KIT_BANDANA"), GetHashKey("BANDANA_ON_RIGHT_HAND"), 1, 0, -1082130432)

            Wait(700)

            -- Adicionar o componente
            Citizen.InvokeNative(0xD3A7B003ED343FD9, playerPed, defaultBandanaComponent, true, true, true)

            -- Levantar a bandana, face up.
            Citizen.InvokeNative(0x66B957AAC2EAAEAB, playerPed, defaultBandanaComponent, -1829635046, 0, true, 1)

            Bandana = true
        else
            -- Animação.
            Citizen.InvokeNative(0xAE72E7DF013AAA61, playerPed, GetHashKey("KIT_BANDANA"), GetHashKey("BANDANA_OFF_RIGHT_HAND"), 1, 0, -1082130432)

            Wait(700)

            -- Remover o wearableState, descer a bandana.
            Citizen.InvokeNative(0x66B957AAC2EAAEAB, playerPed, defaultBandanaComponent, `BASE`, 0, true, 1)

            Bandana = false
        end

        Citizen.InvokeNative(0xCC8CA3E88256E58F, playerPed, 0, 1, 1, 1, false)
    end
)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sentar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_FIRE_SIT'), -1, true, false, false, false)
end)
RegisterCommand('sentar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND'), -1, true, false, false, false)
end)
RegisterCommand('sentar3', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_FALL_ASLEEP'), -1, true, false, false, false)
end)
RegisterCommand('sentar4', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND_WHITTLE'), -1, true, false, false, false)
end)
RegisterCommand('sentarbeber', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_DRINK'), -1, true, false, false, false)
end)
RegisterCommand('sentarbeber2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND_DRINK_DRUNK'), -1, true, false, false, false)
end)
RegisterCommand('sentarfumar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_SMOKE'), -1, true, false, false, false)
end)
RegisterCommand('sentarcafe', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND_COFFEE_DRINK'), -1, true, false, false, false)
end)

RegisterCommand("cafe", function(source, args, rawCommand)
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_COFFEE_DRINK`, 360000, true, false, false, false)
end)

RegisterCommand('sentarlivro', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND_READING_BOOK_STOW'), -1, true, false, false, false)
end)
RegisterCommand('jornal', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_BARREL'), -1, true, false, false, false)
end)
RegisterCommand('jornal2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND_READ_NEWSPAPER'), -1, true, false, false, false)
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('deitar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SLEEP_GROUND_ARM'), -1, true, false, false, false)
end)

RegisterCommand('deitar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SLEEP_GROUND_PILLOW_NO_PILLOW'), -1, true, false, false, false)
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('escorarcerca', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_FENCE_FWD_CHECK_OUT_LIVESTOCK'), -1, true, false, false, false)
end)
RegisterCommand('escorar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING_NO_PROPS'), -1, true, false, false, false)
end)
RegisterCommand('escorar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING'), -1, true, false, false, false)
end)
RegisterCommand('escorar3', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING_INTERACTION'), -1, true, false, false, false)
end)
RegisterCommand('escorar4', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BAR_DRINK_BARTENDER'), -1, true, false, false, false)
end)
RegisterCommand('escorarbeber', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_BACK_RAILING_DRINKING'), -1, true, false, false, false)
end)
RegisterCommand('escorarbeber2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING_DRINKING'), -1, true, false, false, false)
end)
RegisterCommand('escorarcafe', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING_LEFT'), -1, true, false, false, false)
end)
RegisterCommand('escorarfumar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING_SMOKING'), -1, true, false, false, false)
end)
RegisterCommand('escorarcachimbo', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_WALL_LEFT'), -1, true, false, false, false)
end)
RegisterCommand('escorarparede', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_WALL_RIGHT'), -1, true, false, false, false)
end)
RegisterCommand('escorarparede2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_BACK_WALL'), -1, true, false, false, false)
end)
RegisterCommand('escorarparede3', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_BACK_WALL_NO_PROPS'), -1, true, false, false, false)
end)
RegisterCommand('amigoe', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_POST_LEFT_HAND_PLANTED'), -1, true, false, false, false)
end)
RegisterCommand('amigod', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_POST_RIGHT_HAND_PLANTED'), -1, true, false, false, false)
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('beberw', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BOTTLE_PICKUP_BOX_TABLE'), -1, true, false, false, false)
end)

RegisterCommand('beberc', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BOTTLE_PICKUP_BOX_TABLE_BEER'), -1, true, false, false, false)
end)

RegisterCommand('beberm', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_DRINK_FLASK'), -1, true, false, false, false)
end)
RegisterCommand('beberf', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_DRINK_CHAMPAGNE'), -1, true, false, false, false)
end)

----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('trompete', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_TRUMPET'), -1, true, false, false, false)
end)

RegisterCommand('violao', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GUITAR_UPBEAT'), -1, true, false, false, false)
end)

RegisterCommand('violao2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('PROP_HUMAN_SEAT_CHAIR_GUITAR'), -1, true, false, false, false)
end)

RegisterCommand('banjo', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('PROP_HUMAN_SEAT_CHAIR_BANJO'), -1, true, false, false, false)
end)

----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vomitar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_VOMIT_KNEEL'), -1, true, false, false, false)
end)

RegisterCommand('vomitar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_VOMIT'), -1, true, false, false, false)
end)

RegisterCommand('mijar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_PEE'), -1, true, false, false, false)
end)

RegisterCommand('observar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BADASS'), -1, true, false, false, false)
end)

RegisterCommand('esperar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SHOP_BROWSE_COUNTER'), -1, true, false, false, false)
end)

RegisterCommand('esperar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_STAND_WAITING'), -1, true, false, false, false)
end)

RegisterCommand('observar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_STERNGUY_IDLES'), -1, true, false, false, false)
end)

RegisterCommand('rezar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_GRAVE_MOURNING_KNEEL'), -1, true, false, false, false)
end)

RegisterCommand('rezar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_GRAVE_MOURNING'), -1, true, false, false, false)
end)

RegisterCommand('cruzarbraco', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_STARE_STOIC'), -1, true, false, false, false)
end)

RegisterCommand('gesticular', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@sworddance@shw_swrd_int')
    while not HasAnimDictLoaded('script_shows@sworddance@shw_swrd_int') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_shows@sworddance@shw_swrd_int', 'mc_intro', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('martelo', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('PROP_HUMAN_REPAIR_WAGON_WHEEL_ON_LARGE'), -1, true, false, false, false)
end)

RegisterCommand('martelo2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('PROP_HUMAN_REPAIR_WAGON_WHEEL_ON_SMALL'), -1, true, false, false, false)
end)

RegisterCommand('saco', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SACK_OUT_CART_TARP'), -1, true, false, false, false)
    Wait(400)
    ClearPedTasks(PlayerPedId())
end)

RegisterCommand('saco2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SACK_IN_CART_TARP'), -1, true, false, false, false)
    Wait(400)
    ClearPedTasks(PlayerPedId())
end)

RegisterCommand('limparcopo', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BARTENDER_CLEAN_GLASS'), -1, true, false, false, false)
end)

RegisterCommand('anotar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_WRITE_NOTEBOOK'), -1, true, false, false, false)
end)

RegisterCommand('varrer', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BROOM_WORKING'), -1, true, false, false, false)
end)

RegisterCommand('amolar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_TABLE_SHARPEN_KNIFE'), -1, true, false, false, false)
end)

RegisterCommand('amolar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_BACK_WHITTLE'), -1, true, false, false, false)
end)

RegisterCommand('alimentar1', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_FEED_CHICKEN'), -1, true, false, false, false)
end)

RegisterCommand('alimentar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_FEED_PIGS'), -1, true, false, false, false)
end)

RegisterCommand('agua', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BUCKET_FILL'), -1, true, false, false, false)
end)

RegisterCommand('agua2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BUCKET_POUR_LOW'), -1, true, false, false, false)
end)

RegisterCommand('cesto', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_COTTONBOX_DUMP'), -1, true, false, false, false)
end)

RegisterCommand('feno', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_PITCH_HAY_SCOOP'), -1, true, false, false, false)
end)

RegisterCommand('feno2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_PITCH_HAY_SPREAD'), -1, true, false, false, false)
end)

RegisterCommand('lenha', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SLING_PUT_DOWN'), -1, true, false, false, false)
end)

RegisterCommand('lenha2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SLING_PUT_DOWN_EMPTY'), -1, true, false, false, false)
end)
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

local eDrunkStage = {
    SOBER = 0,
    SLIGHTLY_DRUNK = 1,
    MODERATELY_DRUNK = 2,
    VERY_DRUNK = 3,
}

local DRUNK_STAGE_DURATION = 90000

local gPlayerDrunkStage = eDrunkStage.SOBER
local gTimeOfPlayerDrunkStage
local gNumGulps = 0

local gHasDrunkStageReducerInstance = false

function setPlayerDrunk(drunkStage)
    if gPlayerDrunkStage == drunkStage then
        return
    end

    local playerPedId = PlayerPedId()

    if drunkStage == eDrunkStage.SOBER then
        -- Intensidade da estado de bebado / Locomotion.
        Citizen.InvokeNative(0x406CCF555B04FAD3, playerPedId, 0, 0.0)

        Citizen.InvokeNative(0x4285804FD65D8066, 'DRUNK_SHAKE', 0)

        AnimpostfxStop('PlayerDrunk01')

        Citizen.InvokeNative(0x37D7BDBA89F13959, 'PlayerDrunk01')

        -- Remover o locomotion type atual 'very_drunk'
        Citizen.InvokeNative(0x58F7DB5BD8FA2288, playerPedId)

    elseif drunkStage == eDrunkStage.SLIGHTLY_DRUNK then
        Citizen.InvokeNative(0x406CCF555B04FAD3, playerPedId, 1, 0.25)

        ShakeGameplayCam('DRUNK_SHAKE', 1.0)

        AnimpostfxPlay('PlayerDrunk01')

        Citizen.InvokeNative(0x58F7DB5BD8FA2288, playerPedId)

        SetGameplayCamShakeAmplitude(0.4)

        Citizen.InvokeNative(0xCAB4DD2D5B2B7246, 'PlayerDrunk01', 0.4)

    elseif drunkStage == eDrunkStage.MODERATELY_DRUNK then
        Citizen.InvokeNative(0x406CCF555B04FAD3, playerPedId, 1, 0.60)

        ShakeGameplayCam('DRUNK_SHAKE', 1.0)

        AnimpostfxPlay('PlayerDrunk01')

        Citizen.InvokeNative(0x58F7DB5BD8FA2288, playerPedId)

        Citizen.InvokeNative(0x89F5E7ADECCCB49C, playerPedId, 'very_drunk')

        SetGameplayCamShakeAmplitude(0.6)

        Citizen.InvokeNative(0xCAB4DD2D5B2B7246, 'PlayerDrunk01', 0.7)

    elseif drunkStage == eDrunkStage.VERY_DRUNK then
        Citizen.InvokeNative(0x406CCF555B04FAD3, playerPedId, 1, 1.0)

        ShakeGameplayCam('DRUNK_SHAKE', 1.0)

        AnimpostfxPlay('PlayerDrunk01')

        Citizen.InvokeNative(0x58F7DB5BD8FA2288, playerPedId)

        Citizen.InvokeNative(0x89F5E7ADECCCB49C, playerPedId, 'very_drunk')

        SetGameplayCamShakeAmplitude(0.8)

        Citizen.InvokeNative(0xCAB4DD2D5B2B7246, 'PlayerDrunk01', 0.9)
    end

    gPlayerDrunkStage = drunkStage
    gTimeOfPlayerDrunkStage = GetGameTimer()

    if not gHasDrunkStageReducerInstance then
        createDrunkStageReducerThread()
    end
end

function createDrunkStageReducerThread()
    gHasDrunkStageReducerInstance = true

    CreateThread(function()
        while gPlayerDrunkStage > eDrunkStage.SOBER and not GlobalState.keepDrunk do
            Wait(0)

            if GetGameTimer() - gTimeOfPlayerDrunkStage >= DRUNK_STAGE_DURATION then
                setPlayerDrunk(gPlayerDrunkStage - 1)
            end
        end

        gHasDrunkStageReducerInstance = false
    end)
end

function handleUseGenericAlcoholItem()
    local playerPedId = PlayerPedId()

    CreateThread(function()
        -- IsPedRunningTaskItemInteraction
        while Citizen.InvokeNative(0xEC7E480FF8BD0BED, playerPedId) do
            Wait(0)

            -- Deu um gole na bebida.
            if HasAnimEventFired(playerPedId, 442509369) then
                if gPlayerDrunkStage == eDrunkStage.SOBER then
                    gNumGulps = gNumGulps + 1
                    
                    if gNumGulps >= 3 then
                        setPlayerDrunk(eDrunkStage.SLIGHTLY_DRUNK)

                        gNumGulps = 0
                    end
                end
            end

            -- -- Funciona
            -- if HasAnimEventFired(playerPedId, 2089200315) then
            --     print('chug?')

            --     Citizen.InvokeNative(0xCB9401F918CB0F75, playerPedId, "GENERIC_ALCOHOL_BLOCK_CHUG_A", true, 1)
            --     Citizen.InvokeNative(0xCB9401F918CB0F75, playerPedId, "GENERIC_ALCOHOL_ALLOW_CHUG_B", true, 1)
            -- end

            -- Finalizou a animação
            if HasAnimEventFired(playerPedId, 108107462) --[[ HasAnimEventFired(playerPedId, 574156416) ]] then
                local playerDrunkStage = math.min(gPlayerDrunkStage + 1, eDrunkStage.VERY_DRUNK)

                setPlayerDrunk(playerDrunkStage)

                -- O frasco tava ficando preso na mão, então a gente cancela imediatamente
                ClearPedTasks(playerPedId)
            end
        end
    end)
end

function ensureEveryoneDrunkState()
    if GlobalState.everyoneDrunk then
        setPlayerDrunk(eDrunkStage.VERY_DRUNK)
    end
end

-- Quando o comando every_drunk é usado.
RegisterNetEvent('ackSetVeryDrunk', ensureEveryoneDrunkState)

-- Quando o script é iniciado
CreateThread(ensureEveryoneDrunkState)

-- Quando o player seleciona um character.
RegisterNetEvent('FRP:EVENTS:CharacterSetRole', ensureEveryoneDrunkState)

RegisterNetEvent('forceSlightyDrunk', function()
    setPlayerDrunk(eDrunkStage.SLIGHTLY_DRUNK)
end)

RegisterNetEvent('DKT:ANIMATION:whisky')
AddEventHandler('DKT:ANIMATION:whisky', function(source, args)
    local playerPedId = PlayerPedId()

    local bottleModelHash = `P_BOTTLEJD01X`

    if not HasModelLoaded(bottleModelHash) then
        RequestModel(bottleModelHash)

        while not HasModelLoaded(bottleModelHash) do
            Wait(0)
        end
    end

    local propEntity = CreateObject(bottleModelHash, GetEntityCoords(playerPedId), false, true, false, false, true)

    TaskItemInteraction_2(playerPedId, `CONSUMABLE_SALOON_WHISKEY`, propEntity, GetHashKey("P_BOTTLEJD01X_PH_R_HAND"), `DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_UNCORK`, 1, 0, 0.0)

    handleUseGenericAlcoholItem()
end)

RegisterNetEvent('DKT:ANIMATION:cerveja')
AddEventHandler('DKT:ANIMATION:cerveja', function(source, args)
    local playerPedId = PlayerPedId()

    local bottleModelHash = `p_bottleBeer01a`

    if not HasModelLoaded(bottleModelHash) then
        RequestModel(bottleModelHash)

        while not HasModelLoaded(bottleModelHash) do
            Wait(0)
        end
    end

    local propEntity = CreateObject(bottleModelHash, GetEntityCoords(playerPedId), false, true, false, false, true)

    TaskItemInteraction_2(playerPedId, `CONSUMABLE_SALOON_BEER`, propEntity, GetHashKey("P_BOTTLEBEER01X_PH_R_HAND"), `DRINK_BOTTLE@Bottle_Cylinder_D1-55_H18_Neck_A8_B1-8_UNCORK`, 1, 0, 0.0)
    
    handleUseGenericAlcoholItem()
end)

RegisterCommand(
    "prato",
    function(source, args)
        local bowl = CreateObject("p_bowl04x_stew", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
        local spoon = CreateObject("p_spoon01x", GetEntityCoords(PlayerPedId()), true, true, false, false, true)

        Citizen.InvokeNative(0x669655FFB29EF1A9, bowl, 0, "Stew_Fill", 1.0)
        Citizen.InvokeNative(0xCAAF2BCCFEF37F77, bowl, 20)

        Citizen.InvokeNative(0xCAAF2BCCFEF37F77, spoon, 82)

        TaskItemInteraction_2(PlayerPedId(), 599184882, bowl, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 1, 0, -1.0)
        TaskItemInteraction_2(PlayerPedId(), 599184882, spoon, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 1, 0, -1.0)

        Citizen.InvokeNative(0xB35370D5353995CB, PlayerPedId(), -583731576, 1.0)
    end
)

RegisterCommand(
    "pegarfeno",
    function(source, args, rawCommand)
        local model = "p_haybale03x"
        if IsModelValid(model) then
            if not HasModelLoaded(model) then
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(10)
                end
            end
        end

        local coords = GetEntityCoords(PlayerPedId()) + (GetEntityForwardVector(PlayerPedId()) * 0.7)
        local object = CreateObject(model, coords, true, true, false, false, true)
        PlaceObjectOnGroundProperly(object)

        Citizen.InvokeNative(0x3BBDD6143FF16F98, PlayerPedId(), object, "p_hayBale03x_PH_R_HAND", "WORLD_HUMAN_COTTONBALE_PICKUP_2", 0, 0)
    end
)

RegisterCommand('dancar56', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance')
    while not HasAnimDictLoaded('script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance', 'dance_bounty_02', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar55', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance')
    while not HasAnimDictLoaded('script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance', 'dance_bounty_01', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar54', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p1')
    while not HasAnimDictLoaded('script_shows@cancandance@p1') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p1', 'cancandance_male', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar53', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p1')
    while not HasAnimDictLoaded('script_shows@cancandance@p1') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p1', 'cancandance_fem3', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar52', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p1')
    while not HasAnimDictLoaded('script_shows@cancandance@p1') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p1', 'cancandance_fem2', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)


RegisterCommand('dancar51', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p1')
    while not HasAnimDictLoaded('script_shows@cancandance@p1') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p1', 'cancandance_fem0', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar50', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@wild@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@wild@b@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@wild@b@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar49', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@wild@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@wild@b@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@wild@b@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar48', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@awkward@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@awkward@a@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@awkward@a@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar47', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@carefree@b@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@carefree@b@male@unarmed@full') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@carefree@b@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar46', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('ai_react@audience_dance_overlays@stand_lean_left')
    while not HasAnimDictLoaded('ai_react@audience_dance_overlays@stand_lean_left') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'ai_react@audience_dance_overlays@stand_lean_left', 'high_01', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar45', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@awkward@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@awkward@a@male@unarmed@full') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@awkward@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar44', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@old@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@old@a@male@unarmed@full') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@old@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar43', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@graceful@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@graceful@a@male@unarmed@full') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@graceful@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar42', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@graceful@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@graceful@a@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@graceful@a@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar41', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@graceful@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@graceful@a@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@graceful@a@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar40', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@carefree@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@carefree@a@male@unarmed@full') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@carefree@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar39', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@carefree@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@carefree@b@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@carefree@b@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar38', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@carefree@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@carefree@b@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@carefree@b@male@unarmed@full_looped', 'action_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar37', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@carefree@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@carefree@b@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@carefree@b@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar36', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@wild@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@wild@a@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@wild@a@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar35', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('ai_react@audience_dance_overlays@stand_lean_right')
    while not HasAnimDictLoaded('ai_react@audience_dance_overlays@stand_lean_right') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'ai_react@audience_dance_overlays@stand_lean_right', 'med_01', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar34', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@wild@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@wild@a@male@unarmed@full') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@wild@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar33', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@b@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@b@male@unarmed@full') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@b@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar32', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar31', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full_looped', 'action_lf_front', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar30', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full_looped', 'action_alt2_lf_front', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar29', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full_looped', 'action_alt1_lf_front', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar28', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@formal@a@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@formal@a@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@formal@a@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar27', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full', 'fullbody_alt1', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar26', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@a@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@a@male@unarmed@full') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@a@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar25', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@b@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@b@male@unarmed@full') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@b@male@unarmed@full', 'fullbody_alt1', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar24', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@confident@b@male@unarmed@full')
    while not HasAnimDictLoaded('script_mp@emotes@dance@confident@b@male@unarmed@full') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@confident@b@male@unarmed@full', 'fullbody', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar23', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@b@male@unarmed@full_looped', 'loop', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar22', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@b@male@unarmed@full_looped', 'action_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)


RegisterCommand('dancar21', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@b@male@unarmed@full_looped', 'action_alt2_fl', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar20', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@b@male@unarmed@full_looped', 'action_alt1_rf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar19', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped')
    while not HasAnimDictLoaded('script_mp@emotes@dance@drunk@b@male@unarmed@full_looped') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_mp@emotes@dance@drunk@b@male@unarmed@full_looped', 'action_alt1_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar18', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@sworddance@act3_p1')
    while not HasAnimDictLoaded('script_shows@sworddance@act3_p1') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_shows@sworddance@act3_p1', 'dancer_sworddance', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar17', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p2')
    while not HasAnimDictLoaded('script_shows@cancandance@p2') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p2', 'cancandance_p2_male', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar16', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@p2')
    while not HasAnimDictLoaded('script_shows@cancandance@p2') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@p2', 'cancandance_p2_fem2', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar15', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@snakedancer@act1_p1')
    while not HasAnimDictLoaded('script_shows@snakedancer@act1_p1') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_shows@snakedancer@act1_p1', 'kiss_win_dancer', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar14', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@snakedancer@act1_p1')
    while not HasAnimDictLoaded('script_shows@snakedancer@act1_p1') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_shows@snakedancer@act1_p1', 'dance_dancer', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar13', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('script_shows@cancandance@reacts')
    while not HasAnimDictLoaded('script_shows@cancandance@reacts') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'script_shows@cancandance@reacts', 'dancer_react_01', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar12', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_dancing@female_aidle_c')
    while not HasAnimDictLoaded('amb_misc@world_human_dancing@female_aidle_c') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_dancing@female_aidle_c', 'idle_g', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar11', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@base')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@base') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@base', 'base', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar10', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@female@base')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@female@base') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@female@base', 'base', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar9', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_a')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_a@idle_a') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_a', 'idle_c', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar8', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_a')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_a@idle_a') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_a', 'idle_a', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar7', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_a')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_a@idle_a') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_a', 'idle_b', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar6', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_b')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_a@idle_b') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_b', 'idle_f', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar5', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_b')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_a@idle_b') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_b', 'idle_e', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar4', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_b')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_a@idle_b') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_b', 'idle_d', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar3', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_b@idle_b')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_b@idle_b') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_b@idle_b', 'idle_e', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_b@idle_b')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_b@idle_b') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_b@idle_b', 'idle_d', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dancar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_b@idle_a')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_b@idle_a') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_b@idle_a', 'idle_b', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

local prompts = {}

local controlsorder = {
    -- 0x5966D52A,
    -- 0xB73BCA77,
    -- 0xCEFD9220,
    -- 0x760A9C6F,
    -- 0x760A9C6F,
    `INPUT_EMOTE_TWIRL_GUN_VAR_B`,
    `INPUT_EMOTE_TWIRL_GUN_VAR_A`,
    `INPUT_EMOTE_TWIRL_GUN_VAR_D`,
    `INPUT_EMOTE_TWIRL_GUN_VAR_C`
    -- 0x760A9C6F J
    ---
    -- 0x13C42BB2,
    -- 0x470DC190,
    -- 0x72BAD5AA,
    -- 0x661857B3,
    -- 0xF311100C,
    -- 0x04FB8191
}

local groups = {
    {
        -- name = "Emotes",
        actions = {
            {"Concordar", -822629770},
            {"Discordar", -653113914},
            {"Apontar", 486225122},
            {"Aceno legal", -511010399},
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            --{"85", 1509171361},
            {"Uivar", 877603501},
            {"Onça", 698079535},
            {"Ameaçar", 1256841324},
            {"De olho em você", -553424129},
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            {"Siga-me", 1115379199},
            {"Parar Aqui", 474409519},
            {"Vamos, Passe!", 2143329621},
            {"Bandeira Branca", -1023149885},   
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            {"Anotar", -1169051375},
            {"Olhar Longe", 935157006},
            {"Olhar Relógio", -380388425},
            {"Silêncio", -1644757697},
            --{"93", 1897736735},
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            
            {"Mandar Beijo", 1927505461},
            {"Muito Prazer", -2121881035},
            {"Quanto tempo!", 523585988},
            {"Tchau", -1551032732},   
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            
            {"Por Favor, NÃO!", 164860528},
            {"Ohh, Por quê?", 844130790},
            {"É isso aí", 1307697675},
            {"Não Acredito", -78874669},
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            {"Cara ou Coroa", -667707842},
            {"Pedra, Papel, Tesoura", -1219119695},
            {"Hipnotizar", -869481556},
            {"Adorei", -221241824},  
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            {"Brincar com faca", 1814567801},
            {"Maléfico", 589481092},
            {"Chamar para Briga", -2104721573},
            {"Palmas", -184244429}, 
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            {"Cigarro", -1954574613},
            {"Charuto", -2124325981},
            {"Cuspir", -2106738342},
            {"Morder Moeda", 397025279},
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            {"Atenção! Chega!", -1691237868},
            {"Irritado", 796723886},
            {"Dançar", -293533575},
            {"Dançar com Palmas", -256960614},            
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            
            {"Cheiro Bom", -1343104589},
            {"Cheiro Ruim", -166523388},
            {"Ansia de Vomito", -1118911493},
            {"Insulto", 1802342943},
            --{"52", 1457020913}
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            {"Quem? Eu?", 329631369},
            {"Chorar", 81347960},
            {"Positivo", 425751659},
        }
        -- prompt_group
    },
    
    
    --[[{
        -- name = "Emotes",
        actions = {
            --{"4", -1252070669}
            --{"18", 7918540},
            --{"7", -402959},
            --{"8", -773960361}
        }
        -- prompt_group
    },]]
    --[[{
        -- name = "Emotes",
        actions = {
            {"13", -415456998},
            {"14", 1159716480},
            {"15", 1593752891},
            {"16", -843470756}
        }
        -- prompt_group
    },]]
    
    --[[{
        -- name = "Emotes",
        actions = {
            --{"19", -919436740},
            --{"26", -1639456476},
            --{"27", 1939251934},
            --{"32", -799896264}
        }
        -- prompt_group
    },]]
    
    --[[{
        -- name = "Emotes",
        actions = {
            --{"37", -632925771},
            --{"39", -19706765},
            --{"40", -1790393337}
        }
        -- prompt_group
    },]]
    --[[{
        -- name = "Emotes",
        actions = {
            {"41", 1043523184},
            {"42", 1874713704},
            {"43", -2072898350},
            {"44", -808997190}
        }
        -- prompt_group
    },]]
    --[[{
        -- name = "Emotes",
        actions = {
            --{"45", 217596073},
            --{"46", 1140268200},
            --{"48", 901097731}
            --{"49", -1666834415},
        }
        -- prompt_group
    },]]
    
    --[[{
        -- name = "Emotes",
        actions = {
            --{"53", 831975651},
            --{"63", -934299978},
            --{"54", -1801715172},
            --{"55", 1018554126},
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            --{"57", -462132925},
            --{"59", 1879954891},
            --{"60", -339257980}
            --{"68", 296809845}
        }
        -- prompt_group
    },]]
    
    --[[{
        -- name = "Emotes",
        actions = {
            --{"84", 2144049308}
            --{"70", 803206066},
            --{"71", -1312563584},
        }
        -- prompt_group
    },]]
    --[[{
        -- name = "Emotes",
        actions = {
            {"73", -822629770},
            {"74", 803206066},
            {"75", -1312563584},
            {"76", -653113914}
        }
        -- prompt_group
    },]]
    --[[{
        -- name = "Emotes",
        actions = {
            {"77", -110352861},
            {"78", 772373429},
            {"79", -1000272583},
            {"80", 1023735814}
        }
        -- prompt_group
    },]]
    
    --[[{
        -- name = "Emotes",
        actions = {
            --{"89", 1825177171},
            --{"87", 445839715},
            --{"91", 969312568},
            --{"92", -1169275072}
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            --{"88", 246916594}
            --{"95", 1533402397},
            --{"100", 987239450}
            --{"98", 354512356},
        }
        -- prompt_group
    },]]
    
    
}

function init()
    for groupIndex, v in pairs(groups) do
        -- local name = v.name
        local actions = v.actions

        -- v.name = CreateVarString(10, "LITERAL_STRING", name)

        local prompt_group = GetRandomIntInRange(0, 0xffffff)
        groups[groupIndex].prompt_group = prompt_group

        nextpreviouspromptsforgroup(groupIndex, prompt_group)

        for index, av in pairs(actions) do
            local actionName = av[1]
            -- local action = av[2]

            local controlAtIndex = controlsorder[index]

            prompt = PromptRegisterBegin()
            PromptSetControlAction(prompt, controlAtIndex)
            PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", actionName))
            PromptSetEnabled(prompt, 1)
            PromptSetVisible(prompt, 1)
            PromptSetStandardMode(prompt, 1)
            PromptSetGroup(prompt, prompt_group)
            PromptRegisterEnd(prompt)

            table.insert(prompts, prompt)

            Citizen.Wait(50)
        end
    end
end

function nextpreviouspromptsforgroup(groupIndex, group)
    local prompt = PromptRegisterBegin()
    
    local hasPrevious = groupIndex > 1
    local hasNext = groupIndex < #groups

    local promptTextLeft = 'Voltar'
    local promptTextRight = 'Proximo'

    if not hasPrevious then
        promptTextLeft = 'Fechar'
    end

    if not hasNext then
        promptTextRight = nil
    end

    local promptText = ('%s%s'):format(promptTextLeft or '', promptTextRight == nil and '' or ('/' .. promptTextRight) )

    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", promptText))

    PromptSetControlAction(prompt, `INPUT_FRONTEND_LEFT`)

    if hasNext then
        PromptSetControlAction(prompt, `INPUT_FRONTEND_RIGHT`)
    end

    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetStandardMode(prompt, true)
    PromptSetGroup(prompt, group)

    PromptRegisterEnd(prompt)
    table.insert(prompts, prompt)
end

Citizen.CreateThread(
    function()
        init()

        local activeGroupIndex = 0

        while true do
            Citizen.Wait(0)

            if activeGroupIndex == 0 then
                if IsControlJustPressed(0, 0x760A9C6F) then -- G
                    activeGroupIndex = 1
                end
            else

                PromptSetActiveGroupThisFrame(groups[activeGroupIndex].prompt_group, CreateVarString(10, "LITERAL_STRING", "Emotes " .. activeGroupIndex .. "/" .. #groups))

                disablecontrols()

                if IsControlJustPressed(0, 0x760A9C6F) then -- G
                    activeGroupIndex = 0
                end

                if IsControlJustPressed(0, `INPUT_FRONTEND_LEFT`) then
                    if NativeUipromptIsControlActionActive(`INPUT_FRONTEND_LEFT`) then
                        if activeGroupIndex > 1 then
                            activeGroupIndex = activeGroupIndex - 1
                        else
                            activeGroupIndex = 0
                        end
                    end
                end

                if IsControlJustPressed(0, `INPUT_FRONTEND_RIGHT`) then
                    if NativeUipromptIsControlActionActive(`INPUT_FRONTEND_RIGHT`) then
                        if activeGroupIndex < #groups then
                            activeGroupIndex = activeGroupIndex + 1
                        end
                    end
                end

                -- Desabilitar os controles para não dar conflito/não selecionar as armas
                -- quando usar os emotes.
                DisableControlAction(0, `INPUT_SELECT_QUICKSELECT_SIDEARMS_LEFT`, true)
                DisableControlAction(0, `INPUT_SELECT_QUICKSELECT_DUALWIELD`, true)
                DisableControlAction(0, `INPUT_SELECT_QUICKSELECT_SIDEARMS_RIGHT`, true)
                DisableControlAction(0, `INPUT_SELECT_QUICKSELECT_UNARMED`, true)

                for index, control in pairs(controlsorder) do
                    if IsControlJustPressed(0, control) and NativeUipromptIsControlActionActive(control) then
                        local emoteHash = groups[activeGroupIndex].actions[index][2]

                        if emoteHash then
                            Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, emoteHash, 1, 1, 0, 0)
                        end
                    end
                end
            end
        end
    end
)

function disablecontrols()
    DisableControlAction(0, 0xF8982F00, true)
end

function NativeUipromptIsControlActionActive(control)
    return Citizen.InvokeNative(0x1BE19185B8AFE299, control)
end
local DOG_ANIMATIONS = {
    {
        name = "dorme",
        dictionary = "amb_creature_mammal@world_dog_sleeping@idle",
        anim = "idle_a",
        flag =  2
    },
    {
        name = "senta",
        dictionary = "amb_creature_mammal@world_dog_sitting@react_look@exit",
        anim = "front_exit",
        flag =  2
    },
    {
        name = "oi",
        dictionary = "amb_creature_mammal@world_dog_begging@base",
        anim = "base",
        flag =  2
    },
    {
        name = "procura",
        dictionary = "amb_creature_mammal@world_dog_sniffing_ground_wander@wander_e@walk_enter",
        anim = "enter",
        flag =  0
    },
    {
        name = "come",
        dictionary = "amb_creature_mammal@world_dog_eating_ground@idle_a",
        anim = "idle_c",
        flag =  1
    },
    {
        name = "bebe",
        dictionary = "amb_creature_mammal@world_dog_eating_ground@idle_a",
        anim = "idle_c",
        flag =  1
    },
    {
        name = "deita",
        dictionary = "amb_creature_mammal@world_dog_resting@react_look@enter",
        anim = "front_enter",
        flag =  2
    },
    {
        name = "aqui",
        dictionary = "amb_creature_mammal@world_dog_digging@base",
        anim = "base",
        flag =  1
    },
    {
        name = "late",
        dictionary = "amb_creature_mammal@world_dog_guard_growl@idle",
        anim = "idle_a",
        flag =  1
    },
    {
        name = "coco",
        dictionary = "amb_creature_mammal@world_dog_pooping@react_look@loop",
        anim = "front_loop",
        flag =  2
    },
    {
        name = "chore",
        dictionary = "amb_creature_mammal@world_dog_howling@idle0",
        anim = "idle_e",
        flag =  0
    },
    {
        name = "mija",
        dictionary = "amb_creature_mammal@world_dog_mark_territory_a@stand_exit",
        anim = "exit_right_no_dig",
        flag =  0
    }
}

local DOG_PED_MODELS = {
    `a_c_dogamericanfoxhound_01`,											
    `a_c_dogaustraliansheperd_01`,										
    `a_c_dogbluetickcoonhound_01`,											
    `a_c_dogcatahoulacur_01`,										
    `a_c_dogchesbayretriever_01`,								
    `a_c_dogcollie_01`,									
    `a_c_doghobo_01`,										
    `a_c_doghound_01`,										
    `a_c_doghusky_01`,									
    `a_c_doglab_01`,										
    `a_c_dogpoodle_01`,									
    `a_c_dogrufus_01`,										
    `a_c_dogstreet_01`,									
    `re_lostdog_dogs_01`,
}

RegisterCommand(
    'dog',
    function(source, args)
        local playerPedId = PlayerPedId()
        local playerPedModelHash = GetEntityModel(playerPedId)

        local pedIsAllowed = false

        for _, model in ipairs(DOG_PED_MODELS) do
            if model == playerPedModelHash then
                pedIsAllowed = true

                break
            end
        end

        if not pedIsAllowed then
            return
        end
        
        local targetAnimation = args[1]

        local dict, anim, flag

        for _, animation in ipairs(DOG_ANIMATIONS) do 
            if animation.name == targetAnimation then
                dict = animation.dictionary
                anim = animation.anim
                flag = animation.flag

                break
            end
        end

        if not dict then
            return
        end

        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end

        TaskPlayAnim(playerPedId, dict, anim, 2.0, -2.0, -1, flag, 0, true, 0, false, 0, false)

        RemoveAnimDict(dict)
    end
)

RegisterCommand(
    "leque",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_FAN"), 100, true, false, false, false)
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName or resourceName == "_core" then

            setPlayerDrunk(eDrunkStage.SOBER)

            for _, prompt in pairs(prompts) do
                PromptDelete(prompt)
            end
        end
    end
)
