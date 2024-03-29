local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local ScClientRPC = Tunnel.getInterface(GetCurrentResourceName())

local ReviveEnable = false
local target = nil
local sort = nil
RegisterCommand(
    "checar",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local medic = Character:hasGroupOrInheritance("medic")
		local police = Character:hasGroupOrInheritance("trooper")
		local Inventory = User:getCharacter():getInventory()

		sort = math.random(1,2)
        if medic or police then
			TriggerClientEvent('FRP:MEDIC:checkdeath', _source)
			ReviveEnable = false
		end
    end
)

RegisterCommand(
    "reanimar",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local medic = Character:hasGroupOrInheritance("medic")
		local police = Character:hasGroupOrInheritance("trooper")
		local Inventory = User:getCharacter():getInventory()

		sort = math.random(1,2)

		if medic or police then
			--if ReviveEnable then
				TriggerClientEvent('FRP:MEDIC:revivecheck', _source)
			--else
   			--	TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Esta pessoa já está morta.', 5000)
			--end
		end
    end
)

RegisterCommand(
    "tratar",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local medic = Character:hasGroupOrInheritance("medic")
		local Inventory = User:getCharacter():getInventory()

		if medic then
			TriggerClientEvent('FRP:MEDIC:TreatmentCheck', _source)
		end		
    end
)

RegisterServerEvent('FRP:MEDIC:checkcallback')
AddEventHandler('FRP:MEDIC:checkcallback', function(target)
	TriggerClientEvent('FRP:RESPAWN:CheckDeath', target)
end)

RegisterServerEvent('FRP:MEDIC:TreatmentCallback')
AddEventHandler('FRP:MEDIC:TreatmentCallback', function(target)
	TriggerClientEvent('FRP:RESPAWN:Treatment', target)
	ReviveEnable = false
end)

RegisterServerEvent('FRP:MEDIC:revivecallback')
AddEventHandler('FRP:MEDIC:revivecallback', function(target)
	TriggerEvent('FRP:MEDIC:revive', source, target)
	ReviveEnable = false
end)

RegisterServerEvent('FRP:MEDIC:StatusDeath')
AddEventHandler('FRP:MEDIC:StatusDeath', function(target, data)
	TriggerEvent('FRP:MEDIC:ReceiveStatus', target, data)
end)

RegisterServerEvent('FRP:MEDIC:ReceiveStatus')
AddEventHandler('FRP:MEDIC:ReceiveStatus', function(target, data)
	print(json.encode(data))
	if data[2] ~= nil then
		if data[2] then					
			TriggerClientEvent('FRP:NOTIFY:Simple', target, 'Esta pessoa falaceu.', 5000)
			ReviveEnable = false
			return
		else
			TriggerClientEvent('FRP:NOTIFY:Simple', target, 'Esta pessoa está com batimentos.', 5000)
			ReviveEnable = true	
		end
	else
		TriggerClientEvent('FRP:NOTIFY:Simple', target, 'Não identificado a causa da morte.', 5000)
		ReviveEnable = false
	end	
	--TriggerClientEvent('FRP:MEDIC:ReceiveStatus', target, data)
end)


RegisterServerEvent('FRP:MEDIC:revive')
AddEventHandler('FRP:MEDIC:revive', function(source, target)	
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()
	local Inventory = User:getCharacter():getInventory()	

	if sort == 1 and ReviveEnable == false then
		ReviveEnable = true
		print('na sorte')
	end

	if ReviveEnable then
		TriggerClientEvent('FRP:MEDIC:revive', _source)
		Wait(10000)
		TriggerClientEvent('FRP:RESPAWN:PlayerUp', target)
		Character:varyExp(10)
		-- Inventory:addItem('money', 500)	
		TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Reanimado com sucesso.', 5000)
		print('Reanimado com sucesso.')
	else
		TriggerClientEvent('FRP:MEDIC:revive', _source)
		Wait(10000)
	--	TriggerClientEvent('FRP:RESPAWN:PlayerUp', target)
		TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Infelizmente faleceu.', 5000)
	end
end)


RegisterNetEvent("mediconotify")
AddEventHandler("mediconotify", function(coords)
	local _source = source

	local User = API.getUserFromSource(_source)
	local userId = User:getId()

	local Character = User:getCharacter()
	
	if Character ~= nil then
		TriggerClientEvent("FRP:NOTIFY:Simple", source, "Você enviou um Pombo Correio aos Medicos!", 6000)

		local MedicoON = API.getUsersByGroup("medic")

		for i = 1, #MedicoON do
			TriggerClientEvent("mediconotification", MedicoON[i]:getSource(), userId, coords)
		end
	end
end)

AddEventHandler('itemWithRessurectingPropertiesWasUsed', function(user, usedItemSlot, shouldConsumeItem, consumeOnStart)
	local playerId = user:getSource()

	local inRangeNetPlayers = ScClientRPC.getPlayersServerIdInRangeOfPlayer(playerId, 3.0, true, 1)

	if #inRangeNetPlayers <= 0 then
		TriggerClientEvent('chatMessage', playerId, 'SISTEMA', { 255, 255, 255 }, 'Ninguem por perto')
		return
	end

	local character = user:getCharacter()
	local inventory = character:getInventory()

	local function consumeItem()
		return inventory:removeItem(usedItemSlot:getId(), usedItemSlot:getItemId(), 1)
	end

	if (shouldConsumeItem and consumeOnStart) and not consumeItem() then
		TriggerClientEvent('FRP:NOTIFY:Simple', playerId, 'Você não tem mais o item?', 5000)
		return
	end

	Wait(1000)

	if shouldConsumeItem and not consumeItem() then
		TriggerClientEvent('FRP:NOTIFY:Simple', playerId, 'Você não tem mais o item?', 5000)
		return
	end

	local revivedNetPlayerId = inRangeNetPlayers[1]

	TriggerClientEvent('FRP:RESPAWN:revive', revivedNetPlayerId)

	TriggerClientEvent('FRP:NOTIFY:Simple', playerId, 'Reanimado com sucesso.', 5000)

	character:varyExp(10)
end)

local function avisoMedicoNotify(sourceToSend, nomeMedico, nomePaciente, messagem)
    TriggerClientEvent('FRP:NOTIFY:Simple', sourceToSend, ('Médico(a) %s informa ao paciente : [ %s ]'):format(string.upper(nomeMedico), nomePaciente), 5000)
    TriggerClientEvent('FRP:NOTIFY:Simple', sourceToSend, '    ' .. messagem, 5000)
end

RegisterCommand('avisomedico', function(source, args, rawCommand)
	local _source = source
	local user = API.getUserFromSource(_source)
	local character = user:getCharacter()

	if not character:hasGroupOrInheritance('medic') then
		user:notify('error', 'Você não tem permissão!')
		return
	end

	local messagem = cAPI.prompt(_source, 'Mensagem:', '')

	local patientUser = API.getUserFromUserId(tonumber(args[1]))
	
	if not patientUser then
		TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'patient não encontrado', 5000)
		return
	end

	if #messagem <= 0 then
		TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Favor preencher a mensagem!', 5000)
		return
	end

	local patient = patientUser:getCharacter()
	local patientName = patient:getName()

	local medicos = API.getUsersByGroup('medic')

	local characterName = character:getName()

	for _, medico in pairs(medicos) do
		avisoMedicoNotify(medico:getSource(), string.upper(characterName), patientName, messagem)
	end

	avisoMedicoNotify(patient:getSource(), string.upper(characterName), patientName, messagem)
end)