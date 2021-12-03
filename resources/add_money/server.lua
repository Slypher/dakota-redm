local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")
local API = Proxy.getInterface("API")

local DatabaseAPI = Proxy.getInterface('API_DB')

RegisterCommand('deuMerdaSlypher', function()

    DatabaseAPI.prepare('setMoney', 'UPDATE characters SET metaData = @metaData WHERE charid = @charid')

    DatabaseAPI.prepare('getMoney', 'SELECT charid, metaData FROM characters')

    local rows = DatabaseAPI.query('getMoney')

    for i = 1, #rows do

        local row = rows[i]

        local metaData = row.metaData

        local metaDataDecoded = json.decode(metaData)

        local bank = tonumber(metaDataDecoded.banco)

        if bank then
            metaDataDecoded.banco = bank + 350
        end

        DatabaseAPI.execute('setMoney', {metaData = json.encode(metaDataDecoded), charid = row.charid})

    end

end, true)