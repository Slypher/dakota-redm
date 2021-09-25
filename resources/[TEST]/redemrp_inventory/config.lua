Config = {}
Config.MaxWeight = 24.0

Config.Crafting = {
  ["gold"] = {

    items = {
      "gold_nugget", "gold_nugget", "gold_nugget",
      "gold_nugget", "gold_nugget", "gold_nugget",
      "gold_nugget", "gold_nugget", "gold_nugget"
    },
    requireJob = "empty",
    type = "smelting",
    amount = 1,
    category = "valutables", -- categories: materials, food, tools, medicaments, horse, herbs, valutables
    blacklist = true,
  },

  ["moonshine_mash"] = {

    items = {
      "apple", "sugar", "apple",
      "water", "yeast", "water",
      "water", "yeast", "water"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "food",
    blacklist = true,

  },


  ["copper"] = {

    items = {
      "empty", "empty", "empty",
      "empty", "copper_ore", "copper_ore",
      "empty", "copper_ore", "copper_ore"
    },
    requireJob = "empty",
    type = "smelting",
    amount = 2,
    category = "materials",

  },

  ["metal"] = {

    items = {
      "empty", "empty", "empty",
      "empty", "metal_ore", "metal_ore",
      "empty", "metal_ore", "metal_ore"
    },
    requireJob = "empty",
    type = "smelting",
    amount = 2,
    category = "materials",

  },


  ["crate"] = {

    items = {
      "planks", "planks", "planks",
      "planks", "empty", "planks",
      "planks", "planks", "planks"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "tools",

  },

  ["wood"] = {

    items = {
      "empty", "empty", "empty",
      "stick", "stick", "stick",
      "stick", "stick", "stick"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "materials",

  },


  ["tonics"] = {

    items = {
      "cotton", "cotton", "cotton",
      "blueberry", "blueberry", "blueberry",
      "kwiaty_kaktusa", "kwiaty_kaktusa", "kwiaty_kaktusa"
    },
    requireJob = "doctor",
    type = "empty",
    amount = 2,
    category = "medicaments",

  },


  ["orange_juice"] = {

    items = {
      "empty", "orange", "empty",
      "orange", "empty", "orange",
      "empty", "orange", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "food",

  },


  ["orange_pie"] = {

    items = {
      "empty", "orange", "empty",
      "orange", "orange", "orange",
      "empty", "orange", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "food",

  },


  ["cooked_bread"] = {

    items = {
      "empty", "empty", "empty",
      "empty", "bread", "empty",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "cooking",
    amount = 1,
    category = "food",
  },

  ["bread"] = {

    items = {
      "empty", "empty", "empty",
      "wheat", "wheat", "wheat",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "cooking",
    amount = 1,
    category = "food",


  },

  ["stew2"] = {

    items = {
      "carrot", "empty", "carrot",
      "broccoli", "lettuce", "broccoli",
      "carrot", "empty", "carrot"
    },
    requireJob = "empty",
    type = "cooking",
    amount = 1,
    category = "food",


  },


  ["crafting_table"] = {

    items = {
      "empty", "empty", "empty",
      "planks", "planks", "planks",
      "crate", "empty", "crate"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "tools",


  },

  ["flask"] = {

    items = {
      "empty", "pelt", "empty",
      "pelt", "empty", "pelt",
      "pelt", "pelt", "pelt"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "tools",


  },


  ["planks"] = {

    items = {
      "empty", "empty", "empty",
      "empty", "empty", "empty",
      "wood", "empty", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 2,
    category = "materials",


  },

  ["selfcigarettes"] = {

    items = {
      "empty", "tobacco", "empty",
      "empty", "tobacco", "empty",
      "empty", "rollpaper", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "herbs",
    blacklist = true,


  },

  ["selfcigar"] = {

    items = {
      "tobacco", "tobacco", "tobacco",
      "tobacco", "tobacco", "tobacco",
      "empty", "rollpaper", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "herbs",


  },

  ["stick"] = {

    items = {
      "empty", "empty", "empty",
      "empty", "planks", "empty",
      "empty", "planks", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 4,
    category = "materials",


  },

  ["sheet"] = {

    items = {
      "cloth", "cloth", "cloth",
      "cloth", "cloth", "cloth",
      "cloth", "cloth", "cloth"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "materials",
  },



  ["reinforced_stick"] = {

    items = {
      "empty", "stick", "empty",
      "empty", "cloth", "empty",
      "empty", "stick", "empty"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
  },

  ["tent"] = {

    items = {
      "empty", "sheet", "empty",
      "rock", "reinforced_stick", "rock",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
  },

  ["basic_tent"] = {

    items = {
      "empty", "cloth", "empty",
      "cloth", "reinforced_stick", "cloth",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "tools",
  },

  ["advanced_tent"] = {

    items = {
      "empty", "sheet", "empty",
      "sheet", "reinforced_stick", "sheet",
      "reinforced_stick", "empty", "reinforced_stick"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
  },





  ["kit_camp_simple"] = {

    items = {
      "stick", "stick", "stick",
      "stick", "wood", "stick",
      "rock", "rock", "rock"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "tools",
  },

  ["sharp_rock"] = {

    items = {
      "empty", "empty", "empty",
      "empty", "rock", "rock",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 2,
    category = "tools",
  },

  ["arrows"] = {

    items = {
      "empty", "sharp_rock", "empty",
      "empty", "stick", "empty",
      "empty", "feather", "empty"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
  },



  ["sharp_stick"] = {

    items = {
      "empty", "empty", "empty",
      "empty", "stick", "WEAPON_MELEE_KNIFE",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "tools",
  },

  ["cooked_fish"] = {

    items = {
      "empty", "empty", "empty",
      "empty", "smallfish", "empty",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "cooking",
    amount = 1,
    category = "food",
  },



  ["cooked_fish2"] = {

    items = {
      "empty", "empty", "empty",
      "empty", "mediumfish", "empty",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "cooking",
    amount = 1,
    category = "food",
  },



  ["cooked_fish3"] = {

    items = {
      "empty", "empty", "empty",
      "empty", "largefish", "empty",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "cooking",
    amount = 1,
    category = "food",
  },

  ["stew"] = {

    items = {
      "meat", "meat", "meat",
      "empty", "lisc_laurowy", "empty",
      "papryka", "papryka", "papryka"
    },
    requireJob = "empty",
    type = "cooking",
    amount = 1,
    category = "food",
  },

  ["cooked_meat"] = {

    items = {
      "empty", "empty", "empty",
      "empty", "meat", "empty",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "cooking",
    amount = 1,
    category = "food",
  },


  ["cooked_corn"] = {

    items = {
      "empty", "empty", "empty",
      "empty", "corn", "empty",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "cooking",
    amount = 1,
    category = "food",
  },

  ["herbal_bandage"] = {

    items = {
      "empty", "kwiaty_kaktusa", "empty",
      "jezowka", "bandage", "lisc_laurowy",
      "empty", "empty", "empty"
    },
    requireJob = "doctor",
    type = "doctor",
    amount = 1,
    category = "medicaments",
  },

  ["bandage"] = {

    items = {
      "empty", "empty", "empty",
      "cloth", "cloth", "cloth",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "medicaments",
  },


  ["cloth"] = {

    items = {
      "cotton", "cotton", "cotton",
      "empty", "empty", "empty",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "materials",


  },

  ["bagienneziele_pro"] = {

    items = {
      "empty", "bagienneziele", "empty",
      "empty", "bagienneziele", "empty",
      "empty", "rollpaper", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "herbs",
    blacklist = true,


  },





  ["herbal_tea"] = {

    items = {
      "empty", "tea_leaves", "empty",
      "water", "bark", "water",
      "empty", "empty", "empty"
    },
    requireJob = "shaman",
    type = "empty",
    amount = 1,
    category = "food",


  },


  ["bark"] = {

    items = {
      "empty", "empty", "empty",
      "empty", "empty", "empty",
      "stick", "empty", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "materials",


  },

  ["butter"] = {

    items = {
      "cream", "empty", "empty",
      "empty", "empty", "empty",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "food",


  },

  ["lavendar_oil"] = {

    items = {
      "lavendar", "lavendar", "lavendar",
      "empty", "oil", "empty",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "herbs",


  },

  ["pie_crust"] = {

    items = {
      "butter", "flour", "milk",
      "empty", "empty", "empty",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "cooking",
    amount = 2,
    category = "food",


  },


  ["flour"] = {

    items = {
      "wheat", "wheat", "wheat",
      "empty", "empty", "empty",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 3,
    category = "food",


  },

  ["sugar_cookies"] = {

    items = {
      "butter", "wheat", "milk",
      "sugar", "sugar", "sugar",
      "empty", "baking_soda", "empty"
    },
    requireJob = "empty",
    type = "cooking",
    amount = 3,
    category = "food",


  },

  ["cream"] = {

    items = {
      "milk", "empty", "empty",
      "empty", "empty", "empty",
      "empty", "empty", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 3,
    category = "food",


  },

  ["barrel"] = {

    items = {
      "metal", "metal", "metal",
      "empty", "empty", "empty",
      "metal", "metal", "metal"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
    blacklist = true,


  },


  ["grip"] = {

    items = {
      "empty", "metal", "metal",
      "empty", "wood", "empty",
      "empty", "wood", "empty"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
    blacklist = true,



  },

  ["stock"] = {

    items = {
      "empty", "wood", "wood",
      "wood", "wood", "wood",
      "wood", "wood", "empty"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
    blacklist = true,


  },

  ["scope"] = {

    items = {
      "empty", "metal", "empty",
      "metal", "gold", "metal",
      "empty", "metal", "empty"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
    blacklist = true,



  },

  ["mag"] = {

    items = {
      "metal", "ammo_box", "metal",
      "metal", "ammo_box", "metal",
      "metal", "ammo_box", "metal"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 3,
    category = "tools",
    blacklist = true,


  },


  ["WEAPON_REVOLVER_CATTLEMAN"] = {

    items = {
      "r_bp", "empty", "empty",
      "stock", "mag", "barrel",
      "empty", "grip", "empty"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
    blacklist = true,


  },

  ["WEAPON_REPEATER_WINCHESTER"] = {

    items = {
      "rep_bp", "empty", "empty",
      "stock", "mag", "barrel",
      "empty", "grip", "empty"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
    blacklist = true,


  },

  ["WEAPON_MELEE_KNIFE"] = {

    items = {
      "empty", "metal", "empty",
      "empty", "metal", "empty",
      "empty", "stick", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "tools",


  },

  ["WEAPON_THROWN_MOLOTOV"] = {

    items = {
      "e_bp", "moonshine", "empty",
      "empty", "cloth", "empty",
      "empty", "poor_whisky", "empty"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
    blacklist = true,


  },

  ["WEAPON_SHOTGUN_DOUBLEBARREL"] = {

    items = {
      "s_bp", "empty", "empty",
      "stock", "mag", "barrel",
      "empty", "empty", "barrel"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
    blacklist = true,


  },

  ["WEAPON_RIFLE_SPRINGFIELD"] = {

    items = {
      "rifle_bp", "metal", "empty",
      "stock", "mag", "barrel",
      "empty", "grip", "empty"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
    blacklist = true,


  },

  ["WEAPON_MELEE_HATCHET"] = {
    items = {
      "empty", "metal", "metal",
      "empty", "reinforced_stick", "metal",
      "empty", "reinforced_stick", "empty"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
  },

  ["WEAPON_PISTOL_M1899"] = {

    items = {
      "p_bp", "metal", "empty",
      "empty", "mag", "barrel",
      "empty", "grip", "empty"
    },
    requireJob = "empty",
    type = "crafting",
    amount = 1,
    category = "tools",
    blacklist = true,


  },

  ["WEAPON_MELEE_TORCH"] = {

    items = {
      "cloth", "good_whisky", "cloth",
      "cloth", "stick", "cloth",
      "empty", "stick", "empty"
    },
    requireJob = "empty",
    type = "empty",
    amount = 1,
    category = "tools",


  },

}

Config.Items = {

  ["idcard_own"] =
  {
    label = "ID Card",
    description = "Your Identification Card",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 1,
    imgsrc = "items/idcard_own.png",
    type = "item_standard",
    category = "tools",

  },
  ["idcard_stolen"] =
  {
    label = "Stolen ID Card",
    description = "A Stolen Identification Card",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 1,
    imgsrc = "items/idcard_stolen.png",
    type = "item_standard",
    category = "tools",

  },

  ["water"] =
  {
    label = "Water",
    description = "One hydrogen molecule, two oxygen",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 8,
    imgsrc = "items/water.png",
    type = "item_standard",
    category = "food",

  },

  ["mag"] =
  {
    label = "Weapon Magazine",
    description = "Six round shooter",
    weight = 2,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/magazine.png",
    type = "item_standard",
    category = "tools",

  },

  ["scope"] =
  {
    label = "Weapon Scope",
    description = "See far and wide",
    weight = 2,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/scope.png",
    type = "item_standard",
    category = "tools",

  },

  ["stock"] =
  {
    label = "Weapon Stock",
    description = "Keep steady aim",
    weight = 2,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 3,
    imgsrc = "items/stock.png",
    type = "item_standard",
    category = "tools",

  },

  ["grip"] =
  {
    label = "Weapon Grip",
    description = "Reduce that damn recoil",
    weight = 2,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/grip.png",
    type = "item_standard",
    category = "tools",

  },

  ["barrel"] =
  {
    label = "Weapon Barrel",
    description = "Reduce that damn recoil",
    weight = 2,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 3,
    imgsrc = "items/barrel.png",
    type = "item_standard",
    category = "tools",

  },


  ["r_bp"] =
  {
    label = "Cattlemen Revolver Blueprint",
    description = "1 Mag(6 Metal, 3 Ammo Box's), 1 Grip(2 Metal, 2 Wood), 1 Barrel(6 Metal), 1 stock(7 wood)",
    weight = 1,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 3,
    imgsrc = "items/weapon_revolver_cattlemanbp.png",
    type = "item_standard",
    category = "valutables",

  },

  ["e_bp"] =
  {
    label = "Molotov Extra's Blueprint",
    description = "1 Moonshine, 1 Cloth, 1 Dirty Whiskey",
    weight = 2,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/weapon_thrown_molotovbp.png",
    type = "item_standard",
    category = "valutables",

  },

  ["rep_bp"] =
  {
    label = "Lancaster Repeater Blueprint",
    description = "1 Mag(6 Metal, 3 Ammo Box's), 1 Barrel(6 Metal), 1 Stock(7 Wood)",
    weight = 3,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/weapon_repeater_henrybpa.png",
    type = "item_standard",
    category = "valutables",

  },

  ["s_bp"] =
  {
    label = "Double Barrel Shotgun Blueprint",
    description = "1 Mag(6 Metal, 3 Ammo Box's), 2 Barrel(12 Metal), 1 Stock(7 Wood)",
    weight = 1,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/weapon_shotgun_sawedoffbe.png",
    type = "item_standard",
    category = "valutables",

  },

  ["rifle_bp"] =
  {
    label = "Springfield Rifle Blueprint",
    description = "1 Mag(6 Metal, 3 Ammo Box's), 1 Barrel(12 Metal), 1 Stock(7 Wood), 1 Grip(2 Metal, 2 Wood), 1 Metal",
    weight = 1,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 1,
    imgsrc = "items/weapon_rifle_springfieldbr.png",
    type = "item_standard",
    category = "valutables",

  },

  ["p_bp"] =
  {
    label = "M1899 Pistol Blueprint",
    description = "1 Mag(6 Metal, 3 Ammo Box's), 1 Barrel(12 Metal), 1 Grip(2 Metal, 2 Wood), 1 Metal",
    weight = 1,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 3,
    imgsrc = "items/weapon_pistol_m1899aa.png",
    type = "item_standard",
    category = "valutables",

  },

  ["rifle_spec"] =
  {
    label = "Carcarno Special Blueprint",
    description = "Aint no tip for this one sunshine!",
    weight = 1,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 1,
    imgsrc = "items/weapon_sniperrifle_carcanoaa.png",
    type = "item_standard",
    category = "valutables",

  },


  ["cleanshort"] =
  {
    label = "Weapon Cloth",
    description = "Clean your gun, that's all i can describe",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/sheet.png",
    type = "item_standard",
    category = "tools",
  },


  ["bread"] =
  {
    label = "Bread",
    description = "A stale loaf with unknown seeds",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 8,
    imgsrc = "items/bread.png",
    type = "item_standard",
    category = "food",


  },

  ["blueberry"] =
  {
    label = "Blueberry",
    description = "A ripe & fit to eat fruit",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/blueberry.png",
    type = "item_standard",
    category = "food",


  },

  ["stew2"] =
  {
    label = "Stew",
    description = "A cheap stew of leftover meats & vegies",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 3,
    imgsrc = "items/stew.png",
    type = "item_standard",
    category = "food",


  },

  ["wood"] =
  {
    label = "Wood",
    description = "A poorly cut piece of wood",
    weight = 0.6,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 15,
    imgsrc = "items/wood.png",
    type = "item_standard",
    category = "materials",


  },

  ["weddingring"] =
  {
    label = "Wedding Ring",
    description = "The Winters",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 1,
    imgsrc = "items/goldring.png",
    type = "item_standard",
    category = "valutables",

  },

  ["apple_pie"] =
  {
    label = "Apple Pie",
    description = "Tangfastic",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 3,
    imgsrc = "items/pie_crust.png",
    type = "item_standard",
    category = "food",

  },

  ["apple_crumble"] =
  {
    label = "Apple Crumble",
    description = "Crumble, Crumble, Crumble",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 3,
    imgsrc = "items/butter.png",
    type = "item_standard",
    category = "food",

  },

  ["apple_juice"] =
  {
    label = "Apple Juice",
    description = "Orange juice is better",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 8,
    imgsrc = "items/orange_juice.png",
    type = "item_standard",
    category = "food",

  },

  ["crate"] =
  {
    label = "Crate",
    description = "A standard sized crate",
    weight = 1.3,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 6,
    imgsrc = "items/crate.png",
    type = "item_standard",
    category = "tools",


  },

  ["property_title"] =
  {
    label = "Property titles",
    description = "Paypers that say you own something.",
    weight = 0.0,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 1,
    imgsrc = "items/generic_official_doc.png",
    type = "item_standard",
    category = "valutables",
  },



  ["ammo_box"] =
  {
    label = "Ammo Box",
    description = "A box of ammunition",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 3,
    imgsrc = "items/ammo_box.png",
    type = "item_standard",
    category = "tools",


  },


  ["sharp_rock"] =
  {
    label = "Sharp Rock",
    description = "A rock that is sharp",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 7,
    imgsrc = "items/sharp_rock.png",
    type = "item_standard",
    category = "tools",


  },

  ["sharp_stick"] =
  {
    label = "Shark Stick",
    description = "A stick that is sharp",
    weight = 0.15,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 7,
    imgsrc = "items/sharp_stick.png",
    type = "item_standard",
    category = "tools",


  },


  ["reinforced_stick"] =
  {
    label = "Reinforced Stick",
    description = "A stick that is not sharp, but strong",
    weight = 0.2,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 7,
    imgsrc = "items/reinforced_stick.png",
    type = "item_standard",
    category = "tools",


  },

  ["sheet"] =
  {
    label = "Sheet",
    description = "Cloth sheet",
    weight = 0.4,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/sheet.png",
    type = "item_standard",
    category = "materials",


  },

  ["pelt"] =
  {
    label = "Pelt",
    description = "An animal pelt",
    weight = 0.4,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/pelt.png",
    type = "item_standard",
    category = "materials",


  },

  ["kit_camp_simple"] =
  {
    label = "Simple Camp Kit",
    description = "A simple yet effective camp kit",
    weight = 2.0,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/kit_camp_simple.png",
    type = "item_standard",
    category = "tools",


  },

  ["p_baitBread01x"] =
  {
    label = "Bait - Bread",
    description = "Fish love bread",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/bread_bait.png",
    type = "item_standard",
    category = "food",


  },


  ["moneyclip"] =
  {
    label = "Money Clip",
    description = "Money Clip",
    weight = 0.02,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 15,
    imgsrc = "items/moneyclip.png",
    type = "item_standard",
    category = "valutables",


  },

  ["p_baitCheese01x"] =
  {
    label = "Bait - Cheese",
    description = "French fish bait",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 15,
    imgsrc = "items/cheese_bait.png",
    type = "item_standard",
    category = "food",


  },

  ["p_baitCorn01x"] =
  {
    label = "Bait - Corn",
    description = "Goes in the same as it comes out",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 15,
    imgsrc = "items/corn_bait.png",
    type = "item_standard",
    category = "food",


  },
  ["p_baitCricket01x"] =
  {
    label = "Bait - Cricket",
    description = "A dried cricket",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 15,
    imgsrc = "items/cricket_bait.png",
    type = "item_standard",
    category = "food",


  },


  ["p_finishedragonfly01x"] =
  {
    label = "Dragon Fly",
    description = "A creepy looking dragon fly bait",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 15,
    imgsrc = "items/river_bait.png",
    type = "item_standard",
    category = "food",


  },


  ["p_FinisdFishlure01x"] =
  {
    label = "Fish Lure",
    description = "A low effort fish lure",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/lake_bait.png",
    type = "item_standard",
    category = "tools",


  },

  ["p_finishdcrawd01x"] =
  {
    label = "Swamp Bait",
    description = "An unknown bait ",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 15,
    imgsrc = "items/swamp_bait.png",
    type = "item_standard",
    category = "food",


  },


  ["cooked_fish"] =
  {
    label = "Cooked Fish",
    description = "Medium rare cooked fish",
    weight = 0.2,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/cooked_fish.png",
    type = "item_standard",
    category = "food",


  },


  ["cooked_fish2"] =
  {
    label = "Medium Cooked Fish",
    description = "A medium sized cooked fish",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/cooked_fish2.png",
    type = "item_standard",
    category = "food",


  },

  ["cooked_fish3"] =
  {
    label = "Large Cooked Fish",
    description = "A well done large cooked fish",
    weight = 1.0,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/cooked_fish3.png",
    type = "item_standard",
    category = "food",


  },


  ["smallfish"] =
  {
    label = "Little Fish",
    description = "About the size of nemo",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 7,
    imgsrc = "items/smallfish.png",
    type = "item_standard",
    category = "food",


  },


  ["mediumfish"] =
  {
    label = "Medium Fish",
    description = "A medium fish",
    weight = 2.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/mediumfish.png",
    type = "item_standard",
    category = "food",


  },

  ["largefish"] =
  {
    label = "Large Fish",
    description = "What a great catch",
    weight = 4.5,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 3,
    imgsrc = "items/largefish.png",
    type = "item_standard",
    category = "food",

  },

  ["key"] =
  {
    label = "Key",
    description = "A random key, no idea what for, but its a key.",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/key.png",
    type = "item_standard",
    category = "valutables",

  },

  ["selfcigarettes"] =
  {
    label = "Pack of Rolled Cigarettes",
    description = "Contains 15 cancer causing cigarettes.",
    weight = 0.06,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 15,
    imgsrc = "items/selfcigarettes.png",
    type = "item_standard",
    category = "herbs",


  },

  ["selfcigars"] =
  {
    label = "Box of Rolled Cigars",
    description = "Contains 10 premium rolled Cigars.",
    weight = 0.06,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 15,
    imgsrc = "items/selfcigars.png",
    type = "item_standard",
    category = "herbs",


  },


  ["moonshine"] =
  {
    label = "Moonshine",
    description = "37% - Or close to",
    weight = 0.4,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/moonshine.png",
    type = "item_standard",
    category = "food",


  },

  ["herbal_tea"] =
  {
    label = "Herbal Tea",
    description = "a tea with medical properties",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/herbal_tea.png",
    type = "item_standard",
    category = "food",


  },

  ["governorsorders"] =
  {
    label = "Governors Orders",
    description = "A handwritten order from the Governor",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 1,
    imgsrc = "items/governorsorders.png",
    type = "item_standard",
    category = "valutables",


  },

  ["bountyhunter"] =
  {
    label = "Bounty Hunter Liscense",
    description = "A handwritten Liscense to confirm this bounty hunter",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/governorsorders.png",
    type = "item_standard",
    category = "valutables",


  },

  ["cream"] =
  {
    label = "Cream",
    description = "Rich cream",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 7,
    imgsrc = "items/cream.png",
    type = "item_standard",
    category = "food",


  },

  ["egg"] =
  {
    label = "Egg",
    description = "Rounded egg found in nest",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/egg.png",
    type = "item_standard",
    category = "food",


  },

  ["sugar_cookie"] =
  {
    label = "Sugar Cookie",
    description = "Soft white sugar cookies",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/sugar_cookies.png",
    type = "item_standard",
    category = "food",


  },

  ["pie_crust"] =
  {
    label = "Pie Crust",
    description = "flaky pie crust",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/pie_crust.png",
    type = "item_standard",
    category = "food",


  },

  ["butter"] =
  {
    label = "Butter",
    description = "Thick butter from cows",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/butter.png",
    type = "item_standard",
    category = "food",


  },

  ["milk"] =
  {
    label = "Milk",
    description = "Fresh milk",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/milk.png",
    type = "item_standard",
    category = "food",


  },


  ["lavendar"] =
  {
    label = "Lavendar",
    description = "a lovely purple flower",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/lavendar.png",
    type = "item_standard",
    category = "herbs",


  },

  ["oil"] =
  {
    label = "Oil",
    description = "A slick liquid",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/oil.png",
    type = "item_standard",
    category = "valutables",


  },

  ["baking_soda"] =
  {
    label = "Baking soda",
    description = "I say RISE",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/baking_soda.png",
    type = "item_standard",
    category = "food",


  },

  ["flour"] =
  {
    label = "Flour",
    description = "freshly milled flour",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/flour.png",
    type = "item_standard",
    category = "food",


  },


  ["bark"] =
  {
    label = "Bark",
    description = "just some bark",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/bark.png",
    type = "item_standard",
    category = "materials",


  },


  ["sugar"] =
  {
    label = "Sugar",
    description = "Raw Sugar",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 32,
    imgsrc = "items/sugar.png",
    type = "item_standard",
    category = "food",


  },

  ["yeast"] =
  {
    label = "Yeast",
    description = "Bread or Beer?",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 15,
    imgsrc = "items/yeast.png",
    type = "item_standard",
    category = "food",


  },

  ["beer"] =
  {
    label = "Beer",
    description = "A beer for the purpose of getting drunk and a bar fight.",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/beer.png",
    type = "item_standard",
    category = "food",


  },

  ["wine"] =
  {
    label = "Wine",
    description = "Wine",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/wine.png",
    type = "item_standard",
    category = "food",


  },

  ["szampan"] =
  {
    label = "Champagne",
    description = "A bottle of bubbles the rich would say",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/szampan.png",
    type = "item_standard",
    category = "food",


  },


  ["stick"] =
  {
    label = "Stick",
    description = "Long & Brown, quite sticky.",
    weight = 0.02,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 15,
    imgsrc = "items/stick.png",
    type = "item_standard",
    category = "materials",


  },


  ["planks"] =
  {
    label = "Plank",
    description = "( ͡° ͜ʖ ͡°)",
    weight = 0.15,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/planks.png",
    type = "item_standard",
    category = "materials",


  },

  ["rollpaper"] =
  {
    label = "Rolling Paper",
    description = "To roll some smokeables.",
    weight = 0.02,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 32,
    imgsrc = "items/rollpaper.png",
    type = "item_standard",
    category = "valutables",


  },


  ["bandage"] =
  {
    label = "Bandage",
    description = "Great for use if you know first aid, otherwise useless",
    weight = 0.06,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/bandage.png",
    type = "item_standard",
    category = "medicaments",
  },


  ["wateringcan"] =
  {
    label = "Watering Can",
    description = "Can to water",
    weight = 0.5,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/wateringcan.png",
    type = "item_standard",
    category = "tools",


  },


  ["tent"] =
  {
    label = "Tent",
    description = "Tent for tent things",
    weight = 1.0,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/tent.png",
    type = "item_standard",
    category = "tools",


  },


  ["basic_tent"] =
  {
    label = "Basic Tent",
    description = "A basic tent",
    weight = 0.8,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/tent.png",
    type = "item_standard",
    category = "tools",


  },

  ["advanced_tent"] =
  {
    label = "Advanced Tent",
    description = "This bad boy will shield the water for days",
    weight = 2.0,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/tent.png",
    type = "item_standard",
    category = "tools",


  },


  ["cuffs"] =
  {
    label = "Cuffs",
    description = "Popular item for police, bandits & married couples",
    weight = 0.2,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/cuffs.png",
    type = "item_standard",
    category = "tools",


  },

  ["cigar"] =
  {
    label = "Cigar",
    description = "Inhale with style",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/cigar.png",
    type = "item_standard",
    category = "herbs",


  },


  ["cigarettes"] =
  {
    label = "Cigarettes",
    description = "Tobacco has never tasted so great",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/cigarettes.png",
    type = "item_standard",
    category = "herbs",


  },

  ["hairpomade"] =
  {
    label = "Hair Pomade",
    description = "Slick it back you filthy animal.",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/hairpomade.png",
    type = "item_standard",
    category = "valutables",


  },

  ["notebook"] =
  {
    label = "Notebook",
    description = "Write down yer notes.",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/notebook.png",
    type = "item_standard",
    category = "valutables",
  },

  ["pocket_watch"] =
  {
    label = "Pocket Watch",
    description = "Check out the time.",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/pocketwatch.png",
    type = "item_standard",
    category = "valutables",
  },

  ["book"] =
  {
    label = "Book",
    description = "Git yer mind busy with some reading.",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/book.png",
    type = "item_standard",
    category = "valutables",
  },

  ["pipe"] =
  {
    label = "Smoking Pipe",
    description = "A fancy way to smoke Tobacco.",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/pipe.png",
    type = "item_standard",
    category = "valutables",
  },

  ["fan"] =
  {
    label = "Fancy Fan",
    description = "For the ladies to keep cool.",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/fan.png",
    type = "item_standard",
    category = "valutables",
  },

  ["chewingtobacco"] =
  {
    label = "Chewing Tobacco",
    description = "Tobacco for yer mouth.",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/chewingtobacco.png",
    type = "item_standard",
    category = "herbs",
  },


  ["cornseed"] =
  {
    label = "Cornseed",
    description = "Seed of the corn",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/cornseed.png",
    type = "item_standard",
    category = "food",


  },


  ["stew"] =
  {
    label = "Goulash",
    description = "A big ol stew.",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/stew.png",
    type = "item_standard",
    category = "food",


  },


  ["sugarsaneseed"] =
  {
    label = "Sugar Cane Seed",
    description = "Its a sugar canes way of reproducing",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/sugarsaneseed.png",
    type = "item_standard",
    category = "food",


  },


  ["tobaccoseed"] =
  {
    label = "Tobacco Seed",
    description = "Its a tobacco plants way of reproducing",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/tobaccoseed.png",
    type = "item_standard",
    category = "food",


  },

  ["tobacco"] =
  {
    label = "Tobacco",
    description = "Smells like an old saloon.",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 30,
    imgsrc = "items/tobacco.png",
    type = "item_standard",
    category = "herbs",


  },

  ["orange"] =
  {
    label = "Orange's",
    description = "Why is orange, orange?",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/orange.png",
    type = "item_standard",
    category = "food",

  },

  ["orange_juice"] =
  {
    label = "Orange Juice",
    description = "Better than apple juice",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 8,
    imgsrc = "items/orange_juice.png",
    type = "item_standard",
    category = "food",

  },

  ["orange_pie"] =
  {
    label = "Orange Pie",
    description = "Could be a seller",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/pie_crust.png",
    type = "item_standard",
    category = "food",

  },


  ["cloth"] =
  {
    label = "Cloth",
    description = "Clearly a brown stain on this",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/cloth.png",
    type = "item_standard",
    category = "materials",


  },


  ["cooked_meat"] =
  {
    label = "Cooked Meat",
    description = "Medium rare, the only way to have it.",
    weight = 0.09,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/cooked_meat.png",
    type = "item_standard",
    category = "food",


  },


  ["meat"] =
  {
    label = "Meat",
    description = "A bit of pork for ya fork",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/meat.png",
    type = "item_standard",
    category = "food",


  },


  ["poor_whisky"] =
  {
    label = "Dirty Whisky",
    description = "Grainy bottle with a whiskey of the poor man",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/poor_whisky.png",
    type = "item_standard",
    category = "food",


  },


  ["feather"] =
  {
    label = "Feathers",
    description = "Could be the last dodo feather.",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/feather.png",
    type = "item_standard",
    category = "materials",


  },

  ["marked_bills"] =
  {
    label = "Bonds",
    description = "These Marked Bills for internal use only. They are probably stolen.",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/_placeholder.png",
    type = "item_standard",
    category = "valutables",


  },


  ["diamond"] =
  {
    label = "Diamond",
    description = "One of the most valuable and sought after Gemstones.",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 1,
    imgsrc = "items/diamond.png",
    type = "item_standard",
    category = "materials",


  },


  ["rock"] =
  {
    label = "Rock",
    description = "It's not a boulder, its a rock.",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/rock.png",
    type = "item_standard",
    category = "materials",


  },


  ["arrows"] =
  {
    label = "Arrows",
    description = "A poorly built arrow, high drag.",
    weight = 0.8,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 64,
    imgsrc = "items/arrows.png",
    type = "item_standard",
    category = "tools",


  },

  ["Feed_For_Dog"] =
  {
    label = "Dog Food",
    description = "some scrange for yer dog",
    weight = 0.8,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/consumable_game_meat_wild_mint_cooked.png",
    type = "item_standard",
    category = "food",


  },

  ["Health_For_Dog"] =
  {
    label = "Dog Medicine",
    description = "some dog medicine",
    weight = 0.8,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/strength_syrup.png",
    type = "item_standard",
    category = "food",


  },

  ["Drink_For_Dog"] =
  {
    label = "Dog Water",
    description = "slurp",
    weight = 0.8,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/raspberry_lemonade.png",
    type = "item_standard",
    category = "food",


  },


  ["kwiaty_kaktusa"] =
  {
    label = "Aloe",
    description = "Aloe Vera",
    weight = 0.005,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/kwiaty_kaktusa.png",
    type = "item_standard",
    category = "herbs",


  },


  ["jezowka"] =
  {
    label = "Echinacea",
    description = "Great for a vegan diet",
    weight = 0.005,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/jezowka.png",
    type = "item_standard",
    category = "herbs",


  },


  ["szalwia"] =
  {
    label = "Sage",
    description = "A little brown...",
    weight = 0.001,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/szalwia.png",
    type = "item_standard",
    category = "herbs",


  },


  ["papryka"] =
  {
    label = "Pepper",
    description = "Black Pepper",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/papryka.png",
    type = "item_standard",
    category = "food",


  },



  ["lisc_laurowy"] =
  {
    label = "Bay Leaf",
    description = "A simple leaf",
    weight = 0.001,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/lisc_laurowy.png",
    type = "item_standard",
    category = "herbs",


  },



  ["kolce"] =
  {
    label = "Marymus Spines",
    description = "Very spikey, dont hurt yaself!",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/kolce.png",
    type = "item_standard",
    category = "herbs",


  },



  ["herbal_bandage"] =
  {
    label = "Herbal Bandage",
    description = "A bandage that looks to be made by a witch doctor",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 3,
    imgsrc = "items/bandaz_ziolowy.png",
    type = "item_standard",
    category = "medicaments",


  },


  ["tonics"] =
  {
    label = "Tonic",
    description = "A snake oil? I dont think so",
    weight = 0.15,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/napar_orzezwienia.png",
    type = "item_standard",
    category = "medicaments",


  },


  ["moonshine_mash"] =
  {
    label = "Moonshine Mash",
    description = "Apple is worst than orange",
    weight = 1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/provision_trinket_shark_tooth.png",
    type = "item_standard",
    category = "food",


  },


  ["mango"] =
  {
    label = "Mangos",
    description = "Born in Gaurma",
    weight = 0.02,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/peach.png",
    type = "item_standard",
    category = "food",


  },

  ["horsebrush"] =
  {
    label = "Horse Brush",
    description = "Brush that wonderful steed of yours",
    weight = 0.5,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/kit_horse_brush.png",
    type = "item_standard",
    category = "horse",


  },

  ["corn"] =
  {
    label = "Corn",
    description = "Goes in the same it comes out.",
    weight = 0.03,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/corn.png",
    type = "item_standard",
    category = "food",


  },



  ["flask"] =
  {
    label = "Flask",
    description = "A flask, great for quick sessions",
    weight = 0.5,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 4,
    imgsrc = "items/flask.png",
    type = "item_standard",
    category = "tools",


  },


  ["consumable_haycube"] =
  {
    label = "Haycube",
    description = "A block of hay is a nice treat for your steed.",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/consumable_haycube.png",
    type = "item_standard",
    category = "horse",


  },

  ["craftingbook"] =
  {
    label = "Crafting Book",
    description = "All the crafting recipes we have",
    weight = 2,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/notebook.png",
    type = "item_standard",
    category = "tools",


  },

  ["weaponbook"] =
  {
    label = "Weapon Book",
    description = "All the crafting recipes for weapons",
    weight = 0.5,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/notebook.png",
    type = "item_standard",
    category = "tools",


  },

  ["consumable_horse_stimulant"] =
  {
    label = "Horse Stimulant",
    description = "Gotta go fast.",
    weight = 0.02,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/consumable_horse_stimulant.png",
    type = "item_standard",
    category = "horse",


  },

  ["apple"] =
  {
    label = "Apple",
    description = "Not an orange",
    weight = 0.02,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/apple.png",
    type = "item_standard",
    category = "food",


  },


  ["cooked_bread"] =
  {
    label = "Toasted Bread",
    description = "A little char never hurt nobody.",
    weight = 0.015,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/cooked_bread.png",
    type = "item_standard",
    category = "food",


  },


  ["crafting_table"] =
  {
    label = "Crafting Table",
    description = "A table for arts & crafts",
    weight = 1.2,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 1,
    imgsrc = "items/crafting_table.png",
    type = "item_standard",
    category = "tools",


  },


  ["metal"] =
  {
    label = "Metal",
    description = "rusty metal",
    weight = 0.5,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/metal.png",
    type = "item_standard",
    category = "materials",


  },


  ["metal_ore"] =
  {
    label = "Metal Ore",
    description = "An ore for metal",
    weight = 0.23,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/metal_ore.png",
    type = "item_standard",
    category = "materials",


  },

  ["copper"] =
  {
    label = "Copper",
    description = "Its a fools gold",
    weight = 0.5,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/copper.png",
    type = "item_standard",
    category = "materials",


  },

  ["newspaper"] =
  {
    label = "Newspaper",
    description = "Todays good ol' news",
    weight = 0.5,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 1,
    imgsrc = "items/newspaper.png",
    type = "item_standard",
    category = "valutables",


  },

  ["copper_ore"] =
  {
    label = "Copper Ore",
    description = "Copper Ore",
    weight = 0.23,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/copper_ore.png",
    type = "item_standard",
    category = "materials",


  },

  ["cooked_corn"] =
  {
    label = "Cooked Corn",
    description = "Slightly burnt, but its alright.",
    weight = 0.015,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/cooked_corn.png",
    type = "item_standard",
    category = "food",


  },


  ["coffee"] =
  {
    label = "Coffee",
    description = "I allus has wan in the morning",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/coffee.png",
    type = "item_standard",
    category = "food",


  },


  ["lemonade"] =
  {
    label = "Lemonade",
    description = "It aint no beer, but it sure is tasty",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/lemonade.png",
    type = "item_standard",
    category = "food",


  },


  ["minttea"] =
  {
    label = "Mint Tea",
    description = "A herbal mixture in warm water",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/minttea.png",
    type = "item_standard",
    category = "food",


  },


  ["good_whisky"] =
  {
    label = "Good Whisky",
    description = "An award winning whisky, smooth and woody taste",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/good_whisky.png",
    type = "item_standard",
    category = "food",


  },


  ["shovel"] =
  {
    label = "Shovel",
    description = "A broken mining shovel, still works though!",
    weight = 0.35,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/shovel.png",
    type = "item_standard",
    category = "tools",


  },


  ["oldbuckle"] =
  {
    label = "Old Buckle",
    description = "Its old",
    weight = 0.04,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/oldbuckle.png",
    type = "item_standard",
    category = "valutables",


  },


  ["oldwatch"] =
  {
    label = "Old Watch",
    description = "An old watch with a noisy click",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/oldwatch.png",
    type = "item_standard",
    category = "valutables",


  },


  ["goldring"] =
  {
    label = "Gold Ring",
    description = "A ring with the engravings of greek like letters",
    weight = 0.02,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/goldring.png",
    type = "item_standard",
    category = "valutables",


  },


  ["goldtooth"] =
  {
    label = "Gold Tooth",
    description = "A symbol of wealth, engraved with the name SILENT",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/goldtooth.png",
    type = "item_standard",
    category = "valutables",


  },


  ["oldcoin"] =
  {
    label = "Old Coin",
    description = "A almost unrecognisable coin",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/oldcoin.png",
    type = "item_standard",
    category = "valutables",


  },

  ["gold"] =
  {
    label = "Gold Bar",
    description = "The staple of all wealth",
    weight = 0.5,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 3,
    imgsrc = "items/gold.png",
    type = "item_standard",
    category = "materials",


  },

  ["goldpan"] =
  {
    label = "Gold Pan",
    description = "Use this near rivers to test luck and find gold.",
    weight = 1.0,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/goldpan.png",
    type = "item_standard",
    category = "tools",

  },


  ["gold_nugget"] =
  {
    label = "Gold Nugget",
    description = "A small but valuable nugget.",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/gold_nugget.png",
    type = "item_standard",
    category = "materials",

  },


  ["tiny_gold_nugget"] =
  {
    label = "Tiny Gold Nugget",
    description = "A tiny gold nugget, you can smelt a couple or sell it.",
    weight = 0.0,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/tiny_gold_nugget.png",
    type = "item_standard",
    category = "materials",

  },




  ["carrotseed"] =
  {
    label = "Carrot Seed",
    description = "A seed for carrots",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 7,
    imgsrc = "items/carrotseed.png",
    type = "item_standard",
    category = "food",

  },

  ["cottonseed"] =
  {
    label = "Cotton Seed",
    description = "A seed for cotton",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 15,
    imgsrc = "items/cottonseed.png",
    type = "item_standard",
    category = "materials",

  },

  ["moonnote"] =
  {
    label = "Mash Recipe",
    description = "Learn inner secrets of uncle moonshine",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 1,
    imgsrc = "items/governorsorders.png",
    type = "item_standard",
    category = "tools",


  },

  ["wheatseed"] =
  {
    label = "Wheat Seed",
    description = "A seed for wheat",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 5,
    imgsrc = "items/wheatseed.png",
    type = "item_standard",
    category = "food",

  },

  ["broccoliseed"] =
  {
    label = "Broccoli Seed",
    description = "A seed for broccoli",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/broccoliseed.png",
    type = "item_standard",
    category = "food",

  },

  ["lettuceseed"] =
  {
    label = "Lettuce Seed",
    description = "A seed for lettuce",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 12,
    imgsrc = "items/lettuceseed.png",
    type = "item_standard",
    category = "food",

  },


  ["cotton"] =
  {
    label = "Cotton",
    description = "All good business starts with cotton",
    weight = 0.001,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 45,
    imgsrc = "items/cotton.png",
    type = "item_standard",
    category = "materials",

  },

  ["wheat"] =
  {
    label = "Wheat",
    description = "A bakers delight",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 50,
    imgsrc = "items/wheat.png",
    type = "item_standard",
    category = "food",

  },

  ["broccoli"] =
  {
    label = "Broccoli",
    description = "Kids hate it, you love it.",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 40,
    imgsrc = "items/broccoli.png",
    type = "item_standard",
    category = "food",

  },

  ["lettuce"] =
  {
    label = "Lettuce",
    description = "Infested with bugs, but still edible",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 60,
    imgsrc = "items/lettuce.png",
    type = "item_standard",
    category = "food",

  },

  ["carrot"] =
  {
    label = "Carrot",
    description = "What's up Doc?",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 28,
    imgsrc = "items/carrot.png",
    type = "item_standard",
    category = "food",

  },

  ["bagienneseed"] =
  {
    label = "Swamp Herb Seeds",
    description = "Typical seeds",
    weight = 0.01,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/bagienneseed.png",
    type = "item_standard",
    category = "herbs",

  },

  ["pickaxe"] =
  {
    label = "Pickaxe",
    description = "Use this to mine",
    weight = 1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 2,
    imgsrc = "items/double-bit-hatchet.png",
    type = "item_standard",
    category = "tools",

  },

  ["bagienneziele"] =
  {
    label = "Swamp Herb",
    description = "Herb of the Swamps",
    weight = 0.15,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 20,
    imgsrc = "items/bagienneziele.png",
    type = "item_standard",
    category = "herbs",

  },

  ["bagienneziele_pro"] =
  {
    label = "Swamp Herb Cigarettes",
    description = "Twisted herbs of the swamps",
    weight = 0.1,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/bagienneziele_pro.png",
    type = "item_standard",
    category = "herbs",

  },

  ["capocollo"] =
  {
    label = "Capocollo",
    description = "Also known as Capicola or Gabagool.",
    weight = 0.05,
    canBeDropped = true,
    canBeUsed = true,
    requireLvl = 0,
    limit = 10,
    imgsrc = "items/cooked_meat.png",
    type = "item_standard",
    category = "food",

  },


  ["WEAPON_MELEE_LANTERN_ELECTRIC"] =
  {
    label = "Electric Lamp",
    description = "A source of light, fire & fun",
    weight = 0.5,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("weapon_melee_davy_lantern"),
    imgsrc = "items/weapon_melee_electric_lantern.png",
    type = "item_weapon",
    category = "tools",
  },




  ["WEAPON_MELEE_TORCH"] =
  {
    label = "Torch",
    description = "Great for travelers scared of the dark",
    weight = 0.4,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_MELEE_TORCH"),
    imgsrc = "items/WEAPON_MELEE_TORCH.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_FISHINGROD"] =
  {
    label = "Rod",
    description = "A mans second best friend",
    weight = 0.9,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_FISHINGROD"),
    imgsrc = "items/WEAPON_FISHINGROD.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_MELEE_HATCHET"] =
  {
    label = "Hatchet",
    description = "Uses include: Trees, Building, Fireplaces & Humans",
    weight = 1.0,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_MELEE_HATCHET"),
    imgsrc = "items/WEAPON_MELEE_HATCHET.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_MELEE_CLEAVER"] =
  {
    label = "Cleaver",
    description = "Keep out of reach of kids",
    weight = 1.0,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_MELEE_CLEAVER"),
    imgsrc = "items/WEAPON_MELEE_CLEAVER.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_MELEE_KNIFE"] =
  {
    label = "Knife",
    description = "Thats not a knife, this is a knife.",
    weight = 0.5,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_MELEE_KNIFE"),
    imgsrc = "items/WEAPON_MELEE_KNIFE.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_THROWN_THROWING_KNIVES"] =
  {
    label = "Throwing Knives",
    description = "Throw me, ill hurt.",
    weight = 0.2,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_THROWN_THROWING_KNIVES"),
    imgsrc = "items/WEAPON_THROWN_THROWING_KNIVES.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_MELEE_KNIFE_MINER"] =
  {
    label = "Mining Knife",
    description = "An old mining knife, quite large and heavy",
    weight = 0.7,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_MELEE_KNIFE_MINER"),
    imgsrc = "items/WEAPON_MELEE_KNIFE_MINER.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_MELEE_KNIFE_VAMPIRE"] =
  {
    label = "Decorated Dagger",
    description = "A symbol of designer tastes",
    weight = 1.0,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_MELEE_KNIFE_VAMPIRE"),
    imgsrc = "items/WEAPON_MELEE_KNIFE_VAMPIRE.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_LASSO"] =
  {
    label = "Lasso",
    description = "Capture, drag & bind.",
    weight = 0.6,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_LASSO"),
    imgsrc = "items/WEAPON_LASSO.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_THROWN_TOMAHAWK"] =
  {
    label = "Tomahawk",
    description = "The weapon of the Native tribes.",
    weight = 0.4,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_THROWN_TOMAHAWK"),
    imgsrc = "items/WEAPON_THROWN_TOMAHAWK.png",
    type = "item_weapon",
    category = "tools",
  },




  ["WEAPON_PISTOL_M1899"] =
  {
    label = "Pistol M1899",
    description = "A standard cost effective killing machine",
    weight = 0.8,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_PISTOL_M1899"),
    imgsrc = "items/WEAPON_PISTOL_M1899.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_PISTOL_MAUSER"] =
  {
    label = "Pistol Mauser",
    description = "A must for any advanced warfare",
    weight = 0.6,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_PISTOL_MAUSER"),
    imgsrc = "items/WEAPON_PISTOL_MAUSER.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_PISTOL_MAUSER_DRUNK"] =
  {
    label = "Decorated Mauser",
    description = "Gold, silver & metal... what a treat",
    weight = 0.8,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_PISTOL_MAUSER_DRUNK"),
    imgsrc = "items/WEAPON_PISTOL_MAUSER.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_PISTOL_SEMIAUTO"] =
  {
    label = "Pistol Semi-Automatic",
    description = "Goes bang more then once",
    weight = 0.6,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_PISTOL_SEMIAUTO"),
    imgsrc = "items/WEAPON_PISTOL_SEMIAUTO.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_PISTOL_VOLCANIC"] =
  {
    label = "Pistol Volcanic",
    description = "WARNING: Does not shoot lava",
    weight = 0.7,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_PISTOL_VOLCANIC"),
    imgsrc = "items/WEAPON_PISTOL_VOLCANIC.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_REPEATER_CARBINE"] =
  {
    label = "Repeated Carbine",
    description = "Medium range, high damage.",
    weight = 2.0,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REPEATER_CARBINE"),
    imgsrc = "items/WEAPON_REPEATER_CARBINE.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_REPEATER_EVANS"] =
  {
    label = "Repeater Evans",
    description = "A feat in weapon mechanics",
    weight = 2.5,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REPEATER_EVANS"),
    imgsrc = "items/WEAPON_REPEATER_CARBINE.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_REPEATER_HENRY"] =
  {
    label = "Litchfield Bolt-Action Rifle",
    description = "Great range & accuracy",
    weight = 2.3,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REPEATER_HENRY"),
    imgsrc = "items/WEAPON_REPEATER_HENRY.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_RIFLE_VARMINT"] =
  {
    label = "Light Rifle",
    description = "Ride & Shoot!",
    weight = 1.5,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_RIFLE_VARMINT"),
    imgsrc = "items/WEAPON_REPEATER_HENRY.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_REPEATER_WINCHESTER"] =
  {
    label = "Lancaster Bolt-Action Rifle",
    description = "The famous lancaster",
    weight = 1.9,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REPEATER_WINCHESTER"),
    imgsrc = "items/weapon_repeater_lancaster.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_REVOLVER_CATTLEMAN"] =
  {
    label = "Revolver Cattleman",
    description = "Its high noon!",
    weight = 0.4,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REVOLVER_CATTLEMAN"),
    imgsrc = "items/WEAPON_REVOLVER_CATTLEMAN.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_REVOLVER_CATTLEMAN_JOHN"] =
  {
    label = "Revolver Cattleman",
    description = "Its high noon!",
    weight = 0.5,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REVOLVER_CATTLEMAN_JOHN"),
    imgsrc = "items/WEAPON_REVOLVER_CATTLEMAN.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_REVOLVER_CATTLEMAN_MEXICAN"] =
  {
    label = "Revolver Cattleman",
    description = "Its high noon!",
    weight = 0.5,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REVOLVER_CATTLEMAN_MEXICAN"),
    imgsrc = "items/WEAPON_REVOLVER_CATTLEMAN.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_REVOLVER_DOUBLEACTION"] =
  {
    label = "Double Action Revolver",
    description = "Double the action, same weight.",
    weight = 0.8,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REVOLVER_DOUBLEACTION"),
    imgsrc = "items/WEAPON_REVOLVER_DOUBLEACTION.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_REVOLVER_DOUBLEACTION_EXOTIC"] =
  {
    label = "Exotic Double Action Revolver",
    description = "Just a bit more exotic*",
    weight = 0.8,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REVOLVER_DOUBLEACTION_EXOTIC"),
    imgsrc = "items/WEAPON_REVOLVER_DOUBLEACTION.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_REVOLVER_DOUBLEACTION_GAMBLER"] =
  {
    label = "Self-Locking Revolver",
    description = "Dont forget to lock...",
    weight = 0.8,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REVOLVER_DOUBLEACTION_GAMBLER"),
    imgsrc = "items/WEAPON_REVOLVER_DOUBLEACTION.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_REVOLVER_LEMAT"] =
  {
    label = "LeMat Revolver",
    description = "I think its french, it does go bang!",
    weight = 0.9,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REVOLVER_LEMAT"),
    imgsrc = "items/lemat-revolver.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_REVOLVER_SCHOFIELD"] =
  {
    label = "Revolver Schofield",
    description = "Great for prison breaks",
    weight = 0.7,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REVOLVER_SCHOFIELD"),
    imgsrc = "items/WEAPON_REVOLVER_SCHOFIELD.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_REVOLVER_SCHOFIELD_GOLDEN"] =
  {
    label = "Navy Revolver",
    description = "Just a typical revolver that is Navy",
    weight = 0.8,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REVOLVER_NAVY"),
    imgsrc = "items/WEAPON_REVOLVER_SCHOFIELD_GOLDEN.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_REVOLVER_SCHOFIELD_CALLOWAY"] =
  {
    label = "Engraved Schofield",
    description = "Unreadable engravings",
    weight = 0.6,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_REVOLVER_SCHOFIELD_CALLOWAY"),
    imgsrc = "items/WEAPON_REVOLVER_SCHOFIELD.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_RIFLE_BOLTACTION"] =
  {
    label = "Bolt Action Rifle",
    description = "Jams a lot, but works well when it doesnt.",
    weight = 2.3,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_RIFLE_BOLTACTION"),
    imgsrc = "items/WEAPON_RIFLE_BOLTACTION.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_SNIPERRIFLE_CARCANO"] =
  {
    label = "Carcano Rifle",
    description = "Range is the key!",
    weight = 4.0,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_SNIPERRIFLE_CARCANO"),
    imgsrc = "items/WEAPON_SNIPERRIFLE_CARCANO.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_SNIPERRIFLE_ROLLINGBLOCK"] =
  {
    label = "Rotary Rifle",
    description = "Line em up 500 metres away!",
    weight = 4.0,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_SNIPERRIFLE_ROLLINGBLOCK"),
    imgsrc = "items/WEAPON_SNIPERRIFLE_ROLLINGBLOCK.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_SNIPERRIFLE_ROLLINGBLOCK_EXOTIC"] =
  {
    label = "Decorated Rifle",
    description = "Looks nice, probably still goes bang",
    weight = 4.0,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_SNIPERRIFLE_ROLLINGBLOCK_EXOTIC"),
    imgsrc = "items/WEAPON_SNIPERRIFLE_ROLLINGBLOCK.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_RIFLE_SPRINGFIELD"] =
  {
    label = "Springfield Rifle",
    description = "Military standard",
    weight = 2.0,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_RIFLE_SPRINGFIELD"),
    imgsrc = "items/WEAPON_RIFLE_SPRINGFIELD.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_SHOTGUN_DOUBLEBARREL"] =
  {
    label = "Double Action Shotgun",
    description = "Poorly designed, does the trick though.",
    weight = 3.0,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_SHOTGUN_DOUBLEBARREL"),
    imgsrc = "items/WEAPON_SHOTGUN_DOUBLEBARREL.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC"] =
  {
    label = "Decorated Gun",
    description = "Close range death machine",
    weight = 3.0,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC"),
    imgsrc = "items/WEAPON_SHOTGUN_DOUBLEBARREL.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_SHOTGUN_PUMP"] =
  {
    label = "Pump Shotgun",
    description = "WARNING: May mutilate",
    weight = 2.5,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_SHOTGUN_PUMP"),
    imgsrc = "items/WEAPON_SHOTGUN_PUMP.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_SHOTGUN_REPEATING"] =
  {
    label = "Repeating Shotgun",
    description = "Dont shoot too fast, you might jam it!",
    weight = 2.0,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_SHOTGUN_REPEATING"),
    imgsrc = "items/WEAPON_SHOTGUN_REPEATING.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_SHOTGUN_SAWEDOFF"] =
  {
    label = "Sawn-Off Shotgun",
    description = "Compact, high damage & close range",
    weight = 1.2,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_SHOTGUN_SAWEDOFF"),
    imgsrc = "items/WEAPON_SHOTGUN_SAWEDOFF.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_SHOTGUN_SEMIAUTO"] =
  {
    label = "Semi-Automatic Shotgun",
    description = "This may just save your life one day",
    weight = 2.2,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_SHOTGUN_SEMIAUTO"),
    imgsrc = "items/WEAPON_SHOTGUN_SEMIAUTO.png",
    type = "item_weapon",
    category = "tools",
  },



  ["WEAPON_BOW"] =
  {
    label = "Simple Bow",
    description = "A hunting bow",
    weight = 0.7,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_BOW"),
    imgsrc = "items/WEAPON_BOW.png",
    type = "item_weapon",
    category = "tools",
  },


  ["WEAPON_THROWN_DYNAMITE"] =
  {
    label = "Dynamite",
    description = "This baby will blow up in 3 seconds...",
    weight = 0.3,
    canBeDropped = true,
    canBeUsed = false,
    requireLvl = 0,
    limit = 8,
    imgsrc = "items/WEAPON_THROWN_DYNAMITE.png",
    type = "item_standard",
    category = "tools",
  },



  ["WEAPON_THROWN_MOLOTOV"] =
  {
    label = "Molotov",
    description = "A poor mans grenade",
    weight = 0.5,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_THROWN_MOLOTOV"),
    imgsrc = "items/WEAPON_THROWN_MOLOTOV.png",
    type = "item_weapon",
    category = "tools",
  },

  ["WEAPON_KIT_BINOCULARS"] =
  {
    label = "Binoculars",
    description = "Left lens quite scratched...",
    weight = 0.5,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("WEAPON_KIT_BINOCULARS"),
    imgsrc = "items/WEAPON_KIT_BINOCULARS.png",
    type = "item_weapon",
    category = "tools",
  },


  ["weapon_moonshinejug_mp"] =
  {
    label = "Moonshine Jug",
    description = "Pour and burn baby...",
    weight = 0.5,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("weapon_moonshinejug_mp"),
    imgsrc = "items/weapon_moonshinejug.png",
    type = "item_weapon",
    category = "tools",
  },

  ["weapon_thrown_bolas"] =
  {
    label = "Bolas",
    description = "Throw at enemy, problem solved",
    weight = 0.5,
    canBeDropped = true,
    requireLvl = 0,
    weaponHash = GetHashKey("weapon_thrown_bolas"),
    imgsrc = "items/bolas-thrown.png",
    type = "item_weapon",
    category = "tools",
  },



-- Farming Plugin
["aloeseed"] =
{
  label = "Aloe Vera mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
},
["agaveseed"] =
{
  label = "Agávé mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["wintergreenseed"] =
{
  label = "Kúszó fajdbogyó mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["huckleberryseed"] =
{
  label = "Áfonyabokor mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["burdockseed"] =
{
  label = "Bojtorján mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["bulrushseed"] =
{
  label = "Nád mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["blackcurrantseed"] =
{
  label = "Fekete Ribiszke mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["alaskanginseed"] =
{
  label = "Alaszkai Ginzeng mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["yarrowseed"] =
{
  label = "Vörös Cickafark mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["wildmintseed"] =
{
  label = "Vad Menta mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["viosnwdrpseed"] =
{
  label = "Kikeleti Hóvirág mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["thymeseed"] =
{
  label = "Kakukkfű mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["redsageseed"] =
{
  label = "Vörösgyökerű zsálya mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["prariepoppyseed"] =
{
  label = "Vadmák mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["orleanderseed"] =
{
  label = "Leander mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["oreganoseed"] =
{
  label = "Oregánó mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["texasbonseed"] =
{
  label = "Kék Csillagfürt mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["wisteriaseed"] =
{
  label = "Lilaakác mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["agaritaseed"] =
{
  label = "Agarita mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["wrhubarbseed"] =
{
  label = "Vad Rebarbara mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["chocdaisyseed"] =
{
  label = "Csokoládé Virág mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["cardinalflowerseed"] =
{
  label = "Tűzpiros Lobélia mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["bloodflowerseed"] =
{
  label = "Selyembokor mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["bitterweedseed"] =
{
  label = "Sárga Őzsirózsa mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["milkweedseed"] =
{
  label = "Selyemkóró mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["indtobaccoseed"] =
{
  label = "Indián Dohány mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["humbirdsageseed"] =
{
  label = "Hummingbird Zsálya mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["goldencurrantseed"] =
{
  label = "Arany ribiszke mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["feverfewseed"] =
{
  label = "Őszi margitvirág mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["engmaceseed"] =
{
  label = "Cickafark mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["desertsageseed"] =
{
  label = "Sivatagi Zsálya mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["garlicseed"] =
{
  label = "Fokhagyma mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["tobaccoseed"] =
{
  label = "Dohánymag",
  description = "Virginia dohány, Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["potatoseed"] =
{
  label = "Burgonya mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["btobaccoseed"] =
{
  label = "Dohánymag",
  description = "Burnley dohány, Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["wheatseed"] =
{
  label = "Búza mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["carrotseed"] =
{
  label = "Répa mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["carrot3seed"] =
{
  label = "Kis répa mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["lettuceseed"] =
{
  label = "Saláta mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["ginsengseed"] =
{
  label = "Ginseng mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["berryseed"] =
{
  label = "Málna mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["bberryseed"] =
{
  label = "Szeder mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["artichokeseed"] =
{
  label = "Articsóka mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["cottonseed"] =
{
  label = "Gyapot mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["sugarcaneseed"] =
{
  label = "Cukornád mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["cornseed"] =
{
  label = "Kukorica mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["broccoliseed"] =
{
  label = "Brokkoli mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["tomatoseed"] =
{
  label = "Paradicsom mag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["seedlingseed"] =
{
  label = "Növénymag",
  description = "Vetőmag",
  weight = 0.001,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 50,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["wheat"] =
{
  label = "Búza",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/wheat.png",
  type = "item_standard",
  category = "food",

},
["hay"] =
{
  label = "Szalma",
  description = "Termék, abrak",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/hay.png",
  type = "item_standard",
  category = "food",


},
["apple"] =
{
  label = "Alma",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/apple.png",
  type = "item_standard",
  category = "food",


},
["barack"] =
{
  label = "Barack",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/barack.png",
  type = "item_standard",
  category = "food",
},
["artichoke"] =
{
  label = "Articsóka",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/artichoke.png",
  type = "item_standard",
  category = "food",
},
["broccoli"] =
{
  label = "Brokkoli",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/broccoli.png",
  type = "item_standard",
  category = "food",
},
["carrot"] =
{
  label = "Répa",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/carrot.png",
  type = "item_standard",
  category = "food",
},
["corn"] =
{
  label = "Kukorica",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/corn.png",
  type = "item_standard",
  category = "food",
},
["cotton"] =
{
  label = "Gyapot",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/cotton.png",
  type = "item_standard",
  category = "food",
},
["btobacco"] =
{
  label = "Burnley dohánylevél",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/btobacco.png",
  type = "item_standard",
  category = "food",
},
["tobacco"] =
{
  label = "Dohánylevél",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/tobacco.png",
  type = "item_standard",
  category = "food",
},
["tomato"] =
{
  label = "Paradicsom",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/tomato.png",
  type = "item_standard",
  category = "food",
},
["potato"] =
{
  label = "Burgonya",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/potato.png",
  type = "item_standard",
  category = "food",
},
["seedling"] =
{
  label = "Növény",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/seed.png",
  type = "item_standard",
  category = "food",
},
["lettuce"] =
{
  label = "Saláta",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/lettuce.png",
  type = "item_standard",
  category = "food",
},
["ginseng"] =
{
  label = "Ginzeng",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/ginseng.png",
  type = "item_standard",
  category = "food",
},
["berry"] =
{
  label = "Málna",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/berry.png",
  type = "item_standard",
  category = "food",
},
["bberry"] =
{
  label = "Szeder",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/bberry.png",
  type = "item_standard",
  category = "food",
},
["sugar"] =
{
  label = "Cukor",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = true,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/sugar.png",
  type = "item_standard",
  category = "food",
},
["garlic"] =
{
  label = "Fokhagyma",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/garlic.png",
  type = "item_standard",
  category = "food",
},
["desertsage"] =
{
  label = "Sivatagi Zsálya",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/desertsage.png",
  type = "item_standard",
  category = "food",
},
["engmace"] =
{
  label = "Cickafark",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/engmace.png",
  type = "item_standard",
  category = "food",
},
["feverfew"] =
{
  label = "Őszi margitvirág",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/feverfew.png",
  type = "item_standard",
  category = "food",
},
["goldencurrant"] =
{
  label = "Arany ribiszke",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/goldencurrant.png",
  type = "item_standard",
  category = "food",
},
["humbirdsage"] =
{
  label = "Hummingbird Zsálya",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/humbirdsage.png",
  type = "item_standard",
  category = "food",
},
["indtobacco"] =
{
  label = "Indián Dohány",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/indtobacco.png",
  type = "item_standard",
  category = "food",
},
["milkweed"] =
{
  label = "Selyemkóró",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/milkweed.png",
  type = "item_standard",
  category = "food",
},
["bitterweed"] =
{
  label = "Sárga Őzsirózsa",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/bitterweed.png",
  type = "item_standard",
  category = "food",
},
["bloodflower"] =
{
  label = "Selyembokor",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/bloodflower.png",
  type = "item_standard",
  category = "food",
},
["cardinalflower"] =
{
  label = "Tűzpiros Lobélia",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/cardinalflower.png",
  type = "item_standard",
  category = "food",
},
["chocdaisy"] =
{
  label = "Csokoládé virág",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/chocdaisy.png",
  type = "item_standard",
  category = "food",
},
["wrhubarb"] =
{
  label = "Vad Rebarbara",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/wrhubarb.png",
  type = "item_standard",
  category = "food",
},
["agarita"] =
{
  label = "Agarita",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/agarita.png",
  type = "item_standard",
  category = "food",
},
["wisteria"] =
{
  label = "Lilaakác",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/wisteria.png",
  type = "item_standard",
  category = "food",
},
["texasbon"] =
{
  label = "Kék Csillagfürt",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/texasbon.png",
  type = "item_standard",
  category = "food",
},
["oregano"] =
{
  label = "Oregánó",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/oregano.png",
  type = "item_standard",
  category = "food",
},
["orleander"] =
{
  label = "Leander",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/orleander.png",
  type = "item_standard",
  category = "food",
},
["prariepoppy"] =
{
  label = "Vadmák",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/prariepoppy.png",
  type = "item_standard",
  category = "food",
},
["redsage"] =
{
  label = "Vörösgyökerű zsálya",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/redsage.png",
  type = "item_standard",
  category = "food",
},
["thyme"] =
{
  label = "Kakukkfű",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/thyme.png",
  type = "item_standard",
  category = "food",
},
["viosnwdrp"] =
{
  label = "Kikeleti Hóvirág",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/viosnwdrp.png",
  type = "item_standard",
  category = "food",
},
["wildmint"] =
{
  label = "Vad Menta",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/wildmint.png",
  type = "item_standard",
  category = "food",
},
["yarrow"] =
{
  label = "Vörös Cickafark",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/yarrow.png",
  type = "item_standard",
  category = "food",
},
["alaskangin"] =
{
  label = "Alaszkai Ginzeng",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/alaskangin.png",
  type = "item_standard",
  category = "food",
},
["blackcurrant"] =
{
  label = "Fekete Ribiszke",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/blackcurrant.png",
  type = "item_standard",
  category = "food",
},
["bulrush"] =
{
  label = "Nádszál",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/bulrush.png",
  type = "item_standard",
  category = "food",
},
["burdock"] =
{
  label = "Bojtorján",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/burdock.png",
  type = "item_standard",
  category = "food",
},
["huckleberry"] =
{
  label = "Áfonya",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/huckleberry.png",
  type = "item_standard",
  category = "food",
},
["wintergreen"] =
{
  label = "Kúszó fajdbogyó",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/wintergreen.png",
  type = "item_standard",
  category = "food",
},
["agave"] =
{
  label = "Agávé",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/agave.png",
  type = "item_standard",
  category = "food",
},
["aloe"] =
{
  label = "Aloe Vera",
  description = "Termék, alapanyag",
  weight = 0.01,
  canBeDropped = true,
  canBeUsed = false,
  requireLvl = 0,
  limit = 100,
  imgsrc = "items/aloe.png",
  type = "item_standard",
  category = "food",
},

}
