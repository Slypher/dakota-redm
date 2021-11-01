local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local function initSinalFumacaCoolDown()
	GlobalState.sinalFumacaCoolDown = true
	seconds = Config.ExpireTimenNewMessage

	Citizen.CreateThread(
		function()
			while seconds > 0 do
				Citizen.Wait(1000)
				seconds = seconds - 1000
			end
			GlobalState.sinalFumacaCoolDown = false
		end
	)
end

RegisterNetEvent(
	"indio:fumaca",
	function (args)
		local _source = source
		local User = API.getUserFromSource(_source)
		local Character = User:getCharacter()
		local indios = API.getUsersByGroup("indio")
		local message = cAPI.prompt(_source, "Mensagem:", "")

		for i, indio in pairs(indios) do
			if #message > 0 then
				TriggerClientEvent('FRP:NOTIFY:Simple', indio:getSource(), Character:getName().. " está fazendo sinal de fumaça à tribo:", Config.ExpireTime)
				TriggerClientEvent('FRP:NOTIFY:Simple', indio:getSource(), "    " .. message, Config.ExpireTime)
			end
		end
		
		if #message > 0 then
			initSinalFumacaCoolDown()
		end
	end
)

AddEventHandler(
    "onResourceStop",
    function(resource)
		if resource == GetCurrentResourceName() then
			GlobalState.sinalFumacaCoolDown = false
		end
    end
)