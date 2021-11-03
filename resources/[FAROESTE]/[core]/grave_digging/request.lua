local gIsWaitingInitDiggingResponse = false

function requestInitDigging(digCluster, digSite)
    if gIsWaitingInitDiggingResponse then
        return false
    end

    TriggerServerEvent('net.requestInitDigging', digCluster, digSite)

    gIsWaitingInitDiggingResponse = true

    return true
end

function requestUpdateActiveDigSiteState(newState)
    TriggerServerEvent('net.requestStateUpdate', newState)
end

RegisterNetEvent('net.responseInitDigging', function(digCluster, digSite)
    gIsWaitingInitDiggingResponse = false

    if digCluster and digSite then
        gActiveDigSite = digCluster, digSize

        local digSitePos = DIGGING_SITES[digCluster].positions[digSite]

        local desiredAnimHeading = computePlayerHeadingFromDigPoint(digSitePos)

        local animScene = createTreasureDiggingGrabAnimScene(digSitePos, desiredAnimHeading)
        enterTreasureDiggingGrabAnimScene(animScene)
    end
end)