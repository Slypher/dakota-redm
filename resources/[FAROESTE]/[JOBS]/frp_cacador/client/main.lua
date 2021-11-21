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

local gPromptDropOffHuntingWagon

CreateThread(function()
    while true do
        Wait(500)

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

    CreateThread(function()

        local promptGroup = GetRandomIntInRange(0, 0xffffff)

        gPromptDropOffHuntingWagon = CreateDropOffHuntingWagonPrompt(promptGroup)

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

            if ProcessDropOffCarriableEntity() then
                goto continue
            end

            if ProcessDropOffFromHuntingWagon() then
                PromptSetActiveGroupThisFrame(promptGroup, CreateVarString(10, 'LITERAL_STRING', 'Vender Items da Carroça'))

                PromptSetEnabled(gPromptDropOffHuntingWagon, true)
            else
                PromptSetEnabled(gPromptDropOffHuntingWagon, false)
            end

            ::continue::
        end

        PromptDelete(gPromptDropOffHuntingWagon)

        gPromptDropOffHuntingWagon = nil
    end)
end

function ProcessDropOffCarriableEntity()
    -- GetFirstEntityPedIsCarrying
    local carryingEntity = Citizen.InvokeNative(0xD806CD2A4F2C2996, gPlayerPed, Citizen.ResultAsInteger())

    if carryingEntity == 0 then
        return
    end

    if not NetworkGetEntityIsNetworked(carryingEntity) then
        -- DrawCommonText('~e~Essa entidade não é networked :?')
        return
    end

    -- GetIsAnimal, GetIsCarriablePelt
    if not Citizen.InvokeNative(0x9A100F1CF4546629, carryingEntity)
    and not Citizen.InvokeNative(0x255B6DB4E3AD3C3E, carryingEntity) then
        return
    end

    -- print('GetIsCarriablePelt', GetIsCarriablePelt)

    local animalModel = GetEntityModel(carryingEntity)

    -- GetCarriableEntityState
    local carriableState = Citizen.InvokeNative(0x61914209C36EFDDB, carryingEntity, Citizen.ResultAsInteger())

    -- if animalSellInfo then
        -- DrawCommonText('~e~Solte o animal próximo da açougueiro para vender.')
    -- end

    -- CARRIABLE_STATE_BEING_PLACED_ON_GROUND
    if carriableState == 6 and not gTrackedCarriableEntities[carryingEntity] then
        -- print('placing on ground')

        local shopPosCache = gActiveShopPos

        -- CARRIABLE_STATE_NONE
        onEntityCarriableStateChangesTo(carryingEntity, 0 | 3, function()
            -- print('fully on the ground')

            local carriableRDR3InventoryItem = exports.hunting_wagon:getCarriableEntityItem(carryingEntity)

            -- print(
            --     GetFrameTime(),
            --     'Issa animal or a pelt',
            --     animalModel,
            --     `PROVISION_DEER_HIDE_POOR`,
            --     `PROVISION_DEER_HIDE_PRISTINE`,
            --     `PROVISION_DEER_HIDE`,
            --     `PROVISION_ANIMAL_CARCASS_DEER_HIGH_QUALITY`,
            --     `PROVISION_ANIMAL_CARCASS_DEER_PERFECT`,
            --     `PROVISION_ANIMAL_CARCASS_DEER_POOR`,
            --     carriableRDR3InventoryItem
            -- )

            local animalSellInfo = RDR3ProvisionItemToDollars[carriableRDR3InventoryItem] or Config.Animals[animalModel]

            -- print('animalSellInfo', animalSellInfo)

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

            -- `animalSellInfo` vai ser do tipo `number` quando estiver puxando do RDR3ProvisionItemToDollars
            local toAddMoneyQnt = type(animalSellInfo) == 'number' and (animalSellInfo * 100) or nil

            if not toAddMoneyQnt then
                -- local toAddItem = animalSellInfo.givenItem
                toAddMoneyQnt = animalSellInfo.money
                local toAddMoneyQntMultiplier -- = animalSellInfo.poorQualityMultiplier

                -- GetPedQuality
                local animalQuality = Citizen.InvokeNative(0x7BCC6087D130312A, carryingEntity)

                if animalQuality >= ePedQuality.PQ_HIGH then
                    toAddMoneyQntMultiplier = animalSellInfo.perfectQualityMultiplier
                elseif animalQuality == ePedQuality.PQ_MEDIUM then
                    toAddMoneyQntMultiplier = animalSellInfo.goodQualityMultiplier
                end

                toAddMoneyQnt = toAddMoneyQnt * (toAddMoneyQntMultiplier or 1)
            end

            TriggerServerEvent('vorp_hunting:giveReward', toAddMoneyQnt)

            -- DisplayCommonNotification(Config.Language.AnimalSold)
        end)
    end
end

function ProcessDropOffFromHuntingWagon()
    local playerVehicle = GetVehiclePedIsIn(gPlayerPed, false)

    if playerVehicle == 0 then
        return
    end

    if GetEntityModel(playerVehicle) ~= `Huntercart01` then
        return
    end

    local wagonStateBag = Entity(playerVehicle).state

    if not wagonStateBag.isTemporaryPlayerWagon then
        return
    end

    if PromptHasHoldModeCompleted(gPromptDropOffHuntingWagon) then
        TriggerServerEvent('net.huntingWagonRemoveAllItemsAndCollectMoney', NetworkGetNetworkIdFromEntity(playerVehicle))
        
        -- Delay para não continuar pressionando...
        Wait(100)
    end

    return true
end

function onEntityCarriableStateChangesTo(entity, targetCarriableStateFlags, onEnterTargetCarriableState)
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
                if (carriableState & targetCarriableStateFlags) ~= 0 then
                    onEnterTargetCarriableState()
                end

                gTrackedCarriableEntities[entity] = nil

                return
            end
        end
    end)
end

function DrawCommonText(str)
    drawTxt(str, 0.20, 0.83, 0.66, 0.7, 255, 255, 255, 255, true, true)
end

function DisplayCommonNotification(str)
    TriggerEvent('FRP:NOTIFY:Simple', str, 4000)
end

function CreateDropOffHuntingWagonPrompt(promptGroup)
    local prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, `INPUT_CONTEXT_X`)
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", 'Vender'))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, true)
    PromptSetGroup(prompt, promptGroup)
    PromptRegisterEnd(prompt)

    return prompt
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if gPromptDropOffHuntingWagon then
            PromptDelete(gPromptDropOffHuntingWagon)
        end
    end
end)