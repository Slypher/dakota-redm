local Proxy = module('_core', 'lib/Proxy')

local ClientAPI = Proxy.getInterface('API')

local HUNTING_WAGON_TARP_PROPSET = `pg_mp005_huntingWagonTarp01`

local gShopInRangeThread = false
local gWaitingResponse = false

local gPromptGroup

local gPromptOpenShop
local gPromptReturnWagon

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)

        local closestShopDistance = 10.0
        local closestShop

        for _, shop in ipairs(SHOPS) do
            local shopPos = shop.interactionPosition

            local distanceToShop = #(playerPos - shopPos)

            if distanceToShop <= closestShopDistance then
                closestShopDistance = distanceToShop

                closestShop = shop
            end
        end

        gShopInRangeThread = closestShop ~= nil and ensureThreadShopInRange(closestShop) or false

        Wait(1000)
    end
end)

function ensureThreadShopInRange(shop)
    if gShopInRangeThread then
        return true
    end

    createThreadShopInRange(shop)

    return true
end

function createThreadShopInRange(shop)
    CreateThread(function()

        onStartThreadShopInRange()

        local shopInteractionPos = shop.interactionPosition

        local playerPed = PlayerPedId()

        while gShopInRangeThread do
            Wait(0)

            if GetFrameTime() % 30 == 0 then
                playerPed = PlayerPedId()
            end

            local distanceToInteractionPos = #(GetEntityCoords(playerPed) - shopInteractionPos)

            local playerVehicle = GetVehiclePedIsIn(playerPed)

            local isPlayerDriveOfATemporarWagon = playerVehicle ~= 0
                                            and Entity(playerVehicle).state.isTemporaryPlayerWagon
                                            and GetPedInVehicleSeat(playerVehicle, -1) == playerPed

            if distanceToInteractionPos <= (isPlayerDriveOfATemporarWagon and 5.0 or 2.0) then
                PromptSetActiveGroupThisFrame(gPromptGroup, CreateVarString(10, 'LITERAL_STRING', 'Loja de Carroças'))

                PromptSetEnabled(gPromptReturnWagon, isPlayerDriveOfATemporarWagon)

                if isPlayerDriveOfATemporarWagon then
                    if PromptHasHoldModeCompleted(gPromptReturnWagon) then
                        
                        DeleteEntity(playerVehicle)
                        
                        Wait(100)
                    end
                end

                if PromptHasHoldModeCompleted(gPromptOpenShop) then
                    WarMenu.OpenMenu('wagon_shop')

                    Wait(100)
                end

                if WarMenu.IsMenuOpened('wagon_shop') then
                    for shopItemIndex, shopItem in ipairs(AVAILABLE_ITEMS) do
                        if WarMenu.Button( ('%s $%0.02f'):format(shopItem.displayName, shopItem.basePriceInDollars) ) and (not gWaitingResponse) then
                            requestBuyShopItem(shopItemIndex)
                        end
                    end
    
                    WarMenu.Display()
                end
            else
                if WarMenu.IsMenuOpened('wagon_shop') then
                    WarMenu.CloseMenu()
                end
            end
        end

        onStopThreadShopInRange()
    end)
end

function onStartThreadShopInRange()
    print('onStartThreadShopInRange :: started')

    WarMenu.CreateMenu('wagon_shop', 'Aluguel de Carroça')
    WarMenu.SetSubTitle('wagon_shop', 'Lista de Carroça')

    gPromptGroup = GetRandomIntInRange(0, 0xffffff)

    gPromptOpenShop = createPrompt(gPromptGroup, `INPUT_SHOP_BUY`, 'Abrir')
    gPromptReturnWagon = createPrompt(gPromptGroup, `INPUT_CONTEXT_X`, 'Devolver Carroça')

    requestShopItemModels()
end

function onStopThreadShopInRange()
    print('onStopThreadShopInRange :: stopped')

    PromptDelete(gPromptOpenShop)
    PromptDelete(gPromptReturnWagon)

    releaseShopItemModels()
end

function createShopItemInWorldSynchronous(shop, shopItem)
    local modelHash = shopItem.modelHash

    print('createShopItemInWorldSynchronous :: waiting model to be loaded', modelHash)

    hasModelLoadedSynchronous(modelHash)

    print('createShopItemInWorldSynchronous :: model was lodaed')

    local spawnPos = shop.boughtSpawnPosition

    local isSpawnPointOccupied = Citizen.InvokeNative(0x59B57C4B06531E1E, spawnPos, 4.0, CreateItemset(true), 2, Citizen.ResultAsInteger()) > 0

    if isSpawnPointOccupied then
        ClientAPI.notify('error', 'A área de spawn das carroças está ocupada!')
        return
    end

    -- CreateDraftVehicle
    local entity = Citizen.InvokeNative(0x214651FB1DFEBA89, modelHash, spawnPos, 0.0, true, false, false, 1, false)

    print('createShopItemInWorldSynchronous :: entity was created', entity, spawnPos)

    local playerId = PlayerId()

    -- SetPlayerOwnsVehicle
    Citizen.InvokeNative(0xD0E02AA618020D17, playerId, entity)

    -- Wagon ownership?
    Citizen.InvokeNative(0x6A4404BDFA62CE2C, playerId, entity)

    -- RequestPropSet
    Citizen.InvokeNative(0xF3DE57A46D5585E9, HUNTING_WAGON_TARP_PROPSET)
    
    -- HasPropSetLoaded
    while not Citizen.InvokeNative(0x48A88FC684C55FDC, HUNTING_WAGON_TARP_PROPSET) do
        Wait(0)
    end
    
    -- _ADD_VEHIC
    Citizen.InvokeNative(0x75F90E4051CC084C, entity, HUNTING_WAGON_TARP_PROPSET)

    createWagonStateBagAsync(entity)

    SetGameplayEntityHint(entity, vec3(0.0, 0.0, 0.0), -1, 1000, 1000, 0, 0)

    return entity, NetworkGetNetworkIdFromEntity(entity)
end

function createWagonStateBagAsync(entity)
    while not NetworkGetEntityIsNetworked(entity) do
        Wait(0)
    end

    local entityStateBag = Entity(entity).state

    entityStateBag:set('isTemporaryPlayerWagon', true, true)
end

function requestBuyShopItem(shopItemIndex)
    TriggerServerEvent('net.wagonShopRequestCanBuyItem', shopItemIndex)

    gWaitingResponse = true
end

RegisterNetEvent('net.wagonShopResponseCanBuyItem', function(shopItemIndex, canBuy)
    gWaitingResponse = false

    if not canBuy then
        return
    end

    local shopItem = AVAILABLE_ITEMS[shopItemIndex]

    -- #TODO: Realmente achar o SHOP.
    local shop = SHOPS[1]

    local createdEntity, createdEntityNetworkId = createShopItemInWorldSynchronous(shop, shopItem)

    print('createdEntity', createdEntity)
    print('createdEntityNetworkId', createdEntityNetworkId)

    TriggerServerEvent('net.wagonShopRequestBuyItem', shopItemIndex, createdEntityNetworkId)
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then
        return
    end

    onStopThreadShopInRange()
end)

function createPrompt(promptGroup, controlActionHash, promptText)
    local prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, controlActionHash)
    PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', promptText))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, true)
    PromptSetGroup(prompt, promptGroup)
    PromptRegisterEnd(prompt)

    return prompt
end