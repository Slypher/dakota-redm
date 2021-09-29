RegisterNetEvent('FRP:HORSE:OpenInventory')
AddEventHandler('FRP:HORSE:OpenInventory', function()
    local _source = source
    local User = API.getUserFromSource(_source)

    if User == nil then
        return
    end

    local Character = User:getCharacter()

    if Character == nil then
        return
    end

    local Horse, components = Character:getHorse()

    if Horse ~= nil then
        User:viewInventory()

        local HorseInventory = Horse:getInventory()

        User:viewInventoryAsSecondary(HorseInventory)
    end
end)

RegisterNetEvent('FRP:PlayerOwnedHorseWasInjured', function()
    local playerId = source

    local user = API.getUserFromSource(playerId)

    if not user then
        return
    end
    
    local character = user:getCharacter()

    if not character then
        return
    end

    local activeHorse = character:getHorse()

    if not activeHorse then
        return
    end

    -- A gente deixa o modelo e o nome do cavalo como vazio
    -- porque o script do frp_horse interpreta `nil` como podendo
    -- liberar o uso do cavalo padrão.
    TriggerClientEvent('FRP:HORSE:SetHorseInfo', playerId, '', '', '')
    cAPI.SetPlayerHorse(playerId, 0)

    local horseId = activeHorse:getId()

    -- Remover o caval otual da instancia do character.;
    character:removeHorse(horseId)

    -- Remover a entrada do cavalo no banco de dados.
    character:deleteHorse(horseId)
end)