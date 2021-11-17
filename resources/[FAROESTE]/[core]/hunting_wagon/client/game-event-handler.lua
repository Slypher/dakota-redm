local gEntityBeingStowed
local gEntityBeingStowedItem
local gEntityBeingStowedItemWeight

AddEventHandler('gameEventCarriableVehicleStowComplete', function(stowerEntity, vehicle, cancelItemToAdd, unk0)

    print('')
    print('gameEventCarriableVehicleStowComplete ::', stowerEntity, vehicle, cancelItemToAdd, unk0)

    -- Esse evento é executado duplicado, então a gente ignorar o primeiro evento
    -- porque ele contem essa informação diferente de 0.
    if unk0 ~= 0 then
        return
    end

    if stowerEntity ~= PlayerPedId() then
        return
    end

    if vehicle == 0 then
        return
    end

    -- Interação foi cancelado.
    if cancelItemToAdd == 1 then
        return
    end

    local wagonStateBag = Entity(vehicle).state

    local canRegisterStow = wagonStateBag.isTemporaryPlayerWagon == true

    -- print('canRegisterStow', canRegisterStow)

    if not canRegisterStow then
        return
    end

    print('gameEventCarriableVehicleStowComplete :: gEntityBeingStowedItem', gEntityBeingStowedItem)
    print('gameEventCarriableVehicleStowComplete :: gEntityBeingStowedItemWeight', gEntityBeingStowedItemWeight)

    wagonStateBag.huntingWagonInventoryWeight = (wagonStateBag.huntingWagonInventoryWeight or 0.0) + gEntityBeingStowedItemWeight

    print('gameEventCarriableVehicleStowComplete :: wagonStateBag.huntingWagonInventoryWeight', wagonStateBag.huntingWagonInventoryWeight)

    TriggerServerEvent('net.huntingWagonStowedEntity', NetworkGetNetworkIdFromEntity(vehicle), gEntityBeingStowedItem)

    gEntityBeingStowed = nil
    gEntityBeingStowedItem = nil
    gEntityBeingStowedItemWeight = nil
end)

-- Esse evento é executado duplicado...
AddEventHandler('gameEventCarriableVehicleStowStart', function(stowerEntity, carriableEntity, vehicle)
    print('')
    print('gameEventCarriableVehicleStowStart ::', stowerEntity, carriableEntity, vehicle)

    if stowerEntity ~= PlayerPedId() then
        return
    end

    gEntityBeingStowed = carriableEntity
    gEntityBeingStowedItem = getCarriableEntityItem(gEntityBeingStowed)
    gEntityBeingStowedItemWeight = getCarriableItemStowWeight(gEntityBeingStowedItem)

    -- print('gameEventCarriableVehicleStowStart :: isItemAPelt', gEntityBeingStowedModel, isItemAPelt(gEntityBeingStowedModel))
end)

-- Precisa fazer isso abaixo, principalmente para alterar o `fWeight`, que é
-- o que realmente altera do tamanho do tarp do veículo.ANIMAL_CARCASS_TO_SKINNED_CARCASS
AddEventHandler('gameEventCarriablePromptInfoRequest', function(carriableEntity, carryAction, targetParentEntity)
    print('')
    print('gameEventCarriablePromptInfoRequest ::', carriableEntity, carryAction, targetParentEntity)

    -- carryAction(8) : CARRY_ACTION_TYPE_PLACE_ON_VEHICLE

    local carriableEntityItem = getCarriableEntityItem(carriableEntity)

    print('gameEventCarriablePromptInfoRequest :: carriableEntityItem', carriableEntityItem)

    local carriableEntityItemWeight = getCarriableItemStowWeight(carriableEntityItem)

    print('gameEventCarriablePromptInfoRequest :: carriableEntityItemWeight', carriableEntityItemWeight)

    if carryAction ~= 8 then
        return
    end

    -- Só vai poder guardar as entidades em uma carroça que é de um player.
    local canStow = Entity(targetParentEntity).state.isTemporaryPlayerWagon == true

    if not canStow then
        return
    end

    if canStow then
        -- Desabilitar o prompt caso a carroça esteja cheia.
        canStow = not isHuntingWagonFull(targetParentEntity)
    end

    if canStow then
        -- Desabilitar caso o item adicionado ultrapasse do peso máximo.
        canStow = doesHuntingWagonHasSpaceForWeight(targetParentEntity, carriableEntityItemWeight)
    end

    -- print('canStow', canStow)

    exports[GetCurrentResourceName()]:overrideCarryActionPrompt(carriableEntity, carryAction, carriableEntityItemWeight, canStow)
end)

function isHuntingWagonFull(huntingWagonEntity)
    local currWeight = Entity(huntingWagonEntity).state.huntingWagonInventoryWeight or 0.0

    return currWeight > iHuntingWagonInventory
end

function doesHuntingWagonHasSpaceForWeight(huntingWagonEntity, addWeight)
    local currWeight = Entity(huntingWagonEntity).state.huntingWagonInventoryWeight or 0.0

    if currWeight + addWeight > iHuntingWagonInventory then
        return false
    end

    return true
end

RegisterNetEvent('net.huntingWagonResetTarpState', function(wagonNetworkId)
    local wagonEntity = NetworkGetEntityFromNetworkId(wagonNetworkId)

    if wagonEntity == 0 then
        return
    end

    Citizen.InvokeNative(0x31F343383F19C987, wagonEntity, 0.0, true)
end)