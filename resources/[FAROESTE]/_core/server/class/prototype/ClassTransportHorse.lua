TransportHorse = table.clone(Transport)

function TransportHorse:getApparels()
    return { }
end

function TransportHorse:getSaddleApparel()
    return `PLACEHOLDER`
end

function API.createTransportHorse(...)
    local instance = table.clone(TransportHorse)

    instance:constructor(eTransportType.Horse, ...)

    return instance
end

-- entity(32bit) entityGeneration(16 bit)