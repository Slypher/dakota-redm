-- local weatherTypes = {
--     "highpressure",
--     "rain",
--     "snow",
--     "misty",
--     "fog",
--     "sunny",
--     "clouds",
--     "overcast",
--     "thunderstorm",
--     "hurricane",
--     "thunder",
--     "shower",
--     "blizzard",
--     "snowlight",
--     "whiteout",
--     "hail",
--     "sleet",
--     "drizzle",
--     "sandstorm",
--     "overcastdark",
--     "groundblizzard"
-- }

-- local current = CreateVarString(10, 'LITERAL_STRING', 'none')

-- Citizen.CreateThread(
--     function()
--         local index = 1
--         -- while true do
--             Citizen.InvokeNative(0x59174F1AFE095B5A, GetHashKey(r[index]), true, true, true, 0.0, false)
--             current = CreateVarString(10, 'LITERAL_STRING', r[index])
--             index = index + 1
--             Citizen.Wait(2500)
--         -- end
--     end
-- )

-- Citizen.CreateThread(
--     function()
--         while true do
--             Citizen.Wait(0)
--             DisplayText(current, 0.5, 0.1)
--         end
--     end
-- )

local DEBUG_ENABLE_ALWAYS_CLEAR = false

local regionsWeather = {}

Citizen.CreateThread(
    function()

        local transitioningToWeatherHash

        while true do            
            local currRegionName = GetCurrentRegionName()

            -- GetPrevWeatherTypeHashName
            local nextWeatherHash = Citizen.InvokeNative(0x4BEB42AEBCA732E9)

            local nextWeather = regionsWeather[currRegionName]

            if nextWeather then
                nextWeatherHash = GetHashKey(nextWeather)
            end

            if DEBUG_ENABLE_ALWAYS_CLEAR then
                nextWeatherHash = GetHashKey("sunny")
                NetworkClockTimeOverride(12, 0, 0, false, true)
            end

            if transitioningToWeatherHash ~= nextWeatherHash then
                -- SetWeatherType
                Citizen.InvokeNative(0x59174F1AFE095B5A, nextWeatherHash, true, false, true, 15.0, false)

                transitioningToWeatherHash = nextWeatherHash
            end

            Citizen.Wait(1000)
        end
    end
)

function GetCurrentRegionName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 10)

    if town_hash == GetHashKey("GuarmaD") then
        return "GuarmaD"
    elseif town_hash == GetHashKey("BayouNwa") then
        return "BayouNwa"
    elseif town_hash == GetHashKey("bigvalley") then
        return "bigvalley"
    elseif town_hash == GetHashKey("BluewaterMarsh") then
        return "BluewaterMarsh"
    elseif town_hash == GetHashKey("ChollaSprings") then
        return "ChollaSprings"
    elseif town_hash == GetHashKey("Cumberland") then
        return "Cumberland"
    elseif town_hash == GetHashKey("DiezCoronas") then
        return "DiezCoronas"
    elseif town_hash == GetHashKey("GaptoothRidge") then
        return "GaptoothRidge"
    elseif town_hash == GetHashKey("greatPlains") then
        return "greatPlains"
    elseif town_hash == GetHashKey("GrizzliesEast") then
        return "GrizzliesEast"
    elseif town_hash == GetHashKey("GrizzliesWest") then
        return "GrizzliesWest"
    elseif town_hash == GetHashKey("HennigansStead") then
        return "HennigansStead"
    elseif town_hash == GetHashKey("Perdido") then
        return "Perdido"
    elseif town_hash == GetHashKey("PuntaOrgullo") then
        return "PuntaOrgullo"
    elseif town_hash == GetHashKey("RioBravo") then
        return "RioBravo"
    elseif town_hash == GetHashKey("roanoke") then
        return "roanoke"
    elseif town_hash == GetHashKey("scarlettMeadows") then
        return "scarlettMeadows"
    elseif town_hash == GetHashKey("TallTrees") then
        return "TallTrees"
    elseif town_hash == GetHashKey("Heartlands") then
        return "Heartlands"
    elseif town_hash == false then
        return "unknown"
    end
end

AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            TriggerServerEvent("FRP:W:AskForSync")
        end
    end
)

RegisterNetEvent("FRP:W:Sync")
AddEventHandler(
    "FRP:W:Sync",
    function(data)
        regionsWeather = data
    end
)
