-- local sessionQueue = {}

-- LoginCooldown = {}

function connectUser(source, user_id)
    if API.users[user_id] then
        return
    end

    -- if #GetPlayers() == 32 then
    --     API.dropPlayer(source, "Quase bugou a instancia")
    --     return
    -- end

    local steamId = GetPlayerIdentifiers(source)[1] 

    local User = API.User(source, user_id, GetPlayerEndpoint(source))

    API.users[user_id] = User
    API.sources[source] = user_id
    API.identifiers[steamId] = GetPlayerIdentifiers(source)

    print(#GetPlayers() .. "/60 | " .. GetPlayerName(source) .. " (" .. User:getIpAddress() .. ") entrou (user_id = " .. user_id .. ", source = " .. source .. ")")

    TriggerEvent('FRP:OnUserCreated', user_id, source)

    TriggerEvent("FRP:IDENTITY:DisplayCharSelection", User)

    TriggerClientEvent("FRP:_CORE:SetServerIdAsUserId", -1, source, user_id)
    TriggerClientEvent("FRP:_CORE:SetServerIdAsUserIdPacked", source, API.sources)

    return User
end

-- { 
--     {
--         hook = hook,
--         owner = resource,
--     }
-- }
local gOnUserConnectingHooks = { }

-- hook: function(source, user_id) => string
function API.RegisterUserConnectingHook(hook)
    table.insert(gOnUserConnectingHooks,
    {
        hook = hook,
        owner = GetInvokingResource(),
    })
end

AddEventHandler('onResourceStop', function(resource)
    for i = 1, #gOnUserConnectingHooks do
        local data = gOnUserConnectingHooks[i]

        if data.owner == resource then
            table.remove(gOnUserConnectingHooks, i)
        end
    end
end)

--[[
    INICIAR _CORE DEPOIS DO CONNECTQUEUE
]]
Queue.OnReady(
    function()
        Queue.OnJoin(
            function(source, allow)
                local ids = GetPlayerIdentifiers(source)

                local steamId = ids[1]

                local playerName = GetPlayerName(source)

                local user_id = API.getUserIdByIdentifiers(ids, playerName)

                if not user_id then
                    allow("ERROR: Falha ao encontrar ou criar o seu usúario, contate a STAFF!")
                    return
                end

                if not API.isWhitelisted(steamId) then
                    allow("ERROR: Você não tem permissão. \n Passe seu ID a adminstração: " .. user_id .. " \n discord.gg/dakotaroleplay")
                    return
                end

                if API.isBanned(user_id) then
                    allow("ERROR: Você está banido!")
                    return
                end
                
                for _, data in ipairs(gOnUserConnectingHooks) do
                    local hookDenyCon = data.hook(user_id, source)

                    if hookDenyCon then
                        allow( ('ERROR: %s'):format(hookDenyCon) )
                        return
                    end
                end

                API.onFirstSpawn[user_id] = true

                TriggerEvent("API:playerJoin", user_id, source, playerName)

                allow()
            end
        )
    end
)

-- AddEventHandler(
--     "playerConnecting",
--     function(playerName, kickReason, deferrals)
--         -- if #GetPlayers() >= 31 or #API.users >= 31 then
--         --     print("Authentication: " .. source .. " Erro ao autenticar, limite de players alcançado!")
--         --     deferrals.done("32/32")
--         --     CancelEvent()
--         --     return
--         -- end

--         --    deferrals.defer()

--         local _source = source
--         local ids = GetPlayerIdentifiers(_source)

--         -- if ids[1] == nil then
--         --     deferrals.done("Abra a Steam.")
--         --     CancelEvent()
--         --     return
--         -- end

--         if LoginCooldown[ids[1]] == nil then
--             -- deferrals.update("Verificando sua whitelist...")

--             if API.isWhitelisted(ids[1]) then
--                 local user_id = API.getUserIdByIdentifiers(ids, playerName)
--                 if user_id then
--                     -- deferrals.update("Checando lista de banimentos...")

--                     if API.isBanned(user_id) == 0 then
--                         if API.users[user_id] == nil then
--                             -- deferrals.update("Tudo encontrado, carregando seus dados...")

--                             API.onFirstSpawn[user_id] = true

--                             -- table.insert(sessionQueue, _source)

--                             -- local index = indexOf(_source)

--                             -- local seconds = 15

--                             -- while index ~= nil do
--                             --     Citizen.Wait(1000)

--                             --     index = indexOf(_source)

--                             --     -- print("user_id" .. user_id .. " source: " .. source, index)

--                             --     if index ~= nil then
--                             --         deferrals.update("Conectando em " .. (index * seconds) .. " segundos. Aguarde!")

--                             --         -- print(_source, index)

--                             --         if index == 1 then
--                             --             Citizen.Wait(seconds * 1000)

--                             --             -- sessionQueue = splice(sessionQueue, index, 1)
--                             --             table.remove(sessionQueue, index)

--                             --             if #GetPlayers() > 30 then
--                             --                 seconds = 30
--                             --             else
--                             --                 seconds = 15
--                             --             end

--                             --             if #GetPlayers() < 31 and #API.users < 31 then
--                             TriggerEvent("API:playerJoin", user_id, _source, playerName)
--                         --                 deferrals.done()
--                         --             else
--                         --                 print("Authentication: " .. _source .. " Erro ao autenticar, limite de players alcançado!")
--                         --                 deferrals.done("32/32")
--                         --                 CancelEvent()
--                         --                 return
--                         --             end
--                         --             break
--                         --         end
--                         --     end
--                         -- end
--                         end
--                     else
--                         -- deferrals.done("Você está banido do servidor.")

--                         -- exports["connectqueue"].GetQueueExports:RemoveFromQueue(_source, true)
--                         -- exports["connectqueue"].GetQueueExports:RemoveFromConnecting(_source, true)

--                         DropPlayer(_source, "Você está banido do servidor.")

--                         CancelEvent()
--                     end
--                 else
--                     -- deferrals.done("Erro de identificação.")
--                     -- CancelEvent()

--                     exports["connectqueue"].GetQueueExports:RemoveFromQueue(_source, true)
--                     exports["connectqueue"].GetQueueExports:RemoveFromConnecting(_source, true)
--                 end
--             else
--                 LoginCooldown[ids[1]] = true
--                 Citizen.CreateThread(
--                     function()
--                         Citizen.Wait(60000)
--                         LoginCooldown[ids[1]] = nil
--                     end
--                 )

--                 -- print(playerName .. " (" .. ids[1] .. ") tentou conectar sem whitelist")
--                 -- deferrals.done("Sem permissão para entrar. HEX: " .. ids[1] .. " | discord.gg/nf4Qbdm")

--                 -- exports["connectqueue"].GetQueueExports:RemoveFromQueue(_source, true)
--                 -- exports["connectqueue"].GetQueueExports:RemoveFromConnecting(_source, true)

--                 DropPlayer(_source, "Sem permissão para entrar. HEX: " .. ids[1] .. " | discord.gg/nf4Qbdm")

--                 CancelEvent()
--             end
--         else
--             -- deferrals.done("Aguarde um minuto e você logo conseguira entrar.")

--             -- exports["connectqueue"].GetQueueExports:RemoveFromQueue(_source, true)
--             -- exports["connectqueue"].GetQueueExports:RemoveFromConnecting(_source, true)

--             DropPlayer("Aguarde um minuto e você logo conseguira entrar.")

--             CancelEvent()
--         end

--         exports["connectqueue"].GetQueueExports:OnJoin(
--             function(source, allow)
--             end
--         )
--     end
-- )

AddEventHandler('playerDropped', function(reason)

    local playerId = source

    API.dropPlayer(playerId, reason)

    API.log('PLAYER_LEFT', GetPlayerName(playerId), reason)

end)

AddEventHandler('playerConnecting', function()

    local playerId = source

    API.log('PLAYER_JOINED', GetPlayerName(playerId))

end)

RegisterNetEvent("pre_playerSpawned")
AddEventHandler(
    "pre_playerSpawned",
    function()
        local _source = source
        local user_id = API.getUserIdByIdentifiers(GetPlayerIdentifiers(_source), GetPlayerName(_source))
        if user_id then
            local isFirstSpawn = API.onFirstSpawn[user_id]
            TriggerEvent("API:playerSpawned", _source, user_id, isFirstSpawn)
            if onFirstSpawn then
                API.onFirstSpawn[user_id] = nil
            end
        end
    end
)

RegisterNetEvent("API:playerSpawned") -- Use this one !!!!!!!!!!!!!!!!!
AddEventHandler(
    "API:playerSpawned",
    function(source, user_id, isFirstSpawn)
        if isFirstSpawn then
            connectUser(source, user_id)
        -- API.onFirstSpawn[user_id] = nil
        end
    end
)

RegisterNetEvent("API:addReconnectPlayer")
AddEventHandler(
    "API:addReconnectPlayer",
    function()
        local _source = source
        local ids = GetPlayerIdentifiers(_source)
        local user_id = API.getUserIdByIdentifiers(ids, GetPlayerName(_source))
        if user_id then
            connectUser(_source, user_id)
        end
    end
)

RegisterNetEvent("API:OnUserSelectCharacter")
-- AddEventHandler(
--     "API:OnUserSelectCharacter",
--     function(User, characterId)

--     end
-- )

RegisterNetEvent("API:OnUserCharacterInitialization")
AddEventHandler(
    "API:OnUserCharacterInitialization",
    function(User, character_id)
        TriggerClientEvent("FRP:EVENTS:CharacterSetRole", User:getSource(), User:getCharacter().role)
    end
)

RegisterNetEvent("API:pre_OnUserCharacterInitialization")
AddEventHandler(
    "API:pre_OnUserCharacterInitialization",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        TriggerEvent("API:OnUserCharacterInitialization", User, Character:getId())
    end
)

-- function indexOf(v)
--     for i, s in pairs(sessionQueue) do
--         if s == v then
--             return i
--         end
--     end
-- end
