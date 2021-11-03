
local gDiggingSitesActivePointIndex = { }
local gDiggingSitesActivePointState = { }

local gPlayersCurrentDigCluster = { }
local gDigClusterCurrentPlayers = { }

local gPlayerActiveDigSite = { }

local gDigClusterSiteStateByDiscriminator = { }
local gDigClusterSiteLastStateChangeByDiscriminator = { }

--[[
    Cluster -> N Site.
]]

function getRandomDiggingSitePointIndex(diggingSiteIndex)
    local diggingSite = DIGGING_SITES[diggingSiteIndex]

    local points = diggingSite.positions

    local rnd = math.random(#points)

    -- return points[rnd]
    return rnd
end

-- function setDiggingSiteActivePoint(diggingSiteIndex, diggingPointIndex)
--     GlobalState[ ('digSiteActivePoint__%d'):format(diggingSiteIndex) ] = diggingPointIndex

--     gDiggingSitesActivePointIndex[diggingSiteIndex] = diggingPointIndex
-- end

-- function ensureDiggingSiteActivePoint(diggingSiteIndex)
--     if gDiggingSitesActivePointIndex[diggingSiteIndex] then
--         return
--     end

--     local diggingPointIndex = getRandomDiggingSitePointIndex(diggingSiteIndex)

--     setDiggingSiteActivePoint(diggingSiteIndex, diggingPointIndex)

--     -- gDiggingSitesActivePointState[diggingSiteIndex] = eDiggingSitePointState.WAITING
-- end

function sendDigSiteStateUpdateAck(digCluster, digSite)
    local digSiteState = gDigClusterSiteStateByDiscriminator[digSite]

    if not digSiteState then
        return false
    end

    local playersAtCluster = gDigClusterCurrentPlayers[digCluster]

    if not playersAtCluster then
        return false
    end

    for playerId, _ in pairs(playersAtCluster) do
        TriggerClientEvent('net.digSiteStateUpdateAck', playerId, digCluster, digSite, digSiteState)
    end
end

function getDigSiteDiscriminator(digCluster, digSite)
    return ('%d:%d'):format(digCluster, digSite)
end

function getDigClusterAndSiteFromDiscriminator(digDiscriminator)
    local a, b = string.strsplit(':', digDiscriminator)
    return tonumber(a), tonumber(b)
end

function setDigSiteState(digCluster, digSite, state)
    local digDiscriminator = getDigSiteDiscriminator(digCluster, digSite)

    gDigClusterSiteStateByDiscriminator[digDiscriminator] = state

    sendDigSiteStateUpdateAck(digCluster, digSite)

    gDigClusterSiteLastStateChangeByDiscriminator[digDiscriminator] = GetGameTimer()
end

RegisterNetEvent('playerEnterDiggingSite', function(digCluster)
    local playerId = source

    gPlayersCurrentDigCluster[playerId] = digCluster

    if not gDigClusterCurrentPlayers[digCluster] then
        gDigClusterCurrentPlayers[digCluster] = { }
    end

    gDigClusterCurrentPlayers[digCluster][playerId] = true

    print('playerEnterDiggingSite', digCluster)

    -- ensureDiggingSiteActivePoint(diggingSiteIndex)
end)

RegisterNetEvent('playerLeaveDiggingSite', function(digCluster)
    local playerId = source

    gPlayersCurrentDigCluster[playerId] = digCluster

    if gDigClusterCurrentPlayers[digCluster] then
        gDigClusterCurrentPlayers[digCluster][playerId] = nil
    end

    print('playerLeaveDiggingSite', digCluster)
end)

AddEventHandler('playerDropped', function(playerId, reason)
    gPlayersCurrentDigCluster[playerId] = nil
end)

RegisterNetEvent('net.requestInitDigging', function(digCluster, digSite)
    local playerId = source    

    local digDiscriminator = getDigSiteDiscriminator(digCluster, digSite)

    local digSiteState = gDigClusterSiteStateByDiscriminator[digDiscriminator]

    local response = function(success)
        TriggerClientEvent('net.responseInitDigging',
            playerId,
            success and digCluster or nil,
            success and digSite or nil
        )
    end

    -- Já tem algum estado, algo está acontecendo, aguardar...
    if digSiteState then

        local timeOfLastStateChange = gDigClusterSiteLastStateChangeByDiscriminator[digDiscriminator]
        local timeSinceLastStateChange = GetGameTimer() - timeOfLastStateChange

        print('timeSinceLastStateChange', timeSinceLastStateChange)

        print('digSiteState', digSiteState)

        -- Caso tenha demorado menos de X segundos para enviar qualquer resposta, continuar com o site.
        if --[[ digSiteState == eDiggingSitePointState.INIT and ]] timeSinceLastStateChange <= 5000 then
            return response(false)
        end

        -- Ainda está em cooldown...
        -- aguardar...
        if digSiteState == eDiggingSitePointState.EMPTY and timeSinceLastStateChange <= 30 * 60 * 1000 then
            print('emmpptyy')
            return response(false)
        end
    end

    setDigSiteState(digCluster, digSite, eDiggingSitePointState.INIT)

    gPlayerActiveDigSite[playerId] = digDiscriminator

    response(true)
end)

RegisterNetEvent('net.playerBailedDigging', function()
end)

-- Evento não é seguro, o player pode mandar qualquer estado que quiser, quando quiser...
RegisterNetEvent('net.requestStateUpdate', function(newState)
    local playerId = source

    print('requestStateUpdate', playerId, newState)

    local playerActiveDigSiteDiscriminator = gPlayerActiveDigSite[playerId]

    -- Player não está cavando em nenhum lugar.
    if not playerActiveDigSiteDiscriminator then
        return
    end

    local digCluster, digSite = getDigClusterAndSiteFromDiscriminator(playerActiveDigSiteDiscriminator)

    print(digCluster, digSite)

    setDigSiteState(digCluster, digSite, newState)

    if newState == eDiggingSitePointState.DONE then

        print('set to empty')

        setDigSiteState(digCluster, digSite, eDiggingSitePointState.EMPTY)

        local shouldBeRewarded = math.random() >= 0.5

        if not shouldBeRewarded then
            return
        end

        local user = API.getUserFromSource(playerId)
        local character = user:getCharacter()
        local inventory = character:getInventory()

        inventory:addItem('money', 50)
    end
end)

-- Limpar os estados quando o _core for reiniciado.
AddEventHandler('onResourceStop', function(resource)
    if resource == '_core' then
        gPlayersCurrentDigCluster = { }
    end
end)

--[[
    enum 'eDiggingSitePointState' {
        INVALID = -1,
        INIT,
        CREATE_ENTITIES,
        REQUEST_ANIM_SCENE,
        LOAD_ANIM_SCENE,
        LOOT_WAIT,
        DONE,
    }
]]