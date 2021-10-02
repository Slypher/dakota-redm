local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

cAPI = Proxy.getInterface('API')
API = Tunnel.getInterface('API')


local nbDelivery = 0
--CONFIGURATION--

local place = { x = -174.433, y = 633.152, z = 113.964} --Configuration marker prise de service
local placefin = { x = -178.983, y = 626.772, z = 113.964} --Configuration marker fin de service
local spawnwagon = { x = -180.291, y = 652.788, z = 113.504 } --Configuration du point de spawn du faggio

local livpt = { --Configuration des points de livraisons (repris ceux de Maykellll1 / NetOut)

[1] = {name = "Vinewood Hills",  x= 1118.503,  y= 486.313,    z= 97.135},                             --x= 2715.192,    y= -968.919,   z= 44.882},   ||      -- x= 1118.503,  y= 486.313,    z= 97.135},   -- Fazenda Valentine
[2] = {name = "Vinewood Hills",  x= 493.351,   y= 677.030,    z= 117.249},                            --x= 2753.752,    y= -916.901,   z= 44.077},   ||      -- x= 493.351,   y= 677.030,    z= 117.249},  -- Fabrica Petroleo
[3] = {name = "Vinewood Hills",  x= -325.815,  y= 774.430,    z= 117.331},                           --x= 2563.352,    y= -916.587,   z= 43.084},    ||     -- x= -325.815,  y= 774.430,    z= 117.331},
[4] = {name = "Vinewood Hills",  x= -286.253,  y= 804.538,    z= 119.260},                           --x= 2748.204,    y= -1171.547,  z= 52.515},    ||     -- x= -286.253,  y= 804.538,    z= 119.260},
[5] = {name = "Vinewood Hills",  x= -240.578,  y= 769.821,    z= 117.959},                           --x= 2862.136,    y= -1150.998,  z= 47.119},    ||     -- x= -240.578,  y= 769.821,    z= 117.959},
[6] = {name = "Vinewood Hills",  x= -814.825,  y= 348.553,    z= 97.928},                           --x= 2547.547,    y= -1114.459,  z= 53.715},     ||    -- x= -814.825,  y= 348.553,    z= 97.928},
[7] = {name = "Vinewood Hills",  x= -859.275,  y= -1277.984,  z= 43.433},                           --x= 2373.469,    y= -1164.849,  z= 47.474},     ||    -- x= -859.275,  y= -1277.984,  z= 43.433},
[8] = {name = "Vinewood Hills",  x= -787.253,  y= -1323.405,  z= 43.758},                           --x= 2387.023,    y= -1263.916,  z= 46.479},     ||    -- x= -787.253,  y= -1323.405,  z= 43.758},
[9] = {name = "Vinewood Hills",  x= -1804.677, y= -430.257,   z= 158.706},                           --x= 2672.298,    y= -1228.330,  z= 53.373},    ||     -- x= -1804.677, y= -430.257,   z= 158.706},
[10] = {name = "Vinewood Hills", x= -1817.489, y= -370.866,   z= 163.171},                           --x= 2679.135,    y= -1192.016,  z= 61.592},    ||     -- x= -1817.489, y= -370.866,   z= 163.171},
[11] = {name = "Vinewood Hills", x= -1789.718, y= -385.792,   z= 160.203},                           --x= 2725.858,    y= -1160.405,  z= 53.363},    ||     -- x= -1789.718, y= -385.792,   z= 160.203},
[12] = {name = "Vinewood Hills", x= -1765.026, y= -384.281,   z= 157.616},                           --x= 862.118,     y= -1926.899,  z= 44.910},    ||     -- x= -1765.026, y= -384.281,   z= 157.616},
[13] = {name = "Vinewood Hills", x= -1303.031, y= 394.332,    z= 95.304},                           --x= 894.505,     y= -1866.625,  z= 43.732},     ||    -- x= -1303.031, y= 394.332,    z= 95.304},
[14] = {name = "Vinewood Hills", x= 337.223,   y= 1504.675,   z= 181.748},                           --x= 1424.234,    y= -1138.709,  z= 76.080},    ||     -- x= 337.223,   y= 1504.675,   z= 181.748},
[15] = {name = "Vinewood Hills", x= 1420.373,  y= 379.651,    z= 90.195},                           --x= 1348.208,    y= -1323.396,  z= 77.871},     ||    -- x= 1420.373,  y= 379.651,    z= 90.195},
[16] = {name = "Vinewood Hills", x= 1525.188,  y= 442.573,    z= 90.555},                           --x= 1344.430,    y= -1242.983,  z= 79.953},     ||    -- x= 1525.188,  y= 442.573,    z= 90.555},
[17] = {name = "Vinewood Hills", x= 1328.937,  y= -1291.997,  z= 76.898},                           --x= 1296.933,    y= -1144.774,  z= 82.258},     ||    -- x= 1328.937,  y= -1291.997,  z= 76.898},
[18] = {name = "Vinewood Hills", x= 1323.098,  y= -1321.615,  z= 77.764},                           --x= 1371.932,    y= -1154.007,  z= 80.819},     ||    -- x= 1323.098,  y= -1321.615,  z= 77.764},
[19] = {name = "Vinewood Hills", x= 1339.525,  y= -1377.122,  z= 80.355},                           --x= 1699.274,    y= -389.838,   z= 50.105},     ||    -- x= 1339.525,  y= -1377.122,  z= 80.355},
[20] = {name = "Vinewood Hills", x= 2510.612,  y= -1456.752,  z= 46.188},                           --x= 1785.086,    y= -401.818,   z= 47.526},     ||    -- x= 2510.612,  y= -1456.752,  z= 46.188},
[21] = {name = "Vinewood Hills", x= 2391.468,  y= -1212.747,  z= 47.030},                           --x= 2116.760,    y= -595.170,   z= 42.690},     ||    -- x= 2391.468,  y= -1212.747,  z= 47.030},
[22] = {name = "Vinewood Hills", x= 2402.496,  y= -1122.434,  z= 46.478},                           --x= 1173.354,    y= -188.168,   z= 100.914},    ||    -- x= 2402.496,  y= -1122.434,  z= 46.478},
[23] = {name = "Vinewood Hills", x= 2554.530,  y= -1168.601,  z= 53.558},                           --x= 724.088,     y= -467.444,   z= 79.982},     ||    -- x= 2554.530,  y= -1168.601,  z= 53.558},
[24] = {name = "Vinewood Hills", x= -2590.330, y= 457.116,    z= 146.785},                           --x= 347.520,     y= -666.643,   z= 42.865},    ||     -- x= -2590.330, y= 457.116,    z= 146.785},
[25] = {name = "Vinewood Hills", x= -1347.011, y= 2435.638,   z= 307.955},                           --x= 1458.879,    y= 320.330,    z= 90.637},    ||     -- x= -1347.011, y= 2435.638,   z= 307.955},
[26] = {name = "Vinewood Hills", x= -556.895,  y= 2699.023,   z= 320.273},                           --x= 1778.286,    y= 461.139,    z= 112.953},   ||     -- x= -556.895,  y= 2699.023,   z= 320.273},
[27] = {name = "Vinewood Hills", x= 779.672,   y= 849.294,    z= 118.813},                           --x= 2238.104,    y= -141.446,   z= 47.684},    ||     -- x= 779.672,   y= 849.294,    z= 118.813},
[28] = {name = "Vinewood Hills", x= 1697.136,  y= 1508.716,   z= 147.730},                           --x= 2626.500,    y= -909.146,   z= 43.094},    ||     -- x= 1697.136,  y= 1508.716,   z= 147.730},
[29] = {name = "Vinewood Hills", x= 2920.308,  y= 1378.743,   z= 56.100},                             --x= 1710.045,    y= -1002.634,  z= 43.500},   ||      -- x= 2920.308,  y= 1378.743,   z= 56.100},     
[30] = {name = "Vinewood Hills", x= 2946.687,  y= 1320.065,   z= 44.695},                           --x= 2020.745,    y= -780.338,   z= 42.891}      ||    -- x= 2946.687,  y= 1320.065,   z= 44.695},
}

local blip

local coefflouze = 0.1 --Coeficient multiplicateur qui en fonction de la distance definit la paie

--INIT--

local isInJobDelivery = false
local livr = 0
local plateab = "POPJOBS"
local isToHouse = false
local isToPizzaria = false
local paie = 0

local pourboire = 0
local posibilidad = 0
local px = 0
local py = 0
local pz = 0

--THREADS--



Citizen.CreateThread(function() --Thread lancement + livraison depuis le marker vert
  while true do
    --Citizen.Wait(0)
    local sleep = 1000
    local playercoords = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(place.x, place.y, place.z) - playercoords)
    if isInJobDelivery == false then
      MarkerFrp(place.x,place.y,place.z,255, 0, 0, 20 )
      --Citizen.InvokeNative(0x2A32FAA57B937173,0x6903B113, place.x,place.y,place.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 20, 0, 0, 2, 0, 0, 0, false)    
      if distance < 1.5 then
        sleep = 4
        DrawText("Aperte ALT para pegar as cartas" , 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)
        if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT
            cancelar()
            notif = true
            isInJobDelivery = true
            isToHouse = true
            livr = math.random(1, 30)

            px = livpt[livr].x
            py = livpt[livr].y
            pz = livpt[livr].z
            distance = round(#vector3(place.x, place.y, place.z) - vector3(px,py,pz))
            paie = distance * coefflouze
            goliv(livpt,livr)
            nbDelivery = 5
        end
      end
    end

    if isToHouse == true then
      sleep = 4

      destinol = livpt[livr].name

      while notif == true do

        TriggerEvent('FRP:NOTIFY:Simple', 'Entregue as cartas no destino marcado', 10000)
        notif = false

        i = 1
      end
      MarkerFrp(livpt[livr].x,livpt[livr].y,livpt[livr].z, 255, 0, 0, 20)
      --Citizen.InvokeNative(0x2A32FAA57B937173,0x6903B113, livpt[livr].x,livpt[livr].y,livpt[livr].z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 20, 0, 0, 2, 0, 0, 0, false)    
      if #(vector3(px,py,pz) - GetEntityCoords(PlayerPedId())) < 3 then
        sleep = 4
        DrawText("Aperte ALT para entregar" , 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)
        if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT
          notif2 = true
          posibilidad = math.random(1, 100)
          afaitunepizzamin = true
          nbDelivery = nbDelivery - 1
          pourboire = math.random(25, 60)
          TriggerEvent('FRP:NOTIFY:Simple', 'Você recebeu $0.'.. pourboire, 10000)
          TriggerServerEvent("FRP:DELIVERY:pay", pourboire)
          RemoveBlip(blip) 
          ClearGpsMultiRoute()
          Wait(250)
          if nbDelivery == 0 then
            isToHouse = false
            isToPizzaria = true
          else
            isToHouse = true
            isToPizzaria = false
            livr = math.random(1, 30)

            px = livpt[livr].x
            py = livpt[livr].y
            pz = livpt[livr].z

            distance = round(GetDistanceBetweenCoords(place.x, place.y, place.z, px,py,pz))
            paie = distance * coefflouze

            goliv(livpt,livr)
          end
        end
      end
    end
    if isToPizzaria == true then
      sleep = 4
      while notif2 == true do
        TriggerEvent('FRP:NOTIFY:Simple', 'Volte para pegar mais cartas.', 10000)
        notif2 = false
      end
      MarkerFrp(place.x,place.y,place.z, 255, 0, 0, 20)
      --Citizen.InvokeNative(0x2A32FAA57B937173,0x6903B113, place.x,place.y,place.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 20, 0, 0, 2, 0, 0, 0, false)    
      if #(vector3(place.x,place.y,place.z) -  GetEntityCoords(PlayerPedId())) < 3 and afaitunepizzamin == true then
        sleep = 4
        DrawText("Aperte ALT para pegar as cartas" , 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)
          if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT
              afaitunepizzamin = false
              TriggerEvent('FRP:NOTIFY:Simple', 'Obrigado pelo seu trabalho, aqui está seu pagamento $'.. paie, 10000)
              TriggerServerEvent("FRP:DELIVERY:pay", paie)
              isInJobDelivery = true
              isToHouse = true
              livr = math.random(1, 30)

              px = livpt[livr].x
              py = livpt[livr].y
              pz = livpt[livr].z

              distance = round(#vector3(place.x, place.y, place.z) - vector3(px,py,pz))
              paie = distance * coefflouze

              goliv(livpt,livr)
              nbDelivery = 5
          end
      end
     
    end
    if IsEntityDead(PlayerPedId()) then
      isInJobDelivery = false
      livr = 0
      isToHouse = false
      isToPizzaria = false

      paie = 0
      px = 0
      py = 0
      pz = 0
      RemoveBlip(blip) 
      ClearGpsMultiRoute()
    end
    Citizen.Wait(sleep)
  end
end)



Citizen.CreateThread(function() -- Thread de "fim de serviço"
  while true do
    local sleep = 1000
    local pedcoord = GetEntityCoords(PlayerPedId())
    if isInJobDelivery == true then
      MarkerFrp(placefin.x,placefin.y,placefin.z, 255, 0, 0, 20)
      if #(vector3(placefin.x, placefin.y, placefin.z) - pedcoord) < 2.5 then
        sleep = 4
        DrawText("Aperte ALT para cancelar as entregas.", 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)
        if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT
          isInJobDelivery = false
          livr = 0
          isToHouse = false
          isToPizzaria = false
          paie = 0
          px = 0
          py = 0
          pz = 0
          if afaitunepizzamin == true then
            local vehicleu = GetVehiclePedIsIn(PlayerPedId(), false)
            SetEntityAsMissionEntity( vehicleu, true, true )
            deleteCar( vehicleu )
            TriggerEvent('FRP:NOTIFY:Simple', 'Obrigado pelos seus serviços.', 10000)
            SetWaypointOff()
            afaitunepizzamin = false
          else
            local vehicleu = GetVehiclePedIsIn(PlayerPedId(), false)
            SetEntityAsMissionEntity( vehicleu, true, true )
            deleteCar( vehicleu )
            TriggerEvent('FRP:NOTIFY:Simple', 'Obrigado pelos seus serviços.', 10000)
          end
        end
      end
    end
    Citizen.Wait(sleep)
  end
end)

--FONCTIONS--

function cancelar()
  CreateThread(function()
    while isInJobDelivery do
      Wait(5)
      if IsControlJustReleased(0, 0x3C0A40F2) then -- TECLA F6
        ClearGpsMultiRoute()
        SetWaypointOff()
        isInJobDelivery = false
        livr = 0
        isToHouse = false
        isToPizzaria = false
        paie = 0
        px = 0
        py = 0
        pz = 0
        if afaitunepizzamin == true then
          local vehicleu = GetVehiclePedIsIn(PlayerPedId(), false)
          SetEntityAsMissionEntity( vehicleu, true, true )
          deleteCar( vehicleu )
          SetWaypointOff()
          afaitunepizzamin = false
        else
          local vehicleu = GetVehiclePedIsIn(PlayerPedId(), false)
          SetEntityAsMissionEntity( vehicleu, true, true )
          deleteCar( vehicleu )
        end
        TriggerEvent('FRP:NOTIFY:Simple', 'Obrigado pelos seus serviços.', 10000)
      end
    end
  end)
end

function MarkerFrp(x,y,z,r,g,b,a)
  Citizen.InvokeNative(0x2A32FAA57B937173,0x6903B113, x,y,z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, r, g, b, a, 0, 0, 2, 0, 0, 0, false)    
end


function goliv(livpt,livr)
  ClearGpsMultiRoute()
  Wait(500)	
  StartGpsMultiRoute(76603059, true, true)
  liv = AddPointToGpsMultiRoute(livpt[livr].x,livpt[livr].y, livpt[livr].z)
  SetGpsMultiRouteRender(true) 

  blip = N_0x554d9d53f696d002(408396114, livpt[livr].x,livpt[livr].y, livpt[livr].z)
  SetBlipSprite(blip, 408396114, 1)
  SetBlipScale(blip, 0.1)
  Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Entrega')
end

function spawn_faggio() -- Thread spawn faggio
  local veh = GetHashKey('UTILLIWAG')
  local ply = GetPlayerPed()
  local coords = GetEntityCoords(ply)
  Citizen.CreateThread(
    function()
      RequestModel(veh)
      while not HasModelLoaded(veh) do
                  Wait(1000)                    
      end
      if HasModelLoaded(veh) then
          car = CreateVehicle(veh, spawnwagon.x,spawnwagon.y,spawnwagon.z, 264.0, true, true, false, true)
      end
    end)
end

function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function deleteCar( entity )
  Citizen.InvokeNative( 0xE20A909D8C4A70F8, Citizen.PointerValueIntInitialized( entity ) ) --Native qui del le vehicule
end

function IsInVehicle() --Fonction de verification de la presence ou non en vehicule du joueur
  local ply = PlayerPedId()
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end


function playAnim(dict, anim, speed)
  if IsEntityPlayingAnim(PlayerPedId(), dict, anim) then
      RequestAnimDict(dict)
      -- while HasAnimDictLoaded(dict) && !noCrash do
      --     -- noCrash = setTimeout(function ()
      --     --     RequestAnimDict(dict)
      --     -- }, 1000);
      -- end
      TaskPlayAnim(PlayerPedId(), dict, anim, speed, 1.0, -1, 0, 0, 0, 0, 0, 0, 0)
  end
end

function DrawText(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre, font)
  SetTextScale(w, h)
  SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
  SetTextCentre(centre)
  if enableShadow then
      SetTextDropshadow(1, 0, 0, 0, 255)
  end
  Citizen.InvokeNative(0xADA9255D, font)
  DisplayText(CreateVarString(10, "LITERAL_STRING", str), x, y)
end