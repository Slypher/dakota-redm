local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")
API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")


RegisterServerEvent("lumberjack:axecheck")
AddEventHandler("lumberjack:axecheck", function(tree)
	local _source = source
	local choppingtree = tree
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()
	local axe = Inventory.getItemAmount(_source, Config.Axe)

	if axe > 0 then
		TriggerClientEvent("lumberjack:axechecked", _source, choppingtree)
	else
		TriggerClientEvent("lumberjack:noaxe", _source)
		TriggerClientEvent("FRP:NOTIFY:Simple", _source, "Voce esta sem Machado em Maos !", 2000)
	end
end)


RegisterServerEvent("lumberjack:addItem")
AddEventHandler(
    "lumberjack:addItem",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()
		local count = math.random(0,1)
		local count2 = math.random(0,1)


        Inventory:addItem('madeiraboa', (count))
		Inventory:addItem('madeiraruim', (count2))
		User:notify("item", 'madeiraboa', count)
		User:notify("item", 'madeiraruim', count2)
    end
)

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