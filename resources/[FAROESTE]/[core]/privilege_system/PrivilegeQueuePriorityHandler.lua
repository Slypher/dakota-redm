local QueueExports = exports.connectqueue:GetQueueExports()

ServerAPI.RegisterUserConnectingHook(function(userId, playerId)
    local userPrivileges = fetchUserPrivileges(userId)
    
    local queuePriorityPrivileges = { }

    for i = 1, #userPrivileges do
        local privilege = userPrivileges[i]

        if getPrivilegeType(privilege) == 'PRIV_QUEUE_PRIORITY' and isPrivilegeValid(privilege) then
            table.insert(queuePriorityPrivileges, privilege)
        end
    end

    local addQueuePrivilege = 0

    for _, queuePriorityPrivilege in ipairs(queuePriorityPrivileges) do
        addQueuePrivilege += tonumber(getPrivilegeTier(queuePriorityPrivilege))
    end

    QueueExports:AddPriority(playerId, addQueuePrivilege, 90)

    -- return 'No'
end)


