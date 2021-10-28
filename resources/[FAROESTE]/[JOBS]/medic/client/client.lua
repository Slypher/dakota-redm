local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local ScClientRPC = { }
Tunnel.bindInterface(GetCurrentResourceName(), ScClientRPC)

---------------------------
-- MEDIC MANAGEMENT API --
---------------------------
-- Variables

RegisterNetEvent('FRP:MEDIC:checkdeath')
AddEventHandler('FRP:MEDIC:checkdeath', function()
  local player, distance = GetClosestPlayer()

  if distance ~= -1 and distance <= 3.0 then
    TriggerServerEvent('FRP:MEDIC:checkcallback', GetPlayerServerId(player))
   -- TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Curou o (' .. GetPlayerName(player) .. ')')
  else
    TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Ninguem por perto')
  end
end)

RegisterNetEvent('FRP:MEDIC:TreatmentCheck')
AddEventHandler('FRP:MEDIC:TreatmentCheck', function()
  local player, distance = GetClosestPlayer()

  if distance ~= -1 and distance <= 3.0 then
    TriggerServerEvent('FRP:MEDIC:TreatmentCallback', GetPlayerServerId(player))
   -- TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Curou o (' .. GetPlayerName(player) .. ')')
  else
    TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Ninguem por perto')
  end
end)

RegisterNetEvent('FRP:MEDIC:revivecheck')
AddEventHandler('FRP:MEDIC:revivecheck', function()
  local player, distance = GetClosestPlayer()

  if distance ~= -1 and distance <= 3.0 then
    TriggerServerEvent('FRP:MEDIC:revivecallback', GetPlayerServerId(player))
   -- TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Curou o (' .. GetPlayerName(player) .. ')')
  else
    TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Ninguem por perto')
  end
end)

-- RegisterNetEvent('FRP:MEDIC:ReceiveStatus')
-- AddEventHandler('FRP:MEDIC:ReceiveStatus', function(data)     
-- 	if data.InstaDeath ~= nil then		
-- 		if data.InstaDeath == true then
-- 			print('este player está em coma.')
-- 		end
-- 		print(data.InstaDeath)
-- 	end

-- 	if data.deathCause ~= nil then
-- 		print(data.deathCause)
-- 	end

-- 	if data.VitalPartDamage ~= nil then
-- 		if data.VitalPartDamage == true then
-- 			print('está gravemente ferido.')
-- 		end
-- 		print(data.VitalPartDamage)
-- 	end

-- 	if data.BodyPartDamage ~= nil then		
-- 		print('Foi atingido em ' .. json.encode(data.BodyPartDamage))
-- 		print(data.BodyPartDamage)
-- 	end
-- end)

RegisterNetEvent('FRP:MEDIC:revive')
AddEventHandler('FRP:MEDIC:revive', function(data)

    -- PUT HERE ANIMATION

    print('playanim')

end)

RegisterNetEvent("mediconotification")
AddEventHandler("mediconotification", function(notifierPlayerUserId, coords)
	TriggerEvent("FRP:NOTIFY:Simple", ('Telegrama: Um civil(%d) foi avistado desmaiado neste local'):format(notifierPlayerUserId) , 5000)
	local blip = Citizen.InvokeNative(0x45f13b7e0a15c880, -1282792512, coords.x, coords.y, coords.z, 20.0)
	Wait(30000)--Timer del blip per gli sceriffi
	RemoveBlip(blip)
end)

RegisterCommand("medico", function(ped, coords)	
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
		TriggerServerEvent("mediconotify", coords)
end)

function isNearPlayer()
	local player, distance = GetClosestPlayer()
	if distance ~= -1 and distance <= 2.0 then
	    return player, distance
	else
	    return false
	end
	return false
end

function GetPlayers()
    local players = {}

    for _,player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)

        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetPlayers(), -1, -1
    
    local coords, usePlayerPed = coords, false
    local playerPed, playerId = PlayerPedId(), PlayerId()

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    for i=1, #players, 1 do
        local target = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
            local targetCoords = GetEntityCoords(target)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

function getPlayersInRangeOfLocalPlayer(range, deadOnly, limit)
	local localPlayerIdx = PlayerId()
	local localPlayerPed = PlayerPedId()
	local localPlayerPos = GetEntityCoords(localPlayerPed)

	range = range or 999
	
	local inRangePlayers = { }

	-- for _, playerPed in ipairs(GetGamePool('CPed')) do
    for _, playerIndex in ipairs(GetActivePlayers()) do
		-- Ignorar caso seja o player local
		if playerIndex == localPlayerIdx then
			goto continue
		end

		local playerPed = GetPlayerPed(playerIndex)

		-- Ignorar caso o player não tenha um ped
		if playerPed == 0 then
			goto continue
		end

		local playerPos = GetEntityCoords(playerPed)

		local distance = #(playerPos - localPlayerPos)

		-- Ignorar caso o player esteja fora de area
		if distance > range then
			goto continue
		end

		if deadOnly and not IsPedDeadOrDying(playerPed) then
			goto continue
		end

		table.insert(inRangePlayers, { playerIndex, distance } )

		:: continue ::
	end

	-- Ordenar pro players mais próximos.
	table.sort(inRangePlayers, function(a, b)
		return a[2] < b[2]
	end)

	-- Remover os players que passam do limite.
	if limit and #inRangePlayers > limit then
		while #inRangePlayers > limit do
			table.remove(inRangePlayers, limit)
		end
	end

  for i = 1, #inRangePlayers do
    inRangePlayers[i] = inRangePlayers[i][1]
  end

	return inRangePlayers
end

function getPlayersServerIdInRangeOfLocalPlayer(range, deadOnly, limit)
	local players = getPlayersInRangeOfLocalPlayer(range, deadOnly, limit)

	local netPlayers = { }

	for _, playerIndex in ipairs(players) do
		table.insert(netPlayers, GetPlayerServerId(playerIndex))
	end
end

ScClientRPC.getPlayersServerIdInRangeOfPlayer = getPlayersServerIdInRangeOfLocalPlayer

getPlayersInRangeOfLocalPlayer(999.0, false, 5)