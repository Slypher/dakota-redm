local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local HOTBARSLOT_FROM_CONTROLHASH = {
    [`INPUT_SELECT_QUICKSELECT_SIDEARMS_LEFT`] = 1,
    [`INPUT_SELECT_QUICKSELECT_DUALWIELD`] = 2,
    [`INPUT_SELECT_QUICKSELECT_SIDEARMS_RIGHT`] = 3,
    [`INPUT_SELECT_QUICKSELECT_UNARMED`] = 4,
    [`INPUT_SELECT_QUICKSELECT_MELEE_NO_UNARMED`] = 5,
}

local gWhereWeaponIsAtSlot = {}

local gHasReceivedFirstAck = false
local gIsReloadingOrShooting = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if IsControlJustPressed(0, 0xC1989F95) and not opened then
                TriggerServerEvent("FRP:INVENTORY:OpenPersonal")
                opened = true
            end

            if IsControlJustPressed(0, 0x8AAA0AD4) and not opened  then
                SendNUIMessage(
                    {
                        type = "showHotbar"
                    }
                )
                Wait(500)
            end

            for controlHash, hotbarSlot in pairs(HOTBARSLOT_FROM_CONTROLHASH) do
                DisableControlAction(controlHash, true)

                if IsDisabledControlJustPressed(0, controlHash) then
                    SendNUIMessage(
                        {
                            type = 'setActiveHotbarSlot',
                            data = hotbarSlot,
                        }
                    )
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()

        local playerPed = PlayerPedId()

        RemoveAllPedWeapons(playerPed, true, true)
        
        -- RemoveAllPedAmmo
        Citizen.InvokeNative(0x1B83C0DEEBCBB214, playerPed)

        local lastUsedWeaponHash
        local currUsedWeaponHash

        local currUsedAmmoHash

        local isReloading = false
        local ammoInClipBeforeReloading

        while true do
            Citizen.Wait(0)

            local ped = PlayerPedId()

            if gHasReceivedFirstAck then
                local _, currentWeapon = GetCurrentPedWeapon(ped, true, 0, true)

                if currUsedWeaponHash ~= currentWeapon then
                    lastUsedWeaponHash = currUsedWeaponHash

                    currUsedWeaponHash = currentWeapon

                    -- GetPedAmmoTypeFromWeapon
                    currUsedAmmoHash = Citizen.InvokeNative(0x7FEAD38B326B9F74, ped, currUsedWeaponHash)
                end

                if currentWeapon ~= `weapon_lasso` then
                    -- IsPedReloading
                    if Citizen.InvokeNative(0x24B100C68C645951, ped) then
                        if not isReloading then
                            isReloading = true

                            _, ammoInClipBeforeReloading = GetAmmoInClip(ped, currentWeapon)
                        end
                    else
                        if isReloading then
                            isReloading = false

                            _, ammoInClipAfterReloading = GetAmmoInClip(ped, currentWeapon)

                            local ammoAddedAmount = ammoInClipAfterReloading - ammoInClipBeforeReloading

                            local reloadedWeaponSlotId = getWeaponSlotIdFromHash(currentWeapon)

                            local currWeaponEntity = Citizen.InvokeNative(0x3B390A939AF0B5FC, ped, 0)

                            local ammoHashThisFrame = Citizen.InvokeNative(0x7E7B19A4355FEE13, ped, currWeaponEntity)

                            if reloadedWeaponSlotId then
                                TriggerServerEvent('net.playerReloadedInventoryWeapon', reloadedWeaponSlotId, ammoHashThisFrame, ammoAddedAmount)
                            end
                        end
                    end

                    if IsPedShooting(ped) or IsPedPlantingBomb(ped) then

                        -- #WARNING: Vai bloquear a thread toda, nada mais vai executar, talvez dê merda.
                        while IsPedPlantingBomb(ped) do
                            Wait(0)
                        end

                        local weaponHashUsedToShoot = currUsedWeaponHash

                        -- O player usou uma arma jogável e então aconteceu uma coisa ou outra:
                        -- O player mudou ficou sem arma nenhuma na mão
                        -- ou ele trocou para outra arma jogável.

                        -- IsWeaponThrowable
                        if Citizen.InvokeNative(0x30E7C16B12DA8211, lastUsedWeaponHash)then
                        
                            -- GetCoordsOfProjectileTypeWithinDistance
                            local hasProjectile, projectilePos = Citizen.InvokeNative(0xD73C960A681052DF, ped, lastUsedWeaponHash, 2.0, Citizen.PointerValueVector(), false, true, Citizen.ReturnResultAnyway())
                            if hasProjectile then
                                weaponHashUsedToShoot = lastUsedWeaponHash
                            end
                        end

                        local shotWeaponSlotId = getWeaponSlotIdFromHash(weaponHashUsedToShoot)

                        -- Remover o item caso seja um throwable
                        TriggerServerEvent('net.playerShotInventoryWeapon', shotWeaponSlotId)
                    end

                    -- Verificar quando o player muda de tipo de munição e
                    -- enviar para o servidor para poder zerar o numero de munições no clip.
                end
            end
        end
    end
)

function getWeaponSlotIdFromHash(weaponHash)
    for weaponId, slotId in pairs(gWhereWeaponIsAtSlot) do
        if weaponHash == GetHashKey(weaponId) then
            return slotId
        end
    end

    return nil
end

--[[
local currentlyTryingToSendItem = false
local prompt_senditem

function startLookingForAPlayerToSend(slotId)
    if currentlyTryingToSendItem then
         return
     end

     closeInv()

     currentlyTryingToSendItem = true

     local lastTargetPlayerServerId = nil

     prompt_senditem = PromptRegisterBegin()
     PromptSetControlAction(prompt_senditem, 0x07CE1E61)
     PromptSetText(prompt_senditem, CreateVarString(10, "LITERAL_STRING", "Enviar2"))
     PromptSetEnabled(prompt_senditem, true)
     PromptSetVisible(prompt_senditem, false)
     PromptSetHoldMode(prompt_senditem, true)
     PromptRegisterEnd(prompt_senditem)

     Citizen.CreateThread(
         function()
             local timeRemaining = 10
             while currentlyTryingToSendItem do
                 local y, entity = GetPlayerTargetEntity(PlayerId())

                 lastTargetPlayerServerId = nil

                 if y then
                     for _, pid in pairs(GetActivePlayers()) do
                         if NetworkIsPlayerActive(pid) then
                             local pped = GetPlayerPed(pid)
                             if entity == pped then
                                 local serverId = GetPlayerServerId(pid)
                                 if lastTargetPlayerServerId ~= serverId then
                                     lastTargetPlayerServerId = serverId
                                     PromptSetVisible(prompt_senditem, true)
                                     PromptSetGroup(prompt_senditem, PromptGetGroupIdForTargetEntity(entity))

                                     local pPosition = GetEntityCoords(PlayerPedId())
                                     local tPosition = GetEntityCoords(entity)

                                     local dist = #(pPosition - tPosition)

                                     if dist <= 1.5 then
                                         PromptSetEnabled(prompt_senditem, true)
                                     else
                                         PromptSetEnabled(prompt_senditem, false)
                                     end

                                     break
                                 end
                             end
                         end
                     end
                 end

                 if lastTargetPlayerServerId == nil then
                     PromptSetVisible(prompt_senditem, false)
                 end

                 Citizen.Wait(250)

                 timeRemaining = timeRemaining - 0.25

                 if timeRemaining <= 0 then
                     currentlyTryingToSendItem = false
                 end
             end
         end
     )

     Citizen.CreateThread(
         function()
             while currentlyTryingToSendItem do
                 Citizen.Wait(0)
                 if lastTargetPlayerServerId ~= nil then
                     if PromptHasHoldModeCompleted(prompt_senditem) then
                         PromptDelete(prompt_senditem)
                         prompt_senditem = nil

                         currentlyTryingToSendItem = false
                         TriggerServerEvent("FRP:INVENTORY:SendToPlayer", slotId, lastTargetPlayerServerId)
                     end
                 end
             end

             PromptDelete(prompt_senditem)
             prompt_senditem = nil
         end
     )
 end]]--

RegisterNetEvent("FRP:INVENTORY:ToggleHotbar")
AddEventHandler(
    "FRP:INVENTORY:ToggleHotbar",
    function(bool)
        SendNUIMessage(
            {
                type = "ToggleHotbar",
                val = bool
            }
        )
    end
)

RegisterNetEvent("FRP:INVENTORY:closeInv")
AddEventHandler(
    "FRP:INVENTORY:closeInv",
    function()
        closeInv()
    end
)

RegisterNetEvent("FRP:INVENTORY:NUICloseNoCallback")
AddEventHandler(
    "FRP:INVENTORY:NUICloseNoCallback",
    function()
        closeInv(false)
    end
)

RegisterNetEvent("FRP:INVENTORY:openAsPrimary")
AddEventHandler(
    "FRP:INVENTORY:openAsPrimary",
    function(slots, inventoryWeight, inventoryMaxWeight)
        slots = computeSlots(slots, true)

        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                type = "clearPrimary",
                primarySlots = slots,
                primaryWeight = inventoryWeight,
                primaryMaxWeight = inventoryMaxWeight
            }
        )
    end
)

RegisterNetEvent("FRP:INVENTORY:openAsSecondary")
AddEventHandler(
    "FRP:INVENTORY:openAsSecondary",
    function(slots, inventoryWeight, inventoryMaxWeight)
        slots = computeSlots(slots, false)

        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                type = "clearSecondary",
                secondarySlots = slots,
                secondaryWeight = inventoryWeight,
                secondaryMaxWeight = inventoryMaxWeight
            }
        )
    end
)

RegisterNetEvent("FRP:INVENTORY:PrimarySyncSlots")
AddEventHandler(
    "FRP:INVENTORY:PrimarySyncSlots",
    function(slots, inventoryWeight)
        slots = computeSlots(slots, true)

        SendNUIMessage(
            {
                primarySlots = slots,
                primaryWeight = inventoryWeight
            }
        )
    end
)

RegisterNetEvent("FRP:INVENTORY:SecondarySyncSlots")
AddEventHandler(
    "FRP:INVENTORY:SecondarySyncSlots",
    function(slots, inventoryWeight)
        slots = computeSlots(slots, false)

        SendNUIMessage(
            {
                secondarySlots = slots,
                secondaryWeight = inventoryWeight
            }
        )
    end
)

RegisterNUICallback(
    "use",
    function(cb)
        TriggerServerEvent("FRP:INVENTORY:Use", tonumber(cb.slotId))
    end
)

RegisterNUICallback(
    "drop",
    function(cb)
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        TriggerServerEvent("FRP:INVENTORY:Drop", tonumber(cb.slotId), x, y, z)
    end
)

-- RegisterNUICallback(
--     "startsendingslot",
--     function(cb)
--         -- startLookingForAPlayerToSend(cb.slotId)
--         TriggerEvent("FRP:PLAYERPROMPTS:TryToSendItemSlotToTarget", cb.slotId)
--     end
-- )

RegisterNUICallback(
    "moveSlotToPrimary",
    function(cb)
        TriggerServerEvent("FRP:INVENTORY:moveSlotToPrimary", cb.slotId, cb.itemAmount)
    end
)

RegisterNUICallback(
    "moveSlotToSecondary",
    function(cb)
        TriggerServerEvent("FRP:INVENTORY:moveSlotToSecondary", cb.slotId, cb.itemAmount)
    end
)

RegisterNUICallback(
    "primarySwitchSlot",
    function(cb)
        TriggerServerEvent("FRP:INVENTORY:PrimarySwitchSlot", cb.slotFrom, cb.slotTo, cb.itemAmount)
    end
)

RegisterNUICallback(
    "secondarySwitchSlot",
    function(cb)
        TriggerServerEvent("FRP:INVENTORY:SecondarySwitchSlot", cb.slotFrom, cb.slotTo, cb.itemAmount)
    end
)

RegisterNUICallback(
    "interactWithHotbarSlot",
    function(cb)
        local itemId = cb.itemId or "unarmed"
        local weaponId = "weapon_" .. itemId
        local weaponHash = GetHashKey(weaponId)

        local ped = PlayerPedId()

        local _, currentWeapon = GetCurrentPedWeapon(ped, true, 0, true)
        if currentWeapon ~= weaponHash then
            SetCurrentPedWeapon(ped, weaponHash, true, 0, false, false)
        end
    end
)

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeInv()
    end
)

AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        closeInv()
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        if prompt_senditem ~= nil then
            PromptDelete(prompt_senditem)
        end
    end
)

function closeInv(callback)
    SetNuiFocus(false, false)
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    opened = false
    if callback == nil or callback == true then
    TriggerServerEvent("FRP:INVENTORY:Close")
    end
end

function computeSlots(table, asPrimary)
    local ped = PlayerPedId()

    for slotId, values in pairs(table) do
        local itemInfo = ItemList[values.name]

        if itemInfo ~= nil then
            local itemId = values.name
            local itemAmount = values.amount[1]

            local weaponMetadata = values.info

            if weaponMetadata == '[]' then
                weaponMetadata = { }
            end

            -- Valor padrões para armas jogáveis.
            local ammoInClip = -1
            local ammoInWeapon = -1

            local selectedAmmoType = weaponMetadata.selected_ammo_type

            if selectedAmmoType then
                local ammoCountOfType = weaponMetadata[selectedAmmoType] or 0

                ammoInClip = weaponMetadata.ammo_in_clip or 0
                ammoInWeapon = math.max(ammoCountOfType - ammoInClip, 0)
            end
            
            values.itemName = itemInfo.name
            values.itemDescription = itemInfo.description or "Descrição"
            values.itemStackSize = itemInfo.stackSize or 1

            local itemType = itemInfo.type

            if itemInfo.type == "weapon" and asPrimary then
                values.amount[2] = ammoInClip
                values.amount[3] = ammoInWeapon

                if (slotId >= 129 and slotId <= 132) then
                    local weaponId = "weapon_" .. itemId
                    local weaponHash = GetHashKey(weaponId)

                    -- Armas jogáveis só podem ter uma munição por vez.
                    --
                    -- IsWeaponThrowable
                    if Citizen.InvokeNative(0x30E7C16B12DA8211, weaponHash) then
                        ammoInWeapon = 1
                    end

                    gWhereWeaponIsAtSlot[weaponId] = nil

                    if itemAmount > 0 then
                        for wId, slot in pairs(gWhereWeaponIsAtSlot) do
                            if slot == slotId and weaponId ~= wId then
                                local foundHash = GetHashKey(wId)
                                SetPedAmmo(ped, foundHash, 0)
                                RemoveWeaponFromPed(ped, foundHash)
                                gWhereWeaponIsAtSlot[wId] = nil
                            end
                        end

                        if not HasPedGotWeapon(ped, weaponHash, false) then
                            -- GiveWeaponToPed(ped, weaponHash, ammoInWeapon, false, false)
                            -- cAPI.giveWeapon(weaponId, ammoInWeapon, false)
                            Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, weaponHash, ammoInWeapon, true, true)
                        end

                        local selectedAmmoHash = GetHashKey(selectedAmmoType)

                        for key, value in pairs(weaponMetadata) do
                            if string.find(key, 'ammo_') and tonumber(value) ~= nil then

                                local ammoType = key
                                local ammoHash = GetHashKey(ammoType)

                                local amountCount = value

                                -- Não funciona :/
                                --
                                -- EnableAmmoTypeForPedWeapon
                                -- Citizen.InvokeNative(0x23FB9FACA28779C1, ped, weaponHash, ammoHash)

                                -- GetPedAmmoByType
                                local ammoOfType = Citizen.InvokeNative(0x39D22031557946C1, ped, ammoHash, Citizen.ResultAsInteger())

                                -- Remover o excesso de munição
                                if ammoOfType > amountCount then
                                    local ammoExcess = ammoOfType - amountCount

                                    -- RemoveAmmoFromPedByType
                                    Citizen.InvokeNative(0xB6CFEC32E3742779, ped, ammoHash, ammoExcess, `REMOVE_REASON_DEBUG`)
                                end

                                -- SetPedAmmoByType
                                Citizen.InvokeNative(0x5FD1E1F011E76D7E, ped, ammoHash, amountCount)
                            end
                        end

                        -- SetPedWeaponAmmoType
                        Citizen.InvokeNative(0xCC9C4393523833E2, ped, weaponHash, selectedAmmoHash)

                        SetAmmoInClip(ped, weaponHash, ammoInClip)

                        gWhereWeaponIsAtSlot[weaponId] = slotId
                    else
                        if HasPedGotWeapon(ped, weaponHash, false) then
                            SetPedAmmo(ped, weaponHash, 0)
                            RemoveWeaponFromPed(ped, weaponHash)
                        end
                    end
                end
            end
        end
    end

    gHasReceivedFirstAck = true

    return table
end

RegisterCommand(
    "enviar",
    function(source, args, raw)
        if #args < 2 then
            cAPI.notify("error", "Sintaxe: /enviar nomedoitem 2")
            return
        end

        if cAPI.IsWanted() then
            TriggerEvent('FRP:NOTIFY:Simple', 'Você ainda está como procurado, não pode transferir um item. ', 10000)
            return
        end

       -- local targetPlayerServerId = cAPI.getNearestPlayer(1.5)

        local targetPlayerServerId, distance = GetClosestPlayer()
       
        if targetPlayerServerId == nil then
            cAPI.notify('error', 'Ninguem por perto')
            return
        end

        local itemAmountArg
        local itemAmount

        for i = 1, #args do
            if tonumber(args[i]) ~= nil then
                itemAmountArg = i
                itemAmount = tonumber(args[i])
            end
        end

        local concated = args[1]

        if #args > 2 then
            for i = 2, itemAmountArg - 1 do
                concated = concated .. " " .. args[i]
            end
        end

        local lastDistance
        local lastName
        local lastItemId

        for itemId, d in pairs(ItemList) do
            local dist = levenshtein_distance(concated, d.name)

            if lastDistance == nil or dist < lastDistance then
               lastDistance = dist
               lastName = d.name
               lastItemId = itemId
            end
        end

        if lastItemId == 'money' or lastItemId == 'gold' then
            itemAmount = itemAmount * 100
        end

        if targetPlayerServerId ~= nil then
            local nearestPed = GetPlayerPed(player)     
            if distance ~= -1 and distance <= 3.0 then
                TriggerServerEvent("FRP:INVENTORY:SendItemIdAndAmountToPlayer", lastItemId, itemAmount, targetPlayerServerId) 
            end
        end
  
    end,
    false
)

local myPlants = {}
local myPlants2 = {}
local myPlants3 = {}
local prompt, prompt2 = false, false
local DelPrompt
local PlantPrompt

function SetupDelPrompt()
    Citizen.CreateThread(function()
        local str = 'Jogar Fora'
        DelPrompt = PromptRegisterBegin()
        PromptSetControlAction(DelPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(DelPrompt, str)
        PromptSetEnabled(DelPrompt, false)
        PromptSetVisible(DelPrompt, false)
        PromptSetHoldMode(DelPrompt, true)
        PromptRegisterEnd(DelPrompt)

    end)
end


function SetupPlantPrompt()
    Citizen.CreateThread(function()
        local str = 'Plantar'
        PlantPrompt = PromptRegisterBegin()
        PromptSetControlAction(PlantPrompt, 0x07CE1E61)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PlantPrompt, str)
        PromptSetEnabled(PlantPrompt, false)
        PromptSetVisible(PlantPrompt, false)
        PromptSetHoldMode(PlantPrompt, true)
        PromptRegisterEnd(PlantPrompt)

    end)
end

local isPlanting = false

RegisterNetEvent('poke_planting:planto1')
AddEventHandler('poke_planting:planto1', function(itemn, hash1, hash2, hash3)
    local myPed = PlayerPedId()
    if isPlanting == false then
        isPlanting = true
        local itemname = tostring(itemn)
        local pHead = GetEntityHeading(myPed)
        local pos = GetEntityCoords(myPed, true)
        local plant1 = hash1
            if not HasModelLoaded(plant1) then
                RequestModel(plant1)
            end

            while not HasModelLoaded(plant1) do
                Citizen.Wait(100)
            end

            local placing = true
            local tempObj = CreateObject(plant1, pos.x, pos.y, pos.z, true, true, false)
            SetEntityHeading(tempObj, pHead)
            SetEntityAlpha(tempObj, 51)
            AttachEntityToEntity(tempObj, myPed, 0, 0.0, 1.0, -0.7, 0.0, 0.0, 0.0, true, false, false, false, false)

            while placing do
                Wait(1)
                if prompt == false then
                PromptSetEnabled(PlantPrompt, true)
                PromptSetVisible(PlantPrompt, true)
                prompt = true
                end
                if PromptHasHoldModeCompleted(PlantPrompt) then
                PromptSetEnabled(PlantPrompt, false)
                PromptSetVisible(PlantPrompt, false)
                PromptSetEnabled(DelPrompt, false)
                PromptSetVisible(DelPrompt, false)
                prompt = false
                prompt2 = false
                local pPos = GetEntityCoords(tempObj, true)
                DeleteObject(tempObj)
                animacion(itemname)
                local object = CreateObject(plant1, pPos.x, pPos.y, pPos.z, true, true, false)
                local plantCount = #myPlants+1
                myPlants[plantCount] = {["object"] = object, ['x'] = pPos.x, ['y'] = pPos.y, ['z'] = pPos.z, ['stage'] = 1, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3,}
                PlaceObjectOnGroundProperly(myPlants[plantCount].object)
                SetEntityAsMissionEntity(myPlants[plantCount].object, true)
                SetModelAsNoLongerNeeded(plant1)
                TriggerEvent("FRP:NOTIFY:Simple", 'Pronto, agora é só esperar.', 5)
                break
                end
                if prompt2 == false then
                PromptSetEnabled(DelPrompt, true)
                PromptSetVisible(DelPrompt, true)
                prompt2 = true
                end
                if PromptHasHoldModeCompleted(DelPrompt) then
                PromptSetEnabled(PlantPrompt, false)
                PromptSetVisible(PlantPrompt, false)
                PromptSetEnabled(DelPrompt, false)
                PromptSetVisible(DelPrompt, false)
                prompt = false
                prompt2 = false
                DeleteObject(tempObj)
                isPlanting = false
                break
                end
            end
    else
        TriggerEvent("FRP:NOTIFY:Simple", 'Termine o que você está fazendo', 5)
    end
end)


RegisterNetEvent('poke_planting:regar1')
AddEventHandler('poke_planting:regar1', function(source)
    if isPlanting == false then
        local pos = GetEntityCoords(PlayerPedId(), true)
        --local plant2 = GetHashKey("CRP_TOBACCOPLANT_AB_SIM")
        local object = nil
        local key = nil
        local hash1, hash2, hash3 = nil, nil, nil
        local planta = GetEntityCoords(object, true)
        local x, y, z = nil, nil, nil
        
        for k, v in ipairs(myPlants) do
            if v.stage == 1 then
                if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 2.0 then
                    object = v.object
                    key = k
                    x, y, z = v.x, v.y, v.z
                    hash1, hash2, hash3 = v.hash, v.hash2, v.hash3
                    break
                end
            end
        end
        
        local plant2 = hash2
        
        if DoesEntityExist(object) then
            isPlanting = true
            animacion2()

            RequestModel(plant2)

            while not HasModelLoaded(plant2) do
                Citizen.Wait(1)
            end

            DeleteObject(object)
            table.remove(myPlants, key)
            Wait(800)
            local object = CreateObject(plant2, x, y, z, true, true, false)
            local plantCount = #myPlants2+1
            myPlants2[plantCount] = {["object"] = object, ['x'] = x, ['y'] = y, ['z'] = z, ['stage'] = 2, ['timer'] = 150, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3}
            PlaceObjectOnGroundProperly(myPlants2[plantCount].object)
            SetEntityAsMissionEntity(myPlants2[plantCount].object, true)
            SetModelAsNoLongerNeeded(plant2)
            isPlanting = false
        end
    else
        TriggerEvent("FRP:NOTIFY:Simple", 'Termine o que você está fazendo!', 5)
    end
end)

RegisterNetEvent('poke_planting:fin2')
AddEventHandler('poke_planting:fin2', function(object2, x, y, z, key, hash1, hash2, hash3)
    --local plant3 = GetHashKey("CRP_TOBACCOPLANT_AC_SIM")
    local planta2 = GetEntityCoords(object2, true)
    
    TriggerEvent("FRP:NOTIFY:Simple", 'Seu plantiu está pronto para colheita!', 20)
    
    local plant3 = hash3
    
    RequestModel(plant3)

    while not HasModelLoaded(plant3) do
        Citizen.Wait(1)
    end
    
    DeleteObject(object2)
    Wait(800)
    local object3 = CreateObject(plant3, x, y, z, true, true, false)
    PlaceObjectOnGroundProperly(object3)
    local plantCount = #myPlants3+1
    myPlants3[plantCount] = {["object"] = object3, ['x'] = x, ['y'] = y, ['z'] = z, ['stage'] = 3, ['prompt'] = false, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3,}
    PlaceObjectOnGroundProperly(myPlants3[plantCount].object)
    SetEntityAsMissionEntity(myPlants3[plantCount].object, true)
    SetModelAsNoLongerNeeded(plant3)
end)


function harvestPlant(key)
    if isPlanting == false then
        isPlanting = true
        local playerpedid = PlayerPedId()
        if IsPedMale(playerpedid) then
            TaskStartScenarioInPlace(playerpedid, `WORLD_HUMAN_FARMER_WEEDING`, 10000, true, false, false, false)
        else
            RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
            while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
                    Citizen.Wait( 100 )
            end
            TaskPlayAnim(playerpedid, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_a", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
        end
        Wait(10000)
        isPlanting = false
        ClearPedTasksImmediately(playerpedid)
        DeleteObject(myPlants3[key].object)
        table.remove(myPlants3, key)
    else
        TriggerEvent("FRP:NOTIFY:Simple", 'Termine o que você está fazendo', 5)
    end
end

Citizen.CreateThread(function()
    SetupPlantPrompt()
    SetupDelPrompt()
    while true do
        Wait(1000)
        local pos = GetEntityCoords(PlayerPedId(), true)
                if myPlants2 ~= nil then
                    for k, v in ipairs(myPlants2) do
                        if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 65.0 then
                            if v.stage == 2 then
                                v.timer = v.timer-1
                                if v.timer == 0 then
                                    v.stage = 3
                                    local key = k
                                    TriggerEvent('poke_planting:fin2', v.object, v.x, v.y, v.z, key, v.hash, v.hash2, v.hash3)
                                end
                            end    
                        end
                    end
                end
                if myPlants3 ~= nil then
                    for k, v in ipairs(myPlants3) do
                        if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 15.0 then
                            if v.stage == 3 and GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) <= 2.0 then
                                if not v.prompt then
                                    v.prompt = true
                                end
                            end   
                            if v.stage == 3 and GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) > 2.1 then
                                if v.prompt then
                                    v.prompt = false
                                end
                            end
                        end
                    end
                end
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
        local pos = GetEntityCoords(PlayerPedId(), true)
		if myPlants ~= nil  then
			for k, v in ipairs(myPlants) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 3.0 then
					if v.stage == 1 then
                        DrawText3D(v.x, v.y, v.z, 'Precisa de água!')
					end
				end
			end
        end
        if myPlants2 ~= nil then
            for k, v in ipairs(myPlants2) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 3.0 then
					if v.stage == 2 then
                        DrawText3D(v.x, v.y, v.z, ''.. v.timer..' até a colheita')
					end
				end
			end
        end
        if myPlants3 ~= nil then
            for k, v in ipairs(myPlants3) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 3.0 then
					if v.stage == 3 then
                        DrawText3D(v.x, v.y, v.z, 'Colher [L-Alt]')
					end
					if v.prompt then
                        if isPlanting == false then
                            if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0x8AAA0AD4) then
                                local key = k
                                harvestPlant(key)
                                TriggerServerEvent("poke_planting:giveitem", v.hash3)
                            end
                        end
					end
				end
			end
        end
	end
end)
		
function animacion(itemname)
    local itemn = tostring(itemname)
    local playerpedid = PlayerPedId()
    if IsPedMale(playerpedid) then
        PromptSetEnabled(prompt, true)
        PromptSetVisible(prompt, true)
        TaskStartScenarioInPlace(playerpedid, `WORLD_HUMAN_FARMER_RAKE`, 15000, true, false, false, false)
        Wait(18000)
        ClearPedTasksImmediately(playerpedid)
        Wait(1000)
        TaskStartScenarioInPlace(playerpedid, `WORLD_HUMAN_FEED_CHICKEN`, 15000, true, false, false, false)
        Wait(18000)
        ClearPedTasksImmediately(playerpedid)
        isPlanting = false
        TriggerServerEvent("planting_removeseed",itemn)
        ClearPedTasksImmediately(playerpedid)
        PromptSetEnabled(prompt, false)
        PromptSetVisible(prompt, false)
    else
        PromptSetEnabled(prompt, true)
        PromptSetVisible(prompt, true)

        RequestAnimDict("amb_work@world_human_farmer_rake@male_a@idle_a")
        while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_rake@male_a@idle_a" ) ) do
                Citizen.Wait( 100 )
        end
        TaskPlayAnim(playerpedid, "amb_work@world_human_farmer_rake@male_a@idle_a", "idle_b", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
        local rake = `p_rake03x`
        --print(MissionObjectModel)
        local playerCo = GetEntityCoords(playerpedid)
        local object1 = CreateObject(rake, playerCo.x,playerCo.y,playerCo.z, true, true, true)
        --print(object1)
        SetEntityAsMissionEntity(object1, true, false)
        SetModelAsNoLongerNeeded(rake)
        AttachEntityToEntity(object1, playerpedid, 381, -0.04, 0.24, -0.94, -4.0, 16.0, 273.0, false, false, true, false, 0, true, false, false)
        Wait(10000)
        ClearPedTasksImmediately(playerpedid)
        DeleteObject(object1)
        Wait(1000)
        --TaskStartScenarioInPlace(playerpedid, `WORLD_HUMAN_FARMER_WEEDING`, 20000, true, false, false, false)
        RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
        while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
                Citizen.Wait( 100 )
        end
        TaskPlayAnim(playerpedid, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_a", 8.0, -8.0, 20000, 1, 0, true, 0, false, 0, false)
        Wait(20000)
        isPlanting = false
        TriggerServerEvent("planting_removeseed",itemn)
        ClearPedTasksImmediately(playerpedid)
        PromptSetEnabled(prompt, false)
        PromptSetVisible(prompt, false)
    end
end

function animacion2()
    local playerpedid = PlayerPedId()
	TaskStartScenarioInPlace(playerpedid, `WORLD_HUMAN_BUCKET_POUR_LOW`, 5000, true, false, false, false) 
    Wait(6000)
    isPlanting = false
    ClearPedTasksImmediately(playerpedid)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)

    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
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
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 52, 52, 52, 190, 0)
end

function levenshtein_distance(str1, str2)
    local len1, len2 = #str1, #str2
    local char1, char2, distance = {}, {}, {}
    str1:gsub(
        ".",
        function(c)
            table.insert(char1, c)
        end
    )
    str2:gsub(
        ".",
        function(c)
            table.insert(char2, c)
        end
    )
    for i = 0, len1 do
        distance[i] = {}
    end
    for i = 0, len1 do
        distance[i][0] = i
    end
    for i = 0, len2 do
        distance[0][i] = i
    end
    for i = 1, len1 do
        for j = 1, len2 do
            distance[i][j] = math.min(distance[i - 1][j] + 1, distance[i][j - 1] + 1, distance[i - 1][j - 1] + (char1[i] == char2[j] and 0 or 1))
        end
    end
    return distance[len1][len2]
end


function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetPlayers(), -1, -1
    local coords, usePlayerPed = coords, false
    local playerPed, playerId = PlayerPedId(), PlayerId()
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    for i = 1, #players, 1 do
        local target = GetPlayerPed(players[i])
        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
            local targetCoords = GetEntityCoords(target)
            local distance = #(coords - targetCoords)
            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end