function API.ItemData(id, name, description, type, stackSize, weight)
    local self = {}

    self.id = id
    self.name = name
    self.description = description
    self.type = type
    self.stackSize = stackSize
    self.weight = weight

    self.getId = function()
        return self.id
    end

    self.getName = function(this)
        return self.name or "nome"
    end

    self.getDescription = function()
        return self.description or "descricao"
    end

    self.getType = function()
        return self.type or "generic"
    end

    self.getStackSize = function()
        return self.stackSize or 1
    end

    self.getWeight = function()
        return self.weight or 1
    end

    self.triggerUse = function(this, User, Slot)
        return triggerUse(User, self, Slot)
    end

    self.isMelee = function()
        return isMelee(self:getId())
    end

    self.isThrowable = function()
        return isThrowable(self:getId())
    end

    return self
end

-- self.getSlotType = function()
--     if self.type == "food" or self.type == "beverage" then
--         return "Food"
--     end

--     if self.type == "tonics" or self.type == "boost" then
--         return "Tonics"
--     end

--     if self.type == "weapon" or self.type == "ammo" then
--         return "Tools_Weapons"
--     end

--     -- local slotTypes = {
--     --     "Recents",
--     --     "Food",
--     --     "Tonics",
--     --     "Ingredients",
--     --     "Tools_Weapons",
--     --     "Kit",
--     --     "Valuables",
--     --     "Documents"
--     --     "Hotbar",
--     -- }
--     return "Food"

function triggerUse(User, itemData, Slot)
    local source = User:getSource()

    --[[
        return false    : Item não será consumido
        return true     : Item será consumido
    ]]

    if cAPI.getHealth(source) <= 0 or cAPI.IsPlayerLassoed(source) then
        return false
    end

    local itemId = itemData:getId()
    local itemType = itemData:getType()

    if itemType == "Food" then
        local var = itemData.varOnUse

        API.varyHunger2(source, var)

        return true
    end

  --[[  if itemType == "beverage" then
        local var = itemData.varOnUse

        API.varyThirst2(source, var)

        return true
    end]]

    if itemId == "opio" then
        local var = itemData.varOnUse
        cAPI.OpioUse(source, var)
        return true
    end

    if itemId:find("medicine") then
        -- medicine_good
        if itemId:find("horse") then
            local variation = 15.0
            local variationCore = 15.0

            if itemId:find("poor") then
                variation = 5.0
                variationCore = 5.0
            end

            if cAPI.IsPlayerMountedOnOwnHorse(source) then
                Citizen.CreateThread(
                    function()
                        cAPI.TaskAnimalInteraction(source, "injection")
                        cAPI.VaryHorseHealth(source, variation)
                        cAPI.VaryHorseCore(source, 0, variationCore)
                    end
                )
                return true
            end
        else
            local variation = 25.0
            local variationCore = 25.0
            local variationSickness = 0

            if itemId:find("poor") then
                variation = 5.0
                variationCore = 5.0
                variationSickness = 15
            end

            cAPI.TaskInteraction(source, "drink_tonic")
            cAPI.VaryPlayerHealth(source, variation)
            cAPI.VaryPlayerCore(source, 0, variationCore)
            if variationSickness > 0 then
                cAPI.VarySickness(source, variationSickness)
            end

            return true
        end

        return false
    end

    if itemId:find("stimulant") then
        -- medicine_good
        if itemId:find("horse") then
            local variation = 15.0
            local variationCore = 15.0

            if itemId:find("poor") then
                variation = 5.0
                variationCore = 5.0
            end

            if cAPI.IsPlayerMountedOnOwnHorse(source) then
                cAPI.TaskAnimalInteraction(source, "injection")
                cAPI.VaryHorseStamina(source, variation)
                cAPI.VaryHorseCore(source, 1, variationCore)

                return true
            end
        else
            local variation = 25.0
            local variationCore = 25.0
            local variationSickness = 0

            if itemId:find("poor") then
                variation = 4.0
                variationCore = 5.0
                variationSickness = 15
            end

            cAPI.TaskInteraction(source, "injection")
            cAPI.VaryPlayerStamina(source, variation)
            cAPI.VaryPlayerCore(source, 1, variationCore)
            if variationSickness > 0 then
                cAPI.VarySickness(source, variationSickness)
            end

            return true
        end

        return false
    end

    if itemId == 'milho' or itemId == 'trigo' or itemId == 'cenoura' or itemId == 'alface' then

        if cAPI.IsPlayerMountedOnOwnHorse(source) then
            cAPI.TaskAnimalInteraction(source, 'food')

            cAPI.VaryHorseStamina(source, 5.0)
            cAPI.VaryHorseCore(source, 1, 5.0) -- Health?

            User:closeInventory()

            return true
        end

        if itemId == 'cenoura' or itemId == 'alface' then
            cAPI.TaskScriptedAnim(source, "eat")

            API.varyHunger2(source, -15)

            User:closeInventory()

            return true
        end
    end

    if itemId == "waterbottle" then
        cAPI.TaskInteraction(source, "drink_tonic")
        API.varyThirst2(source, -20)
        return true
    end

    if itemId == "pigeonpost" then
        TriggerEvent("FRP:PEAGLE:SendMessage", source)
    end

    if itemId == "chest_small" then
        local var = itemData.varOnUse
        TriggerEvent("FRP:CHESTS:StartPlayerPlacement", source, var)
        return true
    end

    if itemId:find("acamp") then
        local var = itemData.varOnUse
        TriggerClientEvent("FRP:TENTS:usedItem", source, var)
        User:closeInventory()
    end

    if itemId:find("_seed") then        
        TriggerClientEvent("FRP:FARM:StartPlacingSeed", source, itemId:sub(0, itemId:find("_") - 1))
        User:closeInventory()
        return false
    end
    
    if itemId == "p_baitBread01x" then
        TriggerClientEvent("redemrp_fishing:UseBait", source, itemId)
        User:closeInventory()
    end

    if itemId == "p_baitCheese01x" then
        TriggerClientEvent("redemrp_fishing:UseBait", source, itemId)
        User:closeInventory()
    end

    if itemId == "p_baitCricket01x" then
        TriggerClientEvent("redemrp_fishing:UseBait", source, itemId)
        User:closeInventory()
    end

    if itemId == "p_FinisdFishlure01x" then
        TriggerClientEvent("redemrp_fishing:UseBait", source, itemId)
        User:closeInventory()
    end

    if itemId == "p_finishdcrawd01x" then
        TriggerClientEvent("redemrp_fishing:UseBait", source, itemId)
        User:closeInventory()
    end

    if itemId == "pigeonpost" then
        TriggerClientEvent("FRP:PIGEONPOST:Init", source)
    end

    if itemId == "pan" then
        TriggerClientEvent("FrankieGoldPanner:StartGoldPan", source)
    end

    if itemId == "tobaccoseed" then
        local _source = source
        TriggerClientEvent('poke_planting:planto1', _source, 'tobaccoseed',`CRP_TOBACCOPLANT_AA_SIM`, `CRP_TOBACCOPLANT_AB_SIM`, `CRP_TOBACCOPLANT_AC_SIM`)
        User:closeInventory()
        return true
    end
    if itemId == "cornseed" then
        local _source = source
        TriggerClientEvent('poke_planting:planto1', _source, "corn_seed",`CRP_CORNSTALKS_CB_sim`, `CRP_CORNSTALKS_CA_sim`, `CRP_CORNSTALKS_AB_sim`)
        User:closeInventory()
        return true
    end
    if itemId == "cenouraseed" then
        local _source = source
        TriggerClientEvent('poke_planting:planto1', _source, "cenouraseed",`crp_carrots_har_ba_sim`, `crp_carrots_sap_ba_sim`, `crp_carrots_ba_sim`)
        User:closeInventory()
        return true
    end
    if itemId == "trigoseed" then
        local _source = source
        TriggerClientEvent('poke_planting:planto1', _source, "trigoseed",`crp_wheat_sap_long_aa_sim`, `crp_wheat_sap_long_ab_sim`, `crp_wheat_dry_long_aa_sim`)
        User:closeInventory()
        return true
    end
    if itemId == "feijaoseed" then
        local _source = source
        TriggerClientEvent('poke_planting:planto1', _source, "feijaoseed",`crp_berry_sap_aa_sim`, `crp_berry_sap_aa_sim`, `crp_berry_har_aa_sim`)
        User:closeInventory()
        return true
    end
    if itemId == "batataseed" then
        local _source = source
        TriggerClientEvent('poke_planting:planto1', _source, "batataseed",`crp_potato_har_aa_sim`, `crp_potato_sap_aa_sim`, `crp_potato_aa_sim`)
        User:closeInventory()
        return true
    end
    if itemId == "tomateseed" then
        local _source = source
        TriggerClientEvent('poke_planting:planto1', _source, "tomateseed",`crp_tomatoes_sap_aa_sim`, `crp_tomatoes_har_aa_sim`, `crp_tomatoes_aa_sim`)
        User:closeInventory()
        return true
    end
    if itemId == "lupuloseed" then
        local _source = source
        TriggerClientEvent('poke_planting:planto1', _source, "lupuloseed",`rdr_bush_palm_ab_sim`, `crp_artichoke_aa_sim`, `crp_artichoke_aa_sim`)
        User:closeInventory()
        return true
    end
    if itemId == "repolhoseed" then
        local _source = source
        TriggerClientEvent('poke_planting:planto1', _source, "repolhoseed",`crp_tobaccoplant_aa_sim`, `crp_broccoli_aa_sim`, `crp_broccoli_aa_sim`)
        User:closeInventory()
        return true
    end
    if itemId == "alfaceseed" then
        local _source = source
        TriggerClientEvent('poke_planting:planto1', _source, "alfaceseed",`CRP_LETTUCE_AA_SIM`, `CRP_LETTUCE_AA_SIM`, `CRP_LETTUCE_AA_SIM`)
        User:closeInventory()
        return true
    end
    if itemId == "papolaseed" then
        local _source = source
        TriggerClientEvent('poke_planting:planto1', _source, "papolaseed",`mp007_p_nat_flwr_poppy01x`, `prariepoppy_p`, `prariepoppy_p`)
        User:closeInventory()
        return true
    end
    if itemId == "sugarcaneseed" then
        local _source = source
        TriggerClientEvent('poke_planting:planto1', _source, "sugarcaneseed",`crp_sugarcane_aa_sim`, `crp_sugarcane_ab_sim`, `CRP_SUGARCANE_AC_sim`)
        User:closeInventory()
        return true
    end
    if itemId == "algodaoseed" then
        local _source = source
        TriggerClientEvent('poke_planting:planto1', _source, "algodaoseed",`crp_cotton_bc_sim`, `crp_cotton_bb_sim`, `crp_cotton_be_sim`)
        User:closeInventory()
        return true
    end
    if itemId == "wateringcan" then
        local _source = source
	    TriggerClientEvent('poke_planting:regar1', _source)
        User:closeInventory()
    end

    if itemId == "meat_cooked" then
        cAPI.VaryPlayerHealth(source, 15)
        -- cAPI.VaryPlayerStamina(source, 15)
        cAPI.VaryPlayerCore(source, 1, 20)
        cAPI.TaskScriptedAnim(source, "eat")

        cAPI.VarySickness(source, 10)

        User:closeInventory()
        return true
    end
---------------------------------------------- Kits

    if itemId == "campfiresmall" then
        TriggerClientEvent("FRP:Campfire:Campfiresmall", source)
        User:closeInventory()
        return true
    end

    if itemId == "campfirebig" then
        TriggerClientEvent("FRP:Campfire:Campfiresbig", source)
        User:closeInventory()
        return true
    end
   
    

---------------------------------------------- COMIDA

    if itemId == "pao" then
       -- cAPI.VaryPlayerHealth(source, 30)
        -- cAPI.VaryPlayerStamina(source, 15)
        --cAPI.VaryPlayerCore(source, 1, 20)
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -60)
        --cAPI.VarySickness(source, 10)

        User:closeInventory()
        return true
    end

    if itemId == "feijaolata" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -25) 
        User:closeInventory()
        return true
    end
    if itemId == "milholata" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -25) 
        User:closeInventory()
        return true
    end
    if itemId == "bolacha" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -35) 
        User:closeInventory()
        return true
    end
    if itemId == "biscoito" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -35) 
        User:closeInventory()
        return true
    end
    if itemId == "milhoassado" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -18) 
        User:closeInventory()
        return true
    end
    if itemId == "batataassada" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -18) 
        User:closeInventory()
        return true
    end
    if itemId == "carneruimassada" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -18) 
        User:closeInventory()
        return true
    end
    if itemId == "carneboaassada" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -25) 
        User:closeInventory()
        return true
    end
    if itemId == "carneavefrita" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -25) 
        User:closeInventory()
        return true
    end
    if itemId == "carnefrita" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -25) 
        User:closeInventory()
        return true
    end
    if itemId == "carneprimeiraassada" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -50) 
        User:closeInventory()
        return true
    end
    if itemId == "peixegrandeassado" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -40) 
        User:closeInventory()
        return true
    end
    if itemId == "peixemedioassado" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -25) 
        User:closeInventory()
        return true
    end
    if itemId == "peixepequenoassado" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -18) 
        User:closeInventory()
        return true
    end
    if itemId == "puredebatata" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -30) 
        User:closeInventory()
        return true
    end
    if itemId == "sopa" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -70) 
        User:closeInventory()
        return true
    end
    if itemId == "sopadecarne" then
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -80) 
        User:closeInventory()
        return true
    end

------------------------------------------------- BEBIDA

    if itemId == "agua" then
        cAPI.TaskInteraction(source, "drink_tonic")
        API.varyThirst2(source, -20)
        User:closeInventory()
        return true
    end
    if itemId == "cafe" then
        cAPI.TaskInteraction(source, "drink_tonic")
        API.varyThirst2(source, -50)
        User:closeInventory()
        return true
    end
    if itemId == "vitamina" then
        cAPI.TaskInteraction(source, "drink_tonic")
        API.varyThirst2(source, -55)
        User:closeInventory()
        return true
    end
    if itemId == "sucolaranja" then
        cAPI.TaskInteraction(source, "drink_tonic")
        API.varyThirst2(source, -25)
        User:closeInventory()
        return true
    end
    if itemId == "cerveja" then --COLOCAR EFEITO DE BEBADO/ANIMAÇÃO
        TriggerClientEvent("DKT:ANIMATION:cerveja", source)
        API.varyThirst2(source, -20)
        User:closeInventory()
        return true
    end
    if itemId == "whisky" then --COLOCAR EFEITO DE BEBADO/ANIMAÇÃO
        TriggerClientEvent("DKT:ANIMATION:whisky", source)
        API.varyThirst2(source, -20)
        User:closeInventory()
        return true
    end
    if itemId == "tequila" then --COLOCAR EFEITO DE BEBADO/ANIMAÇÃO
        cAPI.TaskInteraction(source, "drink_tonic")
        API.varyThirst2(source, -20)
        User:closeInventory()
        return true
    end
    if itemId == "moonshine" then --COLOCAR EFEITO DE BEBADO/ANIMAÇÃO
        cAPI.TaskInteraction(source, "drink_tonic")
        API.varyThirst2(source, -20)
        User:closeInventory()
        return true
    end

---------------------------- INDIO ---------------------------------

if itemId == "raizesdaterra" then --COLOCAR EFEITO DE BEBADO/ANIMAÇÃO
    cAPI.TaskInteraction(source, "drink_tonic")
    API.varyThirst2(source, -20)
    return true
end
if itemId == "olhosdeaguia" then -- ATIVAR OS OLHOS DE AGUIA POR UM PERIODO DE TEMPO
    cAPI.TaskInteraction(source, "drink_tonic")
    API.varyThirst2(source, -20)
    return true
end
if itemId == "ervamedicinal" then -- REVIVE E CURA
    cAPI.TaskInteraction(source, "drink_tonic")
    API.varyThirst2(source, -20)
    return true
end
if itemId == "ervaveneno" then -- COMEÇA A CAUSAR DANO DEPOIS DE ALGUM TEMPO
    cAPI.TaskInteraction(source, "drink_tonic")
    API.varyThirst2(source, -20)
    return true
end

--------------------------------------------------------------------

    if itemId == "meat_oregano_cooked" then
        --cAPI.VaryPlayerHealth(source, 30)
        -- cAPI.VaryPlayerStamina(source, 30)
        --cAPI.VaryPlayerCore(source, 1, 70)
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger2(source, -20)
        --cAPI.VarySickness(source, 10)

        --User:closeInventory()
        return true
    end

    if itemId == "eagleeye" then
        cAPI.TaskInteraction(source, "drink_tonic")
        TriggerClientEvent("FRP:WANTED:UsedEagleEye", source)

        return true
    end

    if itemId == "lockpick" then
        User:closeInventory()
        TriggerClientEvent("FRP:LOCKPICK:StartLockpicking", source)
    end

    if itemId == 'roupas' then
        local metadata = Slot:getItemMetaData()

        if metadata ~= '[]' then
            TriggerClientEvent('FRP:SetPlayerClothingFromClothingItem', source, metadata)
        end
    end

    return false
end

local melee = {
    "lasso",
    "melee_lantern_electric",
    "melee_torch",
    "melee_broken_sword",
    "fishingrod",
    "melee_knife_john",
    "melee_knife",
    "melee_knife_bear",
    "melee_cleaver",
    "melee_ancient_hatchet",
    "melee_knife_jawbone",
    "melee_knife_hunter",
    "melee_knife_miner",
    "melee_machete"
}

local throwable = {
    "thrown_ancient_tomahawk",
    "thrown_dynamite",
    "thrown_molotov",
    "thrown_throwing_knives",
    "thrown_throwing_knives_improved",
    "melee_hatchet",
    "melee_hatchet_viking",
    "melee_hatchet_hewing",
    "melee_hatchet_double_bit",
    "melee_hatchet_double_bit_rusted",
    "melee_hatchet_hunter",
    "melee_hatchet_hunter_rusted"
}

function isMelee(itemId)
    -- itemId = 'weapon_' .. itemId

    for _, col in pairs(melee) do
        if itemId == col then
            return true
        end
    end

    return false
end

function isThrowable(itemId)
    -- itemId = 'weapon_' .. itemId

    for _, col in pairs(throwable) do
        if itemId == col then
            return true
        end
    end

    return false
end
