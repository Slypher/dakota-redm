Config = {}

Config.copsRequired = 2
Config.policeColor = {0,200,255}

Config.robberyInterval = 3600 -- time in seconds

Config.robberyStartKey = 'ENTER' -- X
Config.robberyCancelKey = 'U' -- Z

Config.MarkerColor = {
	r = 0, g = 200, b = 0
}

Config.moneyReward = {
	min = 10,
	max = 20,
	type = 'dollar' -- normal for for normal money, black for black_money
}

Config.ATMS = {
														-- VALENTINE
	{ id = 1,		x =		-324.17,		y =		804.11,			z = 117.882,	h = 280.57,		seconds = 60,	wasRobbed = 60 }, -- ARMAZEM
	{ id = 2,		x =		-288.108,		y =		804.965,		z = 119.386,	h = 280.57,		seconds = 60,	wasRobbed = 60 }, -- DOCTOR
	{ id = 3,		x =		-280.227,		y =		778.864,		z = 119.526,	h = 2.50,		seconds = 60,	wasRobbed = 60 }, -- ARMEIRO
	{ id = 4,		x =		-176.691,		y =		630.614,		z = 114.111,	h = 50.04,		seconds = 60,	wasRobbed = 60 }, -- ESTAÇÃO DE TREM VALENTINE
														-- BLACKWATER
	{ id = 5,		x =		-785.412,       y =     -1322.127,      z = 43.906,		h = 182.92,		seconds = 60,	wasRobbed = 60 }, -- ARMAZEM
	{ id = 6,		x =		-815.849,		y = 	-1364.406,		z = 43.773,		h = 267.0,		seconds = 60,	wasRobbed = 60 }, -- BARBEIRO
	{ id = 7,		x =		-762.834,		y = 	-1293.624,		z = 43.857,		h = 353.54,		seconds = 60,	wasRobbed = 60 }, -- ALFAIATE
	{ id = 8,		x =		-825.547,		y = 	-1323.500,		z = 47.900,		h = 45.36,		seconds = 60,	wasRobbed = 60 }, -- QUARTO SALOON
														-- STRAWBERRY
	{ id = 9,		x =		-1789.326,      y =     -387.355,       z = 160.229,	h = 60.66,		seconds = 60,	wasRobbed = 60 }, -- ARMAZEM
	

														-- VALENTINE BANK
	{ id = 10,		x =		-308.590,		y = 	765.279,		z = 118.725,	h = 13.65,		seconds = 60,	wasRobbed = 60 }, -- BANCO VALENTINE DIREITA
	{ id = 11,		x =		-308.976,		y = 	763.757,		z = 118.725,	h = 98.0,		seconds = 60,	wasRobbed = 60 }, -- BANCO VALENTINE CENTRO
	{ id = 12,		x =		-307.958,		y = 	762.751,		z =	118.725,	h = 189.94,		seconds = 60,	wasRobbed = 60 }, -- BANCO VALENTINE ESQUERDA

}
