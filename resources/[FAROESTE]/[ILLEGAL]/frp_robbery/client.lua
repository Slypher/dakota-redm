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
                for bankId, bankInfo in ipairs(HEIST_BANK_INFO) do
                    if interiorIdPlayerIsIn == bankInfo.interiorId then
                        interiorIndexPlayerIsIn = bankId
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
    if isCurrentBankBeingRobbed() then
        return false
    end

    if shootingToStartCooldown then
        return false
    end

    return true
end

function canUseStartPathPlantBomb()
    if isCurrentBankBeingRobbed() and getCurrentReplicatedBankState('hasSafeExploded') then
        return false
    end

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

                            while IsPedPlantingBomb(ped) do
                                Wait(0)
                            end

                            local onFinishPlantingBomb = function()

                                local entityExplosionHandler = function()
                                    removeEntityExplosionHandler(entityExplosionHandler)

                                    if isCurrentBankBeingRobbed() then
                                        TriggerServerEvent('net.ackBankRobberySafeDoorWasExploded')
                                    else
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
                else
                    -- UilogClearCachedObjective
                    -- Citizen.InvokeNative(0xDFF0D417277B41F8)

                    -- UilogClearHasDisplayedCachedObjective
                    -- Citizen.InvokeNative(0xA3108D6981A5CADB)
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
                    local timeToEnd__sec = math.max(timeToEnd__ms, 0) / 1000

                    local minutes = math.floor((timeToEnd__sec % 3600) / 60)
                    local seconds = math.floor(timeToEnd__sec % 60)

                    drawText( ('%0.02d:%.02d.%.02d'):format(minutes, seconds, 0.0), true)
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
    local interiorIdPlayerIsIn = HEIST_BANK_INFO[interiorIndexPlayerIsIn].interiorId

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
        isParticipantOfRobbery = false
        isBlockedByRobbery = false

        secondsUntilAbandonRobbery = nil
        shootingToStartCooldown = false

        gParticipatingBankId = nil
    end
)

function setSatchel(model)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), model, true, true, true)
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
    local x = 0.50
    local y = 0.05

    local varstr = CreateVarString(10, "LITERAL_STRING", str)

    SetTextScale(0.5, 0.5)
    SetTextColor(255, 255, 255, 255)
    Citizen.InvokeNative(0xADA9255D, 1)
    --DisplayText(str, x, y)
    if center then
        SetTextCentre(center)
        DisplayText(varstr, x, y)
    elseif alignRight then
        DisplayText(varstr, x + 0.15, y)
    else
        DisplayText(varstr, x, y)
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