RegisterNetEvent('frp.addReplicatedUserPrivilege', function(privilege)
    addUserPrivilegeToCache(-1, privilege)

    print('addReplicatedUserPrivilege', privilege)
end)

RegisterNetEvent('frp.removeReplicatedUserPrivilege', function(privilege)
    removeUserPrivilegeFromCache(-1, privilege)

    print('removeReplicatedUserPrivilege', privilege)
end)