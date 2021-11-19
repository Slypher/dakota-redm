local Proxy = module('_core', 'lib/Proxy')

local API = Proxy.getInterface('API')

local gPlayerCluster = { }
local gClusterPlayers = { }

local gActiveSitePlayer = { }
local gPlayerActiveSite = { }

local gSitesState = { }
local gSitesTimeOfLastChange = { }
local gSitesShouldGiveLoot = { }

-- 30 minutos?
local SITE_COOLDOWN_TIME = 30 * 60 * 1000

local SITE_KEEP_ACTIVE_TIMEOUT = 5000

local BE_REWARD_LOOT_CHANCE = 10

local NOTIFY_LAW_ENFORCEMENT_CHANCE = 5
local MIN_NUM_LAW_ENFORCEMENT_ONLINE = 2

--[[
    Cluster -> N Site.
]]

function getClusterSiteState(cluster, site)
    return gSitesState[cluster]?[site]
end

function sendDigSiteStateUpdateAck(cluster, site)
    if not gSitesState[cluster] then
        return false
    end

    local digSiteState = gSitesState[cluster][site]

    if not digSiteState then
        return false
    end

    local playersAtCluster = gClusterPlayers[cluster]

    if not playersAtCluster then
        return false
    end

    for playerId, _ in pairs(playersAtCluster) do
        TriggerClientEvent('net.digSiteStateUpdateAck', playerId, cluster, site, digSiteState)
    end
end

function setDigSiteState(cluster, site, state)
    if not gSitesState[cluster] then
        gSitesState[cluster] = { }
    end

    gSitesState[cluster][site] = state

    sendDigSiteStateUpdateAck(cluster, site)

    if not gSitesTimeOfLastChange[cluster] then
        gSitesTimeOfLastChange[cluster] = { }
    end

    gSitesTimeOfLastChange[cluster][site] = GetGameTimer()
end

RegisterNetEvent('net.playerEnterDiggingSite', function(cluster)
    local playerId = source

    gPlayerCluster[playerId] = cluster

    if not gClusterPlayers[cluster] then
        gClusterPlayers[cluster] = { }
    end

    gClusterPlayers[cluster][playerId] = true

    local sitesState = gSitesState[cluster]

    if sitesState then
        TriggerClientEvent('net.setSitesStateForCurrentCluster', sitesState)
    end
end)

RegisterNetEvent('net.playerLeaveDiggingSite', function(cluster)
    local playerId = source

    gPlayerCluster[playerId] = cluster

    if gClusterPlayers[cluster] then
        gClusterPlayers[cluster][playerId] = nil
    end
end)

AddEventHandler('playerDropped', function(playerId, reason)

    local currCluster = gPlayerCluster[playerId]

    if not currCluster then
        return
    end

    gPlayerCluster[playerId] = nil
    gClusterPlayers[currCluster][playerId] = nil

    local activeSite = gPlayerActiveSite[playerId]

    gPlayerActiveSite[playerId] = nil
    gActiveSitePlayer[currCluster][activeSite] = nil
end)

RegisterNetEvent('net.requestInitDigging', function(cluster, site)
    local playerId = source    

    local digSiteState = gSitesState[cluster]?[site]

    local response = function(success)
        TriggerClientEvent('net.responseInitDigging',
            playerId,
            success and cluster or nil,
            success and site    or nil
        )
    end

    local user = API.getUserFromSource(playerId)

    if #API.getUsersByGroup('recruta') < MIN_NUM_LAW_ENFORCEMENT_ONLINE then
        user:notify('error', 'Não há policiais suficientes!')

        return response(false)
    end

    -- Já tem algum estado, algo está acontecendo, aguardar...
    if digSiteState then

        local timeOfLastStateChange = gSitesTimeOfLastChange[cluster]?[site]
        local timeSinceLastStateChange = GetGameTimer() - timeOfLastStateChange

        -- Ainda está em cooldown...
        -- aguardar...
        if digSiteState == eDiggingSitePointState.EMPTY and timeSinceLastStateChange <= SITE_COOLDOWN_TIME then
			user:notify('error', 'Esta cova já está aberta!')

            return response(false)
        end

        -- Caso tenha demorado menos de X segundos para enviar qualquer resposta, continuar com o site.
        if --[[ digSiteState == eDiggingSitePointState.INIT and ]] timeSinceLastStateChange <= SITE_KEEP_ACTIVE_TIMEOUT then
            return response(false)
        end
    end

    local rnd = math.random()

    -- 10% de chance de ter loot na cova.
    local hasLootState = rnd <= (BE_REWARD_LOOT_CHANCE / 100) and eDiggingSitePointState.HAS_LOOT_FULL or eDiggingSitePointState.HAS_LOOT_NONE

    if hasLootState and not gSitesShouldGiveLoot[cluster] then
        gSitesShouldGiveLoot[cluster] = { }
    end

    gSitesShouldGiveLoot[cluster][site] = hasLootState == eDiggingSitePointState.HAS_LOOT_FULL and true or nil

    setDigSiteState(cluster, site, hasLootState)

    gPlayerActiveSite[playerId] = site

    if not gActiveSitePlayer[cluster] then
        gActiveSitePlayer[cluster] = { }
    end

    gActiveSitePlayer[cluster][site] = playerId

    response(true)
end)

RegisterNetEvent('net.playerBailedDigging', function()
end)

-- Evento não é seguro, o player pode mandar qualquer estado que quiser, quando quiser...
RegisterNetEvent('net.requestStateUpdate', function(newState)
    local playerId = source

    local activeSite = gPlayerActiveSite[playerId]

    -- Player não está cavando em nenhum lugar.
    if not activeSite then
        return
    end

    local currCluster = gPlayerCluster[playerId]

    setDigSiteState(currCluster, activeSite, newState)

    if newState == eDiggingSitePointState.DONE then

        setDigSiteState(currCluster, activeSite, eDiggingSitePointState.EMPTY)

        math.randomseed(GetGameTimer())
        
        if math.random() <= (NOTIFY_LAW_ENFORCEMENT_CHANCE / 100) then
            local clusterDisplayName = DIGGING_CLUSTERS[currCluster].displayName

            API.NotifyUsersWithGroup('recruta', ('Moradores avistaram pessoas roubando covas em %s'):format(clusterDisplayName))
        end

        if not gSitesShouldGiveLoot[currCluster]?[activeSite] then
            return
        end

        local user = API.getUserFromSource(playerId)
        local character = user:getCharacter()
        local inventory = character:getInventory()

        local lootItemId = getLootFromLoottable()

        inventory:addItem(lootItemId, 1)
        user:notify('item', lootItemId, 1)
    end
end)

CreateThread(function()
    while true do
        Wait(5000)

        -- Limpar os estados/sites da memoria caso estejam inativos
        -- por mais de X segundos.

        local gameTimer = GetGameTimer()

        for cluster, sitesTimeOfLastChange in pairs(gSitesTimeOfLastChange) do
            for site, timeOfLastChange in pairs(sitesTimeOfLastChange) do
                -- Faz mais de 30 segundos desde a ultima mudança de estado, liberar da memoria.
                if gameTimer - timeOfLastChange >= 30000 then

                    local activePlayerId = gActiveSitePlayer[cluster]?[site]

                    if activePlayerId then
                        gActiveSitePlayer[cluster][site] = nil

                        gPlayerActiveSite[activePlayerId] = nil
                    end

                    setDigSiteState(cluster, site, eDiggingSitePointState.INVALID)

                    gSitesState[cluster][site] = nil
                    gSitesTimeOfLastChange[cluster][site] = nil
                    gSitesShouldGiveLoot[cluster][site] = nil
                end
            end
        end
    end
end)

-- Limpar os estados quando o _core for reiniciado.
-- AddEventHandler('onResourceStop', function(resource)
--     if resource == '_core' then
--         gPlayerCluster = { }
--     end
-- end)

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