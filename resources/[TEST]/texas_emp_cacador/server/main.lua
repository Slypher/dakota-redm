local VorpCore = {}
VorpInv = exports.vorp_inventory:vorp_inventoryApi()

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("vorp_hunting:giveReward")
AddEventHandler("vorp_hunting:giveReward", function(givenItem, money)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local rnd = math.random(Config.ItemQuantity.Min, Config.ItemQuantity.Max)
    VorpInv.addItem(_source, givenItem, rnd)
    if money ~= 0 then 
        Character.addCurrency(0, money)
    end
end)