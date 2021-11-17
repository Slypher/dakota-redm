local Proxy = module('_core', 'lib/Proxy')

local ServerAPI = Proxy.getInterface('API')

local gWagonInventoryEntitiesModel = { }

RegisterNetEvent('net.huntingWagonStowedEntity', function(wagonNetworkId, stowedEntityModelHash)
    local wagonEntity = NetworkGetEntityFromNetworkId(wagonNetworkId)

    if wagonEntity == 0 then
        return
    end

    wagonInventoryAddItem(wagonEntity, stowedEntityModelHash, 1)

    print('net.huntingWagonStawedEntity :: huntingWagonInventoryItems', json.encode(wagonInventoryGet(wagonEntity), { indent = true }))
end)

RegisterNetEvent('net.huntingWagonRemoveAllItemsAndCollectMoney', function(wagonNetworkId)
    local playerId = source

    local wagonEntity = NetworkGetEntityFromNetworkId(wagonNetworkId)

    if wagonEntity == 0 then
        return
    end

    local user = ServerAPI.getUserFromSource(playerId)

    local wagonInventoryItems = wagonInventoryGet(wagonEntity)

    if not wagonInventoryItems then
        user:notify('Não há nenhuma animal ou carcaça nesta carroça.')
        return
    end

    local function forAllWagonItems(fn)
        for itemId, itemAmount in pairs(wagonInventoryItems) do
            fn(itemId, itemAmount)
        end
    end

    local character = user:getCharacter()

    local inventory = character:getInventory()

    local toAddDollars = 0

    forAllWagonItems(function(itemId, itemAmount)
        local provisionSellingPriceInDollars = RDR3ProvisionItemToDollars[itemId] or 10

        toAddDollars += (provisionSellingPriceInDollars * itemAmount)
    end)

    print('toAddDollars', toAddDollars)

    -- Não tem nenhum item para vender...
    if toAddDollars <= 0 then
        user:notify('0 Doralés.')
        return
    end

    wagonInventoryDelete(wagonEntity)

    user:notify('Você vendeu todos os animais e peles da carroça!')
    
    inventory:addItem('money', toAddDollars)
    user:notify('item', 'money', toAddDollars)
end)

AddEventHandler('onTemporaryWagonRemoved', function(wagonEntity)
    print('onTemporaryWagonRemoved :: wagonEntity', wagonEntity)

    wagonInventoryDelete(wagonEntity)
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then
        return
    end

    -- Resetar o peso das carroças.
    -- for _, entity in ipairs(GetAllVehicles()) do
    --     wagonInventoryDelete(entity)
    -- end
end)

function wagonInventoryAddItem(entity, itemToAdd, amountToAdd)
    local statebag = Entity(entity).state

    local inventoryItems = statebag.huntingWagonInventoryItems

    if not inventoryItems then
        inventoryItems = { }

        statebag.huntingWagonInventoryItems = inventoryItems
    end

    local currItemAmouht = inventoryItems[itemToAdd] or 0

    inventoryItems[itemToAdd] = currItemAmouht + amountToAdd 

    -- Não replicar.
    statebag:set('huntingWagonInventoryItems', inventoryItems, false)

    return true
end

function wagonInventoryRemoveItem(entity, itemToRemove, amountToRemove)
    local statebag = Entity(entity).state

    local inventoryItems = statebag.huntingWagonInventoryItems

    if not inventoryItems then
        return false
    end

    local currItemAmount = inventoryItems[itemToAdd]

    if not currItemAmouht then
        return false
    end

    local newItemAmount = currItemAmouht - amountToRemove

    if newItemAmount <= 0 then
        inventoryItems[itemToAdd] = nil

        return true
    end

    inventoryItems[itemToAdd] = newItemAmount

    return true
end

function wagonInventoryDelete(entity)
    local statebag = Entity(entity).state

    if statebag.huntingWagonInventoryItems then
        -- Não replicar.
        statebag:set('huntingWagonInventoryItems', nil, false)

        if DoesEntityExist(entity) then
            local netOwner = NetworkGetEntityOwner(entity)

            TriggerClientEvent('net.huntingWagonResetTarpState', netOwner, NetworkGetNetworkIdFromEntity(entity))
        end
    end
end

function wagonInventoryGet(entity)
    local statebag = Entity(entity).state

    if statebag then
        return statebag.huntingWagonInventoryItems
    end

    return nil
end