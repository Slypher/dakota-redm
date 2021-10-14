function Logging.addGameLogEntryWithCharacter(characterId, formatId, ...)
    local user = API.getUserFromCharId(characterId)

    if not user then
        return
    end

    local userId = user:getId()
    local userSource = user:getSource()
    local userName = GetPlayerName(userSource)

    local character = user:getCharacter()

    if not character then
        return
    end

    local characterName = character:getName()

    local content = {
        userName     , userId,
        characterName, characterId,
    }

    for _, extraContent in ipairs({ ... }) do
        table.insert(content, extraContent)
    end

    Logging.log(formatId, table.unpack(content))
end

API.addGameLogEntryWithCharacter = Logging.addGameLogEntryWithCharacter