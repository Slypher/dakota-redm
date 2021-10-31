local Proxy = module("_core", "lib/Proxy")

ServerAPI = Proxy.getInterface('API')

function doesPlayerHaveAdminPermissions(playerId)
    local user = ServerAPI.getUserFromSource(playerId)

    if not user then
        return false
    end

    local character = user:getCharacter()

    if not character then
        return false
    end

    if not character:hasGroupOrInheritance('admin') then
        return false
    end

    return true
end


RegisterCommand('keep_drunk', function(source, args, rawCommand)
    if doesPlayerHaveAdminPermissions(source) then
        GlobalState.keepDrunk = not GlobalState.keepDrunk

        print('keepDrunk!', GlobalState.keepDrunk)
    end
end)

RegisterCommand('everyone_drunk', function(source, args, rawCommand)
    if doesPlayerHaveAdminPermissions(source) then
        GlobalState.everyoneDrunk = not GlobalState.everyoneDrunk

        TriggerClientEvent('forceMaxDrunkState', -1)

        print('everyoneDrunk!', GlobalState.everyoneDrunk)
    end
end)