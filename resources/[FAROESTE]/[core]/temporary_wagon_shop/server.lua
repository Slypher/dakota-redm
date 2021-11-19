-- `Huntercart01` -- -1698498246

local Proxy = module('_core', 'lib/Proxy')

local ServerAPI = Proxy.getInterface('API')

local gScriptEntityRegistry = { }
local gPlayerScriptEntities = { }

RegisterNetEvent('net.wagonShopRequestCanBuyItem', function(shopItemIndex)
    local playerId = source

    print('net.wagonShopRequestCanBuyItem :: ', playerId, shopItemIndex)

    local shopItem = AVAILABLE_ITEMS[shopItemIndex]
    
    if not shopItem then
        print('net.wagonShopRequestCanBuyItem :: no shopping item')
        return
    end

    local user = ServerAPI.getUserFromSource(playerId)

    local hasTemporaryWagonAlready = gPlayerScriptEntities[playerId] ~= nil

    if hasTemporaryWagonAlready then
        user:notify('error', 'Você já tem uma carroça temporário em algum lugar!')
        return
    end

    local character = user:getCharacter()
    local inventory = character:getInventory()

    if inventory:getItemAmount('money') <= (shopItem.basePriceInDollars * 100) then
        user:notify('error', 'Você não possui dinheiro suficiente!')
        return
    end

    print('net.wagonShopRequestCanBuyItem :: sending response')

    TriggerClientEvent('net.wagonShopResponseCanBuyItem', playerId, shopItemIndex, true)
end)

RegisterNetEvent('net.wagonShopRequestBuyItem', function(shopItemIndex, createdEntityNetworkId)
    local playerId = source
    
    local shopItem = AVAILABLE_ITEMS[shopItemIndex]
    
    print('net.wagonShopRequestBuyItem :: ', playerId, shopItemIndex, createdEntityNetworkId)

    if not shopItem then
        return
    end

    print('net.wagonShopRequestBuyItem :: createdEntityNetworkId', createdEntityNetworkId)

    -- Porque caralhos demora tanto para o servidor saber que a entidade existe?
    while NetworkGetEntityFromNetworkId(createdEntityNetworkId) == 0 do
        Wait(0)
    end

    local user = ServerAPI.getUserFromSource(playerId)
    local character = user:getCharacter()
    local inventory = character:getInventory()

    local createdEntity = NetworkGetEntityFromNetworkId(createdEntityNetworkId)

    if not inventory:removeItem(-1, 'money', shopItem.basePriceInDollars * 100) then
        DeleteEntity(createdEntity)

        user:notify('error', 'Você não possui dinheiro suficiente!')

        return
    end

    print('net.wagonShopRequestBuyItem :: createdEntity', createdEntity)

    gScriptEntityRegistry[createdEntity] = playerId
    gPlayerScriptEntities[playerId] = createdEntity -- { createdEntity }
end)

AddEventHandler('entityRemoved', function(entity)
    if gScriptEntityRegistry[entity] then

        -- print('entityRemoved', entity)

        local ownerPlayerId = gScriptEntityRegistry[entity]

        gScriptEntityRegistry[entity] = nil
        gPlayerScriptEntities[ownerPlayerId] = nil

        TriggerEvent('onTemporaryWagonRemoved', entity)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then
        return
    end

    for entity, _ in pairs(gScriptEntityRegistry) do
        DeleteEntity(entity)

        TriggerEvent('onTemporaryWagonRemoved', entity)
    end
end)