local Proxy = module('_core', 'lib/Proxy')

ServerAPI = Proxy.getInterface('API')

RegisterServerEvent('vorp_hunting:giveReward')
AddEventHandler('vorp_hunting:giveReward', function(givenItem, money)
    local playerId = source
    
    local user = ServerAPI.getUserFromSource(playerId)
    local character = user:getCharacter()
    local inventory = character:getInventory()
    
    -- local rnd = math.random(Config.ItemQuantity.Min, Config.ItemQuantity.Max)
    -- VorpInv.addItem(_source, givenItem, rnd)

    -- #WARNING: Anti-injection meio merda.
    if money and money <= 100 then
        inventory:addItem('money', money)
    end
end)