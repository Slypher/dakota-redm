Proxy = module('_core', 'lib/Proxy')

PrivilegeSystemProxy = { }
Proxy.addInterface('PrivilegeSystem', PrivilegeSystemProxy)

-- #TODO: ?
-- PrivilegeSystem = Proxy.addInterface('PrivilegeSystem')

PRIVILEGE_DATABASE = {
    PRIV_QUEUE_PRIORITY = {
        replicate = false,
        tiers = {
            '10',
            '25',
            '50',
            '100',
            '250',
            '500',
        },
    },
    PRIV_SLOT_COUNT_CHAR = {
        replicate = true,
        tiers = {
            'LOW',
            'MEDIUM',
            'HIGH',
        },
    },
    PRIV_SLOT_COUNT_HORSE = {
        replicate = false,
        tiers = {
            '1',
            '2',
            '4',
        },
    }
}

PRIVILEGE_TYPE_TIER_SEPARATOR = '__'

gUserPrivilegesCache = { }

function isPrivilegeValid(privilege)
    local type, tier = getPrivilegeTypeAndTier(privilege)

    if not PRIVILEGE_DATABASE[type] then
        return false
    end

    for _, databaseTier in ipairs(PRIVILEGE_DATABASE[type].tiers) do
        if tier == databaseTier then
            return true
        end
    end

    return false
end

function getPrivilegeTypeAndTier(privilege)
    if not string.find(privilege, PRIVILEGE_TYPE_TIER_SEPARATOR) then
        return
    end

    local privilegeType, privilegeTier

    for s in string.split(privilege, PRIVILEGE_TYPE_TIER_SEPARATOR) do
        if not privilegeType then
            privilegeType = s
        else
            privilegeTier = s
        end
    end

    return privilegeType, privilegeTier
end

function getPrivilegeType(privilege)
    local type, _ = getPrivilegeTypeAndTier(privilege)

    return type
end

function getPrivilegeTier(privilege)
    local _, tier = getPrivilegeTypeAndTier(privilege)

    return tier
end

function addUserPrivilegeToCache(userId, privilege)
    if not gUserPrivilegesCache[userId] then
        gUserPrivilegesCache[userId] = { }
    end

    table.insert(gUserPrivilegesCache[userId], privilege)

    return true
end

function removeUserPrivilegeFromCache(userId, privilege)
    local userPrivileges = gUserPrivilegesCache[userId]

    if not userPrivileges then
        return false
    end

    for i = 1, #userPrivileges do
        local cachedPrivilege = userPrivileges[i]

        if cachedPrivilege == privilege then
            table.remove(userPrivileges, i)
            
            return true
        end
    end

    return false
end

function getUserHasCachedPrivilege(userId, privilege)
    local userPrivileges = gUserPrivilegesCache[userId]

    if not userPrivileges then
        return false
    end

    for _, cachedPrivilege in ipairs(userPrivileges) do
        if privilege == cachedPrivilege then
            return true
        end
    end

    return false
end

function getUserCachedPrivileges(userId)
    return gUserPrivilegesCache[userId] or { }
end

function getUserCachedPrivilegesByType(userId, privilegeType)
    local ret = { }

    local userCachedPrivileges = getUserCachedPrivileges(userId)

    for i = 1, #userCachedPrivileges do
        local cachedPrivilege = userCachedPrivileges[i]

        if getPrivilegeType(cachedPrivilege) == privilegeType then
            table.insert(ret, cachedPrivilege)
        end
    end

    return ret
end

function string:split(pat)
    pat = pat or '%s+'
    local st, g = 1, self:gmatch("()("..pat..")")
    local function getter(segs, seps, sep, cap1, ...)
        st = sep and seps + #sep
        return self:sub(segs, (seps or 0) - 1), cap1 or sep, ...
    end
    return function() if st then return getter(st, g()) end end
end

PrivilegeSystemProxy.getPrivilegeTier = getPrivilegeTier
PrivilegeSystemProxy.getUserCachedPrivileges = getUserCachedPrivileges
PrivilegeSystemProxy.getUserCachedPrivilegesByType = getUserCachedPrivilegesByType