
-------------------------------------------------------------------------------------
-- RAGDOLL -------------------------------------------------------------------------
-------------------------------------------------------------------------------------
local ragdoll = false

function setRagdoll(flag)
    ragdoll = flag
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ragdoll then
          Citizen.InvokeNative(0xAE99FB955581844A, PlayerPedId(), 10000, 10000, 0, 0, 0, 0)
       end
    end
end)


--[[ragdol = true
RegisterNetEvent("Ragdoll")
AddEventHandler("Ragdoll", function()
    if (ragdol) then
		setRagdoll(true)
		ragdol = false
        Wait(1000)
		setRagdoll(false)
		ragdol = true
	end
end)
-- ragdoll
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (IsControlJustPressed(0,0x26E9DC00))  then            
            TriggerEvent("Ragdoll")
        end
    end
end)]]
-------------------------------------------------------------------------------------
-- POINTING -------------------------------------------------------------------------
-------------------------------------------------------------------------------------
--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(8)
        if (IsControlJustPressed(0,0xCEE12B50)) and IsInputDisabled(0) then --
            local ped = PlayerPedId()
            if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then

                RequestAnimDict( "ai_react@point@base" )

                while ( not HasAnimDictLoaded( "ai_react@point@base" ) ) do
                    Citizen.Wait( 100 )
                end

                if IsEntityPlayingAnim(ped, "ai_react@point@base", "point_fwd", 3) then
                    ClearPedTasks(ped)
                    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
                    RemoveAnimDict("ai_react@point@base")
                else
                    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
                    TaskPlayAnim(ped, "ai_react@point@base", "point_fwd", 2.0, -1.5, 120000, 31, 0, true, 0, false, 0, false)
                end
            end
        end
    end
end)]]

-------------------------------------------------------------------------------------
-- HANDS UP -------------------------------------------------------------------------
-------------------------------------------------------------------------------------

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(8)
        if (IsControlJustPressed(0,0x8CC9CD42))  then -- X
            local ped = PlayerPedId()
            if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then  
                RequestAnimDict( "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs" )    
                while ( not HasAnimDictLoaded( "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs" ) ) do 
                    Citizen.Wait( 100 )
                end
                if IsEntityPlayingAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 3) then
                    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
                    DisablePlayerFiring(ped, true)
                    ClearPedSecondaryTask(ped)
                else
                    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
                    DisablePlayerFiring(ped, true)
                    TaskPlayAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 2.0, -1.0, 120000, 31, 0, true, 0, false, 0, false)
                end
            end
        end
    end
end)]]

-------------------------------------------------------------------------------------
-- BANDANA --------------------------------------------------------------------------
-------------------------------------------------------------------------------------

RegisterCommand("bandana", function(source, args)
    if puesta then 
        Citizen.InvokeNative(0xAE72E7DF013AAA61,PlayerPedId(),GetHashKey("KIT_BANDANA"), GetHashKey("BANDANA_OFF_RIGHT_HAND"), 1, 0, -1082130432)
        Wait(700)
        -- Quitar bandana
        Citizen.InvokeNative(0x1902C4CFCC5BE57C,PlayerPedId(),-972364774)
        Citizen.InvokeNative(0xCC8CA3E88256E58F,PlayerPedId(),0,1,1,1,false)
        puesta = false
    else
        Citizen.InvokeNative(0xAE72E7DF013AAA61,PlayerPedId(),GetHashKey("KIT_BANDANA"), GetHashKey("BANDANA_ON_RIGHT_HAND"), 1, 0, -1082130432)
        Wait(700)
        -- Poner bandana
        Citizen.InvokeNative(0x1902C4CFCC5BE57C,PlayerPedId(),-1100875244)
        Citizen.InvokeNative(0xCC8CA3E88256E58F,PlayerPedId(),0,1,1,1,false)
        puesta = true
    end
end)

-------------------------------------------------------------------------------------
-- BACKSPACE PARAR ANIMAÇÃO
-------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(8)
        if (IsControlJustPressed(0,0x156F7119))  then
            print('limpar animação')
            Wait(100)
            ClearPedTasks(PlayerPedId())
        end
    end
end)

-------------------------------------------------------------------------------------
----------------------------------- ANIMAÇÕES ---------------------------------------
-------------------------------------------------------------------------------------

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
RegisterCommand('sentarlivro', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND_READING_BOOK_STOW'), -1, true, false, false, false)
end)
RegisterCommand('sentarjornal', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SIT_GROUND_READ_NEWSPAPER'), -1, true, false, false, false)
end)


RegisterCommand('deitar', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SLEEP_GROUND_ARM'), -1, true, false, false, false)
end)

RegisterCommand('deitar2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_SLEEP_GROUND_PILLOW_NO_PILLOW'), -1, true, false, false, false)
end)

------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('escorarcerca', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_FENCE_FWD_CHECK_OUT_LIVESTOCK'), -1, true, false, false, false)
end)
RegisterCommand('escorarbalcao', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING_NO_PROPS'), -1, true, false, false, false)
end)
RegisterCommand('escorarbalcao2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING'), -1, true, false, false, false)
end)
RegisterCommand('escorarbalcao3', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_RAILING_INTERACTION'), -1, true, false, false, false)
end)
RegisterCommand('escorarbalcao4', function(source, arg)
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
RegisterCommand('amigo2', function(source, arg)
    local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_LEAN_POST_RIGHT_HAND_PLANTED'), -1, true, false, false, false)
end)

------------------------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------------------------

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

RegisterCommand('feno', function(source, arg)
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

-------------------------------------------------------------------------------------
------------------------------------- DANÇAS ----------------------------------------
-------------------------------------------------------------------------------------

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
