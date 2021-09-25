local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")
API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent("mining:pickaxecheck")
AddEventHandler("mining:pickaxecheck", function(rock)
	local _source = source
	local miningrock = rock
	local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()
	local pickaxe = Inventory.getItemAmount(_source, Config.Pickaxe)

	if pickaxe > 0 then
		TriggerClientEvent("mining:pickaxechecked", _source, miningrock)
	else
		TriggerClientEvent("mining:nopickaxe", _source)
		TriggerClientEvent("FRP:NOTIFY:Simple", _source, "Voce esta sem Picareta !", 2000)
	end
end)

RegisterServerEvent('mining:addItem')
AddEventHandler('mining:addItem', function()
			local _source = source
			local User = API.getUserFromSource(_source)
			local Inventory = User:getCharacter():getInventory()
			local count = math.random(0,1)
            local count2 = math.random(0,1)
			local count3 = math.random(0,1)

			Inventory:addItem('pedra', (count))
			Inventory:addItem('minerioferro', (count2))
			Inventory:addItem('mineriocobre', (count3))
			User:notify("item", 'pedra', count)
			User:notify("item", 'minerioferro', count2)
			User:notify("item", 'mineriocobre', count3)
		end
	)

function contains(table, element)
	for k,v in pairs(table) do
		for x,y in pairs(v) do
			  if y == element then
				return true
			end
		end
	end
	return false
end

function LootToGive(source)
	local LootsToGive = {}
	for k,v in pairs(Config.Items) do
		table.insert(LootsToGive,v)
	end

	if LootsToGive[1] ~= nil then
		local value = math.random(1,#LootsToGive)
		local mined = LootsToGive[value]
		return mined
	end
end