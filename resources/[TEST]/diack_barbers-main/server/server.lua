data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent("diack_barbers:SaveHair")
AddEventHandler("diack_barbers:SaveHair", function(index)
	local _item = item
    local _source = source
	TriggerEvent('redemrp:getPlayerFromId', source, function(user)
		local identifier = user.getIdentifier()
		local charid = user.getSessionVar("charid")
		local price = 10
		
        if user.getMoney() >= price then
                user.removeMoney(price)
		MySQL.Async.fetchAll("SELECT skin FROM skins WHERE identifier=(@identifier)", {['@identifier'] = identifier}, function(data)
			local skin = {}

			print("Barbers: Hair saved in database, " .. tostring(index))

			skin = json.decode(data[1].skin)
			skin['hair'] = tostring(index)

			MySQL.Async.execute("UPDATE skins SET skin=(@skin) WHERE identifier=(@identifier)", {['@identifier'] = identifier, ['@skin'] = json.encode(skin)})
		end)
		TriggerClientEvent('redem_roleplay:Tip', _source, "You have (~t6~purchased~t~) a new style", 4000)  
		else
            TriggerClientEvent('redem_roleplay:Tip', _source, "You (~e~dont~t~) have enough money", 4000)

        end
	end)
end)

RegisterServerEvent("diack_barbers:SaveBeard")
AddEventHandler("diack_barbers:SaveBeard", function(index)
	local _item = item
    local _source = source
	TriggerEvent('redemrp:getPlayerFromId', source, function(user)
		local identifier = user.getIdentifier()
		local charid = user.getSessionVar("charid")
		local price = 5
		
        if user.getMoney() >= price then
                user.removeMoney(price)

		MySQL.Async.fetchAll("SELECT skin FROM skins WHERE identifier=(@identifier)", {['@identifier'] = identifier}, function(data)
			local skin = {}

			print("Barbers: Beard saved in database, " .. tostring(index))

			skin = json.decode(data[1].skin)
			skin['beard'] = tostring(index)

			MySQL.Async.execute("UPDATE skins SET skin=(@skin) WHERE identifier=(@identifier)", {['@identifier'] = identifier, ['@skin'] = json.encode(skin)})
		end)
		TriggerClientEvent('redem_roleplay:Tip', _source, "You have (~t6~purchased~t~) a new style", 4000)  
		else
            TriggerClientEvent('redem_roleplay:Tip', _source, "You (~e~dont~t~) have enough money", 4000)

        end
	end)
end)
