local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local verificationData = {
    
    ["Arsenal"] = {
        group = "trooper",
        -- Level, Price, Amount(optional)
        ["revolver_doubleaction"] = {0, 1, 0},
        ["rifle_springfield"] = {0, 1, 0},
        ["ammo_revolver"] = {0, 1, 0, 50},
        ["ammo_rifle"] = {0, 1, 0, 50},
        ["ammo_repeater"] = {0, 1, 0, 50},
        ["melee_torch"] = {0, 1, 0, 1},
        ["lasso"] = {0, 1, 0, 1},
        ["melee_knife"] = {0, 1, 0, 1},
    },

    ["Armeiro"] = {
        -- Level, Price, Amount(optional)
        ["melee_knife"] = {0, 500, 1, 1},--------------------------
		["revolver_doubleaction"] = {0, 3200, 10, 1},--------------
		["revolver_cattleman"] =  {0, 5000, 10, 1},----------------
		["revolver_lemat"] = {0, 12000, 25, 1},--------------------
		["revolver_schofield"] = {0, 8600, 30, 1},-----------------
		["revolver_navy"] = {0, 11000, 35, 1},---------------------
		["pistol_volcanic"] = {0, 8600, 30, 1},--------------------
		["pistol_mauser"] = {0, 8200, 28, 1},----------------------
		["pistol_semiauto"] = {0, 7600, 20, 1},--------------------
		["repeater_carbine"] = {0, 6400, 15, 1},-------------------
		["repeater_evans"] = {0, 7000, 35, 1}, --------------------
		["repeater_winchester"] = {0, 7800, 30, 1},----------------
		["repeater_henry"] = {0, 8000, 45, 1},---------------------
		["rifle_varmint"] = {0, 4000, 35, 1},----------------------
		["rifle_boltaction"] = {0, 9000, 60, 1},-------------------
		["rifle_springfield"] = {0, 9000, 40, 1},------------------
		["shotgun_doublebarrel"] = {0, 17000, 80, 1},--------------
		["shotgun_sawedoff"] = {0, 12000, 65, 1},------------------
		["sniperrifle_rollingblock"] = {0, 14000, 70, 1}-----------
    },
    ["Porto de BlackWater"] = {

        ["corpodevaqueiro"] = {0, 1000, 1, 1},
		["corpodeacaodupla"] = {0, 300, 1, 1},
		["corpodelemat"] = {0, 3000, 1, 1},
		["corpodeschotfield"] = {0, 2700, 1, 1},
		["corpodenavy"] = {0, 3500, 1, 1},
	
        ["corpodevolcanic"] = {0, 3000, 1, 1},
		["corpodemauser"] = {0, 2800, 1, 1},
		["corpodesemiauto"] = {0, 2500, 1, 1},
	
        ["corpodecarabina"] = {0, 1500, 1, 1},
		["corpodeevans"] = {0, 1800, 1, 1},
		["corpodehenry"] = {0, 2100, 1, 1},
		["corpodelancaster"] = {0, 2000, 1, 1},

		["corpodeferrolho"] = {0, 2400, 1, 1},
		["corpodespringfield"] = {0, 2200, 1, 1},

		["corpoderolling"] = {0, 4200, 1, 1},

		["corpodeescopeta"] = {0, 3550, 1, 1},
		["corpodeserrada"] = {0, 3000, 1, 1},

		["sacopolvora"] = {0, 3000, 1, 1},
		["caixacartuchos"] = {0, 3000, 1, 1},
    },
    ["Sementes"] = { -- SEMENTES LEGAIS
			["cornseed"] = {0, 6, 1, 1},
			["cenouraseed"] = {0, 5, 1, 1},
			["feijaoseed"] = {0, 6, 1, 1},
			["sugarcaneseed"] = {0, 6, 1, 1},
			["trigoseed"] = {0, 6, 1, 1},
			["batataseed"] = {0, 6, 1, 1},
			["tomateseed"] = {0, 5, 1, 1},
			["repolhoseed"] = {0, 5, 1, 1},
			["alfaceseed"] = {0, 5, 1, 1},
	},
    ["Clive"] = { -- SEMENTES ILEGAIS
			["tobaccoseed"] = {0, 5, 1, 1},								
			["sugarcaneseed"] = {0, 6, 1, 1},
			["lupuloseed"] = {0, 5, 1, 1},
			["papolaseed"] = {0, 15, 1, 1},
	},
    ["Carteiro"] = {
			["pigeonpost"] = {0, 500, 30, 1},								
			["notepad"] = {0, 6, 1, 1},
	},
    ["Carteiro"] = { -- ILEGAL
			["pigeonpost"] = {0, 500, 30, 1},								
			["notepad"] = {0, 6, 1, 1},
	},
    ["Mark"] = {
            ["feijaolata"] = {0, 90, 1, 1},
			["milholata"] =  {0, 90, 1, 1},
			["sopa"] = {0, 700, 1, 1},
			["sopadecarne"] = {0, 790, 1, 1},
			["molhotomate"] = {0, 70, 1, 1},
	},
    ["Terry"] = { -- 
			["lasso"] = {0, 500, 30, 1},								
			["melee_knife"] = {0, 500, 1, 1},
            ["agua"] = {0, 6, 1, 1},
			["ferramentas"] =  {0, 1000, 1, 1},
	},
    ["Thomas"] = { -- 
			["lasso"] = {0, 500, 30, 1},								
			["melee_knife"] = {0, 500, 1, 1},
            ["agua"] = {0, 6, 1, 1},
			--["ferramentas"] =  {1, 1000, 1, 1},
	},
    ["Charles"] = { -- 
        ["cerveja"] = {0, 170, 1, 1},
        ["whisky"] = {0, 220, 1, 1},
        ["agua"] = {0, 80, 1, 1},
	},
}

RegisterNetEvent("FRP:SHOP:RequestBuyShopItem")
AddEventHandler(
    "FRP:SHOP:RequestBuyShopItem",
    function(shopId, shopItemId, useCurrencyGold, shopItemQuantityMultiplier)
        local playerId = source

        local user = API.getUserFromSource(playerId)

        if not user then
            return
        end

        local shopInfo = SHOPINFO_DATABASE[shopId]

        if not shopInfo then
            user:notify('error', 'Shop inválido, contate a Staff!')
            return
        end

        local character = user:getCharacter()

        local shopExclusivityGroup = shopInfo.exclusivityGroup

        if shopExclusivityGroup and not character:hasGroupOrInheritance(shopExclusivityGroup) then
            user:notify('error', 'Você não tem permissao')
            return
        end
    
        local shopItemInfo = shopInfo.items[shopItemId]
    
        if not shopItemInfo then
            user:notify('error', 'Este item não está presente neste Shop, contate a Staff!')
            return
        end

        local inventory = character:getInventory()

        local currencyItemId = useCurrencyGold and 'gold' or 'money'
        local transactionPriceBuy = (useCurrencyGold and shopItemInfo.transactionPriceBuyGold or shopItemInfo.transactionPriceBuyDollar) * shopItemQuantityMultiplier

        if transactionPriceBuy > 0 and inventory:getItemAmount(currencyItemId) < transactionPriceBuy then
            user:notify('error', useCurrencyGold and 'Ouros insuficientes' or 'Doláres insuficientes')
            return
        end

        if transactionPriceBuy == 0 or inventory:removeItem(-1, currencyItemId, transactionPriceBuy) then

            if transactionPriceBuy > 0 then
                user:notify('item', currencyItemId, -(transactionPriceBuy))
            end

            local addItemId = shopItemInfo.itemId
            local addItemQuantity = (shopItemInfo.bundleBuyQuantity or 1) * shopItemQuantityMultiplier

            if inventory:addItem(addItemId, addItemQuantity) then
                user:notify('item', addItemId, addItemQuantity)

                local addItemName = API.getItemDataFromId(addItemId):getName()

                API.addGameLogEntryWithCharacter(character:getId(), 'SHOP_TRANSACTION',
                    shopInfo.name,
                    addItemName, addItemId,
                    addItemQuantity,
                    transactionPriceBuy / 100, currencyItemId,
                    'Compra'
                )
            else
                user:notify('error', 'Falha ao concluir a transição :/')

                inventory:addItem(currencyItemId, transactionPriceBuy)
            end
        end
    end
)

RegisterNetEvent('FRP:SHOP:RequestSellShopItem', function(shopId, shopItemId, shopItemQuantityMultiplier)
    local playerId = source

    local user = API.getUserFromSource(playerId)

    if not user then
        return
    end

    local shopInfo = SHOPINFO_DATABASE[shopId]

    if not shopInfo then
        user:notify('error', 'Shop inválido, contate a Staff!')
        return
    end

    local shopItemInfo = shopInfo.items[shopItemId]

    if not shopItemInfo then
        user:notify('error', 'Este item não está presente neste Shop, contate a Staff!')
        return
    end

    if not shopItemInfo.transactionPriceSellDollar then
        user:notify('error', 'Esse item não está a venda!')
        return
    end

    local transactionPriceSellDollar = shopItemInfo.transactionPriceSellDollar * shopItemQuantityMultiplier

    local character = user:getCharacter()
    local inventory = character:getInventory()

    local itemId = shopItemInfo.itemId

    local removeItemQuantity = (shopItemInfo.bundleSellQuantity or 1) * shopItemQuantityMultiplier

    if inventory:getItemAmount(itemId) < removeItemQuantity then
        user:notify('error', 'Você não tem items suficientes para vender.')
        return
    end

    if inventory:removeItem(-1, itemId, removeItemQuantity) then
        inventory:addItem('money', transactionPriceSellDollar)

        user:notify('item', 'money', transactionPriceSellDollar)
    else
        user:notify('error', 'Falha ao concluir a transação.')
    end
end)
