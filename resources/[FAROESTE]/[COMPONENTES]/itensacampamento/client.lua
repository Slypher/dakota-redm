local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")


local campfire = 0         --p_hitchingpost01x

local poste = 0         --p_hitchingpost01x
local cocho = 0         --p_watertrough02x

local caldeirao = 0     --p_campfirecombined03x
local tocha = 0         --p_torchpostalwayson01x
local varal = 0         --p_clothesline01x
local sacodormir = 0    --p_re_bedrollopen01x
local couro2 = 0         --mp005_p_mp_hideframe02x
local cela = 0        --mp005_p_wildanimalcage01

local mesa = 0          --p_cratetablemil01x
local mesa2 = 0          --s_tabledominoes01x
local barril = 0        --p_boxcar_barrel_09a
local caixa = 0        --p_chair_crate02x
local cadeira = 0       --p_ambchair01x
local banco = 0         --p_bench03x
local tronco = 0        --p_bench_log06x
local tronco2 = 0       --p_bench_log05x
local tronco3 = 0       --p_bench_log04x

local tendagrande = 0       --p_tentmountainmen02x
local tendamedia = 0        --s_tentbison01x
local tendapequena = 0      --p_ambtentleather01b
local tendaindio = 0        --s_awningsur
local tendacaca = 0         --p_ambtentmulch01b
local tendapalha = 0        --p_ambtentgrass01x

local camera = 0            --p_camera01x

local barricada = 0         --mp005_p_mpcover_gunslinger03
local barricadapolicia = 0  --p_barricade03x
local barricadapolicia2 = 0  --p_barricade04x
local barricadapolicia3 = 0  --p_barricade05x

local posteindio = 0    --p_staffindian01x
local cruz = 0          --p_gravestone06x


RegisterCommand('dposteindio', function(source, args, rawCommand)
    if posteindio == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(posteindio)
        DeleteObject(posteindio)
        posteindio = 0
    end
end, false)
RegisterCommand('dlapide', function(source, args, rawCommand)
    if cruz == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(cruz)
        DeleteObject(cruz)
        cruz = 0
    end
end, false)
RegisterCommand('dbarricada', function(source, args, rawCommand)
    if barricada == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(barricada)
        DeleteObject(barricada)
        barricada = 0
    end
end, false)
RegisterCommand('dbarricadapolicia', function(source, args, rawCommand)
    if barricadapolicia == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(barricadapolicia)
        DeleteObject(barricadapolicia)
        barricadapolicia = 0
    end
end, false)
RegisterCommand('dbarricadapolicia2', function(source, args, rawCommand)
    if barricadapolicia2 == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(barricadapolicia2)
        DeleteObject(barricadapolicia2)
        barricadapolicia2 = 0
    end
end, false)
RegisterCommand('dbarricadapolicia3', function(source, args, rawCommand)
    if barricadapolicia3 == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(barricadapolicia3)
        DeleteObject(barricadapolicia3)
        barricadapolicia3 = 0
    end
end, false)
RegisterCommand('dcamera', function(source, args, rawCommand)
    if camera == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(camera)
        DeleteObject(camera)
        camera = 0
    end
end, false)
RegisterCommand('dtendapalha', function(source, args, rawCommand)
    if tendapalha == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(tendapalha)
        DeleteObject(tendapalha)
        tendapalha = 0
    end
end, false)
RegisterCommand('dtendacaca', function(source, args, rawCommand)
    if tendacaca == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(tendacaca)
        DeleteObject(tendacaca)
        tendacaca = 0
    end
end, false)
RegisterCommand('dtendaindio', function(source, args, rawCommand)
    if tendaindio == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(tendaindio)
        DeleteObject(tendaindio)
        tendaindio = 0
    end
end, false)
RegisterCommand('dtendapequena', function(source, args, rawCommand)
    if tendapequena == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(tendapequena)
        DeleteObject(tendapequena)
        tendapequena = 0
    end
end, false)
RegisterCommand('dtendamedia', function(source, args, rawCommand)
    if tendamedia == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(tendamedia)
        DeleteObject(tendamedia)
        tendamedia = 0
    end
end, false)
RegisterCommand('dtendagrande', function(source, args, rawCommand)
    if tendagrande == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(tendagrande)
        DeleteObject(tendagrande)
        tendagrande = 0
    end
end, false)
RegisterCommand('dfogueira', function(source, args, rawCommand)
    if campfire == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        campfire = 0
    end
end, false)
RegisterCommand('dposte', function(source, args, rawCommand)
    if poste == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(poste)
        DeleteObject(poste)
        poste = 0
    end
end, false)
RegisterCommand('dcocho', function(source, args, rawCommand)
    if cocho == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(cocho)
        DeleteObject(cocho)
        cocho = 0
    end
end, false)
RegisterCommand('dcaldeirao', function(source, args, rawCommand)
    if caldeirao == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(caldeirao)
        DeleteObject(caldeirao)
        caldeirao = 0
    end
end, false)
RegisterCommand('dtocha', function(source, args, rawCommand)
    if tocha == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(tocha)
        DeleteObject(tocha)
        tocha = 0
    end
end, false)
RegisterCommand('dvaral', function(source, args, rawCommand)
    if varal == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(varal)
        DeleteObject(varal)
        varal = 0
    end
end, false)
RegisterCommand('dsacodormir', function(source, args, rawCommand)
    if sacodormir == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(sacodormir)
        DeleteObject(sacodormir)
        sacodormir = 0
    end
end, false)
RegisterCommand('dmesa', function(source, args, rawCommand)
    if mesa == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(mesa)
        DeleteObject(mesa)
        mesa = 0
    end
end, false)
RegisterCommand('dmesa2', function(source, args, rawCommand)
    if mesa2 == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(mesa2)
        DeleteObject(mesa2)
        mesa2 = 0
    end
end, false)

RegisterCommand('dcouro', function(source, args, rawCommand)
    if couro2 == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(couro2)
        DeleteObject(couro2)
        couro2 = 0
    end
end, false)
RegisterCommand('dcela', function(source, args, rawCommand)
    if cela == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(cela)
        DeleteObject(cela)
        cela = 0
    end
end, false)
RegisterCommand('dbarril', function(source, args, rawCommand)
    if barril == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(barril)
        DeleteObject(barril)
        barril = 0
    end
end, false)
RegisterCommand('dcaixa', function(source, args, rawCommand)
    if caixa == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(caixa)
        DeleteObject(caixa)
        caixa = 0
    end
end, false)
RegisterCommand('dcadeira', function(source, args, rawCommand)
    if cadeira == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(cadeira)
        DeleteObject(cadeira)
        cadeira = 0
    end
end, false)
RegisterCommand('dbanco', function(source, args, rawCommand)
    if banco == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(banco)
        DeleteObject(banco)
        banco = 0
    end
end, false)
RegisterCommand('dtronco', function(source, args, rawCommand)
    if tronco == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(tronco)
        DeleteObject(tronco)
        tronco = 0
    end
end, false)
RegisterCommand('dtronco2', function(source, args, rawCommand)
    if tronco2 == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(tronco2)
        DeleteObject(tronco2)
        tronco2 = 0
    end
end, false)
RegisterCommand('dtronco3', function(source, args, rawCommand)
    if tronco3 == 0 then
        cAPI.notify("error","Você não fez isso!")
    else
        SetEntityAsMissionEntity(tronco3)
        DeleteObject(tronco3)
        tronco3 = 0
    end
end, false)

RegisterCommand('fogueira', function(source, args, rawCommand)
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
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_campfirefresh01x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    campfire = prop                     -- COLOCOU A FOGUEIRA ACESSA
    Citizen.Wait(1200000)                 -- DPS DE CERTO TEMPO O PROP É APAGADO
    SetEntityAsMissionEntity(campfire)
    DeleteObject(campfire)
    campfire = 0
    local prop = CreateObject(GetHashKey("p_campfire_win2_01x"), x, y, z, true, false, true) -- E SUBSTITUIDO POR OUTRO
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    campfire = prop
    Citizen.Wait(300000) -- DPS ELE É APAGADO NOVAMENTE PARA N FICAR NO MAPA
    SetEntityAsMissionEntity(campfire)
    DeleteObject(campfire)
    campfire = 0
end, false)



RegisterCommand('poste', function(source, args, rawCommand)
    if poste ~= 0 then
        SetEntityAsMissionEntity(poste)
        DeleteObject(poste)
        poste = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_hitchingpost01x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    poste = prop
end, false)

RegisterCommand('cocho', function(source, args, rawCommand)
    if cocho ~= 0 then
        SetEntityAsMissionEntity(cocho)
        DeleteObject(cocho)
        cocho = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_watertrough02x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    cocho = prop
end, false)

RegisterCommand('caldeirao', function(source, args, rawCommand)
    if caldeirao ~= 0 then
        SetEntityAsMissionEntity(caldeirao)
        DeleteObject(caldeirao)
        caldeirao = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_campfirecombined03x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    caldeirao = prop
end, false)

RegisterCommand('tocha', function(source, args, rawCommand)
    if tocha ~= 0 then
        SetEntityAsMissionEntity(tocha)
        DeleteObject(tocha)
        tocha = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_torchpostalwayson01x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tocha = prop
end, false)

RegisterCommand('varal', function(source, args, rawCommand)
    if varal ~= 0 then
        SetEntityAsMissionEntity(varal)
        DeleteObject(varal)
        varal = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_clothesline01x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    varal = prop
end, false)

RegisterCommand('sacodormir', function(source, args, rawCommand)
    if sacodormir ~= 0 then
        SetEntityAsMissionEntity(sacodormir)
        DeleteObject(sacodormir)
        sacodormir = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_re_bedrollopen01x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    sacodormir = prop
end, false)


RegisterCommand('couro', function(source, args, rawCommand)
    if couro2 ~= 0 then
        SetEntityAsMissionEntity(couro2)
        DeleteObject(couro2)
        couro2 = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("mp005_p_mp_hideframe02x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    couro2 = prop
end, false)

RegisterCommand('cela', function(source, args, rawCommand)
    if cela ~= 0 then
        SetEntityAsMissionEntity(cela)
        DeleteObject(cela)
        cela = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("mp005_p_wildanimalcage01"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    cela = prop
end, false)

RegisterCommand('mesa', function(source, args, rawCommand)
    if mesa ~= 0 then
        SetEntityAsMissionEntity(mesa)
        DeleteObject(mesa)
        mesa = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_cratetablemil01x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    mesa = prop
end, false)

RegisterCommand('mesa2', function(source, args, rawCommand)
    if mesa2 ~= 0 then
        SetEntityAsMissionEntity(mesa2)
        DeleteObject(mesa2)
        mesa2 = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("s_tabledominoes01x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    mesa2 = prop
end, false)

RegisterCommand('barril', function(source, args, rawCommand)
    if barril ~= 0 then
        SetEntityAsMissionEntity(barril)
        DeleteObject(barril)
        barril = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_boxcar_barrel_09a"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    barril = prop
end, false)

RegisterCommand('caixa', function(source, args, rawCommand)
    if caixa ~= 0 then
        SetEntityAsMissionEntity(caixa)
        DeleteObject(caixa)
        caixa = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_chair_crate02x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    caixa = prop
end, false)

RegisterCommand('cadeira', function(source, args, rawCommand)
    if cadeira ~= 0 then
        SetEntityAsMissionEntity(cadeira)
        DeleteObject(cadeira)
        cadeira = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_ambchair01x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    cadeira = prop
end, false)

RegisterCommand('banco', function(source, args, rawCommand)
    if banco ~= 0 then
        SetEntityAsMissionEntity(banco)
        DeleteObject(banco)
        banco = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_bench03x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    banco = prop
end, false)

RegisterCommand('tronco', function(source, args, rawCommand)
    if tronco ~= 0 then
        SetEntityAsMissionEntity(tronco)
        DeleteObject(tronco)
        tronco = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_bench_log06x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tronco = prop
end, false)
RegisterCommand('tronco2', function(source, args, rawCommand)
    if tronco2 ~= 0 then
        SetEntityAsMissionEntity(tronco2)
        DeleteObject(tronco2)
        tronco2 = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_bench_log05x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tronco2 = prop
end, false)
RegisterCommand('tronco3', function(source, args, rawCommand)
    if tronco3 ~= 0 then
        SetEntityAsMissionEntity(tronco3)
        DeleteObject(tronco3)
        tronco3 = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_bench_log04x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tronco3 = prop
end, false)

RegisterCommand('tendagrande', function(source, args, rawCommand)
    if tendagrande ~= 0 then
        SetEntityAsMissionEntity(tendagrande)
        DeleteObject(tendagrande)
        tendagrande = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_tentmountainmen02x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tendagrande = prop
end, false)
RegisterCommand('tendamedia', function(source, args, rawCommand)
    if tendamedia ~= 0 then
        SetEntityAsMissionEntity(tendamedia)
        DeleteObject(tendamedia)
        tendamedia = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("s_tentbison01x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tendamedia = prop
end, false)
RegisterCommand('tendapequena', function(source, args, rawCommand)
    if tendapequena ~= 0 then
        SetEntityAsMissionEntity(tendapequena)
        DeleteObject(tendapequena)
        tendapequena = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_ambtentleather01b"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tendapequena = prop
end, false)

RegisterCommand('tendaindio', function(source, args, rawCommand)
    if tendaindio ~= 0 then
        SetEntityAsMissionEntity(tendaindio)
        DeleteObject(tendaindio)
        tendaindio = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("s_awningsur"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tendaindio = prop
end, false)

RegisterCommand('tendacaca', function(source, args, rawCommand)
    if tendacaca ~= 0 then
        SetEntityAsMissionEntity(tendacaca)
        DeleteObject(tendacaca)
        tendacaca = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_ambtentmulch01b"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tendacaca = prop
end, false)

RegisterCommand('tendapalha', function(source, args, rawCommand)
    if tendapalha ~= 0 then
        SetEntityAsMissionEntity(tendapalha)
        DeleteObject(tendapalha)
        tendapalha = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_ambtentgrass01x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tendapalha = prop                    
    Citizen.Wait(2400000)                 
    SetEntityAsMissionEntity(tendapalha)
    DeleteObject(tendapalha)
    tendapalha = 0
end, false)

RegisterCommand('camera', function(source, args, rawCommand)
    if camera ~= 0 then
        SetEntityAsMissionEntity(camera)
        DeleteObject(camera)
        camera = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_camera01x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    camera = prop                    
    Citizen.Wait(2400000)                 
    SetEntityAsMissionEntity(camera)
    DeleteObject(camera)
    camera = 0
end, false)

RegisterCommand('barricada', function(source, args, rawCommand)
    if barricada ~= 0 then
        SetEntityAsMissionEntity(barricada)
        DeleteObject(barricada)
        barricada = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("mp005_p_mpcover_gunslinger03"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    barricada = prop                    
    Citizen.Wait(2400000)                 
    SetEntityAsMissionEntity(barricada)
    DeleteObject(barricada)
    barricada = 0
end, false)

RegisterCommand('barricadapolicia2', function(source, args, rawCommand)
    if barricadapolicia2 ~= 0 then
        SetEntityAsMissionEntity(barricadapolicia2)
        DeleteObject(barricadapolicia2)
        barricadapolicia2 = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_barricade04x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    barricadapolicia2 = prop                    
    Citizen.Wait(2400000)                 
    SetEntityAsMissionEntity(barricadapolicia2)
    DeleteObject(barricadapolicia2)
    barricadapolicia2 = 0
end, false)
RegisterCommand('barricadapolicia3', function(source, args, rawCommand)
    if barricadapolicia3 ~= 0 then
        SetEntityAsMissionEntity(barricadapolicia3)
        DeleteObject(barricadapolicia3)
        barricadapolicia3 = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_barricade05x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    barricadapolicia3 = prop                    
    Citizen.Wait(2400000)                 
    SetEntityAsMissionEntity(barricadapolicia3)
    DeleteObject(barricadapolicia3)
    barricadapolicia3 = 0
end, false)
RegisterCommand('barricadapolicia', function(source, args, rawCommand)
    if barricadapolicia ~= 0 then
        SetEntityAsMissionEntity(barricadapolicia)
        DeleteObject(barricadapolicia)
        barricadapolicia = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_barricade03x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    barricadapolicia = prop                    
    Citizen.Wait(2400000)                 
    SetEntityAsMissionEntity(barricadapolicia)
    DeleteObject(barricadapolicia)
    barricadapolicia = 0
end, false)

RegisterCommand('posteindio', function(source, args, rawCommand)
    if posteindio ~= 0 then
        SetEntityAsMissionEntity(posteindio)
        DeleteObject(posteindio)
        posteindio = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_staffindian01x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    posteindio = prop                    
    Citizen.Wait(2400000)                 
    SetEntityAsMissionEntity(posteindio)
    DeleteObject(posteindio)
    posteindio = 0
end, false)

RegisterCommand('lapide', function(source, args, rawCommand)
    if cruz ~= 0 then
        SetEntityAsMissionEntity(cruz)
        DeleteObject(cruz)
        cruz = 0
    end
    local playerPed = PlayerPedId()
    RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
    while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
            Citizen.Wait( 200 )
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_c", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_gravestone06x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    cruz = prop                    
    Citizen.Wait(2400000)                 
    SetEntityAsMissionEntity(cruz)
    DeleteObject(cruz)
    cruz = 0
end, false)






















-- /dfogueira    /fogueira
-- /dposte    /poste
-- /dcocho    /cocho
-- /dcaldeirao    /caldeirao
-- /dtocha    /tocha
-- /dvaral    /varal
-- /dsacodormir    /sacodormir
-- /dcouro2    /couro2
-- /dcela    /cela
-- /dmesa    /mesa
-- /dmesa2    /mesa2
-- /dbarril    /barril
-- /dcaixa    /caixa
-- /dcadeira    /cadeira
-- /dbanco    /banco
-- /dtronco    /tronco
-- /dtronco2    /tronco2
-- /dtronco3    /tronco3
-- /dtendagrande    /tendagrande
-- /dtendamedia    /tendamedia
-- /dtendapequena    /tendapequena
-- /dtendaindio    /tendaindio
-- /dtendacaca    /tendacaca
-- /dtendapalha    /tendapalha
-- /dcamera    /camera
-- /dbarricada    /barricada
-- /dbarricadapolicia    /barricadapolicia
-- /dbarricadapolicia2    /barricadapolicia2
-- /dbarricadapolicia3    /barricadapolicia3
-- /dposteindio    /posteindio
-- /dcruz    /cruz