local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")
API_Database = Proxy.getInterface("API_DB")

------------------------------------
------------ADMIN COMMANDS----------
------------------------------------

RegisterCommand('pon',function(source,args,rawCommand)
    local User = API.getUserFromSource(source)
    local Character = User:getCharacter()
    if Character:hasGroupOrInheritance("admin") then
        local users = API.getUsers()
        local players = ""
        local quantidade = 0
        for k,v in pairs(users) do
            if k ~= #users then
                players = players..", "
            end
            players = players..k
            quantidade = quantidade + 1
        end
        TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{255,160,0},quantidade)
        TriggerClientEvent('chatMessage',source,"ID's ONLINE",{255,160,0},players)
    end
end)

RegisterCommand('wl',function(source, args, rawCommand)

    local user = API.getUserFromSource(source)

    local character = user:getCharacter()

    if character:hasGroupOrInheritance('admin') or character:hasGroupOrInheritance('allowlister') then

        if args[1] then
            API.setAsWhitelisted(tonumber(args[1]), true)
            return TriggerClientEvent('FRP:TOAST:New', source, 'alert', 'Você aprovou o passaporte ' .. args[1] .. ' na whitelist.')
        end

        user:notify('error', 'Você não tem permissão!')
    end
end)

RegisterCommand('unwl',function(source,args,rawCommand)

    local user = API.getUserFromSource(source)

    local character = user:getCharacter()

    if character:hasGroupOrInheritance('admin') or character:hasGroupOrInheritance('allowlister') then

        if args[1] then
            API.setAsWhitelisted(tonumber(args[1]), false)
            return TriggerClientEvent('FRP:TOAST:New', source, 'alert', 'Você Removeu o passaporte ' .. args[1] .. ' na whitelist.')
        end

        user:notify('error', 'Você não tem permissão!')
    end
end)

RegisterCommand(
    "loadsk",
    function(source)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        local model = Character:getModel()
        local appearenceRow = Character:getCharacterAppearence()
        local appearence = {}
        appearence.enabledComponents = appearenceRow[1].enabledComponents
        appearence.faceFeatures = appearenceRow[1].faceFeatures
        appearence.overlays = appearenceRow[1].overlays
        appearence.clothes = appearenceRow[1].clothes
        appearence.pedHeight = appearenceRow[1].pedHeight
        appearence.pedWeight = appearenceRow[1].pedWeight

        TriggerClientEvent("FRP:ADMIN:Model", source, model,  appearence)
    end
)

RegisterCommand('nc', function(source, args, rawCommand)

    local user = API.getUserFromSource(source)

    local character = user:getCharacter()

    if character:hasGroupOrInheritance('admin') then
        return TriggerClientEvent('core:toggleNoclip', source)
    end

    user:notify("error", "Você não tem permissão!")
end)

RegisterCommand(
    "tpose",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local x, y, z = cAPI.getPosition(source)
            cAPI.SetPlayerPosition(source, x, y, z)
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "tptome",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") and args[1] then
            local tplayer = API.getUserFromUserId(tonumber(args[1])):getSource()
            local x, y, z = cAPI.getPosition(source)
            if tplayer then
                cAPI.SetPlayerPosition(tplayer, x, y, z)
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand("tpto",function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") and args[1] then
            local UserTarget = API.getUserFromUserId(tonumber(args[1]))
            if args[1] then
                local tplayer = UserTarget:getSource()
                if tplayer then
                    cAPI.SetPlayerPosition(source, cAPI.getPosition(tplayer))
                end
            else
                User:notify("error", "Usuário não encontrado!")
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "tpcds",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local fcoords = cAPI.prompt(source, "Cordenadas:", "")
            if fcoords == "" then
                return
            end
            local coords = {}
            for coord in string.gmatch(fcoords or "0,0,0", "[^,]+") do
                table.insert(coords, tonumber(coord))
            end
            cAPI.SetPlayerPosition(source, coords[1] or 0, coords[2] or 0, coords[3] or 0)
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "tpway",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            cAPI.TeleportPlayerToWaypoint(source)
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "ban",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") and args[1] then
            local sourcePlayer = API.getUserFromUserId(tonumber(args[1])):getSource()
            if args[2] ~= nil then
                API.setBanned(sourcePlayer, args[1], "Banido por " .. table.concat(args, " ", 2))
            else
                API.setBanned(sourcePlayer, args[1], "Banido")
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "unban",
    function(source, args, rawCommand)
        if rawCommand then
            if args[2] ~= nil then
                API.UnBan(User, args[1])
            else
                API.UnBan(User, args[1])
            end
            return
        end

        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("admin") and args[1] then
            if args[2] ~= nil then
                API.setBanned(User, args[1])
            else
                API.setBanned(User, args[1])
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "kick",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") and args[1] then
            local sourcePlayer = API.getUserFromUserId(tonumber(args[1])):getSource()
            API.kick(sourcePlayer, "Você foi expulso da cidade.")
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "god",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            cAPI.toggleInvinsible(source)
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "addxp",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local UserTarget = API.getUserFromUserId(tonumber(args[1]))
            if UserTarget ~= nil then
                UserTarget:getCharacter():varyExp(tonumber(args[2]))
                TriggerClientEvent("chatMessage", source, args[2] .. " XP adicionado ao jogador " .. UserTarget:getCharacter():getName())
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "remXP",
    function(source, args, raw)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local UserTarget = API.getUserFromUserId(tonumber(args[1]))
            if UserTarget ~= nil then
                UserTarget:getCharacter():varyExp(-(tonumber(args[2])))
                TriggerClientEvent("chatMessage", source, args[2] .. " XP removido ao jogador " .. UserTarget:getCharacter():getName())
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "veh",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            TriggerClientEvent("FRP:ADMIN:CreateVehicle", source, args[1])
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "setlevel",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local UserTarget = API.getUserFromUserId(tonumber(args[1]))
            if UserTarget ~= nil then
                UserTarget:getCharacter():setLevel(tonumber(args[2]))
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "item",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        local numArgs = #args

        if numArgs < 2 and not tonumber(args[2]) then
            User:notify("error", "sintaxe: /item id quantidade")
            return
        end

        if not Character:hasGroupOrInheritance("admin") then
            User:notify("error", "Você não tem permissão!")
            return
        end

        local toAddItemId = args[1]
        local toAddItemQuantity = tonumber(args[2])

        local toAddUser = User
        local toAddCharacter = Character

        if numArgs >= 3 then
            local targetUserId = tonumber(args[1])

            local UserTarget = API.getUserFromUserId(targetUserId)
            
            if UserTarget == nil then
                User:notify("error", "Usuario invalido!")
                return
            end

            local CharacterTarget = UserTarget:getCharacter()

            if CharacterTarget == nil then
                User:notify("error", "Usuario não escolheu um personagem ainda!")
                return
            end

            toAddItemId = args[2]
            toAddItemQuantity = tonumber(args[3])

            toAddUser = UserTarget
            toAddCharacter = CharacterTarget
        end

        if toAddCharacter:getInventory():addItem(toAddItemId, toAddItemQuantity) then

            -- API.logs("./savedata/giveitem.txt",  os.date() .. " | [AdminID]: " .. Character:getId() .. " / [TargetID]: " .. CharacterTarget:getId() .. " [FUNÇÃO]: AddItem / [NOME]: " .. args[2] .. " / Quantidade " .. tonumber(args[3]))
            -- API.logs("./savedata/giveitem.txt",  os.date() .. " | [AdminID]: " .. Character:getId() .. " / [TargetID]: " .. args[1]                 .. " [FUNÇÃO]: AddItem / [NOME]: " .. args[1] .. " / Quantidade " .. tonumber(args[2]))

            local toAddUserName = GetPlayerName(toAddUser:getSource())

            local toAddItemName = API.getItemDataFromId(toAddItemId):getName()

            API.addGameLogEntryWithCharacter(Character:getId(), 'ADMIN_ADD_ITEM',
                toAddUserName           ,      toAddUser:getId(),
                toAddCharacter:getName(), toAddCharacter:getId(),
                toAddItemName           ,            toAddItemId,
                toAddItemQuantity
            )
        else
            User:notify("error", "Algum erro ocorreu ao tentar enviar o item!")
        end
    end
)

RegisterCommand(
    "presente",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if #args < 2 and not tonumber(args[2]) then
            User:notify("error", "sintaxe: /item id quantidade")
            return
        end

        if Character:hasGroupOrInheritance("admin") then
            if #args >= 3 then
                local UserTarget = API.getUserFromUserId(tonumber(-1))
                if UserTarget ~= nil then
                    local CharacterTarget = UserTarget:getCharacter()
                    if CharacterTarget ~= nil then
                        CharacterTarget:getInventory():addItem(args[2], tonumber(args[3]))
                    else
                        User:notify("error", "Usuario não escolheu um personagem ainda!")
                    end
                else
                    User:notify("error", "Usuario invalido!")
                end
            else
                if #args == 2 then
                    Character:getInventory():addItem(tonumber(-1), tonumber(args[2]))
                end
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "ped",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if args[2] ~= nil then
            if Character:hasGroupOrInheritance("admin") then
                cAPI.SetPlayerPed(API.getUserFromUserId(parseInt(args[1])):getSource(), args[2])
            end
        else
            if Character:hasGroupOrInheritance("admin") then
                cAPI.SetPlayerPed(source, args[1])
            else
                User:notify("error", "Você não tem permissão!")
            end
        end
    end
)

RegisterCommand(
    "cds",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local x, y, z = cAPI.getPosition(source)
            API.prompt(source, "Cordenadas:", string.format("%.3f", x) .. "," .. string.format("%.3f", y) .. "," .. string.format("%.3f", z))
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "group",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            if args[1] == "add" or args[1] == "remove" then
                local UserTarget = API.getUserFromUserId(tonumber(args[2]))
                if UserTarget ~= nil then
                    if args[1] == "add" then
                        UserTarget:getCharacter():addGroup(args[3])
                    elseif args[1] == "remove" then
                        UserTarget:getCharacter():removeGroup(args[3])
                    end
--                    API.logs("./savedata/group.txt",  os.date() .. " | [AdminID]: " .. Character:getId() .. " / [TargetID]: " .. args[2] .. " [FUNÇÃO]: ".. args[1] , args[3])
                else
                    User:notify("error", "Usuario invalido!")
                end
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "recrutar",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("sheriff") then
            if args[1] ~= nil then
                local UserTarget = API.getUserFromUserId(tonumber(args[1]))
                UserTarget:getCharacter():addGroup("trooper")
            else
                User:notify("error", "Usuario invalido!")
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "demitir",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("sheriff") then
            if args[1] ~= nil then
                local UserTarget = API.getUserFromUserId(tonumber(args[1]))
                UserTarget:getCharacter():removeGroup("trooper")
            else
                User:notify("error", "Usuario invalido!")
            end
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

RegisterCommand(
    "policia",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        local PoliceON = API.getUsersByGroup("trooper")
        if #PoliceON <= 0 then
            User:notify("alert", "Não há Oficiais, em serviço!")
        end
        User:notify("alert", "No momento há " .. #PoliceON .. " Oficiais, em serviço!")
    end
)

RegisterCommand(
    "callbau",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local random = math.random(1, 6)
            TriggerEvent("TREASURE:create", random)
        else
            User:notify("error", "Você não tem permissão!")
        end
    end
)

-- RegisterCommand(
--     "groups",
--     function(source, args, rawCommand)
--         local User = API.getUserFromSource(source)
--         local Character = User:getCharacter()
--         if Character:hasGroupOrInheritance("admin") then
--             if #args > 0 then
--                 local UserTarget = API.getUserFromUserId(tonumber(args[1]))
--                 if UserTarget ~= nil then
--                     local TargetCharacter = UserTarget:getCharacter()
--                     for group, _ in pairs(TargetCharacter:getGroups()) do
--                         User:notify("longer_dev", group)
--                     end
--                 else
--                     User:notify("error", "Usuario invalido!")
--                 end
--             else
--                 for group, _ in pairs(Character:getGroups()) do
--                     User:notify("longer_dev", group)
--                 end
--             end
--         else
--             User:notify("error", "Você não tem permissão!")
--         end
--     end
-- )

RegisterCommand(
    "spawnped",
    function(source, args, rawCommand)
        if #args >= 1 then
            local User = API.getUserFromSource(source)
            local Character = User:getCharacter()
            if Character:hasGroupOrInheritance("admin") then
                if args[2] ~= nil then
                    TriggerClientEvent("FRP:ADMIN:SpawnPed", source, args[1], tonumber(args[2]))
                else
                    TriggerClientEvent("FRP:ADMIN:SpawnPed", source, args[1])
                end
            else
                User:notify("error", "Você não tem permissão!")
            end
        end
    end
)

RegisterCommand(
    "spawnprop",
    function(source, args, rawCommand)
        if #args >= 1 then
            local User = API.getUserFromSource(source)
            local Character = User:getCharacter()
            if Character:hasGroupOrInheritance("admin") then
                TriggerClientEvent("FRP:ADMIN:SpawnObject", source, args[1])
            else
                User:notify("error", "Você não tem permissão!")
            end
        end
    end
)

RegisterCommand(
    "revive",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("admin") or Character:hasGroupOrInheritance("medic") then
            if args[1] ~= nil then
                local tplayer = API.getUserFromUserId(tonumber(args[1])):getSource()
                if tplayer ~= nil then
                    TriggerClientEvent("FRP:RESPAWN:revive", tplayer)

--                    API.logs("./savedata/revive.txt",  os.date() .. " | [AdminID]: " .. Character:getId() .. " / [TargetID]: " .. args[1] .. " [FUNÇÃO]: REVIVE")
                end
            else
                TriggerClientEvent("FRP:RESPAWN:revive", _source)
            end
        end
    end
)

RegisterCommand(
    "revivehorse",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("admin") then
            if args[1] ~= nil then
                local tplayer = API.getUserFromUserId(tonumber(args[1])):getSource()
                if tplayer ~= nil then
                    cAPI.VaryPlayerHorseHealth(tplayer, 100)
                end
            else
                cAPI.VaryPlayerHorseHealth(_source, 100)
            end
        end
    end
)

RegisterCommand(
    "dv",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("admin") then
            local playerPed = PlayerPedId()
				    local vehicle   = GetVehiclePedIsIn(playerPed, false)

				    if IsPedInAnyVehicle(playerPed, true) then
				        vehicle = GetVehiclePedIsIn(playerPed, false)
				    end

				    if DoesEntityExist(vehicle) then
				        DeleteVehicle(vehicle)
				    end
        end
    end
)

RegisterNetEvent('FRP:ADMIN:DestroyTargetEntity', function(entityNetworkId)
    local _source = source
    local User = API.getUserFromSource(source)
    local Character = User:getCharacter()

    if Character:hasGroupOrInheritance("admin") then

        local entity = NetworkGetEntityFromNetworkId(entityNetworkId)

        if entity == 0 then
            return
        end

        DeleteEntity(entity)
    end
end)

RegisterCommand(
    "aviso",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("admin") then
            if #args > 0 then
                local m = ""

                for i = 1, #args do
                    m = m .. " " .. args[i]
                end

                TriggerClientEvent("FRP:NOTIFY:Simple", -1, m, 10000)
            end
        end
    end
)

RegisterCommand(
    "tpall",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("admin") then
            cAPI.SetPlayerPosition(-1, cAPI.getPosition(_source))
        end
    end
)

-- RegisterCommand(
--     "givehorse",
--     function(source, args, rawCommand)
--         local _source = source
--         local User = API.getUserFromSource(source)
--         local Character = User:getCharacter()

--         if Character:hasGroupOrInheritance("admin") then
--             -- cAPI.SetPlayerPosition(-1, cAPI.getPosition(_source))
--             if args[1] ~= nil then
--                 local UserTarget = API.getUserFromUserId(tonumber(args[1]))
--                 if UserTarget ~= nil then
--                     local CharacterTarget = UserTarget:getCharacter()

--                     if CharacterTarget ~= nil then
--                         if #args >= 2 then
--                             local name = args[2]

--                             for i = 3, #args do
--                                 if args[i] ~= nil then
--                                     name = name .. " " .. args[i]
--                                 end
--                             end

--                             CharacterTarget:createHorse("A_C_Horse_Arabian_White", name)
--                             User:notify("success", "Cavalo setado!")
--                         else
--                             User:notify("error", "/givehorse id nomedocavalo")
--                         end
--                     else
--                         User:notify("error", "Usuário ainda não escolheu um char")
--                     end
--                 else
--                     User:notify("error", "Usuário não existe ou não está logado")
--                 end
--             end
--         end
--     end,
--     false
-- )

-- RegisterCommand(
--     "idfromsource",
--     function(source, args, rawCommand)
--         local _source = source
--         local User = API.getUserFromSource(source)
--         local Character = User:getCharacter()

--         if Character:hasGroupOrInheritance("admin") then
--             if args[1] ~= nil and tonumber(args[1]) then
--                 local tplayer = API.getUserFromSource(tonumber(args[1]))
--                 if tplayer ~= nil then
--                     User:notify("success", "IDFromSource: source: " .. source .. " id: " .. User:getId())
--                 else
--                     User:notify("error", "Source não encontrada")
--                 end
--             else
--                 User:notify("success", "IDFromSource: source: " .. source .. " id: " .. User:getId())
--             end
--         end
--     end
-- )

local sourcesUsingGamerTags = {}
RegisterNetEvent("FRP:ADMIN:TryToGetGamerTagsInfo")
AddEventHandler(
    "FRP:ADMIN:TryToGetGamerTagsInfo",
    function()
        local _source = source
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("admin") then
            TriggerClientEvent("FRP:ADMIN:ReceiveGamerTagsInfo", _source, API.getSources())
            sourcesUsingGamerTags[_source] = true
        end
    end
)

AddEventHandler(
    "playerDropped",
    function(reason)
        local _source = source
        if sourcesUsingGamerTags[_source] then
            sourcesUsingGamerTags[_source] = nil
        end
    end
)

RegisterNetEvent("API:playerSpawned") -- Use this one !!!!!!!!!!!!!!!!!
AddEventHandler(
    "API:playerSpawned",
    function(source, user_id, isFirstSpawn)
        if isFirstSpawn then
            local User = API.getUserFromSource(source)
            if User ~= nil then
                local user_id = User:getId()
                for sourceUsingGt, _ in pairs(sourcesUsingGamerTags) do
                    TriggerClientEvent("FRP:ADMIN:ReceiveGamerTagInfo", sourceUsingGt, source, user_id)
                end
            end
        end
    end
)

RegisterCommand(
    "outfit",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("admin") then
            if args[2] ~= nil then
                local tplayer = API.getUserFromUserId(parseInt(args[1])):getSource()
                if tplayer ~= nil then
                    TriggerClientEvent("FRP:ADMIN:outift", tplayer, tonumber(args[2]))
                end
            else
                TriggerClientEvent("FRP:ADMIN:outift", _source, tonumber(args[1]))
            end
        end
    end
)

RegisterCommand(
    "dual",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()

        if Character:hasGroupOrInheritance("admin") then
            TriggerClientEvent("FRP:ADMIN:Dual", _source)
        end
    end
)

-- RegisterCommand(
--     "weapon",
--     function(source, args, rawCommand)
--         local _source = source
--         local User = API.getUserFromSource(source)
--         local Character = User:getCharacter()

--         if Character:hasGroup("admin") then
--             local modelw = args[1]
--             if modelw == nil then
--                 print("Please set the specific name for weapon")
--             else
--                 User:giveWeapon(modelw)
--             end
--         end
--     end
-- )

CreateThread(
    function()

        API_Database.prepare("FCRP/UpdatePedByChar", 'UPDATE characters_appearence SET model = @ped , clothes = \'{"Outfit":"0"}\', enabledComponents = \'{}\', faceFeatures = \'{}\' WHERE charid = @charid')
        API_Database.prepare("FCRP/GetCharacter", "SELECT * from characters WHERE charid = @charid")
        API_Database.prepare("FCRP/GetCharacterLikeCharName", "SELECT * FROM characters where characterName like @charname")
        API_Database.prepare("FCRP/DeleteCharacter", "DELETE FROM characters WHERE charid = @charid")
        API_Database.prepare("FCRP/DeleteCharacterAppearence", "DELETE FROM characters_appearence WHERE charid = @charid")
        API_Database.prepare("FCRP/DeleteHorseByChar", "DELETE FROM horses WHERE charid = @charid")
        API_Database.prepare("FCRP/DeleteInventoreByChar", "DELETE FROM inventories WHERE charid = @charid")
        API_Database.prepare("FCRP/GetCharacterByUserId", "SELECT * from characters WHERE user_id = @userid")
        API_Database.prepare("FCRP/GetInventoryByCharid", "SELECT * FROM inventories WHERE id = @charid")
    end
)

RegisterCommand(
    "findchar",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local chars = API_Database.query("FCRP/GetCharacterLikeCharName", {charname = '%'..args[1]..'%'})
            if #chars > 0 then
                for i, char  in pairs(chars) do                    
                    TriggerClientEvent("FRP:NOTIFY:Simple", User:getSource(), "[ "..char.charid.." ] - "..char.characterName, 2000)
                end
            else
                TriggerClientEvent("FRP:NOTIFY:Simple", User:getSource(), "Não encontramos personagens com esse nome", 2000)
            end
        end
    end
)

RegisterCommand(
    "setped",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            API_Database.query("FCRP/UpdatePedByChar", {ped = args[2], charid = args[1]})
            
            TriggerClientEvent("FRP:NOTIFY:Simple", User:getSource(), "PED: "..args[2].." está setado para o Char: "..args[1], 2000)
        end
    end
)

RegisterCommand(
    "delchar",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local rows = API_Database.query("FCRP/GetCharacter", {charid = args[1]})    
            if #rows == 1 then
                local resposta = cAPI.prompt(User:getSource(), "Tem certeza que quer apagar: "..rows[1].characterName, "")
                if resposta == "sim" then
                    Wait(1000)
                    API_Database.query("FCRP/DeleteHorseByChar", {charid = rows[1].charid})
                    API_Database.query("FCRP/DeleteInventoreByChar", {charid = rows[1].charid})
                    API_Database.query("FCRP/DeleteCharacterAppearence", {charid = rows[1].charid})
                    API_Database.query("FCRP/DeleteCharacter", {charid = rows[1].charid})
                    TriggerClientEvent("FRP:NOTIFY:Simple", User:getSource(), "Char: "..rows[1].characterName.." Foi deletado com sucesso.", 2000) 
                else
                    TriggerClientEvent("FRP:NOTIFY:Simple", User:getSource(), "Fique tranquilo, nada foi apagado.", 2000) 
                end
            else
                TriggerClientEvent("FRP:NOTIFY:Simple", User:getSource(), "Char não encontrado", 2000)    
            end
        end
    end
)

RegisterCommand(
    "charmoney",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then            
            local slots = {}
            local inventoryMoney = 0

            local characterFound = API_Database.query("FCRP/GetCharacter", {charid = args[1]})    

            if #characterFound > 0 then

                local inventory = API_Database.query("FCRP/GetInventoryByCharid", {charid = 'char:'..args[1]})
                if #inventory > 0 then
                    slots, _ = json.decode(inventory[1].inv_slots)
                    for k, v in pairs(slots) do
                        local slot = json.decode(v)
                        if slot.name == "money" then 
                            for i, dol in pairs(slot.amount) do
                                inventoryMoney = inventoryMoney + dol
                            end
                        end
                    end
                end                

                
                local bankMoney = json.decode(characterFound[1].metaData).banco/100
                inventoryMoney = inventoryMoney/100
                TriggerClientEvent("FRP:NOTIFY:Simple", User:getSource(), characterFound[1].characterName, 5000)
                TriggerClientEvent("FRP:NOTIFY:Simple", User:getSource(), "No Bolso -> "..inventoryMoney, 5000)
                TriggerClientEvent("FRP:NOTIFY:Simple", User:getSource(), "No Banco -> "..bankMoney, 5000)
                TriggerClientEvent("FRP:NOTIFY:Simple", User:getSource(), "Total    -> "..bankMoney+inventoryMoney, 5000)

            else
                TriggerClientEvent("FRP:NOTIFY:Simple", User:getSource(), "Não encontramos esse personagem", 2000)
            end
        end
    end
)

RegisterCommand(
    "charusuario",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        local Character = User:getCharacter()
        if Character:hasGroupOrInheritance("admin") then
            local chars = API_Database.query("FCRP/GetCharacterByUserId", {userid = args[1]})
            if #chars > 0 then
                for i, char  in pairs(chars) do                    
                    TriggerClientEvent("FRP:NOTIFY:Simple", User:getSource(), "CharId -> [ "..char.charid.." ] Nome -> "..char.characterName, 5000)
                end
            else
                TriggerClientEvent("FRP:NOTIFY:Simple", User:getSource(), "Não encontramos personagens para esse usuário", 2000)
            end
        end
    end
)

function updateReplicatedNumConnectedPlayers()
    GlobalState.numConnectedPlayers = GetNumPlayerIndices()
end

AddEventHandler('playerJoining', function()
    updateReplicatedNumConnectedPlayers()
end)

AddEventHandler('playerDropped', function()
    updateReplicatedNumConnectedPlayers()
end)

CreateThread(function()
    updateReplicatedNumConnectedPlayers()
end)