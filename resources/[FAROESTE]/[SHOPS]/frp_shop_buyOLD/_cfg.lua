Config = {}

Config.ShopDatas = {
	-- level, dollar, gold
	-- {
	{
		name = "Arsenal",
		{
			{"revolver_doubleaction", 0, 0, 0},
			{"rifle_springfield", 0, 0, 0},
			{"ammo_revolver", 0, 0, 0},
			{"ammo_rifle", 0, 0, 0},
			{"ammo_repeater", 0, 0, 0},
			{"melee_torch", 0, 0, 0},
			{"lasso", 0, 0, 0},
			{"melee_knife", 0, 0, 0},
		}
	},
	{
		name = "Armeiro",
		{
			{"melee_knife", 0, 500, 1},---------------------------
			{"revolver_doubleaction", 0, 3200, 10},---------------
			{"revolver_cattleman", 0, 5000, 10},------------------
			{"revolver_lemat", 0, 12000, 25},---------------------
			{"revolver_schofield", 0, 8600, 30},------------------
			{"revolver_navy", 0, 11000, 35},----------------------
			{"pistol_volcanic", 0, 8600, 30},---------------------
			{"pistol_mauser", 0, 8200, 28},-----------------------
			{"pistol_semiauto", 0, 7600, 20},---------------------
			{"repeater_carbine", 0, 6400, 15},--------------------
			{"repeater_evans", 0, 7000, 35}, ---------------------
			{"repeater_winchester", 0, 7800, 30},-----------------
			{"repeater_henry", 0, 8000, 45},----------------------
			{"rifle_varmint", 0, 4000, 35},------------------------
			{"rifle_boltaction", 0, 9000, 60},---------------------
			{"rifle_springfield", 0, 9000, 40},-------------------
			{"shotgun_doublebarrel", 0, 17000, 80},---------------
			{"shotgun_sawedoff", 0, 12000, 65},-------------------
			{"sniperrifle_rollingblock", 0, 14000, 70}------------
		}
    },
	{
		name = "Porto de BlackWater",
		{
			{"corpodevaqueiro", 0, 1000, 1},
			{"corpodeacaodupla", 0, 300, 1},
			{"corpodelemat", 0, 3000, 1},
			{"corpodeschotfield", 0, 2700, 1},
			{"corpodenavy", 0, 3500, 1},

			{"corpodevolcanic", 0, 3000, 1},
			{"corpodemauser", 0, 2800, 1},
			{"corpodesemiauto", 0, 2500, 1},

			{"corpodecarabina", 0, 1500, 1},
			{"corpodeevans", 0, 1800, 1},
			{"corpodehenry", 0, 2100, 1},
			{"corpodelancaster", 0, 2000, 1},

			{"corpodeferrolho", 0, 2400, 1},
			{"corpodespringfield", 0, 2200, 1},

			{"corpoderolling", 0, 4200, 1},

			{"corpodeescopeta", 0, 3550, 1},
			{"corpodeserrada", 0, 3000, 1},

			{"sacopolvora", 0, 3000, 1},
			{"caixacartuchos", 0, 3000, 1},
		}
	},
	{
		name = "Sementes",
		{
			{"cornseed", 0, 6, 1},
			{"cenouraseed", 0, 5, 1},
			{"feijaoseed", 0, 6, 1},
			{"sugarcaneseed", 0, 6, 1},
			{"trigoseed", 0, 6, 1},
			{"batataseed", 0, 6, 1},
			{"tomateseed", 0, 5, 1},
			{"repolhoseed", 0, 5, 1},
			{"alfaceseed", 0, 5, 1},
		}
	},
	{
		name = "Clive",
		{
			{"tobaccoseed", 0, 5, 1},								
			{"sugarcaneseed", 0, 6, 1},
			{"lupuloseed", 0, 5, 1},
			{"papolaseed", 0, 15, 1},
		}
	},
	{
		name = "Carteiro",
		{
			{"pigeonpost", 0, 500, 30},
			{"notepad", 0, 6, 1}
		}
	},
	--[[{
		name = "Capitão",
		{
			{"medicine_poor", 1, 1000, 100},
			{"stimulant_poor", 1, 1000, 100},
			{"flask", 1, 10, 2},
		}
	},]]
	{
		name = "Mark",
		{
			{"feijaolata", 0, 90, 1},
			{"milholata", 0, 90, 1},
			{"sopa", 0, 700, 1},
			{"sopadecarne", 0, 790, 1},
			{"molhotomate", 0, 70, 1},
			{"wateringcan", 0, 100, 1},
		}
	},
	{
		name = "Terry",
		{
			{"lasso", 0, 500, 10},
			{"melee_knife", 0, 400, 1},
			{"agua", 0, 6, 1},
			{"ferramentas", 0, 1000, 1},
			{"wateringcan", 0, 100, 1},
		}
	},
	{
		name = "Thomas",
		{
			{"lasso", 0, 500, 10},
			{"agua", 1, 500, 1},
			{"melee_knife", 1, 6, 1}
		}
	},
	{
		name = "Charles",
		{
			{"cerveja", 1, 170, 1},
			{"whisky", 1, 220, 1},
			{"agua", 1, 80, 1},
		}
	}
}

Config.ShopLocations = {
	-- x, y, z, heading(optional)
	
	["Arsenal"] = {
		{-764.927,-1272.443,44.041}, -- BlackWater
		{-1813.949,-354.912,164.649}, -- Strawberry
		{-278.437,805.132,119.380}, -- Valentine
		{1361.049,-1305.521,77.761}, -- Rhodes
		{2494.479,-1304.272,48.954}, -- Saint Denis
		{2906.995,1315.255,44.938}, -- Annesburg
		{-3622.943,-2600.530,-13.342}, -- Armadillo
		{-5526.657,-2928.446,-1.361}, -- Tumbleweed
	},

	["Carteiro"] = {
		{-875.067,-1328.737,43.958},
		{-179.030,626.742,114.090},
		{1522.069,439.479,90.681},
		{1225.592,-1293.857,76.909},
		{-3733.931,-2597.845,-12.927},
		{-1095.692,-576.687,82.407},
	},

	--[[["Capitão"] = {
		{794.514,-1241.300,45.826} -- Próximo a Rhodes em um Barco
	},]]

	["Porto de BlackWater"] = {
		{-732.461,-1227.509,44.734} -- BlackWater
	},
	
	["Sementes"] = {
		{-783.899,-1326.072,43.888}, -- BlackWater
		{-321.619,799.736,117.882} -- Valentine
	},
	["Clive"] = {
		{-783.899,-1326.072,43.888}, -- Sementes "Ilegais"
	},
	["Mark"] = {
		{-322.255,803.602,117.882} -- Armazém de Valentine
	},
	["Terry"] = {
		{-784.457,-1323.834,43.884} -- Armazém de Blackwater
	},
	["Thomas"] = {
		{-1791.571,-387.511,159.339} -- Armazém de Strawberry
	},
	["Charles"] = {
		{-311.569,805.882,118.980} -- Saloon de Valentine
	},
	["Armeiro"] = {
		{-279.248,780.535,118.504}, -- VALENTINE
		{2717.618,-1284.861,48.631}, -- SAINT DENIS
		{1325.508,-1321.458,76.890} -- RHODES
	},
}

Config.Charles = {
	-- x, y, z, heading(optional)
	
	--[[["Charles"] = {
		{-311.569,805.882,118.980} -- Saloon de Valentine
	},
	["Armeiro"] = {
		{-279.248,780.535,118.504}, -- VALENTINE
		{2717.618,-1284.861,48.631}, -- SAINT DENIS
		{1325.508,-1321.458,76.890} -- RHODES
	},]]

	["Arsenal"] = {
		{-764.927,-1272.443,44.041}, -- BlackWater
		{-1813.949,-354.912,164.649}, -- Strawberry
		{-278.437,805.132,119.380}, -- Valentine
		{1361.049,-1305.521,77.761}, -- Rhodes
		{2494.479,-1304.272,48.954}, -- Saint Denis
		{2906.995,1315.255,44.938}, -- Annesburg
		{-3622.943,-2600.530,-13.342}, -- Armadillo
		{-5526.657,-2928.446,-1.361}, -- Tumbleweed
	},

	["Carteiro"] = {
		{-875.067,-1328.737,43.958},
		{-179.030,626.742,114.090},
		{1522.069,439.479,90.681},
		{1225.592,-1293.857,76.909},
		{-3733.931,-2597.845,-12.927},
		{-1095.692,-576.687,82.407},
	},

	--[[["Capitão"] = {
		{794.514,-1241.300,45.826} -- Próximo a Rhodes em um Barco
	},]]

	["Porto de BlackWater"] = {
		{-732.461,-1227.509,44.734} -- BlackWater
	},
	
	["Sementes"] = {
		{-783.899,-1326.072,43.888}, -- BlackWater
		{-321.619,799.736,117.882} -- Valentine
	},
	["Clive"] = {
		{-783.899,-1326.072,43.888}, -- Sementes "Ilegais"
	},
	["Mark"] = {
		{-322.255,803.602,117.882} -- Armazém de Valentine
	},
	["Terry"] = {
		{-784.457,-1323.834,43.884} -- Armazém de Blackwater
	},
	["Thomas"] = {
		{-1791.193,-386.928,160.334} -- Armazém de Strawberry
	},
	["Charles"] = {
		{-311.569,805.882,118.980} -- Saloon de Valentine
	},
	["Armeiro"] = {
		{-279.248,780.535,118.504}, -- VALENTINE
		{2717.618,-1284.861,48.631}, -- SAINT DENIS
		{1325.508,-1321.458,76.890} -- RHODES
	},
}
