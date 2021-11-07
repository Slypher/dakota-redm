function getStateBagKeyForBank(bankId, key)
    return ('bankRobbery_%d__%s'):format(bankId, key)
end

function getReplicatedBankState(bankId, key)
    return GlobalState[ getStateBagKeyForBank(bankId, key) ]
end