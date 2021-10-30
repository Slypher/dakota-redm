function getTransportStateByIndex(transportIndex)
    return gTransportPool[transportIndex]?.state
end

function setTransportStateForIndex(transportIndex, currHealth, currDirtLevel, lossType, dateOfLoss)
    assertTransportIndexIsValid(transportIndex)

    local transportState = getTransportStateByIndex(transportIndex)

    -- Vai ser usado como `currBodyHealth` em veículos.
    transportState.currHealth    = currHealth          or 100.0
    transportState.currDirtLevel = currDirtLevel       or 0
    transportState.lossType      = eLossType[lossType] or eLossType.None
    transportState.dateOfLoss    = dateOfLoss
end

function setTransportStateHorseForIndex(transportIndex, isInWrithe, bodyWeight)
    assertTransportIndexIsValid(transportIndex)

    local transportState = getTransportStateByIndex(transportIndex)

    transportState.isInWrithe = isInWrithe or false
    transportState.bodyWeight = bodyWeight or 0.5
end

function setTransportStateVehicleDraftForIndex(transportIndex, brokenWheelFlags, brokenDoorFlags)
    assertTransportIndexIsValid(transportIndex)

    local transportState = getTransportStateByIndex(transportIndex)

    transportState.brokenWheelFlags = brokenWheelFlags or 0
    transportState.brokenDoorFlags  = brokenDoorFlags  or 0
end