local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local AnimalModelToItem = {

--GRANDES
[`A_C_Alligator_01`] = "dente",
[`A_C_Alligator_03`] = "dente",
[`A_C_Bear_01`] = "dente",
[`A_C_BearBlack_01`] = "dente",
[`A_C_Buck_01`] = "galhada",
[`A_C_Buffalo_01`] = "chifrebisao",
[`A_C_Coyote_01`] = "osso",
[`A_C_Beaver_01`] = "rabocastor",
[`A_C_BigHornRam_01`] = "chifre",
[`A_C_Deer_01`] = "osso",
[`A_C_Wolf`] = "dente",
[`A_C_Wolf_Medium`] = "dente",
[`A_C_Wolf_Small`] = "dente",
[`A_C_Elk_01`] = "galhadagrande",
[`A_C_Moose_01`] = "galhadagrande",
[`A_C_Fox_01`] = "osso",
[`A_C_Javelina_01`] = "gordura",
[`A_C_Panther_01`] = "patadefelino",
[`A_C_Pronghorn_01`] = "osso",
--MÉDIOS
[`A_C_Possum_01`] = "couro",
[`A_C_Armadillo_01`] = "cascatatu",
[`A_C_Badger_01`] = "couro",
[`A_C_Boar_01`] = "gordura",
[`A_C_GilaMonster_01`] = "couroreptil",
[`A_C_Iguana_01`] = "couroreptil",
[`A_C_IguanaDesert_01`] = "couroreptil",
[`A_C_Rabbit_01`] = "patacoelho",
[`A_C_Raccoon_01`] = "couro",
[`A_C_Skunk_01`] = "glandulas",
[`A_C_TurtleSnapping_01`] = "",
--PEQUENOS
[`A_C_Chipmunk_01`] = "couro",
[`A_C_Crab_01`] = "",
[`A_C_Rat_01`] = "couro",
[`A_C_Squirrel_01`] = "caudaesquilo",
[`A_C_Muskrat_01`] = "couro",
[`A_C_Toad_01`] = "couro",
-- LENDÁRIO
[`A_C_boarlegendary_01`] = "dentejavalilendario",
[`A_C_Buffalo_Tatanka_01`] = "chifrebisaolendario",
[`A_C_Alligator_02`] = "dentelendario",
-- ONLINE
[`MP_A_C_Alligator_01`] = "osso",
[`MP_A_C_Beaver_01`] = "osso",
[`MP_A_C_BIGHORNRAM_01`] = "osso",
[`MP_A_C_Boar_01`] = "osso",
[`MP_A_C_BUCK_01`] = "osso",
[`MP_A_C_BUFFALO_01`] = "osso",
[`MP_A_C_Cougar_01`] = "osso",
[`MP_A_C_Coyote_01`] = "osso",
[`MP_A_C_DEER_01`] = "osso",
[`MP_A_C_ELK_01`] = "osso",
[`MP_A_C_FOX_01`] = "osso",
[`MP_A_C_MOOSE_01`] = "osso",
[`MP_A_C_Panther_01`] = "osso",
[`MP_A_C_Wolf_01`] = "osso",
-- RURAIS
[`A_C_Sheep_01`] = "osso",
[`A_C_Bull_01`] = "chifre",
[`A_C_Cow`] = "osso",
[`A_C_Goat_01`] = "osso",
[`A_C_Ox_01`] = "chifre",
[`A_C_Pig_01`] = "gordura",
-- AVES
[`A_C_Bat_01`] = "asamorcego",
[`A_C_CaliforniaCondor_01`] = "penacondor",
[`A_C_Cardinal_01`] = "pena",
[`A_C_CedarWaxwing_01`] = "pena",
[`A_C_CarolinaParakeet_01`] = "penapapagaio",
[`A_C_Chicken_01`] = "carneave",
[`A_C_Cormorant_01`] = "pena",
[`A_C_BlueJay_01`] = "pena",
[`A_C_CraneWhooping_01`] = "pena",
[`A_C_Crow_01`] = "pena",
[`A_C_Duck_01`] = "carneave",
[`A_C_Eagle_01`] = "penarapina",
[`A_C_Egret_01`] = "pena",
[`A_C_GooseCanada_01`] = "carneave",
[`A_C_Hawk_01`] = "penarapina",
[`A_C_Heron_01`] = "pena",
[`A_C_Loon_01`] = "pena",
[`A_C_Oriole_01`] = "pena",
[`A_C_Owl_01`] = "penarapina",
[`A_C_Parrot_01`] = "penaarara",
[`A_C_Pelican_01`] = "pena",
[`A_C_Pheasant_01`] = "pena",
[`A_C_Pigeon`] = "pena",
[`A_C_PrairieChicken_01`] = "pena",
[`A_C_Raven_01`] = "pena",
[`A_C_RedFootedBooby_01`] = "pena",
[`A_C_Robin_01`] = "pena",
[`A_C_RoseateSpoonbill_01`] = "pena",
[`A_C_Rooster_01`] = "carneave",
[`A_C_Seagull_01`] = "pena",
[`A_C_SongBird_01`] = "pena",
[`A_C_Sparrow_01`] = "pena",
[`A_C_Turkey_01`] = "carneave",
[`A_C_Turkey_02`] = "carneave",
[`A_C_TurkeyWild_01`] = "carneave",
[`A_C_Vulture_01`] = "pena",
[`A_C_Woodpecker_01`] = "penapicapau",
[`A_C_Woodpecker_02`] = "penapicapau",
--COBRAS
[`A_C_SnakeWater_01`] = "venenodecobra",
[`A_C_Snake_01`] = "venenodecobra",
[`A_C_SnakeBlackTailRattle_01`] = "venenodecobra",
[`A_C_SnakeFerDeLance_01`] = "venenodecobra",
[`A_C_SnakeRedBoa_01`] = "venenodecobra",
-- PEIXES
[`A_C_FishBluegil_01_ms`] = "mediumfish",
[`A_C_FishBullHeadCat_01_ms`] = "mediumfish",
[`A_C_FishChainPickerel_01_ms`] = "mediumfish",
[`A_C_FishLargeMouthBass_01_ms`] = "mediumfish",
[`A_C_FishPerch_01_ms`] = "mediumfish",
[`A_C_FishRainbowTrout_01_ms`] = "mediumfish",
[`A_C_FishRedfinPickerel_01_ms`] = "mediumfish",
[`A_C_FishRockBass_01_ms`] = "mediumfish",
[`A_C_FishSalmonSockeye_01_ms`] = "mediumfish",
[`A_C_FishSmallMouthBass_01_ms`] = "mediumfish",
[`A_C_FishBluegil_01_sm`] = "mediumfish",
[`A_C_FishBullHeadCat_01_sm`] = "mediumfish",
[`A_C_FishChainPickerel_01_sm`] = "mediumfish",
[`A_C_FishPerch_01_sm`] = "mediumfish",
[`A_C_FishRedfinPickerel_01_sm`] = "mediumfish",
[`A_C_FishRockBass_01_sm`] = "mediumfish",
}

local AnimalModelToItem2 = {
--GRANDES
[`A_C_Alligator_01`] = "",
[`A_C_Alligator_03`] = "",
[`A_C_Bear_01`] = "gordura",
[`A_C_BearBlack_01`] = "",
[`A_C_Buck_01`] = "",
[`A_C_Buffalo_01`] = "gordura",
[`A_C_Coyote_01`] = "",
[`A_C_Beaver_01`] = "",
[`A_C_BigHornRam_01`] = "",
[`A_C_Deer_01`] = "",
[`A_C_Wolf`] = "",
[`A_C_Wolf_Medium`] = "",
[`A_C_Wolf_Small`] = "",
[`A_C_Elk_01`] = "",
[`A_C_Moose_01`] = "gordura",
[`A_C_Fox_01`] = "",
[`A_C_Javelina_01`] = "gordura",
[`A_C_Panther_01`] = "",
[`A_C_Pronghorn_01`] = "",
--MÉDIOS
[`A_C_Possum_01`] = "couro",
[`A_C_Armadillo_01`] = "couro",
[`A_C_Badger_01`] = "couro",
[`A_C_Boar_01`] = "couro",
[`A_C_GilaMonster_01`] = "couro",
[`A_C_Iguana_01`] = "couro",
[`A_C_IguanaDesert_01`] = "couro",
[`A_C_Rabbit_01`] = "couro",
[`A_C_Raccoon_01`] = "couro",
[`A_C_Skunk_01`] = "couro",
[`A_C_TurtleSnapping_01`] = "couro",
--PEQUENOS
[`A_C_Chipmunk_01`] = "couro",
[`A_C_Crab_01`] = "couro",
[`A_C_Rat_01`] = "couro",
[`A_C_Squirrel_01`] = "couro",
[`A_C_Muskrat_01`] = "couro",
[`A_C_Toad_01`] = "couro",
-- LENDÁRIO
[`A_C_boarlegendary_01`] = "",
[`A_C_Buffalo_Tatanka_01`] = "",
[`A_C_Alligator_02`] = "escamalendaria",
-- ONLINE
[`MP_A_C_Alligator_01`] = "",
[`MP_A_C_Beaver_01`] = "",
[`MP_A_C_BIGHORNRAM_01`] = "",
[`MP_A_C_Boar_01`] = "",
[`MP_A_C_BUCK_01`] = "",
[`MP_A_C_BUFFALO_01`] = "",
[`MP_A_C_Cougar_01`] = "",
[`MP_A_C_Coyote_01`] = "",
[`MP_A_C_DEER_01`] = "",
[`MP_A_C_ELK_01`] = "",
[`MP_A_C_FOX_01`] = "",
[`MP_A_C_MOOSE_01`] = "",
[`MP_A_C_Panther_01`] = "",
[`MP_A_C_Wolf_01`] = "",
-- RURAIS
[`A_C_Sheep_01`] = "gordura",
[`A_C_Bull_01`] = "gordura",
[`A_C_Cow`] = "gordura",
[`A_C_Goat_01`] = "gordura",
[`A_C_Ox_01`] = "gordura",
[`A_C_Pig_01`] = "gordura",
-- AVES
[`A_C_Bat_01`] = "",
[`A_C_CaliforniaCondor_01`] = "carneave",
[`A_C_Cardinal_01`] = "carneave",
[`A_C_CedarWaxwing_01`] = "carneave",
[`A_C_CarolinaParakeet_01`] = "carneave",
[`A_C_Chicken_01`] = "pena",
[`A_C_Cormorant_01`] = "carneave",
[`A_C_BlueJay_01`] = "carneave",
[`A_C_CraneWhooping_01`] = "carneave",
[`A_C_Crow_01`] = "carneave",
[`A_C_Duck_01`] = "carneave",
[`A_C_Eagle_01`] = "garrarapina",
[`A_C_Egret_01`] = "carneave",
[`A_C_GooseCanada_01`] = "carneave",
[`A_C_Hawk_01`] = "garrarapina",
[`A_C_Heron_01`] = "carneave",
[`A_C_Loon_01`] = "carneave",
[`A_C_Oriole_01`] = "carneave",
[`A_C_Owl_01`] = "garrarapina",
[`A_C_Parrot_01`] = "carneave",
[`A_C_Pelican_01`] = "carneave",
[`A_C_Pheasant_01`] = "carneave",
[`A_C_Pigeon`] = "carneave",
[`A_C_PrairieChicken_01`] = "carneave",
[`A_C_Raven_01`] = "carneave",
[`A_C_RedFootedBooby_01`] = "carneave",
[`A_C_Robin_01`] = "carneave",
[`A_C_RoseateSpoonbill_01`] = "carneave",
[`A_C_Rooster_01`] = "carneave",
[`A_C_Seagull_01`] = "carneave",
[`A_C_SongBird_01`] = "carneave",
[`A_C_Sparrow_01`] = "carneave",
[`A_C_Turkey_01`] = "carneave",
[`A_C_Turkey_02`] = "carneave",
[`A_C_TurkeyWild_01`] = "carneave",
[`A_C_Vulture_01`] = "carneave",
[`A_C_Woodpecker_01`] = "carneave",
[`A_C_Woodpecker_02`] = "carneave",
--COBRAS
[`A_C_SnakeWater_01`] = "peledecobra",
[`A_C_Snake_01`] = "peledecobra",
[`A_C_SnakeBlackTailRattle_01`] = "peledecobra",
[`A_C_SnakeFerDeLance_01`] = "peledecobra",
[`A_C_SnakeRedBoa_01`] = "peledecobra",
-- PEIXES
[`A_C_FishBluegil_01_ms`] = "oleodepeixe",
[`A_C_FishBullHeadCat_01_ms`] = "oleodepeixe",
[`A_C_FishChainPickerel_01_ms`] = "oleodepeixe",
[`A_C_FishLargeMouthBass_01_ms`] = "oleodepeixe",
[`A_C_FishPerch_01_ms`] = "oleodepeixe",
[`A_C_FishRainbowTrout_01_ms`] = "oleodepeixe",
[`A_C_FishRedfinPickerel_01_ms`] = "oleodepeixe",
[`A_C_FishRockBass_01_ms`] = "oleodepeixe",
[`A_C_FishSalmonSockeye_01_ms`] = "oleodepeixe",
[`A_C_FishSmallMouthBass_01_ms`] = "oleodepeixe",
[`A_C_FishBluegil_01_sm`] = "oleodepeixe",
[`A_C_FishBullHeadCat_01_sm`] = "oleodepeixe",
[`A_C_FishChainPickerel_01_sm`] = "oleodepeixe",
[`A_C_FishPerch_01_sm`] = "oleodepeixe",
[`A_C_FishRedfinPickerel_01_sm`] = "oleodepeixe",
[`A_C_FishRockBass_01_sm`] = "oleodepeixe",
}

RegisterNetEvent("FRP:GATHERING:Gathered", function(entityModelHash, isHuman, entityQuality)
    local _source = source

    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()

    if Character == nil then
        return
    end

    local toAddItemBundle = { }
    local toAddAmount = 1

    if isHuman then
        toAddItemBundle = { 'money' }

        -- 2 a 4 centavos.
        math.randomseed(GetGameTimer())
        toAddAmount = math.random(2, 4)
    else
        if entityQuality >= 2 then
            toAddItemBundle = { 'carneperfeita', AnimalModelToItem[entityModelHash], AnimalModelToItem2[entityModelHash] }
        elseif entityQuality == 1 then
            toAddItemBundle = { 'carneboa', AnimalModelToItem[entityModelHash] }
        elseif entityQuality <= 0 then
            toAddItemBundle = { 'carneruim' }
        end
    end

    local Inventory = Character:getInventory()

    for _, toAddItem in ipairs(toAddItemBundle) do
        Inventory:addItem(toAddItem, toAddAmount)

        User:notify('item', toAddItem, toAddAmount)
    end

    -- TriggerClientEvent("FRP:LOOTING:LooteableDenied", _source, GetHashKey('p_whitefleshymeat01xa'))
end)

--[[
    
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
    
--GRANDES

[`A_C_Alligator_01`] = "",
[`A_C_Alligator_02`] = "",
[`A_C_Alligator_03`] = "",
[`A_C_Bear_01`] = "",
[`A_C_BearBlack_01`] = "",
[`A_C_Buck_01`] = "",
[`A_C_Buffalo_01`] = "",
[`A_C_Coyote_01`] = "",
[`A_C_Beaver_01`] = "",
[`A_C_BigHornRam_01`] = "",
[`A_C_Deer_01`] = "",
[`A_C_Wolf`] = "",
[`A_C_Wolf_Medium`] = "",
[`A_C_Wolf_Small`] = "",
[`A_C_Elk_01`] = "",
[`A_C_Moose_01`] = "",
[`A_C_Fox_01`] = "",
[`A_C_Javelina_01`] = "",
[`A_C_Panther_01`] = "",
[`A_C_Pronghorn_01`] = "",

--MÉDIOS

[`A_C_Possum_01`] = "",
[`A_C_Armadillo_01`] = "",
[`A_C_Badger_01`] = "",
[`A_C_Boar_01`] = "",
[`A_C_GilaMonster_01`] = "",
[`A_C_Iguana_01`] = "",
[`A_C_IguanaDesert_01`] = "",
[`A_C_Rabbit_01`] = "",
[`A_C_Raccoon_01`] = "",
[`A_C_Skunk_01`] = "",
[`A_C_TurtleSnapping_01`] = "",

--PEQUENOS

[`A_C_Chipmunk_01`] = "",
[`A_C_Crab_01`] = "",
[`A_C_Rat_01`] = "",
[`A_C_Squirrel_01`] = "",
[`A_C_Muskrat_01`] = "",
[`A_C_Toad_01`] = "",

-- LENDÁRIO

[`A_C_boarlegendary_01`] = "",
[`A_C_Buffalo_Tatanka_01`] = "",

-- RURAIS

[`A_C_Sheep_01`] = "",
[`A_C_Bull_01`] = "",
[`A_C_Cow`] = "",
[`A_C_Goat_01`] = "",
[`A_C_Ox_01`] = "",
[`A_C_Pig_01`] = "",

-- AVES

[`A_C_Bat_01`] = "",
[`A_C_CaliforniaCondor_01`] = "",
[`A_C_Cardinal_01`] = "",
[`A_C_CedarWaxwing_01`] = "",
[`A_C_CarolinaParakeet_01`] = "",
[`A_C_Chicken_01`] = "",
[`A_C_Cormorant_01`] = "",
[`A_C_BlueJay_01`] = "",
[`A_C_CraneWhooping_01`] = "",
[`A_C_Crow_01`] = "",
[`A_C_Duck_01`] = "",
[`A_C_Eagle_01`] = "",
[`A_C_Egret_01`] = "",
[`A_C_GooseCanada_01`] = "",
[`A_C_Hawk_01`] = "",
[`A_C_Heron_01`] = "",
[`A_C_Loon_01`] = "",
[`A_C_Oriole_01`] = "",
[`A_C_Owl_01`] = "",
[`A_C_Parrot_01`] = "",
[`A_C_Pelican_01`] = "",
[`A_C_Pheasant_01`] = "",
[`A_C_Pigeon`] = "",
[`A_C_PrairieChicken_01`] = "",
[`A_C_Raven_01`] = "",
[`A_C_RedFootedBooby_01`] = "",
[`A_C_Robin_01`] = "",
[`A_C_RoseateSpoonbill_01`] = "",
[`A_C_Rooster_01`] = "",
[`A_C_Seagull_01`] = "",
[`A_C_SongBird_01`] = "",
[`A_C_Sparrow_01`] = "",
[`A_C_Turkey_01`] = "",
[`A_C_Turkey_02`] = "",
[`A_C_TurkeyWild_01`] = "",
[`A_C_Vulture_01`] = "",
[`A_C_Woodpecker_01`] = "",
[`A_C_Woodpecker_02`] = "",

--COBRAS

[`A_C_SnakeWater_01`] = "",
[`A_C_Snake_01`] = "",
[`A_C_SnakeBlackTailRattle_01`] = "",
[`A_C_SnakeFerDeLance_01`] = "",
[`A_C_SnakeRedBoa_01`] = "",

-- ONLINE

MP_[`A_C_Alligator_01`] = "",
MP_[`A_C_Beaver_01`] = "",
MP_[`A_C_BIGHORNRAM_01`] = "",
MP_[`A_C_Boar_01`] = "",
MP_[`A_C_BUCK_01`] = "",
MP_[`A_C_BUFFALO_01`] = "",
MP_[`A_C_Cougar_01`] = "",
MP_[`A_C_Coyote_01`] = "",
MP_[`A_C_DEER_01`] = "",
MP_[`A_C_ELK_01`] = "",
MP_[`A_C_FOX_01`] = "",
MP_[`A_C_MOOSE_01`] = "",
MP_[`A_C_Panther_01`] = "",
MP_[`A_C_Wolf_01`] = "",

-- PEIXES

[`A_C_FishBluegil_01_ms`] = "",
[`A_C_FishBullHeadCat_01_ms`] = "",
[`A_C_FishChainPickerel_01_ms`] = "",
[`A_C_FishLargeMouthBass_01_ms`] = "",
[`A_C_FishPerch_01_ms`] = "",
[`A_C_FishRainbowTrout_01_ms`] = "",
[`A_C_FishRedfinPickerel_01_ms`] = "",
[`A_C_FishRockBass_01_ms`] = "",
[`A_C_FishSalmonSockeye_01_ms`] = "",
[`A_C_FishSmallMouthBass_01_ms`] = "",
[`A_C_FishBluegil_01_sm`] = "",
[`A_C_FishBullHeadCat_01_sm`] = "",
[`A_C_FishChainPickerel_01_sm`] = "",
[`A_C_FishPerch_01_sm`] = "",
[`A_C_FishRedfinPickerel_01_sm`] = "",
[`A_C_FishRockBass_01_sm`] = "",

]]