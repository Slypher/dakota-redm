local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

-- RegisterCommand(
--     "interiss",
--     function(source, args, rawCommand)
--         print('a,', GetInteriorFromEntity(PlayerPedId()))
--     end,
--     false
-- )

local interiors = {
    --   [1] = 72962, -- BANCO BLACKWATER
    [2] = 42754, -- BANCO SAINT DENNIS
    [3] = 29442 -- BANCO RHODES
    --  [4] = 12290 -- BANCO VALENTINE

    --[[
        2644.385,-1299.759,52.204 Saint dennis.
        1293.334,-1298.951,77.600 Rhodes.
        -817.363,-1273.928,43.605 Black Water.
        -307.966,769.112,118.991 Valentine.
    ]]
}

-- local interiorIndexBeingRobbed = nil
local interiorIndexPlayerIsIn = nil

local isParticipantOfRobbery = false
local isBlockedByRobbery = false

local secondsUntilAbandonRobbery = nil

local shootingToStartCooldown = false

local gParticipatingBankId

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()

            local interiorIdPlayerIsIn = GetInteriorFromEntity(ped)

            if interiorIdPlayerIsIn ~= 0 then
                for index, interiorId in pairs(interiors) do
                    if interiorIdPlayerIsIn == interiorId then
                        interiorIndexPlayerIsIn = index
                    end
                end
            else
                interiorIndexPlayerIsIn = nil
            end
        end
    end
)

function getCurrentReplicatedBankState(key)
    return getReplicatedBankState(interiorIndexPlayerIsIn, key)
end

function isCurrentBankBeingRobbed()
    return getCurrentReplicatedBankState('hasStarted')
end

function canUseStartPathShootUp()
    -- print('canUseStartPathShootUp :: 0')

    if isCurrentBankBeingRobbed() then
        return false
    end

    -- print('canUseStartPathShootUp :: 1')

    if shootingToStartCooldown then
        return false
    end

    -- print('canUseStartPathShootUp :: 2')

    return true
end

function canUseStartPathPlantBomb()
    -- print('canUseStartPathPlantBomb :: 1')

    if isCurrentBankBeingRobbed() and getCurrentReplicatedBankState('hasSafeExploded') then
        return false
    end

    -- print('canUseStartPathPlantBomb :: 0')

    return true
end

Citizen.CreateThread(
    function()
        ClearPedTasksImmediately(PlayerPedId())

        --AddTextEntry("shoot_to_start", "Atire para começar o assalto")
        --AddTextEntry("wait_to_shoot", "Aguarde 10 segundos...")

        while true do
            Citizen.Wait(0)

            if interiorIndexPlayerIsIn ~= nil then

                local ped = PlayerPedId()
                local retval, weaponHash = GetCurrentPedWeapon(ped, 1)

                local isUnarmed = weaponHash == `WEAPON_UNARMED`

                if not isUnarmed then

                    -- IsWeaponAGun
                    local isWeaponAGun      = Citizen.InvokeNative(0x705BE297EEBDB95D, weaponHash)
                    local isWeaponADynamite = weaponHash == `WEAPON_THROWN_DYNAMITE`

                    -- print('isWeaponAGun', isWeaponAGun)
                    -- print('isWeaponADynamite', isWeaponADynamite)

                    if isWeaponAGun and canUseStartPathShootUp() then
                        notify('Atire para começar o assalto.')

                        if IsPedShooting(ped) then
                            initShootingCountdown()

                            handleStartRobberyOnCurrentBank(false)
                        end
                    end

                    if isWeaponADynamite and canUseStartPathPlantBomb() then
                        notify('Plante a dinamite no cofre para começar o assalto.')

                        if IsPedPlantingBomb(ped) then
                            local bombObjectEntity = GetCurrentPedWeaponEntityIndex(ped, 0)
                            
                            -- print('is planting, hey', bombObjectEntity)

                            while IsPedPlantingBomb(ped) do
                                Wait(0)
                            end

                            -- print('waiting to fully plant')

                            local onFinishPlantingBomb = function()

                                -- print('onFinishPlantingBomb', onFinishPlantingBomb)

                                local entityExplosionHandler = function()
                                    -- print('exploded')

                                    removeEntityExplosionHandler(entityExplosionHandler)

                                    if isCurrentBankBeingRobbed() then
                                        -- print('ack')

                                        TriggerServerEvent('net.ackBankRobberySafeDoorWasExploded')
                                    else
                                        -- print('start')

                                        handleStartRobberyOnCurrentBank(true)
                                    end
                                end

                                addEntityExplosionHandler(entityExplosionHandler)
                            end

                            local heistInfo = HEIST_BANK_INFO[interiorIndexPlayerIsIn]

                            local explodableDoorModelHash, explodableDoorPosition in heistInfo
                        
                            if explodableDoorModelHash and explodableDoorPosition then
                                local entities = findEntitiesInRangeByModel(explodableDoorPosition, 1.0, explodableDoorModelHash)
                                
                                local explodableDoorEntity = entities[1]

                                if explodableDoorEntity then
                                    onPlayerPlantBombTestCollisionWithEntity(bombObjectEntity, explodableDoorEntity, onFinishPlantingBomb)
                                end
                            end
                        end
                    end
                end

                if isBlockedByRobbery then
                    if not isCurrentBankBeingRobbed() then
                        isBlockedByRobbery = false
                        RemoveAnimDict("random@arrests@busted")
                        ClearPedTasks(ped)
                    else
                        -- DisableControlAction(0, 24, true)
                        -- DisableControlAction(0, 25, true)
                        -- DisableControlAction(0, 140, true)
                        -- DisableControlAction(0, 141, true)
                        -- DisableControlAction(0, 142, true)
                        -- DisableControlAction(0, 257, true)
                        -- DisableControlAction(0, 263, true)
                        -- DisableControlAction(0, 264, true)

                        if not isUnarmed then
                            SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                        end

                        if not IsEntityPlayingAnim(ped, "script_proc@robberies@homestead@lonnies_shack@deception", "hands_up_loop", 3) then
                            TaskPlayAnim(ped, "script_proc@robberies@homestead@lonnies_shack@deception", "hands_up_loop",  2.0, -2.0, -1, 67109393, 0.0, false, 1245184, false, "UpperbodyFixup_filter", false)
                        end
                    end
                end

                if getCurrentReplicatedBankState('hasStarted') then
                    local endNetworkTime = getCurrentReplicatedBankState('endNetworkTime')

                    local timeToEnd__ms = endNetworkTime - GetNetworkTime()
                    local timeToEnd__sec = timeToEnd__ms / 1000

                    local minutes = math.floor((timeToEnd__sec % 3600) / 60)
                    local seconds = timeToEnd__sec % 60

                    drawText( ('%d minutos e %.0f segundos'):format(minutes, seconds), true)
                end
            else
                if secondsUntilAbandonRobbery ~= nil then
                    drawText("~r~Volte para dentro do banco! " .. math.floor((secondsUntilAbandonRobbery / 10)) .. " segundos", true)
                end
            end

            -- :: continue ::
        end
    end
)

function getBankIdFromInterior(interiorId)
    for bankId, info in pairs(HEIST_BANK_INFO) do
        if info.interiorId == interiorId then
            return bankId
        end
    end

    return nil
end

function initCheckPedIsOutside()
    isParticipantOfRobbery = true
    Citizen.CreateThread(
        function()
            local defaultSeconds = 5
            defaultSeconds = defaultSeconds * 10 -- 100ms (Wait) * 50 = 5000ms
            secondsUntilAbandonRobbery = defaultSeconds
            while isParticipantOfRobbery do
                Citizen.Wait(100)

                local ped = PlayerPedId()

                -- local interiorIdBeingRobbed = interiors[interiorIndexBeingRobbed]
                local interiorIdPlayerIsIn = GetInteriorFromEntity(ped)

                local bankIdPlayerIsIn = getBankIdFromInterior(interiorIdPlayerIsIn)
                -- local isInteriorABank = bankIdPlayerIsIn ~= nil

                if gParticipatingBankId ~= bankIdPlayerIsIn then
                    if secondsUntilAbandonRobbery == nil then
                        secondsUntilAbandonRobbery = defaultSeconds
                    end

                    secondsUntilAbandonRobbery = secondsUntilAbandonRobbery - 1 -- Wait ms
                    if secondsUntilAbandonRobbery <= 0 then
                        if not isBlockedByRobbery then
                            TriggerServerEvent("FRP:ROBBERY:PlayerAbandonedRobbery")
                        else
                            isBlockedByRobbery = false
                            ClearPedTasks(ped)
                        end

                        TriggerEvent("FRP:ROBBERY:EndRobbery")

                        break
                    end
                else
                    if secondsUntilAbandonRobbery ~= nil then
                        secondsUntilAbandonRobbery = nil
                    end
                end
            end

            if not isParticipantOfRobbery then
                local ped = PlayerPedId()
                if IsEntityPlayingAnim(ped, "random@arrests@busted", "idle_a", 3) then
                    ClearPedTasks(ped)
                end
            end
        end
    )
end

function initShootingCountdown()
    shootingToStartCooldown = true
    seconds = 10

    Citizen.CreateThread(
        function()
            while seconds > 0 do
                Citizen.Wait(1000)
                seconds = seconds - 1
            end
            shootingToStartCooldown = false
        end
    )
end

function handleStartRobberyOnCurrentBank(wasDynamiteUsed)
    local playerId = PlayerId()
    local interiorIdPlayerIsIn = interiors[interiorIndexPlayerIsIn]

    local participants = {
        GetPlayerServerId(playerId)
    }

    for _, activePlayerId in ipairs(GetActivePlayers()) do
        if activePlayerId ~= playerId then
            local activePlayerPed = GetPlayerPed(activePlayerId)
            if activePlayerPed ~= 0 then
                local activePlayerPedInterior = GetInteriorFromEntity(activePlayerPed)
                if activePlayerPedInterior == interiorIdPlayerIsIn then
                    table.insert(participants, GetPlayerServerId(activePlayerId))
                end
            end
        end
    end

    TriggerServerEvent("FRP:ROBBERY:TryToStartRobbery", interiorIndexPlayerIsIn, participants, wasDynamiteUsed)
end

RegisterNetEvent("FRP:ROBBERY:StartRobbery")
AddEventHandler(
    "FRP:ROBBERY:StartRobbery",
    function(index, asParticipant)
        -- interiorIndexBeingRobbed = index

        if asParticipant then

            gParticipatingBankId = index

            initCheckPedIsOutside()

            cAPI.AddWantedTime(true, 30)
        end

        -- TriggerEvent("FRP:TOAST:New", "alert", "O assalto acabará em " .. seconds .. " segundos")
    end
)

RegisterNetEvent("FRP:ROBBERY:StartRobberyAsBlocked")
AddEventHandler(
    "FRP:ROBBERY:StartRobberyAsBlocked",
    function(index)
        -- interiorIndexBeingRobbed = index
        isBlockedByRobbery = true
        initCheckPedIsOutside()

        if not HasAnimDictLoaded("random@arrests@busted") then
            RequestAnimDict("random@arrests@busted")
        end
    end
)

RegisterNetEvent("FRP:ROBBERY:EndRobbery")
AddEventHandler(
    "FRP:ROBBERY:EndRobbery",
    function()
        -- interiorIndexBeingRobbed = nil

        isParticipantOfRobbery = false
        isBlockedByRobbery = false

        secondsUntilAbandonRobbery = nil
        shootingToStartCooldown = false

        gParticipatingBankId = nil
    end
)

function setSatchel(model)
    if HasModelLoaded(model) then
        Citizen.InvokeNative(0xFA28FE3A6246FC3, parseInt(model))
    end
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), parseInt(model), true, true, true)
end

RegisterNetEvent("FRP:ROBBERY:Bolsa")
AddEventHandler(
    "FRP:ROBBERY:Bolsa",
    function()
        --   cAPI.AddWantedTime(true, 30)

        if IsPedMale(PlayerPedId()) then
            setSatchel(0xEA272E11)
        else
            setSatchel(0xFCAF241B)
        end
    end
)

local lastDisplayedText
local lastVarString

function drawText(str, center)
    local x = 0.87
    local y = 0.95
    if lastDisplayedText == nil or lastDisplayedText ~= str then
        lastDisplayedText = str
        lastVarString = CreateVarString(10, "LITERAL_STRING", str)
    end
    SetTextScale(0.4, 0.4)
    SetTextColor(255, 255, 255, 255)
    Citizen.InvokeNative(0xADA9255D, 1)
    --DisplayText(str, x, y)
    if center then
        SetTextCentre(center)
        DisplayText(lastVarString, x, y)
    elseif alignRight then
        DisplayText(lastVarString, x + 0.15, y)
    else
        DisplayText(lastVarString, x, y)
    end
end

function notify(_message)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", _message, Citizen.ResultAsLong())
    SetTextScale(0.25, 0.25)
    SetTextCentre(1)
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end

function onPlayerPlantBombTestCollisionWithEntity(bombObjectEntity, testCollsionEntity, onFinish)
    local playerPed = PlayerPedId()

    local wasCompletlyPlanted = not IsEntityAttachedToEntity(bombObjectEntity, playerPed)

    if not wasCompletlyPlanted then
        return
    end

    onPlayerCompletyPlantBomb(bombObjectEntity, testCollsionEntity, onFinish)
end

function onPlayerCompletyPlantBomb(bombObjectEntity, testCollsionEntity, onFinish)
    local playerPed = PlayerPedId()

    if not IsEntityTouchingEntity(bombObjectEntity, testCollsionEntity) then
        return
    end

    if onFinish then
        onFinish()
    end
end

function findEntitiesInRangeByModel(position, range, modelHash)
    local itemSet = CreateItemset(true)

    local size = Citizen.InvokeNative(0x59B57C4B06531E1E, position, range, itemSet, 3, Citizen.ResultAsInteger())
    -- number xPos, number yPox, number zPos, float distance, int itemSet, int entityType

    local ret = { }

    if size > 0 then
        for index = 0, size - 1 do
            local entity = GetIndexedItemInItemset(index, itemSet)

            if GetEntityModel(entity) == modelHash then
                table.insert(ret, entity)
            end
        end
    end

    if IsItemsetValid(itemSet) then
        DestroyItemset(itemSet)
    end

    return ret
end

local gIsProcessingEntityExplosionEvent = false

local gEntityExplosionHandlers = { }

function addEntityExplosionHandler(handler)
    table.insert(gEntityExplosionHandlers, handler)

    processEntityExplosionEvent()
end

function removeEntityExplosionHandler(toRemoveHandler)
    for i, handler in ipairs(gEntityExplosionHandlers) do
        if handler == toRemoveHandler then
            table.remove(gEntityExplosionHandlers, i)
            break
        end
    end
end

function processEntityExplosionEvent()
    if gIsProcessingEntityExplosionEvent then
        return
    end

    gIsProcessingEntityExplosionEvent = true

    CreateThread(function()
        while gIsProcessingEntityExplosionEvent do
            local size = GetNumberOfEvents(0)
    
            if size > 0 then
                for i = 0, size - 1 do
                    local eventAtIndex = GetEventAtIndex(0, i)
    
                    if eventAtIndex == `EVENT_ENTITY_EXPLOSION` then
    
                        local eventData = exports['research']:DataViewNativeGetEventData(0, i, 6)
    
                        local eventPerpetrator = eventData['0']
                        -- local unk              = eventData['2']
                        local eventWeaponHash  = eventData['4']
    
                        local playerPedId = PlayerPedId()
    
                        if eventPerpetrator == playerPedId then
                            for _, handler in ipairs(gEntityExplosionHandlers) do
                                handler()
                            end
                        end
                    end
                end
            end
    
            if #gEntityExplosionHandlers <= 0 then
                break
            end
    
            Citizen.Wait(0)
        end
    
        gIsProcessingEntityExplosionEvent = false
    end)
end