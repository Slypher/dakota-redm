function enum(name)
    return function(def)

        local reversed = table.clone(def)

        -- Reverse enum.
        for key, value in pairs(def) do
            reversed[value] = key
        end

        _G[name] = reversed
    end
end

--[[
    Example:

    enum 'eTransportType' {
        Unknown      = 0,
        Horse        = 1,
        VehicleDraft = 2,
        VehicleBoat  = 3,
    }
]]