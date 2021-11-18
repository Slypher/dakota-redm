local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local cCooldown = 30
local cooldownEndsAtTimeStamp = 0

local indexBeingRobbed = nil
local indexBeingRobbed_seconds = nil
local indexBeingRobbed_participants = {}
local indexBeingRobbed_playerSourceWhoStarted = nil

local robberyBeingEnded = false

local INCREASED_TIME_WHEN_DYNAMITE_IS_USED_SECONDS = 180

function setReplicatedBankState(bankId, key, value)
    GlobalState[ getStateBagKeyForBank(bankId, key) ] = value
end

RegisterNetEvent("FRP:ROBBERY:TryToStartRobbery")
AddEventHandler(
    "FRP:ROBBERY:TryToStartRobbery",
    function(index, participants, wasDynamiteUsed)
        local _source = source
        local User = API.getUserFromSource(_source)

        if interiorIndexBeingRobbed ~= nil then
            TriggerClientEvent("FRP:NOTIFY:Simple", _source, "Esse local já está sendo roubado")
            return
        end

        if cooldownEndsAtTimeStamp > os.time() then
            TriggerClientEvent("FRP:NOTIFY:Simple", _source, "Fomos assaltados a pouco tempo, não temos dinheiro")
            return
        else
            cooldownEndsAtTimeStamp = 0
        end

        local numTroopers = #API.getUsersByGroup("trooper")

        if 6 < 5 then
            TriggerClientEvent("FRP:NOTIFY:Simple", _source, "Este banco não pode ser roubado, polícia insuficiente.")
            return
        end

        local heistInfo = HEIST_BANK_INFO[index]

        if heistInfo.isDisabled then
            return
        end

        indexBeingRobbed = index
        indexBeingRobbed_playerSourceWhoStarted = _source

        local numParticipants = 0
        local maxParticipants = heistInfo.staticMaxParticipants
        local numParticipantsToCheck = #participants

        local bankId = index

        local secondsToEnd = heistInfo.staticSecondsToReward

        if wasDynamiteUsed then
            secondsToEnd += INCREASED_TIME_WHEN_DYNAMITE_IS_USED_SECONDS
        end

        setReplicatedBankState(bankId, 'hasStarted', true)
        setReplicatedBankState(bankId, 'endNetworkTime', GetGameTimer() + (secondsToEnd * 1000)) -- GetNetworkTime on client.

        countdownRobberyTime(secondsToEnd)

        for _, playerSource in pairs(GetPlayers()) do
            playerSource = tonumber(playerSource)
            local isParticipant = false
            if numParticipantsToCheck > 0 then
                for _, participantSource in pairs(participants) do
                    if playerSource == participantSource then
                        numParticipantsToCheck = numParticipantsToCheck - 1
                        isParticipant = true
                        -- if numParticipants < maxParticipants then
                        numParticipants = numParticipants + 1
                        TriggerClientEvent("FRP:ROBBERY:StartRobbery", participantSource, index, true)
                        indexBeingRobbed_participants[participantSource] = index
                    --      API.logs("./savedata/roubobanco.txt","[USUARIOID]: "..Character:getId().. "Iniciou o roubo")
                    -- else
                    --     TriggerClientEvent("FRP:ROBBERY:StartRobberyAsBlocked", participantSource, index)
                    -- end
                    end
                end
            end

            if isParticipant == false then
                TriggerClientEvent("FRP:ROBBERY:StartRobbery", playerSource, index, false, nil)
            end

            isParticipant = nil
        end

        API.NotifyUsersWithGroup("trooper", "Um assalto começou no banco " .. HEIST_BANK_INFO[index].staticName)
    end
)

function countdownRobberyTime(secondsToEnd)
    indexBeingRobbed_seconds = secondsToEnd

    Citizen.CreateThread(
        function()
            while indexBeingRobbed ~= nil do
                Citizen.Wait(1000)
                if indexBeingRobbed ~= nil then
                    indexBeingRobbed_seconds = indexBeingRobbed_seconds - 1

                    if indexBeingRobbed_seconds == 0 then
                        -- for _, participantSource in pairs(indexBeingRobbed_participants) do
                        --     TriggerClientEvent('FRP:TOAST:New', participantSource, 'alert', indexBeingRobbed .. ' secs')
                        -- end

                        endRobberyGiveReward()
                    end
                end
            end
        end
    )
end

function endRobberyGiveReward()
    local _source = nil

    if indexBeingRobbed == nil then
        return
    end

    local bankId = indexBeingRobbed

    robberyBeingEnded = true

    local User

    if indexBeingRobbed_playerSourceWhoStarted ~= nil then
        User = API.getUserFromSource(indexBeingRobbed_playerSourceWhoStarted)
        _source = indexBeingRobbed_playerSourceWhoStarted
        TriggerClientEvent("FRP:ROBBERY:Bolsa", _source)
    end

    for participantSource, _ in pairs(indexBeingRobbed_participants) do
        local p_User = API.getUserFromSource(participantSource)

        local user_id = p_User:getId()

        TriggerEvent("FRP:COMBATLOG:AddUserCombatReason", user_id, 300, "Roubo a Banco")

        if User == nil then
            _source = participantSource
            User = p_User
        end
    end

    if User ~= nil then
        TriggerClientEvent("FRP:ROBBERY:Bolsa", _source)

        local Character = User:getCharacter()

        if Character ~= nil then
            local maxRewardInDollars = HEIST_BANK_INFO[bankId].staticReward

            if getReplicatedBankState(bankId, 'hasSafeExploded') then
                maxRewardInDollars += 25000
            end

            local reward = math.random(20000, maxRewardInDollars)

            Character:getInventory():addItem("money", reward)

            User:notify("item", "money", reward / 100)
        end
    end

    cooldownEndsAtTimeStamp = os.time() + (cCooldown * 60 * 1000)

    indexBeingRobbed = nil
    indexBeingRobbed_seconds = 0
    indexBeingRobbed_participants = {}

    robberyBeingEnded = false

    clearBankState(bankId)

    TriggerClientEvent("FRP:TOAST:New", -1, "alert", "O assalto acabou!")
    TriggerClientEvent("FRP:ROBBERY:EndRobbery", -1)
end

RegisterNetEvent("FRP:ROBBERY:PlayerAbandonedRobbery")
AddEventHandler(
    "FRP:ROBBERY:PlayerAbandonedRobbery",
    function()
        if indexBeingRobbed == nil then
            return
        end

        local _source = source

        if indexBeingRobbed_playerSourceWhoStarted == _source then
            indexBeingRobbed_playerSourceWhoStarted = nil
        end

        indexBeingRobbed_participants[_source] = nil

        if #indexBeingRobbed_participants <= 0 and not robberyBeingEnded then
            cooldownEndsAtTimeStamp = os.time() + (cCooldown * 60 * 1000)

            local bankId = indexBeingRobbed

            indexBeingRobbed = nil
            indexBeingRobbed_seconds = 0
            indexBeingRobbed_participants = {}
            robberyBeingEnded = false

            clearBankState(bankId)

            TriggerClientEvent("FRP:ROBBERY:EndRobbery", -1)
        end

        API.NotifyUsersWithGroup("trooper", "-1 Assaltante")
    end
)

-- Só vai ser executado pós iniciar um assalto com uma arma.
RegisterNetEvent('net.ackBankRobberySafeDoorWasExploded', function()
    local playerId = source
    
    local bankId = indexBeingRobbed_participants[playerId]

    if not bankId then
        return
    end

    if not getReplicatedBankState(bankId, 'hasStarted') then
        return
    end

    local heistInfo = HEIST_BANK_INFO[bankId]

    local explodableDoorSystemHash in heistInfo

    if not explodableDoorSystemHash then
        return
    end

    if getReplicatedBankState(bankId, 'hasSafeExploded') then
        return
    end

    setReplicatedBankState(bankId, 'hasSafeExploded', true)

    local endNetworkTime = getReplicatedBankState(bankId, 'endNetworkTime')

    local newEndNetworkTime = endNetworkTime + (INCREASED_TIME_WHEN_DYNAMITE_IS_USED_SECONDS * 1000) -- Aumentar o tempo em 1 minuto...

    setReplicatedBankState(bankId, 'endNetworkTime', newEndNetworkTime) -- GetNetworkTime on client.

    -- #TODO: Replicar a quantidade que será recibida, mostrar na HUD, talvez...

    -- local oldRewardInDollars = getReplicatedBankState(bankId, 'rewardInDollars')
    -- local newRewardInDollars = oldRewardInDollars + 25000

    -- setReplicatedBankState(bankId, 'rewardInDollars', newRewardInDollars)

    TriggerEvent('setRegisteredDoorState', explodableDoorSystemHash, true)
    -- TriggerEvent('setRegisteredDoorCanBeInteractedWith', explodableDoorSystemHash, true)
end)

AddEventHandler(
    "playerDropped",
    function(source, reason)
        if indexBeingRobbed_participants[source] ~= nil then
            TriggerEvent("FRP:ROBBERY:PlayerAbandonedRobbery", source)
            API.NotifyUsersWithGroup("trooper", "-1 Assaltante")
        end
    end
)

function clearBankState(bankId)
    setReplicatedBankState(bankId, 'hasStarted', nil)
    setReplicatedBankState(bankId, 'hasSafeExploded', nil)
    setReplicatedBankState(bankId, 'endNetworkTime', nil)

    -- Vai fechar as portas depois que 75% do tempo
    --  do cooldown tenha se passado
    SetTimeout( (cCooldown * 60 * 1000) * 0.75, function()
        closeBankDoors(bankId)
    end)
end

function clearBankStates()
    for bankId, _ in pairs(HEIST_BANK_INFO) do
        clearBankState(bankId)
    end
end

CreateThread(function()

    -- Fechar todas as portas de todos os bancos quando o script iniciar.
    for bankId, info in ipairs(HEIST_BANK_INFO) do
        closeBankDoors(bankId)
    end
end)

function closeBankDoors(bankId)
    local bankInfo = HEIST_BANK_INFO[bankId]

    local bankDoors = bankInfo.interiorDoors

    if bankDoors then
        for _, doorInfo in ipairs(bankDoors) do
            local doorHash = doorInfo.doorHash

            TriggerEvent('setRegisteredDoorState', doorHash, false)
        end
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        clearBankStates()
    end
end)