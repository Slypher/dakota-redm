RegisterNetEvent('frp.addReplicatedUserPrivilege', function(privilege)
    addUserPrivilegeToCache(-1, privilege)
end)

RegisterNetEvent('frp.removeReplicatedUserPrivilege', function(privilege)
    removeUserPrivilegeFromCache(-1, privilege)
end)

PrivilegeSystemProxy.getUserHasCachedPrivilege = function(privilege)
    return getUserHasCachedPrivilege(-1, privilege)
end)