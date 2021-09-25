local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local toItem = {
    -- OVOS --
    ["DUCK_EGG_5_DEF"] = "ovopato",
    ["GOOSE_EGG_4_DEF"] = "ovoganso",
    ["LOON_EGG_3_DEF"] = "ovomobelha",
    ["VULTURE_EGG_DEF"] = "ovoabutre",

    -- PLANTAS -- 
    ["ALASKAN_GINSENG_ROOT_DEF"] = "ginsengalaska",
    ["AMERICAN_GINSENG_ROOT_DEF"] = "ginsengamericano",
    ["BLACK_BERRY_DEF"] = "amora",
    ["BLACK_CURRANT_DEF"] = "cassis",
    ["BURDOCK_ROOT_DEF"] = "bardana",
    ["COMMON_BULRUSH_DEF"] = "fibra",
    ["DESERT_SAGE_DEF"] = "salviadeserto",
    ["OLEANDER_SAGE_DEF"] = "oleandro", -- 
    ["OREGANO_DEF"] = "oregano",
    ["PARASOL_MUSHROOM_DEF"] = "parasol",
    ["PRAIRIE_POPPY_DEF"] = "papola", -- 
    ["RAMS_HEAD_DEF"] = "maitake", -- opio
    ["WILD_CARROT_DEF"] = "cenouraselvagem",
    ["WILD_FEVERFEW_DEF"] = "quinina",
    ["WILD_MINT_DEF"] = "mentasilvestre",
    ["BAY_BOLETE_DEF"] = "boletobaio",-- TESTE --
    ["YARROW_DEF"] = "milfolhas", -- TESTE --
    ["MILKWEED_DEF"] = "asclepia",-- TESTE --
    ["WINTERGREEN_BERRY_DEF"] = "gualteria",
    ["VIOLET_SNOWDROP_DEF"] = "violeta",
    ["HUMMINGBIRD_SAGE_DEF"] = "beijaflor",
    ["GOLDEN_CURRANT_DEF"] = "cassisdourado",
    ["INDIAN_TOBACCO_DEF"] = "tabacoindiano",
    ["CREEPING_THYME_DEF"] = "tomilhorastejante",
    ["CHANTERELLES_DEF"] = "cantarelo",
    
    ["RED_SAGE_DEF"] = "salviavermelha",
    -- Não ta pronto
    "AGARITA_DEF",
    "BITTERWEED_DEF",
    "BLOODFLOWER_DEF",
    "CARDINAL_FLOWER_DEF",
    "CHOC_DAISY_DEF",
    "CREEKPLUM_DEF",
    "ENGLISH_MACE_DEF",
    "EVERGREEN_HUCKLEBERRY_DEF",
    "RED_RASPBERRY_DEF",
    "TEXAS_BONNET_DEF",
    "WILD_RHUBARB_DEF",
    "WISTERIA_DEF",
    
    -- "BITTERWEED_INTERACTABLE_DEF",
    -- "BLOODFLOWER_INTERACTABLE_DEF",
    -- "CARDINAL_FLOWER_INTERACTABLE_DEF",
    -- "CHOC_DAISY_INTERACTABLE_DEF",
    -- "TEXAS_BONNET_INTERACTABLE_DEF",  
    -- "WILD_RHUBARB_INTERACTABLE_DEF",
    

    -- SEM USO, NÃO APARECEM --
    --"ORCHID_ACUNA_STAR_DEF",
    --"ORCHID_CIGAR_DEF",
    --"ORCHID_CLAM_SHELL_DEF",
    --"ORCHID_DRAGONS_DEF",
    --"ORCHID_GHOST_DEF",
    --"ORCHID_LADY_NIGHT_DEF",
    --["ORCHID_LADY_SLIPPER_DEF"] = "herb_lady_slipper",
    --"ORCHID_MOCCASIN_DEF",
    --"ORCHID_NIGHT_SCENTED_DEF",
    --"ORCHID_QUEENS_DEF",
    --"ORCHID_RAT_TAIL_DEF",
    --"ORCHID_SPARROWS_DEF",
    --"ORCHID_SPIDER_DEF",
    --"ORCHID_VANILLA_DEF",
}

local SUPPRESSION_WEAROFF_SECONDS = 10 * 60

local popSuppressed = {}

RegisterNetEvent("FRP:HERB_POPULATION:Gathered")
AddEventHandler(
    "FRP:HERB_POPULATION:Gathered",
    function(compositeTypeFormatted, indexComposite, index)
        local _source = source
        if not IsVectorIndexSuppressed(indexComposite, index) then
            local item = toItem[compositeTypeFormatted]
            if item ~= nil then
                local User = API.getUserFromSource(_source)
                local Character = User:getCharacter()

                if Character == nil then
                    return
                end

                local Inventory = Character:getInventory()

                if Inventory:addItem(item, 1) then
                    SetVectorIndexSuppressed(indexComposite, index, true)

                    if not User:hasInventoryOpen() then
                        User:notify("item", item, 1)
                    end

                    Character:varyExp(2)
                    User:notify("xp", 2)
                else
                    User:notify("error", "Sem espaço no aforje!")
                    TriggerClientEvent("FRP:HERB_POPULATION:ForceVectorIndexReload", _source, indexComposite, index)
                end
            end
        end
    end
)

function IsVectorIndexSuppressed(indexComposite, index)
    return popSuppressed[indexComposite] ~= nil and popSuppressed[indexComposite][index] ~= nil or false
end

function SetVectorIndexSuppressed(indexComposite, index, suppress)
    if suppress then
        -- end
        -- if not IsVectorIndexSuppressed(indexComposite, index) then
        if popSuppressed[indexComposite] == nil then
            popSuppressed[indexComposite] = {}
        end

        popSuppressed[indexComposite][index] = os.time() + SUPPRESSION_WEAROFF_SECONDS
    else
        -- end
        -- if IsVectorIndexSuppressed(indexComposite, index) then
        popSuppressed[indexComposite][index] = nil
    end

    TriggerClientEvent("FRP:HERB_POPULATION:SetVectorIndexSuppressed", -1, indexComposite, index, suppress)
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1 * 60 * 1000) -- 1 Min

            local timestamp = os.time()

            for indexComposite, v in pairs(popSuppressed) do
                for index, suppression_wearoff_timestamp in pairs(v) do
                    if suppression_wearoff_timestamp <= timestamp then
                        SetVectorIndexSuppressed(indexComposite, index, false)
                    end
                end
            end
        end
    end
)

RegisterNetEvent("API:playerSpawned")
AddEventHandler(
    "API:playerSpawned",
    function(source, user_id, isFirstSpawn)
        if isFirstSpawn then
            TriggerClientEvent("FRP:HERB_POPULATION:SetPopSuppressed", source, popSuppressed)
        end
    end
)
