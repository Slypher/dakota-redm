-- # Possibilidade de VIPS e ADMINS poderem criar mais de 1 personagem.
--     - A quantidade máxima parece ser definida pelo script da NUI do 'frp_identity'...
--      meio complicado definir uma permissão disso daqui ja que o User em si não guarda
--      permissões e na framework standalone não tem sistema de VIP...
--      o 'workaround' seria só fazer a verificação após o player já tiver 1 personagem
--      criado e verificar se esse personagem possui permissão de vip, mas isso teria que
--      ser feito com o Character não estando ativo/logado e eu duvido que seja possivel
--      verificar corretamente os grupos do Character atualmente via banco de dados somente.
--     - Dá para fazer uma query para verificar se o primeiro personagem está em um dos grupos que
--      a gente deseja verificar e enviar para o client o numero maximo e personagens possiveis.
--
-- # Vip | Privilegios
--     - PRIV_QUEUE_PRIORITY__LOW: LOW | MEDIUM | HIGH
--     - PRIV_SLOT_COUNT_CHAR__LOW: LOW | MEDIUM | HIGH
--     - PRIV_SLOT_COUNT_HORSE__LOW: LOW | MEDIUM | HIGH
--     - Schema: { id name created_at set_by }

local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

ServerAPI = Proxy.getInterface('API')
ClientRPC = Tunnel.getInterface('API')

DatabaseAPI = Proxy.getInterface('API_DB')

CreateThread(function()
    DatabaseAPI.prepare('privilege_system_create_schema', [[
CREATE TABLE IF NOT EXISTS `user_privileges` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `user_id` int(11) NOT NULL,
    `name` varchar(50) NOT NULL,
    `set_by` int(11) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
    PRIMARY KEY (`id`),
    KEY `FK_user_privileges_users` (`user_id`),
    CONSTRAINT `FK_user_privileges_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
    KEY `FK_user_privileges_users_set_by` (`set_by`),
    CONSTRAINT `FK_user_privileges_users_set_by` FOREIGN KEY (`set_by`) REFERENCES `users` (`user_id`)
); 
    ]])

    DatabaseAPI.prepare('privilege_system_get_user_privileges_name_only', 'SELECT `name` FROM `user_privileges` WHERE `user_id` = @user_id');

    DatabaseAPI.prepare('privilege_system_add_privilege_for_user', 'INSERT INTO `user_privileges`(`user_id`, `name`, `set_by`) VALUES(@user_id, @name, @set_by)');

    DatabaseAPI.prepare('privilege_system_remove_privilege_for_user', 'DELETE FROM `user_privileges` WHERE `user_id` = @user_id AND `name` = @name LIMIT 1');

    --

    init()
end)

function init()
    DatabaseAPI.execute('privilege_system_create_schema', { })

    -- print('PrivilegeSystem: a tabela `user_privileges` foi criada.')

    Wait(1000)

    for userId, user in pairs(ServerAPI.getUsers()) do
        loadUserPrivileges(userId, user:getSource())
    end
end

-- Type: PRIV_QUEUE_PRIORITY
-- Tier: 10
-- Privilege: PRIV_QUEUE_PRIORITY__10

-- {
--     [userId] = {
--         'PRIV_?',
--         'PRIV_?',
--         ... 
--     }
-- }

-- Release on playerDropped and on playerBailedConnection.
-- Replicate user privilege to the client.

local function doesPrivilegeHaveReplicatedFlag(privilege)
    return PRIVILEGE_DATABASE[getPrivilegeType(privilege)].replicate
end

local function replicateAddUserPrivilegeToPlayer(playerId, privilege)
    TriggerClientEvent('frp.addReplicatedUserPrivilege', playerId, privilege)
end

local function replicateRemoveUserPrivilegeToPlayer(playerId, privilege)
    TriggerClientEvent('frp.removeReplicatedUserPrivilege', playerId, privilege)
end

local function addUserPrivilege(userId, privilege, setByUserId)
    if not isPrivilegeValid(privilege) then
        return false
    end
    
    local user = ServerAPI.getUserFromUserId(userId)

    local playerId = user:getSource()

    DatabaseAPI.execute('privilege_system_add_privilege_for_user', { user_id = userId, name = privilege })

    addUserPrivilegeToCache(userId, privilege)

    if doesPrivilegeHaveReplicatedFlag(privilege) then
        replicateAddUserPrivilegeToPlayer(playerId, privilege)
    end

    return true
end

local function removeUserPrivilege(userId, privilege)
    if not isPrivilegeValid(privilege) then
        return false
    end

    local user = ServerAPI.getUserFromUserId(userId)

    local playerId = user:getSource()

    DatabaseAPI.execute('privilege_system_remove_privilege_for_user', { user_id = userId, name = privilege })

    removeUserPrivilegeFromCache(userId, privilege)

    if doesPrivilegeHaveReplicatedFlag(privilege) then
        replicateRemoveUserPrivilegeToPlayer(playerId, privilege)
    end

    return true
end

function fetchUserPrivileges(userId)
    local result = DatabaseAPI.query('privilege_system_get_user_privileges_name_only', { user_id = userId })

    local userPrivileges = { }

    for i = 1, #result do
        table.insert(userPrivileges, result[i].name)
    end

    return userPrivileges
end

function loadUserPrivileges(userId, playerId)
    local userPrivileges = fetchUserPrivileges(userId)

    gUserPrivilegesCache[userId] = { }

    for i = 1, #userPrivileges do
        local privilege = userPrivileges[i]

        if isPrivilegeValid(privilege) then

            table.insert(gUserPrivilegesCache[userId], privilege)

            if doesPrivilegeHaveReplicatedFlag(privilege) then
                replicateAddUserPrivilegeToPlayer(playerId, privilege)
            end
        end
    end

    -- print('loadUserPrivileges', json.encode(gUserPrivilegesCache[userId]))
end

AddEventHandler('FRP:OnUserCreated', loadUserPrivileges)

AddEventHandler('FRP:UserDropped', function(source, userId, characterId, reason)
    gUserPrivilegesCache[userId] = nil
end)

function privilegeCommandWrapper(fn, ignorePrivilegeArg)
    return function(playerId, args, rawCommand)
        local user = ServerAPI.getUserFromSource(playerId)

        if not user then
            return
        end

        local character = user:getCharacter()

        if not character then
            return
        end

        if not character:hasGroupOrInheritance('admin') then
            user:notify('error', 'Você não tem permissão!')
            return
        end

        local targetUserId = tonumber(args[1])

        if not targetUserId then
            user:notify('error', 'O parametro {targetUserId} precisa ser um número.')
            return
        end

        local privilege = args[2]

        if not ignorePrivilegeArg and not isPrivilegeValid(privilege) then
            user:notify('error', ('O prívilegio {%s} não é valido.'):format(privilege) )
            return
        end

        fn(targetUserId, privilege, user:getId())
    end
end

RegisterCommand('priv_add', privilegeCommandWrapper(addUserPrivilege))
RegisterCommand('priv_remove', privilegeCommandWrapper(removeUserPrivilege))
RegisterCommand('priv_list', privilegeCommandWrapper(function(targetUserId, userId)
    print(json.encode(gUserPrivilegesCache[targetUserId], { indent = true }))
end, true))