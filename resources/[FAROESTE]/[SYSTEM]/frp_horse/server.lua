local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

local API = Proxy.getInterface("API")

local DatabaseAPI = Proxy.getInterface('API_DB')

local cAPI = Tunnel.getInterface("API")

local horseServer = {}

Tunnel.bindInterface(GetCurrentResourceName(), horseServer)

CreateThread(function()
    DatabaseAPI.prepare('transferHorse', 'UPDATE horses SET charid = @charid WHERE id = @id')
end)

function horseServer.GetCharacterNameByServerId(playerServerId)

    local userTarget = API.getUserFromSource(playerServerId)

    local character = userTarget:getCharacter()

    return character:getName()
end

RegisterNetEvent('frp_horse:transferHorse', function(currentHorseOwnerServerId, targetPlayerServerId, horse)

    local user = API.getUserFromSource(currentHorseOwnerServerId)

    local character = user:getCharacter()

    local userTarget = API.getUserFromSource(targetPlayerServerId)

    local characterTarget = userTarget:getCharacter()

    local characterTargetId = characterTarget:getId()

    DatabaseAPI.execute('transferHorse', {
        charid = characterTargetId,
        id = horse.id
    })

    userTarget:notify('Você recebeu um cavalo do(a) ' .. character:getName())

    user:notify('Você transferiu um cavalo para ' .. characterTarget:getName())

    TriggerClientEvent('FRP:HORSE:SetHorseInfo', targetPlayerServerId, horse.id, horse.model, horse.name, horse.components)

    cAPI.SetPlayerHorse(targetPlayerServerId, horse.entity)

    characterTarget:removeHorse(horse.id)

    -- Remove cavalo do ex-proprietário

    TriggerClientEvent('FRP:HORSE:SetHorseInfo', currentHorseOwnerServerId, '', '', '')

    cAPI.SetPlayerHorse(currentHorseOwnerServerId, 0)

    character:removeHorse(horse.id)

end)

RegisterNetEvent("FRP:HORSE:RequestMyHorseInfo")
AddEventHandler(
    "FRP:HORSE:RequestMyHorseInfo",
    function()
        local _source = source

        local User = API.getUserFromSource(_source)

        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Horse = Character:getHorse()

        if Horse ~= nil then
            TriggerClientEvent("FRP:HORSE:SetHorseInfo", _source, Horse:getId(), Horse:getModel(), Horse:getName(), Horse:getComponents())
        end
    end
)

RegisterNetEvent("FRP:HORSE:HitCarriedPlayer")
AddEventHandler(
    "FRP:HORSE:HitCarriedPlayer",
    function(playerServerId)
        local _source = source

        TriggerClientEvent("FRP:HORSE:PlayBeingHitAnim", playerServerId)
    end
)
