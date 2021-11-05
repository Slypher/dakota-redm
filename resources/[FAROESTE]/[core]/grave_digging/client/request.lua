GroundDigging = Proxy.getInterface('GroundDigging')

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
        
        HandheldShovelItem.setDigPromptEnabled(false)

        local sitePos = DIGGING_CLUSTERS[cluster].sites[site]

        local desiredAnimHeading = computePlayerHeadingForSite(sitePos)

        local useNothingScenario = getClusterSiteState(site) == eDiggingSitePointState.HAS_LOOT_NONE

        local hooks = {
            onCreate = function()
                requestUpdateActiveDigSiteState(eDiggingSitePointState.LOAD_ANIM_SCENE)
            end,
            onLoad = function()
                requestUpdateActiveDigSiteState(eDiggingSitePointState.PLAY_ANIM_SCENE_WAIT)
            end,
            onStart = function()
                requestUpdateActiveDigSiteState(eDiggingSitePointState.WAIT_TO_BE_DONE)
            end,
            onFinish = function()
                requestUpdateActiveDigSiteState(eDiggingSitePointState.DONE)

                gActiveSite = nil
            end,
        }

        GroundDigging.startDiggingAnimScene(useNothingScenario and 'nothing' or 'grab', sitePos, desiredAnimHeading, hooks)
    end
end)