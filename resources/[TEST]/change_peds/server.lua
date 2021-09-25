local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)
data = {}
VORP = exports.vorp_core:vorpAPI()


RegisterServerEvent("peds:check")
AddEventHandler("peds:check", function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter           
    
    --[[ ADICIONAR STEAM:HEX AQUI ]]
--								
    if Character.identifier == 'steam:11000010e89a137' then
        TriggerClientEvent('peds:open', _source)
    end
end)