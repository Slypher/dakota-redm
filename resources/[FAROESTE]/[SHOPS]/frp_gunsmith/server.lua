local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local verificationData = {
    -- min_level, price_dollar, price_gold
    --["REVOLVER_DOUBLEACTION"] = {0, 200, 10},
    --------["revolver_cattleman"] = {0, 2500, 10},
    --["REVOLVER_SCHOFIELD"] = {0, 200, 10},
    --------["revolver_lemat"] = {0, 6000, 25},
    --["revolver_navy"] = {0, 200, 10},

    --["pistol_volcanic"] = {0, 200, 10},
    --["PISTOL_MAUSER"] = {0, 200, 10},
    --["PISTOL_SEMIAUTO"] = {0, 200, 10},

    --------["repeater_carbine"] = {0, 3200, 15},
    --["REPEATER_EVANS"] = {0, 200, 10},
    --["REPEATER_WINCHESTER"] = {0, 200, 10},
    --------["repeater_henry"] = {0, 4000, 45},

    --["rifle_varmint"] = {0, 200, 10},

    --["RIFLE_SPRINGFIELD"] = {0, 200, 10},
    --------["rifle_boltaction"] = {0, 4500, 50},

    --["shotgun_sawedoff"] = {0, 200, 10},
    --["SHOTGUN_DOUBLEBARREL"] = {0, 200, 10},

    --------["sniperrifle_rollingblock"] = {0, 14000, 70},

    --["thrown_throwing_knives"] = {0, 200, 10},
    --["melee_cleaver"] = {0, 200, 10},
    ["kit_binoculars"] = {0, 1000, 1},
    ["melee_knife"] = {0, 250, 1},



    -- AMMO
    ["ammo_revolver"] = {0, 300, 1, 20},
    ["ammo_pistol"] = {0, 300, 1, 20},
    ["ammo_repeater"] = {0, 300, 1, 20},
    ["ammo_rifle"] = {0, 400, 1, 20},
    ["ammo_22"] = {0, 300, 1, 20},
    ["ammo_shotgun"] = {0, 400, 1, 20},
}

RegisterNetEvent("FRP:GUNSMITH:TryToBuy")
AddEventHandler(
    "FRP:GUNSMITH:TryToBuy",
    function(itemId, withGold)
        local _source = source

        if not verificationData[itemId] then
            return
        end

        local User = API.getUserFromSource(_source)
        local Character = User.getCharacter()

        local itemData = verificationData[itemId]
        local itemLevel = itemData[1]

        if Character:getLevel() < itemLevel then
            User:notify("error", "Você não tem level suficiente")
            return
        end

        local Inventory = Character:getInventory()

        local currencyItem = "money"
        local itemPrice = itemData[2]

        if withGold then
            currencyItem = "gold"
            itemPrice = itemData[3]
        end

        if Inventory:getItemAmount(currencyItem) < itemPrice then
            User:notify("error", "Você não tem dinheiro suficiente")
            return
        end

        local itemAmount = itemData[4] or 1

        if Inventory:addItem(itemId, itemAmount) then
            Inventory:removeItem(-1, currencyItem, itemPrice)
            if itemPrice > 0 then
                if not withGold then
                    User:notify("item", "money", -(itemPrice))
                else
                    User:notify("item", "gold", -(itemPrice))
                end
            end
            User:notify("item", itemId, itemAmount)
        else
            User:notify("error", "Espaço insuficiente na bolsa!")
        end
    end
)
