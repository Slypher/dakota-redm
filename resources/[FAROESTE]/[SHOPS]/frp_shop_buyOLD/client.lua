local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

local closestShopId
local closestShopVector

local prompt
local prompt_group
local prompt_group_name

local sentFirstData = false

local gSelectedShopId
local gSelectedShopName

local gSelectedShopChildPos

local gSelectedShopItemId
local gSelectedShopItemQuantityMultiplier = 1

local gShopItemPrompts = { }
local gShopItemPromptCooldown = { }

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            
            local playerPed = PlayerPedId()
            local playerPos = GetEntityCoords(playerPed)

            local closestShopId
            local closestShopName
            local closestShopChildPos

            local closestShopDistance

            for shopId, shopInfo in ipairs(SHOPINFO_DATABASE) do
                
                if shopInfo.positions then
                    for _, childShopPos in ipairs(shopInfo.positions) do

                        local distanceToShop = #(playerPos - childShopPos)

                        if distanceToShop <= 10.0 and (closestShopDistance == nil or distanceToShop <= closestShopDistance) then

                            closestShopId = shopId
                            closestShopName = shopInfo.name

                            closestShopChildPos = childShopPos

                            closestShopDistance = distanceToShop
                        end
                    end
                end
            end

            gSelectedShopId = closestShopId
            gSelectedShopName = closestShopName

            gSelectedShopChildPos = closestShopChildPos

            if closestShopId and not prompt_group then
                initPrompt()
            end

            -- local ped = PlayerPedId()
            -- local pCoords = GetEntityCoords(ped)

            -- local foundShopId
            -- local foundShopVector
            -- local lastDist

            -- for shopId, shopLocations in pairs(Config.ShopLocations) do
            --     for _, locationData in pairs(shopLocations) do
            --         local x, y, z, _ = table.unpack(locationData)
            --         local vec = vec3(x, y, z)
            --         local dist = #(pCoords - vec)
            --         if (foundShopVector == nil and dist <= 10.0) or (lastDist ~= nil and dist < lastDist)  then
            --             foundShopId = shopId
            --             foundShopVector = vec
            --             lastDist = dist
            --         end
            --     end
            -- end

            -- if foundShopId ~= nil then
            --     prompt_group_name = CreateVarString(10, "LITERAL_STRING", foundShopId)
            -- end

            -- closestShopId = foundShopId
            -- closestShopVector = foundShopVector

            -- gSelectedShopId = nil
            -- gSelectedShopName = closestShopId

            -- if closestShopId then
            --     for shopId, shopInfo in ipairs(Config.ShopDatas) do
            --         if shopInfo.name == closestShopId then
            --             gSelectedShopId = shopId
            --             break
            --         end
            --     end
            -- end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if gSelectedShopId then
                if IsNuiFocused() then
                    DisableAllControlActions(0)
                else
                    local playerPed = PlayerPedId()
                    local playerPos = GetEntityCoords(playerPed)

                    if #(playerPos - gSelectedShopChildPos) <= 1.5 then
                        local displayText = CreateVarString(10, 'LITERAL_STRING', gSelectedShopName)

                        PromptSetActiveGroupThisFrame(prompt_group, displayText)

                        if PromptHasHoldModeCompleted(prompt) and IsControlPressed(0, 0xDFF812F9) then

                            if sentFirstData then
                                SendNUIMessage(
                                    {
                                        display = true,
                                        shopId = gSelectedShopId - 1,
                                    }
                                )
                            else
                                local shopInfoDatabaseClone = { }

                                for shopId, shopInfo in ipairs(SHOPINFO_DATABASE) do
                                    
                                    local items = { }

                                    for shopItemId, shopItemInfo in ipairs(shopInfo.items) do
                                        local itemId = shopItemInfo.itemId
    
                                        local itemData = ItemList[itemId] or { }
    
                                        table.insert(items,
                                        {
                                            itemId,
                                            0,
                                            shopItemInfo.transactionPriceBuyDollar,
                                            shopItemInfo.transactionPriceBuyGold,
                                            itemData.name or ('ERROR %s'):format(itemId),
                                            itemData.weight or 0.0,
                                            itemData.description or '',
                                        })
                                    end

                                    table.insert(shopInfoDatabaseClone,
                                    {
                                        name = shopInfo.name,
                                        items = items,
                                    })
                                end

                                SendNUIMessage(
                                    {
                                        display = true,
                                        shopId = gSelectedShopId - 1,
                                        firstTimeData = shopInfoDatabaseClone,
                                    }
                                )

                                sentFirstData = true
                            end

                            local shopAudios = SHOPINFO_DATABASE[gSelectedShopId].audios

                            if shopAudios and #shopAudios > 0 then
                                local rnd = math.random(#shopAudios)

                                ExecuteCommand("campainha")
                                Wait(2000)
                                TriggerEvent('vrp_sound:source', shopAudios[rnd], 0.95)
                            end

                            SetNuiFocus(true, true)
                            SetNuiFocusKeepInput(true)
                        end
                    end
                end
            end
        end
    end
)

function initPrompt()
    prompt = PromptRegisterBegin()
    prompt_group = GetRandomIntInRange(0, 0xffffff)
    PromptSetControlAction(prompt, 0xDFF812F9)
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Falar"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, true)
    -- PromptSetPosition(prompt, foundShopVector)
    -- N_0x0c718001b77ca468(prompt, 1.5)
    PromptSetGroup(prompt, prompt_group)
    PromptRegisterEnd(prompt)
end

-- RegisterNUICallback(
--     "buyItem",
--     function(data, cb)
--         TriggerServerEvent("FRP:SHOP:TryToBuy", data.shopId, data.itemId, data.withGold)
--     end
-- )

RegisterNUICallback(
    "focusOff",
    function(data, cb)
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)

        ReleaseShopItemPrompts(gShopItemPrompts)
    end
)

RegisterNUICallback('shopItemWasSelected', function(data, cb)
    gSelectedShopItemQuantityMultiplier = 1

    gSelectedShopItemId = tonumber(data.shopItemId) + 1

    DrawSelectedShopItemPromptsWhileSelected()

    cb({ })
end)

RegisterNUICallback('shopItemWasUnselected', function(data, cb)
    gSelectedShopItemId = nil

    cb({ })
end)

function CreatePrompt(text, control, isHoldMode, promptGroup)
    local prompt = PromptRegisterBegin()
    PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', text))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetControlAction(prompt, control)

    if isHoldMode then
        PromptSetHoldMode(prompt, true)
    else
        -- UipromptSetStandardMode
        Citizen.InvokeNative(0xCC6656799977741B, prompt, true)
    end

    PromptSetGroup(prompt, promptGroup, 0)

    PromptRegisterEnd(prompt)

    return prompt
end

function CreateShopItemPromptGroup(shopItemInfo)
    local promptGroup = GetRandomIntInRange(0, 0xffffff)

    local promptGroupPrompts = { }

    local promptsInfo = {
        {
            name = 'QUANTITY_INCREASE',
            text = 'Mais',
            control = `INPUT_FRONTEND_UP`,
        },
        {
            name = 'QUANTITY_DECREASE',
            text = 'Menos',
            control = `INPUT_FRONTEND_DOWN`,
        },
    }

    if shopItemInfo.transactionPriceBuyDollar then
        table.insert(promptsInfo,
        {
            name = 'BUY_DOLLAR',
            control = `INPUT_DIVE`,
            isHold = true,
        })
    end

    if shopItemInfo.transactionPriceBuyGold then
        table.insert(promptsInfo,
        {
            name = 'BUY_GOLD',
            control = `INPUT_FRONTEND_RDOWN`,
            isHold = true,
        })
    end

    -- A parte de enviar as informações de items para NUI
    -- tá injetando valores nos indices 5, 6, 7
    -- então isso quebra toda a tabela de config...
    -- que deveria ficar inalterada né, na que é a porra de uma config.
    if shopItemInfo.transactionPriceSellDollar then
        table.insert(promptsInfo,
        {
            name = 'SELL_DOLLAR',
            control = `INPUT_NEXT_CAMERA`,
            isHold = true,
        })
    end

    local shopItemPrompts = { }

    for _, promptInfo in ipairs(promptsInfo) do
        local prompt = CreatePrompt(promptInfo.text, promptInfo.control, promptInfo.isHold, promptGroup)

        Citizen.InvokeNative(0xCA24F528D0D16289, prompt)

        table.insert(shopItemPrompts,
        {
            handle = prompt,
            info = promptInfo,
        })
    end

    return promptGroup, shopItemPrompts
end

function ReleaseShopItemPrompts(shopItemPrompts)
    for _, shopItemPrompt in ipairs(shopItemPrompts) do
        PromptDelete(shopItemPrompt.handle)
    end

    gSelectedShopItemId = nil

    gShopItemPrompts = { }
    gShopItemPromptCooldown = { }
end

function DrawSelectedShopItemPromptsWhileSelected()
    local shopItemId = gSelectedShopItemId

    local shopInfo = SHOPINFO_DATABASE[gSelectedShopId]
    
    local shopInfoItems = shopInfo.items

    local shopItemInfo = shopInfoItems[shopItemId]

    local shopItemPriceInDollar = shopItemInfo.transactionPriceBuyDollar
    local shopItemPriceInGold = shopItemInfo.transactionPriceBuyGold

    local itemId = shopItemInfo.itemId
    local itemInfo = ItemList[itemId]

    if not itemInfo then
        error( ('Item \'%s\' não existe no banco de dados.'):format(itemId) )
    end

    local shopItemName = itemInfo.name

    local promptGroup, shopItemPrompts = CreateShopItemPromptGroup(shopItemInfo)

    gShopItemPrompts = shopItemPrompts

    local numShopItemPrompts = #shopItemPrompts

    while gSelectedShopItemId == shopItemId do
        Wait(0)

        local selectedItemQuantity = gSelectedShopItemQuantityMultiplier * 1

        PromptSetActiveGroupThisFrame(promptGroup, CreateVarString(10, 'LITERAL_STRING', ('%d %s'):format(selectedItemQuantity, shopItemName) ))

        local gameTimer = GetGameTimer()

        for i = 1, numShopItemPrompts do
            local shopItemPrompt = shopItemPrompts[i]

            local handle = shopItemPrompt.handle
            local info = shopItemPrompt.info
            local name = info.name

            local onPromptPressedCooldown = 500
            local onPromptPressed

            if name == 'QUANTITY_INCREASE' or name == 'QUANTITY_DECREASE' then
                -- UipromptIsJustPressed
                if Citizen.InvokeNative(0x2787CC611D3FACC5, handle) then
                    onPromptPressed = function()
                        local toAdd = name == 'QUANTITY_INCREASE' and 1 or -1

                        gSelectedShopItemQuantityMultiplier = gSelectedShopItemQuantityMultiplier + toAdd

                        gSelectedShopItemQuantityMultiplier = math.max(gSelectedShopItemQuantityMultiplier, 1)

                        -- Cooldown das teclas de aumentar e diminuir a quantidade
                        -- são menores, para ficar mais dinamico.
                        onPromptPressedCooldown = 100
                    end
                end
            elseif name == 'BUY_DOLLAR' or name == 'BUY_GOLD' then
                local isBuyWithDollarPrompt = name == 'BUY_DOLLAR'

                if PromptHasHoldModeCompleted(handle) then
                    onPromptPressed = function()
                        local useCurrencyGold = isBuyWithDollarPrompt == false

                        TriggerServerEvent("FRP:SHOP:RequestBuyShopItem", gSelectedShopId, gSelectedShopItemId, useCurrencyGold, gSelectedShopItemQuantityMultiplier)
                    end
                end

                local currencySymbol = isBuyWithDollarPrompt and '$' or '~t4~G'
                local currencyPrice = isBuyWithDollarPrompt and shopItemPriceInDollar or shopItemPriceInGold

                PromptSetText(handle, CreateVarString(10, 'LITERAL_STRING', ('Comprar %s%0.2f'):format(currencySymbol, (currencyPrice / 100) * selectedItemQuantity) ))

            elseif name == 'SELL_DOLLAR' then
                if PromptHasHoldModeCompleted(handle) then
                    onPromptPressed = function()
                        TriggerServerEvent('FRP:SHOP:RequestSellShopItem', gSelectedShopId, gSelectedShopItemId, gSelectedShopItemQuantityMultiplier)
                    end
                end

                local currencySymbol = '$'
                local currencyPrice = shopItemInfo.transactionPriceSellDollar

                PromptSetText(handle, CreateVarString(10, 'LITERAL_STRING', ('Vender %s%0.2f'):format(currencySymbol, (currencyPrice / 100) * selectedItemQuantity) ))
            end

            -- A thread principal está bloqueando todos os controles
            -- então a gente só reativa as que estão sendo usadas
            -- por prompts.
            EnableControlAction(0, info.control, true)

            if gShopItemPromptCooldown[handle] and (gameTimer - gShopItemPromptCooldown[handle]) <= 0 then
                PromptSetEnabled(handle, false)
            else
                PromptSetEnabled(handle, true)

                if onPromptPressed then
                    onPromptPressed()
                    
                    gShopItemPromptCooldown[handle] = GetGameTimer() + onPromptPressedCooldown
                end
            end
        end
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then
        return
    end

    ReleaseShopItemPrompts(gShopItemPrompts)

    SendNUIMessage(
        {
            display = false
        }
    )
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)

    if prompt ~= nil then
        PromptDelete(prompt)
    end
end)