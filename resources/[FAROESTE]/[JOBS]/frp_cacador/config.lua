Config = { }

Config.Language = {
    ["NotHoldingAnimal"] = "Você precisa estar carregando o animal",
    ["NotInTheButcher"] = "Eu não vou comprar este animal",
    ["AnimalSold"] = "Muito Obrigado!",
    ["AnimalBodyToFar"] = "Você deixou o animal longe demais!",
}

Config.ItemQuantity = {
    ["Max"] = 3,
    ["Min"] = 1
}

Config.Butchers = {
    {["butchername"] = "Açougueiro", ["pressToSell"] = "~e~ESPAÇO~q~ \nVender",  ["blip"] = -1665418949,  ["npcmodel"] = "S_M_M_UNIBUTCHERS_01",["coords"] = vector3(-1980.89, -1648.11, 115.60),["heading"] = 339.97,   ["radius"] = 3.0},
    {["butchername"] = "Açougueiro", ["pressToSell"] = "~e~ESPAÇO~q~ \nVender",  ["blip"] = -1665418949,  ["npcmodel"] = "S_M_M_UNIBUTCHERS_01",["coords"] = vector3(-339.084,767.199,115.581),["heading"] = 89.97,   ["radius"] = 3.0},
    {["butchername"] = "Açougueiro", ["pressToSell"] = "~e~ESPAÇO~q~ \nVender",  ["blip"] = -1665418949,  ["npcmodel"] = "U_M_M_VALBUTCHER_01",["coords"] = vector3(-3691.438, -2623.152, -14.75121),["heading"] = 0.46632757782936,["radius"] = 3.0},
    {["butchername"] = "Açougueiro", ["pressToSell"] = "~e~ESPAÇO~q~ \nVender",  ["blip"] = -1665418949,  ["npcmodel"] = "U_M_M_TumButcher_01",["coords"] = vector3(-5509.88, -2947.44, -2.88),["heading"] = 251.54911804199,["radius"] = 3.0},
	{["butchername"] = "Tribo Indígena", ["pressToSell"] = "~e~ESPAÇO~q~ \nVender",  ["blip"] = 327180499,["npcmodel"] = "MSP_NATIVE1_MALES_01",["coords"] = vector3(-2642.72, -1474.75, 144.84),["heading"] = 187.02,["radius"] = 3.0},
}

Config.Animals = {
    -- Animals
    [-1568716381] =  {["name"] = "Big Horn Ram",              ["givenItem"] = nil,      ["money"] = 20,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQuityMultiplier"] = 3.0,  ["poor"] = 1796037447,   ["good"] = -476045512,   ["perfect"] = 1795984405 },
    [-1963605336]  = {["name"] = "Buck",                      ["givenItem"] = nil,   	["money"] = 20,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 1603936352,   ["good"] = -868657362,   ["perfect"] = -702790226 },
    [1957001316]   = {["name"] = "Bull",                      ["givenItem"] = nil,  	["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 9293261,      ["good"] = -336086818,   ["perfect"] = -53270317 },
    [1110710183]   = {["name"] = "Deer",                      ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -662178186,   ["good"] = -1827027577,  ["perfect"] = -1035515486 },
    [-1003616053]  = {["name"] = "Duck",                      ["givenItem"] = nil,      ["money"] = 5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [1459778951]   = {["name"] = "Bald Eagle",                ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 569071378,    ["good"] = nil,          ["perfect"] = nil },
    [831859211]    = {["name"] = "Egret",                     ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [252669332]    = {["name"] = "American Red Fox",          ["givenItem"] = nil,      ["money"] = 15,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 1647012424,   ["good"] = 238733925,    ["perfect"] = 500722008 },
    [-1143398950]  = {["name"] = "Big Grey Wolf",             ["givenItem"] = nil,      ["money"] = 20,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 85441452,     ["good"] = 1145777975,   ["perfect"] = 653400939 },
    [-885451903]   = {["name"] = "Medium Grey Wolf",          ["givenItem"] = nil,      ["money"] = 15,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 85441452,  	 ["good"] = 1145777975,   ["perfect"] = 653400939 },
    [-829273561]   = {["name"] = "Small Grey Wolf",           ["givenItem"] = nil,      ["money"] = 15,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [1104697660]   = {["name"] = "Vulture",                   ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-407730502]   = {["name"] = "Snapping Turtle",           ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-466054788]   = {["name"] = "Wild Turkey",               ["givenItem"] = nil,      ["money"] = 5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-2011226991]  = {["name"] = "Wild Turkey",               ["givenItem"] = nil,      ["money"] = 5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-166054593]   = {["name"] = "Wild Turkey",               ["givenItem"] = nil,      ["money"] = 5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-229688157]   = {["name"] = "Water Snake",               ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-1790499186]  = {["name"] = "Snake Red Boa",             ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [1464167925]   = {["name"] = "Snake Fer-De-Lance",        ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [846659001]    = {["name"] = "Black-Tailed Rattlesnake",  ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [545068538]    = {["name"] = "Western Rattlesnake",       ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-1211566332]  = {["name"] = "Striped Skunk",             ["givenItem"] = nil,      ["money"] = 5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [40345436]     = {["name"] = "Merino Sheep",              ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 1729948479,   ["good"] = -1317365569,  ["perfect"] = 1466150167 },
    [-164963696]   = {["name"] = "Herring Seagull",           ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-1076508705]  = {["name"] = "Roseate Spoonbill",         ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [2023522846]   = {["name"] = "Dominique Rooster",         ["givenItem"] = nil,      ["money"] = 5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-466687768]   = {["name"] = "Red-Footed Booby",          ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-575340245]   = {["name"] = "Wester Raven",              ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [1458540991]   = {["name"] = "North American Racoon",     ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-541762431]   = {["name"] = "Black-Tailed Jackrabbit",   ["givenItem"] = nil,      ["money"] = 5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -662506832,   ["good"] = nil,          ["perfect"] = nil },
    [1755643085]   = {["name"] = "American Pronghorn Doe",    ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -983605026,   ["good"] = 554578289,    ["perfect"] = -1544126829 },
    [2079703102]   = {["name"] = "Greater Prairie Chicken",   ["givenItem"] = nil,      ["money"] = 5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 111224131,    ["good"] = nil,          ["perfect"] = nil },
    [-1414989025]  = {["name"] = "Wirginia Possum",           ["givenItem"] = nil,      ["money"] = 5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [1007418994]   = {["name"] = "Berkshire Pig",             ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -308965548,   ["good"] = -57190831,    ["perfect"] = -1102272634 },
    [14163224601]  = {["name"] = "Ring-Necked Pheasant",      ["givenItem"] = nil,      ["money"] = 5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -985299804,   ["good"] = nil,          ["perfect"] = nil },
    [1265966684]   = {["name"] = "American White Pelican",    ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-1797450568]  = {["name"] = "Blue And Yellow Macaw",     ["givenItem"] = nil,      ["money"] = 25,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [1654513481]   = {["name"] = "Panther",                   ["givenItem"] = nil,      ["money"] = 50,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 10,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 1584468323,   ["good"] = -395646254,   ["perfect"] = 1969175294 },
    [1205982615]   = {["name"] = "Californian Condor",        ["givenItem"] = nil,      ["money"] = 5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-2063183075]  = {["name"] = "Dominique Chicken",         ["givenItem"] = nil,      ["money"] = 5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-2073130256]  = {["name"] = "Double-Crested Cormorant",  ["givenItem"] = nil,      ["money"] = 6,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [90264823]     = {["name"] = "Cougar",                    ["givenItem"] = nil,   	["money"] = 25,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 10,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 1914602340,   ["good"] = 459744337,    ["perfect"] = -1791452194 },
    [480688259]    = {["name"] = "Coyote",                    ["givenItem"] = nil,      ["money"] = 5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -1558096473,  ["good"] = 1150939141,   ["perfect"] = -794277189 },
    [-564099192]   = {["name"] = "Whooping Crane",            ["givenItem"] = nil,      ["money"] = 7,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },   
    [457416415]    = {["name"] = "Gila Monster",              ["givenItem"] = nil,      ["money"] = 20,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-753902995]   = {["name"] = "Alpine Goat",               ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 699990316,    ["good"] = 1710714415,   ["perfect"] = -1648383828 },
    [723190474]    = {["name"] = "Canada Goose",              ["givenItem"] = nil,      ["money"] = 8,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-2145890973]  = {["name"] = "Ferruinous Hawk",           ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [1095117488]   = {["name"] = "Great Blue Heron",          ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-1854059305]  = {["name"] = "Green Iguana",              ["givenItem"] = nil,      ["money"] = 15,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-593056309]   = {["name"] = "Desert Iguana",             ["givenItem"] = nil,      ["money"] = 15,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [1751700893]   = {["name"] = "Peccary Pig",               ["givenItem"] = nil,      ["money"] = 10,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -99092070,    ["good"] = -1379330323,  ["perfect"] = 1963510418 },
    [386506078]    = {["name"] = "Common Loon",               ["givenItem"] = nil,      ["money"] = 8,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-1134449699]  = {["name"] = "American Muskrat",          ["givenItem"] = nil,      ["money"] = 7,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-861544272]   = {["name"] = "Great Horned Owl",          ["givenItem"] = nil,      ["money"] = 12,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [759906147]    = {["name"] = "North American Beaver",     ["givenItem"] = nil,      ["money"] = 12,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -1569450319,  ["good"] = -2059726619,  ["perfect"] = 854596618 },
    [-1295720802]  = {["name"] = "Small Alligator",           ["givenItem"] = nil,      ["money"] = 15,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -1202329112,  ["good"] = -1202329112,  ["perfect"] = -1202329112 },
    [-1797625440]  = {["name"] = "Armadillo",                 ["givenItem"] = nil,      ["money"] = 8,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -1797625440,  ["good"] = -1797625440,  ["perfect"] = -1797625440 },
    [-1170118274]  = {["name"] = "American Badger",           ["givenItem"] = nil,      ["money"] = 8,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -901307487,   ["good"] = nil,  ["perfect"] = nil },
    
    --PELTS
    [-2004866590]  = {["name"] = "Alligator",                 ["givenItem"] = nil,   	["money"] = 0.25,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,	["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,["perfectQualityMultiplier"] = 3.0,  	["poor"] = -2004866590,  ["good"] = -2004866590,  ["perfect"] = -2004866590 },
    [-1202329112]  = {["name"] = "Small Alligator",           ["givenItem"] = nil,   	["money"] = 0.20,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -1202329112,  ["good"] = -1202329112,  ["perfect"] = -1202329112 },
    [-1124266369]  = {["name"] = "Bear",                      ["givenItem"] = nil,   	["money"] = 0.50,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 15,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 957520252,    ["good"] = 143941906,    ["perfect"] = 1292673537 },
    [730092646]    = {["name"] = "American Black Bear",       ["givenItem"] = nil,   	["money"] = 0.25,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 1083865179,   ["good"] = 1490032862,   ["perfect"] = 663376218 },
    [1556473961]   = {["name"] = "Bison",                     ["givenItem"] = nil,   	["money"] = 0.20,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -1730060063,  ["good"] = -591117838,   ["perfect"] = -237756948 },
    [-2021043433]  = {["name"] = "Elk",                       ["givenItem"] = nil,   	["money"] = 0.20,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 2053771712,   ["good"] = 1181652728,   ["perfect"] = -1332163079 },
    [-1098441944]  = {["name"] = "Moose",                     ["givenItem"] = nil,   	["money"] = 0.5,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 10,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 1868576868,   ["good"] = 1636891382,   ["perfect"] = -217731719 },
    [556355544]    = {["name"] = "Angus Ox",                  ["givenItem"] = nil,   	["money"] = 0.2,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 4623248928,   ["good"] = 1208128650,   ["perfect"] = 659601266 },
    [-50684386]    = {["name"] = "Florida Cracker Cow",       ["givenItem"] = nil,   	["money"] = 0.2,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 334093551,    ["good"] = 1150594075,   ["perfect"] = -845037222 },
    [-1038420333]  = {["name"] = "Boar",                      ["givenItem"] = nil,   	["money"] = 0.15,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -1038420333,  ["good"] = -1038420333,  ["perfect"] = -1038420333 },

    --LEGENDARY
    [-368368059]  = {["name"] =  "Legendary Alligator",       ["givenItem"] = "osso",   	 ["money"] = 1.0,   ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0.20,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = -368368059,  ["good"] = -368368059,   ["perfect"] = -368368059 },
    [213792403]  = {["name"] =  "Legendary Tatanka",          ["givenItem"] = "osso",   	 ["money"] = 1.0,   ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0.20,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = 213792403,   ["good"] = 213792403,    ["perfect"] = 213792403 },

    -- Fish
    [-711779521]   = {["name"] = "Longnose Gar",              ["givenItem"] = "oleodepeixe",          ["money"] = 0.30,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0.20,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-1553593715]  = {["name"] = "Muskie",                    ["givenItem"] = "oleodepeixe",          ["money"] = 0.30,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0.20,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [-300867788]   = {["name"] = "Lake Sturgeon",             ["givenItem"] = "oleodepeixe",          ["money"] = 0.30,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0.20,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [1538187374]   = {["name"] = "Channel Catfish",           ["givenItem"] = "oleodepeixe",          ["money"] = 0.30,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0.20,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
    [697075200]    = {["name"] = "Northern Pike",             ["givenItem"] = "oleodepeixe",          ["money"] = 0.30,  ["gold"] = 0,  ["rolPoints"] = 0,  ["xp"] = 1,  ["poorQualityMultiplier"] = 0.20,  ["goodQualityMultiplier"] = 2.0,  ["perfectQualityMultiplier"] = 3.0,  ["poor"] = nil,          ["good"] = nil,          ["perfect"] = nil },
}