Config = {}

Config.ShopDatas = {
	{
		name = "Venda Mercado Geral",
		{
			-- {"tobacco", 100, 40, 10},
			-- {"corn", 100, 40, 10},
			-- {"sugarcane", 100, 40, 10}
			{"tobacco", 100, 10},
			{"milho", 45,  5},
			{"sugarcane", 100,  10}
		}
	},
	{
		name = "Acogueiro",
		{
			-- {"meat", 80, 32, 1},
			-- {"feather_1", 100, 40, 5},
			-- {"feather_2", 100, 40, 5}
			{"meat", 78, 1},
			{"meat_poor", 78, 1},
			{"meat_good", 137, 1},
			{"meat_perfect", 356, 1},
			{"feather_1", 100, 5},
			{"feather_2", 100, 5}
		}
	},
	{
		name = "Vendas Sallon",
		{
			{"sopa", 310, 1},
			{"sopadecarne", 390, 1},
			{"cerveja", 50, 1},
			{"whisky", 60, 1},
		}
	},
	{
		name = "Posto de Troca",
		{
			-- {"raw_coal", 100, 40, 2},
			-- {"raw_iron", 200, 80, 2},
			-- {"raw_copper", 300, 120, 2}
			{"raw_coal", 100, 2},
			{"raw_iron", 200, 2},
			{"raw_copper", 300, 2}
		}
	}
}

Config.ShopLocations = {
	["Venda Mercado Geral"] = {
		{-325.513,803.713,117.882}
    },
	["Vendas Sallon"] = {
		{-313.014,811.530,118.979}
    },
	["Posto de Troca"] = {
		{3027.058, 561.334, 44.794}
	}
}
