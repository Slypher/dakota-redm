data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

Citizen.CreateThread(function()
    if Config.RestartDelete == true then
        local Scenes_a = {}
        SaveResourceFile(GetCurrentResourceName(), "scenes.json", json.encode(Scenes_a))
    end
end)

RegisterServerEvent("ricx_scene:add")
AddEventHandler("ricx_scene:add", function(text,coords)
	local _source = source
    local _text = tostring(text)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        identi = user.getIdentifier()
        charid = user.getSessionVar("charid")
        local scene = {id = identi, charid = charid, text = _text, coords = coords, font = 1, color = 1, bg = 61, scale = 0.3}
        local edata = LoadResourceFile(GetCurrentResourceName(), "scenes.json")
        local datas = json.decode(edata)
        datas[#datas+1] = scene
        SaveResourceFile(GetCurrentResourceName(), "scenes.json", json.encode(datas))
        TriggerClientEvent("ricx_scene:sendscenes", -1, datas)
    end)
end)

RegisterServerEvent("ricx_scene:getscenes")
AddEventHandler("ricx_scene:getscenes", function(text)
	local _source = source
    local edata = LoadResourceFile(GetCurrentResourceName(), "scenes.json")
    local datas = json.decode(edata)
    TriggerClientEvent("ricx_scene:sendscenes", _source, datas)
end)

RegisterServerEvent("ricx_scene:delete")
AddEventHandler("ricx_scene:delete", function(nr)
	local _source = source
    local edata = LoadResourceFile(GetCurrentResourceName(), "scenes.json")
    local datas = json.decode(edata)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        print(user.getSessionVar("charid"),user.getIdentifier())
        print(datas[nr].charid,datas[nr].id)
        if tostring(datas[nr].id) == user.getIdentifier() and tonumber(datas[nr].charid) == user.getSessionVar("charid") then
            table.remove( datas, nr)
            SaveResourceFile(GetCurrentResourceName(), "scenes.json", json.encode(datas))
            TriggerClientEvent("ricx_scene:sendscenes", -1, datas)
            return
        end
    end)
end)

RegisterServerEvent("ricx_scene:edit")
AddEventHandler("ricx_scene:edit", function(nr)
	local _source = source
    local edata = LoadResourceFile(GetCurrentResourceName(), "scenes.json")
    local datas = json.decode(edata)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if tostring(datas[nr].id) == user.getIdentifier() and tonumber(datas[nr].charid) == user.getSessionVar("charid") then
            TriggerClientEvent("ricx_scene:client_edit", _source, nr)
            return
        end
    end)
end)

RegisterServerEvent("ricx_scene:color")
AddEventHandler("ricx_scene:color", function(nr)
	local _source = source
    local edata = LoadResourceFile(GetCurrentResourceName(), "scenes.json")
    local datas = json.decode(edata)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if tostring(datas[nr].id) == user.getIdentifier() and tonumber(datas[nr].charid) == user.getSessionVar("charid") then
            datas[nr].color = datas[nr].color + 1
            if datas[nr].color > #Config.Colors then
                datas[nr].color = 1
            end
            SaveResourceFile(GetCurrentResourceName(), "scenes.json", json.encode(datas))
            TriggerClientEvent("ricx_scene:sendscenes", -1, datas)
            return
        end
    end)
end)

RegisterServerEvent("ricx_scene:background")
AddEventHandler("ricx_scene:background", function(nr)
	local _source = source
    local edata = LoadResourceFile(GetCurrentResourceName(), "scenes.json")
    local datas = json.decode(edata)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if tostring(datas[nr].id) == user.getIdentifier() and tonumber(datas[nr].charid) == user.getSessionVar("charid") then
            datas[nr].bg = datas[nr].bg + 1
            if datas[nr].bg > #Config.Colors then
                datas[nr].bg = 1
            end
            SaveResourceFile(GetCurrentResourceName(), "scenes.json", json.encode(datas))
            TriggerClientEvent("ricx_scene:sendscenes", -1, datas)
            return
        end
    end)
end)

RegisterServerEvent("ricx_scene:font")
AddEventHandler("ricx_scene:font", function(nr)
	local _source = source
    local edata = LoadResourceFile(GetCurrentResourceName(), "scenes.json")
    local datas = json.decode(edata)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if tostring(datas[nr].id) == user.getIdentifier() and tonumber(datas[nr].charid) == user.getSessionVar("charid") then
            datas[nr].font = datas[nr].font + 1
            if datas[nr].font > #Config.Fonts then
                datas[nr].font = 1
            end
            SaveResourceFile(GetCurrentResourceName(), "scenes.json", json.encode(datas))
            TriggerClientEvent("ricx_scene:sendscenes", -1, datas)
            return
        end
    end)
end)

RegisterServerEvent("ricx_scene:edited")
AddEventHandler("ricx_scene:edited", function(text,nr)
	local _source = source
    local _text = tostring(text)
    local edata = LoadResourceFile(GetCurrentResourceName(), "scenes.json")
    local datas = json.decode(edata)
    datas[nr].text = _text
    SaveResourceFile(GetCurrentResourceName(), "scenes.json", json.encode(datas))
    TriggerClientEvent("ricx_scene:sendscenes", -1, datas)
end)

RegisterServerEvent("ricx_scene:scale")
AddEventHandler("ricx_scene:scale", function(nr)
    local _source = source
    local edata = LoadResourceFile(GetCurrentResourceName(), "scenes.json")
    local datas = json.decode(edata)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if tostring(datas[nr].id) == user.getIdentifier() and tonumber(datas[nr].charid) == user.getSessionVar("charid") then
            datas[nr].scale = datas[nr].scale + 0.05
            print(datas[nr].scale)
            if datas[nr].scale > Config.MaxScale then
                datas[nr].scale = 0.2
            end
            SaveResourceFile(GetCurrentResourceName(), "scenes.json", json.encode(datas))
            TriggerClientEvent("ricx_scene:sendscenes", -1, datas)
            return
        end
    end)
end)

