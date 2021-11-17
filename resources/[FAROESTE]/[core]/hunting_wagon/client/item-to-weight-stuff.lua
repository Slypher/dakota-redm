iHuntingWagonInventory = 20
iMaxHorseCargoPelts = 50

function itemHasPropertyTag(inventoryItemHash, propertyTagHash)
    -- ItemdatabaseDoesItemHaveTag
    local hasTag = Citizen.InvokeNative(0xFF5FB5605AD56856, inventoryItemHash, propertyTagHash, 1120943070)

    -- print('itemHasPropertyTag :: hasTag', hasTag)

    return hasTag
end

function isItemAPelt(inventoryItemHash)
    -- print('isItemAPelt :: 0x4AEF1FB5B9011D75', Citizen.InvokeNative(0x4AEF1FB5B9011D75, inventoryItemHash))

    return itemHasPropertyTag(inventoryItemHash, 1686880204) or Citizen.InvokeNative(0x4AEF1FB5B9011D75, inventoryItemHash)
end

function isItemAProvision(inventoryItemHash)
    if not isItemAPelt(inventoryItemHash) then
        return false
    end

    for provisionHash, _ in pairs(HASH_PROVISIONS) do
        if inventoryItemHash == provisionHash then
            return true
        end
    end

    return false
end

function returnFirstFloatIfPelt(isPelt, floatA, floatB)
    if isPelt then
        return floatA
    end

    return floatB
end

function func_1971(isPelt, someFloat)
    someFloat = 0.25 -- Always 0.25f

    -- clamp
    local clampedFloat =  math.max(math.min(someFloat, 1.0), 0.0)

    local computedFloat = ((1.0 / iHuntingWagonInventory) * returnFirstFloatIfPelt(isPelt, clampedFloat, (1.0 - clampedFloat)))

    if isPelt then
        return ( ( iHuntingWagonInventory / iMaxHorseCargoPelts ) * computedFloat)
    end

    return computedFloat
end

function func_1199(inventoryItemHash)
    if isItemAProvision(inventoryItemHash) then
		return 1
	end

	return calculateCarcassItemSlotUsage(inventoryItemHash)
end

function calculateCarcassItemSlotUsage(inventoryItemHash)
    -- print('calculateCarcassItemSlotUsage :: inventoryItemHash', inventoryItemHash)

    local animalCarcassFromSkinnedCarcass = SKINNED_CARCASS_TO_ANIMAL_CARCASS[inventoryItemHash]

    -- print('calculateCarcassItemSlotUsage :: animalCarcassFromSkinnedCarcass', animalCarcassFromSkinnedCarcass)

    -- ItemdatabaseFilloutSatchelData
    local hasSatchelData, unkType = Citizen.InvokeNative(0x4776EFD78F75C23F, animalCarcassFromSkinnedCarcass or inventoryItemHash, Citizen.PointerValueInt(), Citizen.ReturnResultAnyway())

    -- print('calculateCarcassItemSlotUsage :: hasSatchelData, unkType', hasSatchelData, unkType)

    if not hasSatchelData then
        return -1
    end

    if unkType == 1 then
        return 1
    elseif unkType == 2 then
        return 2
    elseif unkType == 3 then
        return 4
    elseif unkType == 4 then
        return 8
    end

    return -1
end

function getCarriableItemStowWeight(inventoryItemHash)
    -- print('getCarriableItemStowWeight :: func_1199', func_1199(inventoryItemHash))
    -- print('getCarriableItemStowWeight :: func_1971', func_1971(isItemAProvision(inventoryItemHash), 0.25))

    return (func_1199(inventoryItemHash) * func_1971(isItemAProvision(inventoryItemHash), 0.25));
end

function getPedSkinningQuality(ped)
    -- GetPedDamageCleanliness
    local pedDamageCleanliness = Citizen.InvokeNative(0x88EFFED5FE8B0B4A, carriableEntity, Citizen.ResultAsInteger())

    if pedDamageCleanliness == 0 then
        return 0
    end

    if pedDamageCleanliness == 1 then
        return 1
    end

    if pedDamageCleanliness == -1 or pedDamageCleanliness == 2 then
        return 2
    end
end

function getSatchelItemFromPedCarcass(carriableEntity)
    -- GetPedDamageCleanliness
    local pedDamageCleanliness = Citizen.InvokeNative(0x88EFFED5FE8B0B4A, carriableEntity, Citizen.ResultAsInteger())
    local pedSkinningQuality = getPedSkinningQuality(carriableEntity)

    -- print('getSatchelItemFromPedCarcass :: pedDamageCleanliness', pedDamageCleanliness, 'pedSkinningQuality', pedSkinningQuality)

    if pedSkinningQuality < pedDamageCleanliness then
        pedDamageCleanliness = pedSkinningQuality
    end

    local hasSatchelItem, satchelItemForPedDamage = Citizen.InvokeNative(0x9E7738B291706746, Citizen.PointerValueInt(), carriableEntity, pedDamageCleanliness, Citizen.ReturnResultAnyway())

    -- print('getSatchelItemFromPedCarcass :: satchelItemForPedDamage', hasSatchelItem, satchelItemForPedDamage)

    if satchelItemForPedDamage ~= 0 then
        -- Não faço ideia que componente é esse...
        -- IsMetapedUsingComponent || IsEntityFullyLooted
        if Citizen.InvokeNative(0xFB4891BD7578CDC1, carriableEntity, 43391475) or Citizen.InvokeNative(0x8DE41E9902E85756, carriableEntity) then
            return ANIMAL_CARCASS_TO_SKINNED_CARCASS[satchelItemForPedDamage]
        end

        return satchelItemForPedDamage
    end

    if satchelItemForPedDamage == 2 then
        return `PROVISION_ANIMAL_CARCASS_PERFECT`
    end

    if satchelItemForPedDamage == 1 then
        return `PROVISION_ANIMAL_CARCASS_HIGH_QUALITY`
    end

    if satchelItemForPedDamage == 0 then
        return `PROVISION_ANIMAL_CARCASS_POOR`
    end
end

function func_1193(carriableEntity)
    local someItemHash = Citizen.InvokeNative(0x31FEF6A20F00B963, carriableEntity)

    -- print('func_1193 :: someItemHash', someItemHash)

    if someItemHash == 0 then
        -- Fazer alguma coisa.
    end
    
    return someItemHash
end

function getCarriableEntityItem(carriableEntity)
    local isAnimal = Citizen.InvokeNative(0x9A100F1CF4546629, carriableEntity)
    local isBird = Citizen.InvokeNative(0xC346A546612C49A9, carriableEntity)

    -- print('getCarriableEntityItem :: isAnimal', isAnimal)
    -- print('getCarriableEntityItem :: isBird', isAnimal)

    -- GetIsAnimal or GetIsBird
    if Citizen.InvokeNative(0x9A100F1CF4546629, carriableEntity) or Citizen.InvokeNative(0xC346A546612C49A9, carriableEntity) then
        return getSatchelItemFromPedCarcass(carriableEntity) -- Rockstar usa o 'GetSatchelItemOfCarriedCarcass' aqui
    else
        return func_1193(carriableEntity)
    end
end
