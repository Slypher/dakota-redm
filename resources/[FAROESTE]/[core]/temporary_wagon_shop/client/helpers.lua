function hasModelLoadedSynchronous(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(0)
    end
end

function forAllShopItems(fn)
    for _, shopItem in ipairs(AVAILABLE_ITEMS) do
        fn(shopItem)
    end
end

function requestShopItemModels()
    forAllShopItems(function(shopItem)
        local modelHash = shopItem.modelHash

        if not IsModelInCdimage(modelHash) then
            error( ('O \'modelHash\' do item \'%s\' não é valido'):format(shopItem.displayName) )
            return
        end

        RequestModel(modelHash)
    end)
end

function releaseShopItemModels()
    forAllShopItems(function(shopItem)
        local modelHash = shopItem.modelHash

        SetModelAsNoLongerNeeded(modelHash)
    end)
end

RegisterCommand('hunt', function()
    if not HasModelLoaded(WAGON_MODEL_HASH) then
        RequestModel(WAGON_MODEL_HASH)
    end

    while not HasModelLoaded(WAGON_MODEL_HASH) do
        Wait(0)
    end

    local playerPed = PlayerPedId()
    local playerId = PlayerId()

    local spawnPos = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 2.0, 0.0)

    -- Global_1270813.f_581.f_235 -- entitdade do hunting wagon.
    
    -- CreateDraftVehicle
    local wagon = Citizen.InvokeNative(0x214651FB1DFEBA89, WAGON_MODEL_HASH, spawnPos, 0.0, true, false, false, 1, false)

    -- SetPlayerOwnsVehicle
    Citizen.InvokeNative(0xD0E02AA618020D17, playerId, wagon)

    -- Wagon ownership?
    Citizen.InvokeNative(0x6A4404BDFA62CE2C, playerId, wagon)

    Wait(100)

    -- _ADD_VEHIC
    Citizen.InvokeNative(0x75F90E4051CC084C, wagon, TARP_PROPSET_HASH)

    -- _SET_VEHICLE_TARP_HEIGHT
    -- Citizen.InvokeNative(0x31F343383F19C987, wagon, 0.5, 1)

    -- Citizen.InvokeNative(0x7264F9CA87A9830B, wagon)  -- _IS_VEHICLE_PROPSET_LOADED
    -- Citizen.InvokeNative(0xD798DF5DB67B1659, wagon)  -- _IS_VEHICLE_PROPSET_APPLIED
end)