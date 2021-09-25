local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")
emP = {}
Tunnel.bindInterface("frp_heal",emP)

RegisterServerEvent("frp_heal:heallife")
AddEventHandler(
    "frp_heal:heallife",
    function(price)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()
        local Character = User:getCharacter()
        if Inventory:getItemAmount("money") < price then
            User:notify("error", "Dinheiro insuficiente!")
            return
        end
        User:notify("successo", "Você foi curado")
        User:notify("item", "money", -price) 
        Inventory:removeItem(-1, "money", price)
        TriggerClientEvent("heal:player", _source)
end)
RegisterNetEvent("permissao")
AddEventHandler(
    "permissao",
    function()
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character then
            local paramedicos = API.getUsersByGroup("medic")
            if parseInt(#paramedicos) == 0 then
                return true
            end
        end
end)

function emP.checkServices()
    local User = API.getUserFromSource(source)
    local Character = User:getCharacter()
        local users = API.getUsers()
        local players = PoliceON
        local PoliceON = API.getUsersByGroup("medic")
        local quantidade = 0
        for k,v in pairs(PoliceON) do
            quantidade = quantidade + 1
        end
		if quantidade == 0 then
			return true
		end
end