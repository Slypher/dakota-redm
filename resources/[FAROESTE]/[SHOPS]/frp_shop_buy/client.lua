local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

local closestShopId
local closestShopVector

local prompt
local prompt_group
local prompt_group_name

local sentFirstData = false


-----------------------------------------------------------------------------------------------------------------------------------------
-- PED PART
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
        local modelName = 'U_M_M_TumBartender_01' -- SALOON VALENTINE
        local modelHash = GetHashKey(modelName)
        while not HasModelLoaded(modelHash) do
            Wait(100)
            RequestModel(modelHash)
        end
        local ped = CreatePed(modelHash, -313.366,805.996,117.955,267.0, false, true)
        Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
        FreezeEntityPosition(ped,true)
        SetEntityInvincible(ped,true)
        SetBlockingOfNonTemporaryEvents(ped,true)
end)
Citizen.CreateThread(function()
    local modelName = 'U_F_M_TumGeneralStoreOwner_01' -- ARMAZEM VALENTINE
    local modelHash = GetHashKey(modelName)
    while not HasModelLoaded(modelHash) do
        Wait(100)
        RequestModel(modelHash)
    end
    local ped = CreatePed(modelHash, -324.078,804.157,116.882,289.0, false, true)
    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
    FreezeEntityPosition(ped,true)
    SetEntityInvincible(ped,true)
    SetBlockingOfNonTemporaryEvents(ped,true)
end)

Citizen.CreateThread(function()
    local modelName = 'U_M_Y_CzPHomesteadSon_01' -- HOTEL VALENTINE
    local modelHash = GetHashKey(modelName)
    while not HasModelLoaded(modelHash) do
        Wait(100)
        RequestModel(modelHash)
    end
    local ped = CreatePed(modelHash, -325.825,773.059,116.436,20.0, false, true)
    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
    FreezeEntityPosition(ped,true)
    SetEntityInvincible(ped,true)
    SetBlockingOfNonTemporaryEvents(ped,true)
end)

Citizen.CreateThread(function()
    local modelName = 'U_M_O_BHT_DOCWORMWOOD' -- BANCO VALENTINE
    local modelHash = GetHashKey(modelName)
    while not HasModelLoaded(modelHash) do
        Wait(100)
        RequestModel(modelHash)
    end
    local ped = CreatePed(modelHash, -308.108,773.999,117.703,20.0, false, true)
    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
    FreezeEntityPosition(ped,true)
    SetEntityInvincible(ped,true)
    SetBlockingOfNonTemporaryEvents(ped,true)
end)

Citizen.CreateThread(function()
    local modelName = 'U_M_M_ValDoctor_01' -- DOCTOR VALENTINE
    local modelHash = GetHashKey(modelName)
    while not HasModelLoaded(modelHash) do
        Wait(100)
        RequestModel(modelHash)
    end
    local ped = CreatePed(modelHash,  -287.991,804.201,118.386,290.0, false, true)
    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
    FreezeEntityPosition(ped,true)
    SetEntityInvincible(ped,true)
    SetBlockingOfNonTemporaryEvents(ped,true)
end)

Citizen.CreateThread(function()
    local modelName = 'S_M_M_ValCowpoke_01' -- PRISIONEIRO VALENTINE
    local modelHash = GetHashKey(modelName)
    while not HasModelLoaded(modelHash) do
        Wait(100)
        RequestModel(modelHash)
    end
    local ped = CreatePed(modelHash,  -271.402,806.932,118.371,45.0, false, true)
    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
    FreezeEntityPosition(ped,true)
    SetEntityInvincible(ped,true)
    SetBlockingOfNonTemporaryEvents(ped,true)
end)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
                        
            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)

            local foundShopId
            local foundShopVector
            local lastDist

            for shopId, shopLocations in pairs(Config.ShopLocations) do
                for _, locationData in pairs(shopLocations) do
                    local x, y, z, _ = table.unpack(locationData)
                    local vec = vec3(x, y, z)
                    local dist = #(pCoords - vec)
                    if (foundShopVector == nil and dist <= 10.0) or (lastDist ~= nil and dist < lastDist)  then
                        foundShopId = shopId
                        foundShopVector = vec
                        lastDist = dist
                    end
                end
            end

            if foundShopId ~= nil then
                prompt_group_name = CreateVarString(10, "LITERAL_STRING", foundShopId)

            end

            closestShopId = foundShopId
            closestShopVector = foundShopVector
        end
    end
)

function audio()                    
            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)

            local foundShopId
            local foundShopVector
            local lastDist

            for shopId, shopLocations in pairs(Config.Charles) do
                for _, locationData in pairs(shopLocations) do
                    local x, y, z, _ = table.unpack(locationData)
                    local vec = vec3(x, y, z)
                    local dist = #(pCoords - vec)
                    if (foundShopVector == nil and dist <= 3.0) then
                        foundShopId = shopId
                    end
                end
            end

            if foundShopId == "Charles" then
                TriggerEvent("vrp_sound:source",'charles',0.95)
                print(foundShopId)
            end
            if foundShopId == "Armeiro" then
                TriggerEvent("vrp_sound:source",'alarm',0.95)
                print(foundShopId)
            end

            closestShopId = foundShopId
            closestShopVector = foundShopVector
end


Citizen.CreateThread(
    function()
        initPrompt()
        while true do
            Citizen.Wait(0)

            if closestShopId ~= nil then
                local ped = PlayerPedId()
                local pCoords = GetEntityCoords(ped)

                if #(pCoords - closestShopVector) <= 1.5 then
                    -- if IsControlJustPressed(0, 0xDFF812F9) then
                    PromptSetActiveGroupThisFrame(prompt_group, prompt_group_name)

                    if PromptHasHoldModeCompleted(prompt) then
                        if IsControlPressed(0, 0xDFF812F9) then
                            

                            if sentFirstData == true then
                                SendNUIMessage(
                                    {
                                        display = true,
                                        shopId = closestShopId
                                    }
                                )
                            else
                                local temp_ConfigShopData = Config.ShopDatas

                                for _, shopData in pairs(temp_ConfigShopData) do
                                    for key, value in pairs(shopData) do
                                        if key ~= "name" then
                                            for _, shopItemData in pairs(value) do
                                                local itemData = ItemList[shopItemData[1]]
                                                if itemData then
                                                    shopItemData[5] = itemData.name
                                                    shopItemData[6] = itemData.weight
                                                    shopItemData[7] = itemData.description
                                                end
                                            end
                                        end
                                    end
                                end
                                SendNUIMessage(
                                    {
                                        display = true,
                                        shopId = closestShopId,
                                        firstTimeData = temp_ConfigShopData
                                    }
                                )
                                sentFirstData = true
                            end
                            audio()
                            SetNuiFocus(true, true)
                            Citizen.Wait(1000)
                        end
                    end
                end
            end
        end
    end
)

function initPrompt()
    prompt = PromptRegisterBegin()
    prompt_group = GetRandomIntInRange(0, 0xffffff)
    PromptSetControlAction(prompt, 0xDFF812F9)
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Falar"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, true)
    -- PromptSetPosition(prompt, foundShopVector)
    -- N_0x0c718001b77ca468(prompt, 1.5)
    PromptSetGroup(prompt, prompt_group)
    PromptRegisterEnd(prompt)
end

RegisterNUICallback(
    "buyItem",
    function(data, cb)
        TriggerServerEvent("FRP:SHOP:TryToBuy", data.shopId, data.itemId, data.withGold)
    end
)

RegisterNUICallback(
    "focusOff",
    function(data, cb)
        SetNuiFocus(false, false)
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            SendNUIMessage(
                {
                    display = false
                }
            )
            SetNuiFocus(false, false)

            if prompt ~= nil then
                PromptDelete(prompt)
            end
        end
    end
)
