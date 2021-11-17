local gWagonInventoryEntitiesModel = { }

RegisterNetEvent('net.huntingWagonStowedEntity', function(wagonNetworkId, stowedEntityModelHash)
    local wagonEntity = NetworkGetEntityFromNetworkId(wagonNetworkId)

    if wagonEntity == 0 then
        return
    end

    local inventoryEntitiesModel = gWagonInventoryEntitiesModel[wagonEntity]

    if not inventoryEntitiesModel then
        inventoryEntitiesModel = { }

        gWagonInventoryEntitiesModel[wagonEntity] = inventoryEntitiesModel
    end

    local entitiesOfModelCount = inventoryEntitiesModel[stowedEntityModelHash] or 0

    -- Aumentar a quantidade de entidades desse modelo que está guardado.
    inventoryEntitiesModel[stowedEntityModelHash] = entitiesOfModelCount + 1

    print('net.huntingWagonStawedEntity :: inventoryEntitiesModel', json.encode(inventoryEntitiesModel, { indent = true }))
end)

AddEventHandler('onTemporaryWagonRemoved', function(wagonEntity)
    -- print('onTemporaryWagonRemoved :: wagonEntity', wagonEntity)

    gWagonInventoryEntitiesModel[wagonEntity] = nil
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then
        return
    end

    -- Resetar o peso das carroças.
    for wagonEntity, _ in pairs(gWagonInventoryEntitiesModel) do
        local stateBag = Entity(wagonEntity).state

        if stateBag then
            stateBag:set('huntingWagonInventoryWeight', nil, true)
        end
    end
end)