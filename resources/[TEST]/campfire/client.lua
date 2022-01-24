local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")


local campfire = 0

RegisterNetEvent("FRP:Campfire:Campfiresmall")
AddEventHandler(
    "FRP:Campfire:Campfiresmall",
    function()
    if campfire ~= 0 then
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        campfire = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 100 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
   -- exports['progressBars']:startUI(30000, "Creando hogera")
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_campfire05x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    campfire = prop
end, false)


RegisterNetEvent("FRP:Campfire:Campfiresbig")
AddEventHandler(
    "FRP:Campfire:Campfiresbig",
    function()
    if campfire ~= 0 then
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        campfire = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
   -- exports['progressBars']:startUI(30000, "Creando hogera")
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_campfire04x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    campfire = prop
end, false)

RegisterCommand('delcampfire', function(source, args, rawCommand)
    if campfire == 0 then
        cAPI.notify("error","Você não fez nenhuma uma fogueira")
    else
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        campfire = 0
    end
end, false)