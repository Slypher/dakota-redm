--[[local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local verificationData = {
    ["Mercado Geral"] = {
        ["tobacco"] = {1, 1, 10},
        ["milho"] = {45, 45, 5},
        ["sugarcane"] = {1, 1, 10},
    },
    ["Acogueiro"] = {
        ["meat_poor"] = {75, 1, 1},
        ["meat_good"] = {137, 1, 1},
        ["meat_perfect"] = {356, 1, 1},
        -- ["feather_1"] = {100, 25, 5}
        -- ["feather_2"] = {100, 1, 5}
    },
    ["Posto de Troca"] = {
        ["raw_coal"] = {100, 40, 2},
        ["raw_iron"] = {200, 80, 2},
        ["raw_copper"] = {300, 120, 2}
    }
}

RegisterNetEvent("FRP:SHOP:TryToSell")
AddEventHandler(
    "FRP:SHOP:TryToSell",
    function(shopId, itemId, withGold)
        local _source = source

        if not verificationData[shopId] or not verificationData[shopId][itemId] then
            -- User:notify("error", "Item não registrado, contate um ADMIN")
            return
        end

        local data = verificationData[shopId]

        local User = API.getUserFromSource(_source)
        local Character = User.getCharacter()

        if data.group then
            if not Character:hasGroupOrInheritance(data.group) then
                User:notify("error", "Você não tem permissao")
                return
            end
        end

        local itemData = data[itemId]

        local Inventory = Character:getInventory()

        local itemAmount = itemData[3]

        if Inventory:getItemAmount(itemId) < itemAmount then
            local idata = API.getItemDataFromId(itemId)
            User:notify("error", "Você precisa de no mínimo x" .. itemAmount .. " " .. idata:getName() .. " para vender!")
            return
        end

        local currencyItem = "money"
        local itemPrice = itemData[1]

        if withGold then
            currencyItem = "gold"
            itemPrice = itemData[2]
        end

        if Inventory:removeItem(-1, itemId, itemAmount) then
            Inventory:addItem(currencyItem, itemPrice)
            User:notify("item", itemId, -(itemAmount))
            if not withGold then
                User:notify("item", "money", itemPrice)
            else
                User:notify("item", "gold", itemPrice)
            end
        end
    end
)
]]

local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local verificationData = {
        
	["Negociar produção com Mark"] = { -- Armazém de Valentine
		
		["milho"] = {11, 1},
		["cenoura"] = {10, 1},
		["trigo"] = {9, 1},
		["batata"] = {10, 1},
		["repolho"] = {9, 1},
		["tomate"] = {10, 1},
		["feijao"] = {10, 1},
		["alface"] = {9, 1},
		["canadeacucar"] = {10, 1},
		["pao"] = {29, 1},
		["biscoito"] = {20, 1},
		["bolacha"] = {20, 1},
		["milholata"] = {45, 1},
		["feijaolata"] = {45,  1},
		["sopa"] = {310, 1},
		["sopadecarne"] = {390, 1},
		["molhotomate"] = {35, 1},
    },
	
	
	["Negociar produção com Terry"] = { -- Armazém de Blackwater
		
		["milho"] = {11, 1},
		["cenoura"] = {9, 1},
		["trigo"] = {11, 1},
		["batata"] = {9, 1},
		["repolho"] = {11, 1},
		["tomate"] = {11, 1},
		["feijao"] = {8, 1},
		["alface"] = {11, 1},
		["canadeacucar"] = {11, 1}
		
    },
	
	["Negociar produção com Thomas"] = { -- Armazém de Strawberry
		
		["milho"] = {10, 1},
		["cenoura"] = {10, 1},
		["trigo"] = {11, 1},
		["batata"] = {10, 1},
		["repolho"] = {9, 1},
		["tomate"] = {9, 1},
		["feijao"] = {11, 1},
		["alface"] = {9, 1},
		["canadeacucar"] = {11, 1}
    },
	
	
	["Negociar bebidas com Charles"] = { -- Saloon de Valentine
		
		["cerveja"] = {50, 1},
		["whisky"] = {60, 1}
    },
	
	
	["Negociar minérios com Bill"] = { -- Venda de Minerios
		
		["minerioferro"] = {20, 1},
		["mineriocobre"] = {30, 1},
		["pedra"] = {20, 1}
    },
	
	
	["Negociar Madeira com Castor"] = { -- Venda de Madeira
		
		["madeiraruim"] = {10, 1},
		["madeiraboa"] = {20, 1},
		["madeirarefinada"] = {30, 1},
		["tabua"] = {25, 1}
    },
	
	
	["Negociar com o Doutor"] = { -- Doutor de Valentine
		
		["cassis"] = {100, 2},
		["cassisdourado"] = {200, 2},
		["tabacoindiano"] = {100, 2},
		["oregano"] = {200, 2},
		["tomilhorastejante"] = {100, 2},
		["ginsengamericano"] = {200, 2},
		["amora"] = {100, 2},
		["salviadeserto"] = {200, 2},
		["salviavermelha"] = { 200, 2},
		["bardana"] = {200, 2},
		["mentasilvestre"] = {200, 2},
		["parasol"] = {200, 2},
		["cantarelo"] = {200, 2},
		["boletobaio"] = {200, 2},
		["milfolhas"] = {100, 2},
		["violeta"] = {100, 2},
		["beijaflor"] = {100, 2},
		["gualteria"] = {100, 2},
		["asclepia"] = {100, 2},
		["maitake"] = {100, 2},
		["quinina"] = {100, 2},
		["papola"] = {100, 2},
		["cenouraselvagem"] = {100, 2},
		["ginsengalaska"] = {100, 2},
		["oleandro"] = {100, 2},
		["frasco"] = {100, 2}
    },
	
	
	["Falar com o Açougueiro de Valentine"] = { -- Açougue de Valentine

		["carneruim"] = {6, 1},
		["carneboa"] = {11, 1},
		["carneperfeita"] = {22, 1},
		["carnedeave"] = {7, 1}
    },	
	
	["Falar com o Açougueiro de Blackwater"] = { -- Açougue de Blackwater

		["carneruim"] = {6, 1},
		["carneboa"] = {10, 1},
		["carneperfeita"] = {18, 1},
		["carnedeave"] = {7, 1},
    },
	
	
	["Falar com o Açougueiro de Strawberry"] = { -- Açougue de Strawberry

		["carneruim"] = {5, 1},
		["carneboa"] = {10, 1},
		["carneperfeita"] = {20, 1},
		["carnedeave"] = {8, 1},
    },
	
}

RegisterNetEvent("FRP:SHOP:TryToSell")
AddEventHandler(
    "FRP:SHOP:TryToSell",
    function(shopId, itemId, withGold)
        local _source = source

        if not verificationData[shopId] or not verificationData[shopId][itemId] then
            -- User:notify("error", "Item não registrado, contate um ADMIN")
            return
        end

        local data = verificationData[shopId]

        local User = API.getUserFromSource(_source)
        local Character = User.getCharacter()

        if data.group then
            if not Character:hasGroupOrInheritance(data.group) then
                User:notify("error", "Você não tem permissao")
                return
            end
        end

        local itemData = data[itemId]

        local Inventory = Character:getInventory()

        local itemAmount = itemData[3]

        if Inventory:getItemAmount(itemId) < itemAmount then
            local idata = API.getItemDataFromId(itemId)
            User:notify("error", "Você precisa de no mínimo x" .. itemAmount .. " " .. idata:getName() .. " para vender!")
            return
        end

        local currencyItem = "money"
        local itemPrice = itemData[1]

        if withGold then
            currencyItem = "gold"
            itemPrice = itemData[2]
        end

        if Inventory:removeItem(-1, itemId, itemAmount) then
            Inventory:addItem(currencyItem, itemPrice)
            User:notify("item", itemId, -(itemAmount))
            if not withGold then
                User:notify("item", "money", itemPrice)
            else
                User:notify("item", "gold", itemPrice)
            end
        end
    end
)
