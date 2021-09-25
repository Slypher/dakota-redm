local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")
API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")


local User = API.getUserFromSource(_source)
local VorpInv = User:getCharacter():getInventory()



RegisterServerEvent("vorp_lumberjack:axecheck")
AddEventHandler("vorp_lumberjack:axecheck", function(tree)
	local _source = source
	local choppingtree = tree
	local axe = VorpInv.getItemCount(_source, Config.Axe)

	if axe > 0 then
		TriggerClientEvent("vorp_lumberjack:axechecked", _source, choppingtree)
	else
		TriggerClientEvent("vorp_lumberjack:noaxe", _source)
		TriggerClientEvent("vorp:TipRight", _source, "You don't have an axe", 2000)
	end
end)

RegisterServerEvent("vorp_lumberjack:addItem")
AddEventHandler("vorp_lumberjack:addItem", function()
	local _source = source
	local User = User.getUser(_source).getUsedCharacter
	local inventory = VorpInv.getUserInventory(_source)
	TriggerEvent("User:canCarryItems", tonumber(_source), 1, function(canCarry)
		if canCarry then
			if contains(inventory, "wood") then
				for i,item in pairs(inventory) do
					if item.name == "wood" then
						local carrying = 1 + item.count
						if item.limit >= carrying then
							VorpInv.addItem(_source, "wood", 1)
							TriggerClientEvent("vorp:TipRight", _source, "You chopped some "..item.label, 3000)
						else
							TriggerClientEvent("vorp:TipRight", _source, "You can't carry any more "..item.label, 3000)
						end
					end
				end
			else
				local item = "wood"
				exports.ghmattimysql:execute('SELECT * FROM items WHERE item = @item', {['item'] = item}, function(result)
					if result[1] ~= nil then
						local itemlimit = result[1].limit
						local itemlabel = result[1].label
						if itemlimit >= 1 then 
							VorpInv.addItem(_source, item, 1)
							TriggerClientEvent("vorp:TipRight", _source, "You chopped some "..itemlabel, 3000)
						else
							TriggerClientEvent("vorp:TipRight", _source, "You can't carry any more "..itemlabel, 3000)
						end 
					end
				end)
			end
		else
			TriggerClientEvent("vorp:TipRight", _source, "You can't carry any more items", 3000)
		end
	end)
end)

function contains(table, element)
	for k, v in pairs(table) do
		for x, y in  pairs(v) do
			  if y == element then
				return true
			end
		end
	end
	return false
end