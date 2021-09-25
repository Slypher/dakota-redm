local isInventoryOpen = false
local isOtherOpen = false
local InventoryItems = {}
local OtherItems = {}
local PlayerMoney = 0
local InventoryWeight = 0.0
local DroppedItems = {}
local CreatedLockers = {}
local LockerZone
local UsedWeapons = {}
local CreatedCraftings = lock
local PlayerJob = job
local CurrentCraftingType = "empty"
local CraftingData = {}
local WeaponsWithoutAmmo = {
["WEAPON_FISHINGROD"] = true,
["WEAPON_MELEE_KNIFE"] = true,
["WEAPON_MELEE_KNIFE_MINER"] = true,
["WEAPON_MELEE_KNIFE_VAMPIRE"] = true,
["WEAPON_LASSO"] = true,
["WEAPON_MELEE_CLEAVER"] = true,
["WEAPON_MELEE_LANTERN_ELECTRIC"] = true,
["WEAPON_MELEE_TORCH"] = true,
["WEAPON_KIT_BINOCULARS"] = true,
["WEAPON_KIT_CAMERA_ADVANCED"] = true,
["WEAPON_MELEE_MACHETE_HORROR"] = true,
["WEAPON_LASSO_REINFORCED"] = true,
["WEAPON_KIT_BINOCULARS_IMPROVED"] = true,
["WEAPON_MELEE_KNIFE_TRADER"] = true,
["WEAPON_MELEE_MACHETE_COLLECTOR"] = true,


}
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if IsControlJustReleased(0, 0x4CC0E2FE) then
            if LockerZone then
                TriggerServerEvent("redemrp_inventory:GetLocker", LockerZone)
            else
                isInventoryOpen = not isInventoryOpen

                if isInventoryOpen then
                    for i,k in pairs(InventoryItems) do
                        if k.type  == "item_weapon" and not WeaponsWithoutAmmo[k.name] then
                            if HasPedGotWeapon(PlayerPedId(), tonumber(k.weaponHash)) then
                                if UsedWeapons[tonumber(k.weaponHash)] and UsedWeapons[tonumber(k.weaponHash)].meta.uid == k.meta.uid then
                                    InventoryItems[i].amount = GetAmmoInPedWeapon(PlayerPedId(), tonumber(k.weaponHash))
                                end
                            end
                        end
                    end
                    CurrentCraftingType = "empty"
                    SendNUIMessage({
                        type = 1,
                        inventory = isInventoryOpen,
                        otherinventory = isOtherOpen,
                        crafting = GetForZone(CraftingData),
                        items = InventoryItems,
                        otheritems = OtherItems,
                        money = PlayerMoney,
                        time =  GetClockHours()..":"..GetClockMinutes(),
                        weight = InventoryWeight	,
                        target = 0,
                    })

                    SetNuiFocus(true, true)
                else
                    SendNUIMessage({
                        type = 2
                    })
                    SetNuiFocus(false, false)
                    isOtherOpen = false
                    LockerZone = nil
					CurrentCraftingType = "empty"
                end
            end
        end
    end

end)


RegisterNetEvent('redemrp_inventory:SearchPlayer')
AddEventHandler('redemrp_inventory:SearchPlayer', function(target)
    TriggerServerEvent("redemrp_inventory:GetPlayer", target)
end)



RegisterNetEvent('redemrp_inventory:removeWeapon')
AddEventHandler('redemrp_inventory:removeWeapon', function(hash)
    if UsedWeapons[tonumber(hash)] then
        UsedWeapons[tonumber(hash)] = nil
        ReloadWeapons()
    end
end)


RegisterNetEvent('redemrp_inventory:UseWeapon')
AddEventHandler('redemrp_inventory:UseWeapon', function(hash , ammoAmount, meta , name)
    local id = false
    if not UsedWeapons[tonumber(hash)] then
        for i,k in pairs(UsedWeapons) do
            if k.WeaponType == Citizen.InvokeNative(0x5C2EA6C44F515F34, tonumber(hash)) then
                id = i
                break
            end
        end
        if id then
            UsedWeapons[id] = nil
        end
        UsedWeapons[tonumber(hash)] = {WeaponHash = tonumber(hash), WeaponType = Citizen.InvokeNative(0x5C2EA6C44F515F34, tonumber(hash)), Ammo = tonumber(ammoAmount) , name = name , meta = meta}
	else
		if not WeaponsWithoutAmmo[UsedWeapons[tonumber(hash)].name] then
			UsedWeapons[tonumber(hash)].Ammo = GetAmmoInPedWeapon(PlayerPedId(), tonumber(hash))
		end
        TriggerServerEvent("redemrp_inventory:ChangeAmmoAmount", {UsedWeapons[tonumber(hash)]})
        UsedWeapons[tonumber(hash)] = nil
    end
    ReloadWeapons()
end)

exports('GetCurrentWeaponId', function(WeaponHash)
	if UsedWeapons[tonumber(WeaponHash)] then
		return UsedWeapons[tonumber(WeaponHash)].meta.uid
	else
		return false
	end
end)

function ReloadWeapons()
    Citizen.InvokeNative(0x1B83C0DEEBCBB214, PlayerPedId())
    RemoveAllPedWeapons(PlayerPedId() , true , true)
    for i,k in pairs(UsedWeapons) do
        Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), k.WeaponHash, 0, false, true)
	    SetPedAmmo(PlayerPedId(), k.WeaponHash , k.Ammo)
        -- Wait(100)
        TriggerServerEvent('rdr_weapon_customization:Request', k.name , tonumber(k.WeaponHash) , k.meta.uid)
    end
end
RegisterNetEvent('redemrp_inventory:ReloadWeapons')
AddEventHandler('redemrp_inventory:ReloadWeapons', function()
    ReloadWeapons()
end)

function WeaponAmmoLoop()
    SetTimeout(60000, function()
        Citizen.CreateThread(function()
            if next(UsedWeapons) ~= nil and NetworkIsSessionStarted() then
                for i,k in pairs(UsedWeapons) do
                    if not WeaponsWithoutAmmo[k.name] then
                        UsedWeapons[i].Ammo = GetAmmoInPedWeapon(PlayerPedId(), i)
                    end
                end
                TriggerServerEvent("redemrp_inventory:ChangeAmmoAmount", UsedWeapons)
                TriggerServerEvent("rdr_weapon_customization:SaveStats", UsedWeapons)
            end
			WeaponAmmoLoop()
        end)
    end)
end
WeaponAmmoLoop()

function WeaponStatsLoop()
    SetTimeout(1000, function()
        Citizen.CreateThread(function()
            if next(UsedWeapons) ~= nil and NetworkIsSessionStarted()  then
                for i,k in pairs(UsedWeapons) do
                        local _, WeaponHash = GetCurrentPedWeapon(PlayerPedId(), true, 0, true)
                        if i == WeaponHash then
                            local WeaponObject = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(PlayerPedId() , 0))
                            UsedWeapons[i].Stats = GetWeaponStats(WeaponObject)
                        end
                end
            end
			WeaponStatsLoop()
        end)
    end)
end
WeaponStatsLoop()

function GetWeaponStats(WeaponObject)
    local WeaponDegradation =  Citizen.InvokeNative(0x0D78E1097F89E637 ,WeaponObject , Citizen.ResultAsFloat())
    local WeaponPernamentDegradation =  Citizen.InvokeNative(0xD56E5F336C675EFA ,WeaponObject , Citizen.ResultAsFloat())
    local WeaponDirt = Citizen.InvokeNative(0x810E8AE9AFEA7E54  ,WeaponObject , Citizen.ResultAsFloat())
    local WeaponSoot = Citizen.InvokeNative(0x4BF66F8878F67663  ,WeaponObject , Citizen.ResultAsFloat())
    local WeaponDamage = Citizen.InvokeNative(0x904103D5D2333977   ,WeaponObject , Citizen.ResultAsFloat())
    local Stats = {
        ["Degradation"] = WeaponDegradation,
        ["PernamentDegradation"] = WeaponPernamentDegradation,
        ["Dirt"] = WeaponDirt,
        ["Soot"] = WeaponSoot,
        ["Damage"] = WeaponDamage,
    }
    return Stats
end

RegisterNetEvent("redemrp_inventory:SaveAmmo")
AddEventHandler("redemrp_inventory:SaveAmmo", function()
        if next(UsedWeapons) ~= nil  then
		 for i,k in pairs(UsedWeapons) do
			if not WeaponsWithoutAmmo[k.name] then
				UsedWeapons[i].Ammo = GetAmmoInPedWeapon(PlayerPedId(), i)
				end
			 end
            TriggerServerEvent("redemrp_inventory:ChangeAmmoAmount", UsedWeapons)
        end
end)


RegisterNetEvent("redemrp_inventory:RequestSaveStats")
AddEventHandler("redemrp_inventory:RequestSaveStats", function()
     TriggerServerEvent("rdr_weapon_customization:SaveStats", UsedWeapons)
end)


RegisterNetEvent("redemrp_inventory:SendItems")
AddEventHandler("redemrp_inventory:SendItems", function(data, data2, money, weight , other , target , crafting)
    InventoryItems  = data
    OtherItems  = data2
    PlayerMoney = money
    InventoryWeight = weight
    CraftingData = crafting
    local _target = 0
    if other then
        isOtherOpen = true
        isInventoryOpen = true
    end
    if target then
        _target = target
        for i,k in pairs(InventoryItems) do
            if k.type  == "item_weapon" and not WeaponsWithoutAmmo[k.name] then
                if HasPedGotWeapon(PlayerPedId(), tonumber(k.weaponHash)) then
                    if UsedWeapons[tonumber(k.weaponHash)].meta.uid == k.meta.uid then
                        InventoryItems[i].amount = GetAmmoInPedWeapon(PlayerPedId(), tonumber(k.weaponHash))
                    end
                end
            end
        end
        -----TO DO ----------
        -- local player = GetPlayerFromServerId(id)
        -- local targetPed = GetPlayerPed(player)
        -- for i,k in pairs(isOtherOpen) do
        -- if k.type  == "item_weapon" then
        -- if HasPedGotWeapon(targetPed, tonumber(k.weaponHash)) then
        -- isOtherOpen[i].amount = GetAmmoInPedWeapon(targetPed, tonumber(k.weaponHash))
        -- end
        -- end
        -- end
    end
    if isInventoryOpen then
        SendNUIMessage({
            type = 1,
            inventory = isInventoryOpen,
            otherinventory = isOtherOpen,
            crafting = GetForZone(CraftingData),
            items = InventoryItems,
            otheritems = OtherItems,
            money = PlayerMoney,
            time =  GetClockHours()..":"..GetClockMinutes(),
            weight = InventoryWeight	,
            target = _target,
        })
        SetNuiFocus(true, true)
    end
end)

RegisterNUICallback('additem', function(data)
    TriggerServerEvent("redemrp_inventory:update", "add", data.data , data.target ,LockerZone)
end)

RegisterNUICallback('removeitem', function(data)
    TriggerServerEvent("redemrp_inventory:update", "delete" ,data.data, data.target, LockerZone)
end)

--==================== D R O P =======================================

RegisterNUICallback('dropitem', function(data)
    TriggerServerEvent("redemrp_inventory:drop",data.data)
end)

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end

RegisterNetEvent('redemrp_inventory:CreatePickup')
AddEventHandler('redemrp_inventory:CreatePickup', function(name, amount , meta, label, img)
    local ped     = PlayerPedId()
    local coords  = GetEntityCoords(ped)
    local forward = GetEntityForwardVector(ped)
    local x, y, z = table.unpack(coords + forward * 1.6)
    while not HasModelLoaded( GetHashKey("P_COTTONBOX01X") ) do
        Wait(500)
        modelrequest( GetHashKey("P_COTTONBOX01X") )
    end
    local obj = CreateObject("P_COTTONBOX01X", x, y, z, true, true, true)
    PlaceObjectOnGroundProperly(obj)
    SetEntityAsMissionEntity(obj, true, true)
    FreezeEntityPosition(obj , true)
	local _coords = GetEntityCoords(obj)
    TriggerServerEvent("redemrp_inventory:AddPickupServer",name, amount, meta, label, img, _coords.x, _coords.y, _coords.z, obj)
    PlaySoundFrontend("show_info", "Study_Sounds", true, 0)
    SetModelAsNoLongerNeeded(GetHashKey("P_COTTONBOX01X"))
end)

RegisterNetEvent('redemrp_inventory:removePickup')
AddEventHandler('redemrp_inventory:removePickup', function(obj)
    SetEntityAsMissionEntity(obj, false, true)
    NetworkRequestControlOfEntity(obj)
    local timeout = 0
    while not NetworkHasControlOfEntity(obj) and timeout < 5000 do
        timeout = timeout+100
        if timeout == 5000 then
            --print('Never got control of' ..obj)
        end
        Wait(100)
    end
    if NetworkHasControlOfEntity(obj) then
        --print("yeah we have control")
    end
    FreezeEntityPosition(obj , false)
    DeleteEntity(obj)
end)

RegisterNetEvent('redemrp_inventory:PickupAnim')
AddEventHandler('redemrp_inventory:PickupAnim', function()
    local dict = "amb_work@world_human_box_pickup@1@male_a@stand_exit_withprop"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), dict, "exit_front", 1.0, 8.0, -1, 1, 0, false, false, false)
    Wait(1200)
    PlaySoundFrontend("CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true, 1)
    Wait(1000)
    ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('redemrp_inventory:UpdatePickups')
AddEventHandler('redemrp_inventory:UpdatePickups', function(pick)
    DroppedItems = pick
end)

function GetForZone (crafts)
    local output = {}
    for k,v in pairs(crafts) do
        if v.type == CurrentCraftingType or v.type == "empty" then
            table.insert( output, v)
        end
    end
    return output
end

local PickupPromptGroup = GetRandomIntInRange(0, 0xffffff)
--print('PickupPromptGroup: ' .. PickupPromptGroup)
local PickupPrompt
local PromptActive = false

function SetupPickPrompt()
    Citizen.CreateThread(function()
        local str = 'Pick Up'
        PickupPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(PickupPrompt, 0xF84FA74F)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PickupPrompt, str)
        PromptSetEnabled(PickupPrompt, true)
        PromptSetVisible(PickupPrompt, true)
        PromptSetHoldMode(PickupPrompt, true)
        PromptSetGroup(PickupPrompt, PickupPromptGroup)
        PromptRegisterEnd(PickupPrompt)
    end)
end

local PickUpCommand = false
RegisterCommand("pickup", function(source, args)
	PickUpCommand = true
end)

Citizen.CreateThread(function()
    local wait = 1
    SetupPickPrompt()
    while true do
        Citizen.Wait(wait)

        local can_wait = true
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        if next(DroppedItems) == nil then
            Citizen.Wait(500)
        end

        if DroppedItems ~= nil then

            for k,v in pairs(DroppedItems) do
                local distance = Vdist(coords, v.coords.x, v.coords.y, v.coords.z)
                if distance <= 15.0 then
                    can_wait = false
                end

                if distance <= 5.0 then
                    DrawText3D(v.coords.x, v.coords.y, v.coords.z+0.5, v.label.." ".."["..v.amount.."]")
                end

                if distance <= 1.2 then
                    if  not PromptActive then
                        TaskLookAtEntity(playerPed, v.obj , 3000 ,2048 , 3)
                        local PromptGroupName  = CreateVarString(10, 'LITERAL_STRING', v.label)
                        PromptSetActiveGroupThisFrame(PickupPromptGroup, PromptGroupName)
                        if PromptHasHoldModeCompleted(PickupPrompt) or PickUpCommand then
                            PromptActive = true
			    PickUpCommand = false
                            TriggerServerEvent("redemrp_inventory:onPickup",k )

                        end
                    end
                end

            end
        end
        if can_wait == true then
            wait = 2000
        else
            wait = 1
        end
    end
end)

RegisterNetEvent('redemrp_inventory:ReEnablePrompt')
AddEventHandler('redemrp_inventory:ReEnablePrompt', function()
    PromptActive = false
end)


RegisterNetEvent('redemrp_inventory:OpenPrivateLocker')
AddEventHandler('redemrp_inventory:OpenPrivateLocker', function()
		LockerZone = "private"
     TriggerServerEvent("redemrp_inventory:GetLocker", LockerZone)
end)

--==================== D R O P =======================================



RegisterNUICallback('useitem', function(data)
  print("log", data)
    TriggerServerEvent("redemrp_inventory:use",data.data )
end)

RegisterNUICallback('giveItemSelected', function(data)
    local players = GetClosestPlayer()
    local elements     = {}
    if next(players) then
        for i=1, #players, 1 do
            foundPlayers = true
            table.insert(elements, {
                label = GetPlayerName(players[i]),
                player = GetPlayerServerId(players[i]),
                data = data
            })
        end

        SendNUIMessage({
            type = 1,
            inventory = isInventoryOpen,
            otherinventory = isOtherOpen,
            crafting = GetForZone(CraftingData),
            items = InventoryItems,
            otheritems = OtherItems,
            money = PlayerMoney,
            time =  GetClockHours()..":"..GetClockMinutes(),
            weight = InventoryWeight	,
            target = 0,
            players = elements
        })
    else
       --print("BrakGaraczy")
    end
end)

RegisterNUICallback('craft', function(data)
    TriggerServerEvent("redemrp_inventory:craft",data , CurrentCraftingType )
end)

RegisterNUICallback('giveitem', function(data)
    --print(data.target)
    --print(json.encode(data.item))
    TriggerServerEvent("redemrp_inventory:give", data.target , data.item)
end)

RegisterNetEvent('redemrp_inventory:SendLockers')
AddEventHandler('redemrp_inventory:SendLockers', function(lock)
    CreatedLockers = lock
end)

RegisterNetEvent('redemrp_inventory:SendCraftings')
AddEventHandler('redemrp_inventory:SendCraftings', function(craft, job)
    CreatedCraftings = craft
	if job ~= nil then
		PlayerJob = job
	end
end)

RegisterNetEvent('redemrp_inventory:OpenLocker')
AddEventHandler('redemrp_inventory:OpenLocker', function(id)
    LockerZone = id
	TriggerServerEvent("redemrp_inventory:GetLocker", LockerZone)
end)

Citizen.CreateThread(function()
    local wait = 1
    while true do
        Citizen.Wait(wait)

        local can_wait = true
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)


        if CreatedLockers ~= nil then

            for k,v in pairs(CreatedLockers) do
			if v.coords.x ~= "empty" then
                local distance = Vdist(coords, v.coords.x, v.coords.y, v.coords.z)

                if distance <= 15.0 then
                    can_wait = false
                end

                if distance <= 2.0 and not LockerZone then
                    LockerZone = k
                    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", "Press ~INPUT_JUMP~ to open the locker", Citizen.ResultAsLong())
                    Citizen.InvokeNative(0xFA233F8FE190514C, str)
                    Citizen.InvokeNative(0xE9990552DEC71600)
                end

                if distance > 2 and k == LockerZone then
                    local blank = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", " ", Citizen.ResultAsLong())
                    Citizen.InvokeNative(0xFA233F8FE190514C, blank)
                    Citizen.InvokeNative(0xE9990552DEC71600)
                    if isInventoryOpen then
                        SendNUIMessage({
                            type = 2
                        })
                        SetNuiFocus(false, false)
                        isOtherOpen = false
                        LockerZone = nil
                    else
                        LockerZone = nil
                    end
                end
                if LockerZone then
                    if IsControlJustReleased(0, 0xD9D0E1C0) then
                        TriggerServerEvent("redemrp_inventory:GetLocker", LockerZone)
                        Wait(1000)
                    end
                end
            end

        end
		end
        if can_wait == true then
            wait = 2000
        else
            wait = 1
        end
    end
end)

local CraftingTarget
Citizen.CreateThread(function()
    local wait = 1
    while true do
        Citizen.Wait(wait)

        local can_wait = true
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)


        if CreatedCraftings ~= nil then

            for k,v in pairs(CreatedCraftings) do
                local distance = Vdist(coords, v.coords.x, v.coords.y, v.coords.z)

                if distance <= 15.0 then
                    can_wait = false
                end

                if distance <= 2.0 and not CraftingTarget and (v.requireJob == PlayerJob or v.requireJob  == "empty") then
                    CraftingTarget = k
                    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", "Press ~INPUT_JUMP~ to open the crafting station", Citizen.ResultAsLong())
                    Citizen.InvokeNative(0xFA233F8FE190514C, str)
                    Citizen.InvokeNative(0xE9990552DEC71600)
                end

                if distance > 2 and k == CraftingTarget then
                    local blank = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", " ", Citizen.ResultAsLong())
                    Citizen.InvokeNative(0xFA233F8FE190514C, blank)
                    Citizen.InvokeNative(0xE9990552DEC71600)
                    if isInventoryOpen then
                        SendNUIMessage({
                            type = 2
                        })
                        SetNuiFocus(false, false)
                        isOtherOpen = false
                        CraftingTarget = nil
                    else
                        CraftingTarget = nil
                    end
                end
                if CraftingTarget == k and (v.requireJob == PlayerJob or v.requireJob  == "empty")then

                    if IsControlJustReleased(0, 0xD9D0E1C0) then
                                                CurrentCraftingType = v.type
						isInventoryOpen = true
                                                SendNUIMessage({
							type = 1,
							inventory = isInventoryOpen,
							otherinventory = isOtherOpen,
							crafting = GetForZone(CraftingData),
							items = InventoryItems,
							otheritems = OtherItems,
							money = PlayerMoney,
							time =  GetClockHours()..":"..GetClockMinutes(),
							weight = InventoryWeight	,
							target = 0,
						})
						SetNuiFocus(true, true)
                    end
                end
            end

        end

        if can_wait == true then
            wait = 2000
        else
            wait = 1
        end
    end
end)



RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    isInventoryOpen = false
    isOtherOpen = false
    LockerZone = nil
end)


function GetClosestPlayer(coords)
    local players         = GetActivePlayers()
    local closestDistance = 5
    local closestPlayer   = {}
    local coords          = coords
    local usePlayerPed    = false
    local playerPed       = PlayerPedId()
    local playerId        = PlayerId()

    if coords == nil then
        usePlayerPed = true
        coords       = GetEntityCoords(playerPed)
    end

    for i=1, #players, 1 do
        local target = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~=  playerId ) then
            local targetCoords = GetEntityCoords(target)
            local distance     = #(targetCoords - coords)

            if closestDistance > distance then
                table.insert(closestPlayer, players[i])
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end


-- RegisterNetEvent('redemrp_inventory:closeinv')
-- AddEventHandler('redemrp_inventory:closeinv', function()
--     SendNUIMessage({
--         type = 2
--     })
--     SetNuiFocus(false, false)
--     isInventoryOpen = false
--     isOtherOpen = false
--     CraftingTarget = nil
-- end)

-- RegisterNetEvent("Outlaws:openinv")
-- AddEventHandler("Outlaws:openinv", function()
--     if LockerZone then
--         TriggerServerEvent("redemrp_inventory:GetLocker", LockerZone)
--     else
--         isInventoryOpen = not isInventoryOpen

--         if isInventoryOpen then
--             for i,k in pairs(InventoryItems) do
--                 if k.type  == "item_weapon" and not WeaponsWithoutAmmo[k.name] then
--                     if HasPedGotWeapon(PlayerPedId(), tonumber(k.weaponHash)) then
--                         if UsedWeapons[tonumber(k.weaponHash)] and UsedWeapons[tonumber(k.weaponHash)].meta.uid == k.meta.uid then
--                             InventoryItems[i].amount = GetAmmoInPedWeapon(PlayerPedId(), tonumber(k.weaponHash))
--                         end
--                     end
--                 end
--             end
--             CurrentCraftingType = "empty"
--             SendNUIMessage({
--                 type = 1,
--                 inventory = isInventoryOpen,
--                 otherinventory = isOtherOpen,
--                 crafting = GetForZone(CraftingData),
--                 items = InventoryItems,
--                 otheritems = OtherItems,
--                 money = PlayerMoney,
--                 time =  GetClockHours()..":"..GetClockMinutes(),
--                 weight = InventoryWeight	,
--                 target = 0,
--             })

--             SetNuiFocus(true, true)
--         end
--     end
-- end)
