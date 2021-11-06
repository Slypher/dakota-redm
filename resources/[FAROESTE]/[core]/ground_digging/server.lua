local Proxy = module('_core', 'lib/Proxy')

local API = Proxy.getInterface('API')

RegisterNetEvent('net.playerDigRandomGroundSite', function()
    local playerId = source

    local user = API.getUserFromSource(playerId)
    local character = user:getCharacter()
    local inventory = character:getInventory()

    local lootItemId = getLootFromLoottable()

    inventory:addItem(lootItemId, 1)
    user:notify('item', lootItemId, 1)
end)