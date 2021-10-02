local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')


RegisterNetEvent('PersonaCreatorHandler.setPlayerRoutingBucket')
AddEventHandler('PersonaCreatorHandler.setPlayerRoutingBucket', function()
    local _source = source
    SetPlayerRoutingBucket(_source, _source)
end)

RegisterNetEvent('PersonaCreatorHandler.setPlayerToGlobalRoutingBucket')
AddEventHandler('PersonaCreatorHandler.setPlayerToGlobalRoutingBucket', function()
    SetPlayerRoutingBucket(source, 0)
end)

RegisterNetEvent('PersonaCreatorHandler.setRoutingBucket')
AddEventHandler('PersonaCreatorHandler.setRoutingBucket', function(entityId)
    local _source = source
    SetEntityRoutingBucket(NetworkGetEntityFromNetworkId(entityId), _source)
end)


RegisterNetEvent('PersonaCreatorHandler.requestCreatePersona')
AddEventHandler('PersonaCreatorHandler.requestCreatePersona', function(playerProfileCreation)
    local _source = source
    local User = API.getUserFromSource(_source)

    local Character = User:createCharacter(playerProfileCreation.name, playerProfileCreation.age, playerProfileCreation.isMale)

    if Character ~= nil then
                
        Character:createAppearance(Character:getId(), playerProfileCreation)

        Character:setData(Character:getId(), "metaData", "hunger", 20)
        Character:setData(Character:getId(), "metaData", "thirst", 20)
        Character:setData(Character:getId(), "metaData", "banco", 1500)

        local encoded = json.encode({-284.436,796.012,118.737})
        Character:setData(Character:getId(), "metaData", "position", encoded)       
        User:setCharacter(Character:getId()) -- Will draw itself      
    end

    Wait(1000)

    SetPlayerRoutingBucket(_source, 0)

    TriggerClientEvent('FRP:CREATOR:FirstSpawn', _source)

end)
