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