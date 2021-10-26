TransportVehicleDraft = table.clone(Transport)

function TransportVehicleDraft:yes()
    return 'yes'
end

function API.createTransportVehicleDraft(...)
    local instance = table.clone(TransportVehicleDraft)

    instance:constructor(eTransportType.VehicleDraft, ...)

    return instance
end

-- CreateThread(function()
--     local transportA = API.createTransport(1)
--     local transportB = API.createTransportVehicleDraft(2)
--     while true do
--         Wait(1000)

--         print('Transport', eTransportType[transportA:getType()], transportA:getId())

--         print('Transport', eTransportType[transportB:getType()], transportB:getId(), transportB:yes())
--     end
-- end)