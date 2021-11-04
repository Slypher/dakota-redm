local gIsWaitingInitDiggingResponse = false

function requestInitDigging(cluster, site)
    if gIsWaitingInitDiggingResponse then
        return false
    end

    TriggerServerEvent('net.requestInitDigging', cluster, site)

    gIsWaitingInitDiggingResponse = true

    return true
end

function requestUpdateActiveDigSiteState(newState)
    TriggerServerEvent('net.requestStateUpdate', newState)
end

RegisterNetEvent('net.responseInitDigging', function(cluster, site)
    gIsWaitingInitDiggingResponse = false

    if cluster and site then
        gActiveSite = site

        local sitePos = DIGGING_CLUSTERS[cluster].sites[site]

        local desiredAnimHeading = computePlayerHeadingForSite(sitePos)

        local useNothingScenario = getClusterSiteState(site) == eDiggingSitePointState.HAS_LOOT_NONE

        local animScene, animScenePlayerAnim = createTreasureDiggingGrabAnimScene(sitePos, desiredAnimHeading, useNothingScenario)
        enterTreasureDiggingGrabAnimScene(animScene, animScenePlayerAnim)
    end
end)