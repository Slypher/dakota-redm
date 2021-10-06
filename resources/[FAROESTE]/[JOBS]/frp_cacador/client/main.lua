-- RegisterNetEvent("vorp:SelectedCharacter") -- NPC loads after selecting character
-- AddEventHandler("vorp:SelectedCharacter", function(charid)
--     startButchers()
-- end)

-- function startButchers() -- Loading Butchers Function
--     for i,v in ipairs(Config.Butchers) do 
--         -- Loading Model
--         local hashModel = GetHashKey(v.npcmodel) 
--         if IsModelValid(hashModel) then 
--             RequestModel(hashModel)
--             while not HasModelLoaded(hashModel) do                
--                 Wait(100)
--             end
--         else 
--             print(v.npcmodel .. " is not valid") -- Concatenations
--         end        
--         -- Spawn Ped
--         local x, y, z = table.unpack(v.coords)
--         local npc = CreatePed(hashModel, x, y, z, v.heading, false, true, true, true)
--         Citizen.InvokeNative(0x283978A15512B2FE, npc, true) -- SetRandomOutfitVariation
--         SetEntityNoCollisionEntity(PlayerPedId(), npc, false)
--         SetEntityCanBeDamaged(npc, false)
--         SetEntityInvincible(npc, true)
--         Wait(1000)
--         FreezeEntityPosition(npc, true) -- NPC can't escape
--         SetBlockingOfNonTemporaryEvents(npc, true) -- NPC can't be scared
--         local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, x, y, z) -- Blip Creation
--         SetBlipSprite(blip, v.blip, true) -- Blip Texture
--         Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.butchername) -- Name of Blip
--     end
-- end

function drawTxt(text, x, y, fontscale, fontsize, r, g, b, alpha, textcentred, shadow) -- Text function
    local str = CreateVarString(10, "LITERAL_STRING", text)
    SetTextScale(fontscale, fontsize)
    SetTextColor(r, g, b, alpha)
    SetTextCentre(textcentred)
    if shadow then 
        SetTextDropshadow(1, 0, 0, 255)
    end
    SetTextFontForCurrentCommand(1)
    DisplayText(str, x, y)
end

local ePedQuality = {
    PQ_INVALID = -1,
    PQ_LOW = 0,
    PQ_MEDIUM = 1,
    PQ_HIGH = 2,
    PQ_MAX = 3,
}

local gPlayerPed

local gActiveShopId
local gActiveShopPos

CreateThread(function()
    while true do
        Wait(0)

        gPlayerPed = PlayerPedId()
        local playerPos = GetEntityCoords(gPlayerPed)

        local aboutToActiveShopDist

        local aboutToActiveShopId
        local aboutToActiveShopInfo

        for butcherShopId, butcherShopInfo in ipairs(Config.Butchers) do
            
            local shopPos = butcherShopInfo.coords

            local distanceToShop = #(playerPos - shopPos)

            if distanceToShop <= 15.0 and (aboutToActiveShopDist == nil or distanceToShop < aboutToActiveShopDist) then
                aboutToActiveShopDist = distanceToShop

                aboutToActiveShopId = butcherShopId
                aboutToActiveShopInfo = butcherShopInfo
            end
        end

        local runBrainThread = (aboutToActiveShopId ~= nil and aboutToActiveShopId ~= gActiveShopId)

        gActiveShopId = aboutToActiveShopId
        gActiveShopPos = aboutToActiveShopInfo?.coords

        if runBrainThread then
            RunButcherShopBrainThread()
        end
    end
end)

local gTrackedCarriableEntities = { }

function RunButcherShopBrainThread()
    local shopIdCache = gActiveShopId

    local function DrawCommonText(str)
        drawTxt(str, 0.20, 0.83, 0.66, 0.7, 255, 255, 255, 255, true, true)
    end

    local function DisplayCommonNotification(str)
        TriggerEvent('FRP:NOTIFY:Simple', str, 4000)
    end

    CreateThread(function()
        while gActiveShopId == shopIdCache do
            Wait(0)

            if not gActiveShopId then
                return
            end

            local playerPos = GetEntityCoords(gPlayerPed)
            local playerDistanceToButcher = #(playerPos - gActiveShopPos)

            -- Longe demais :/
            if playerDistanceToButcher > 7.0 then
                goto continue
            end

            if playerDistanceToButcher >= 4.5 and playerDistanceToButcher <= 7.0 then
                -- DrawCommonText('~e~Chegue mais proximo do açougueiro')
                goto continue
            end

            -- GetFirstEntityPedIsCarrying
            local carryingEntity = Citizen.InvokeNative(0xD806CD2A4F2C2996, gPlayerPed, Citizen.ResultAsInteger())

            if carryingEntity == 0 then
                goto continue
            end

            if not NetworkGetEntityIsNetworked(carryingEntity) then
                -- DrawCommonText('~e~Essa entidade não é networked :?')
                goto continue
            end

            -- GetIsAnimal
            if not Citizen.InvokeNative(0x9A100F1CF4546629, carryingEntity) then
                goto continue
            end

            local animalModel = GetEntityModel(carryingEntity)

            -- GetCarriableEntityState
            local carriableState = Citizen.InvokeNative(0x61914209C36EFDDB, carryingEntity, Citizen.ResultAsInteger())

            local animalSellInfo = Config.Animals[animalModel]

            if animalSellInfo then
                DrawCommonText('~e~Solte o animal próximo da açougueiro para vender.')
            end

            -- CARRIABLE_STATE_BEING_PLACED_ON_GROUND
            if carriableState == 6 and not gTrackedCarriableEntities[carryingEntity] then
                -- print('placing on ground')

                local shopPosCache = gActiveShopPos

                -- CARRIABLE_STATE_NONE
                OnCarriableNextStateChangesTo(carryingEntity, 0, function()
                    -- print('fully on the ground')

                    if not animalSellInfo then
                        DisplayCommonNotification(Config.Language.NotInTheButcher)
                        return
                    end

                    local animalPos = GetEntityCoords(carryingEntity)

                    local animalDistanceToShop = #(GetEntityCoords(carryingEntity) - shopPosCache)

                    if animalDistanceToShop >= 3.5 then
                        DisplayCommonNotification(Config.Language.AnimalBodyToFar)
                        return
                    end

                    -- SetEntityCarryingFlag, CARRYING_FLAG_CAN_BE_CARRIED_WHEN_DEAD
                    Citizen.InvokeNative(0x18FF3110CF47115D, carryingEntity, 7, false)

                    -- SetEntityCarryingFlag, CARRYING_FLAG_CLEAN_UP_WHEN_NOT_CARRIED
                    Citizen.InvokeNative(0x18FF3110CF47115D, carryingEntity, 27, true)

                    SetEntityAsNoLongerNeeded(carryingEntity)

                    -- #TODO: Passar esta merda toda de enviar item para o server-side.

                    -- local toAddItem = animalSellInfo.givenItem
                    local toAddMoneyQnt = animalSellInfo.money
                    local toAddMoneyQntMultiplier = animalSellInfo.poorQualityMultiplier

                    -- GetPedQuality
                    local animalQuality = Citizen.InvokeNative(0x7BCC6087D130312A, carryingEntity)

                    if animalQuality >= ePedQuality.PQ_HIGH then
                        toAddMoneyQntMultiplier = animalSellInfo.perfectQualityMultiplier
                    elseif animalQuality == ePedQuality.PQ_MEDIUM then
                        toAddMoneyQntMultiplier = animalSellInfo.goodQualityMultiplier
                    end

                    TriggerServerEvent('vorp_hunting:giveReward', nil, toAddMoneyQnt * toAddMoneyQntMultiplier)

                    DisplayCommonNotification(Config.Language.AnimalSold)
                end)
            end

            ::continue::
        end
    end)
end

function OnCarriableNextStateChangesTo(entity, targetCarriableState, onEnterTargetCarriableState)
    gTrackedCarriableEntities[entity] = true

    -- GetCarriableEntityState
    local startCarriableState = Citizen.InvokeNative(0x61914209C36EFDDB, entity, Citizen.ResultAsInteger())

    CreateThread(function()
        while true do
            Wait(10)

            -- GetCarriableEntityState
            local carriableState = Citizen.InvokeNative(0x61914209C36EFDDB, entity, Citizen.ResultAsInteger())

            if carriableState ~= startCarriableState then

                -- Só vai executar a função caso a entidade
                -- mude para esse carriable state
                if carriableState == targetCarriableState then
                    onEnterTargetCarriableState()
                end

                gTrackedCarriableEntities[entity] = nil

                return
            end
        end
    end)
end