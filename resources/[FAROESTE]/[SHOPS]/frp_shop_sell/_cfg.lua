Config = {}

Config.ShopDatas = {
	{
		name = "Negociar produção com Mark", -- Armazém de Valentine
		{
			{"milho", 11, 1},
			{"cenoura", 10, 1},
			{"trigo", 9, 1},
			{"batata", 10, 1},
			{"repolho", 9, 1},
			{"tomate", 10, 1},
			{"feijao", 10, 1},
			{"alface", 9, 1},
			{"canadeacucar", 10, 1},
			{"pao", 29, 1},
			{"biscoito", 20, 1},
			{"bolacha", 20, 1},
			{"milholata", 45, 1},
			{"feijaolata", 45, 1},
			{"sopa", 310, 1},
			{"sopacarne", 390, 1},
			{"molhotomate", 35, 1}
		}
	},
	{
		name = "Negociar produção com Terry", -- Armazém de Blackwater
		{
			{"milho", 11, 1},
			{"cenoura", 9, 1},
			{"trigo", 11, 1},
			{"batata", 9, 1},
			{"repolho", 11, 1},
			{"tomate", 11, 1},
			{"feijao", 8, 1},
			{"alface", 11, 1},
			{"canadeacucar", 11, 1}
		}
	},
	{
		name = "Negociar produção com Thomas", -- Armazém de Strawberry
		{
			{"milho", 10, 1},
			{"cenoura", 10, 1},
			{"trigo", 11, 1},
			{"batata", 10, 1},
			{"repolho", 9, 1},
			{"tomate", 9, 1},
			{"feijao", 11, 1},
			{"alface", 9, 1},
			{"canadeacucar", 11, 1}
		}
	},
	{
		name = "Negociar bebidas com Charles", -- Saloon de Valentine
		{
			{"cerveja", 50, 1},
			{"whisky", 60, 1}
		}
	},
	{
		name = "Negociar minérios com Bill", -- Venda de Minerios
		{
			{"minerioferro", 20, 1},
			{"mineriocobre", 30, 1},
			{"pedra", 20, 1}
		}
	},
	{
		name = "Negociar Madeira com Castor", -- Venda de Madeira
		{
			{"madeiraruim", 10, 1},
			{"madeiraboa", 20, 1},
			{"madeirarefinada", 30, 1},
			{"tabua", 25, 1}
		}
	},
	{
		name = "Negociar com o Doutor", -- Doutor de Valentine
		{
			{"cassis", 100, 2},
			{"cassisdourado", 200, 2},
			{"tabacoindiano", 100, 2},
			{"oregano", 200, 2},
			{"tomilhorastejante", 100, 2},
			{"ginsengamericano", 200, 2},
			{"amora", 100, 2},
			{"salviadeserto", 200, 2},
			{"salviavermelha",  200, 2},
			{"bardana", 200, 2},
			{"mentasilvestre", 200, 2},
			{"parasol", 200, 2},
			{"cantarelo", 200, 2},
			{"boletobaio", 200, 2},
			{"milfolhas", 100, 2},
			{"violeta", 100, 2},
			{"beijaflor", 100, 2},
			{"gualteria", 100, 2},
			{"asclepia", 100, 2},
			{"maitake", 100, 2},
			{"quinina", 100, 2},
			{"papola", 100, 2},
			{"cenouraselvagem", 100, 2},
			{"ginsengalaska", 100, 2},
			{"oleandro", 100, 2},
			{"frasco", 100, 2}
		}
	},
	{
		name = "Falar com o Açougueiro de Valentine", -- Açougue de Valentine
		{
			{"carneruim", 6, 1},
			{"carneboa", 11, 1},
			{"carneperfeita", 22, 1},
			{"carnedeave", 7, 1}
		}
	},
	{
		name = "Falar com o Açougueiro de Blackwater", -- Açougue de Blackwater
		{
			{"carneruim", 6, 1},
			{"carneboa", 10, 1},
			{"carneperfeita", 18, 1},
			{"carnedeave", 7, 1}
		}
	},
	{
		name = "Falar com o Açougueiro de Strawberry", -- Açougue de Strawberry
		{
			{"carneruim", 5, 1},
			{"carneboa", 10, 1},
			{"carneperfeita", 20, 1},
			{"carnedeave", 8, 1}
		}
	},
	--[[{
		name = "Falar com o Colecionador",
		{
			{"asamorcego", 100, 2},
			{"penarapina", 200, 2},
			{"rabocastor", 300, 2},
			{"raboesquilo", 300, 2},
			{"penaarara", 300, 2},
			{"paradefelino", 300, 2},
			{"ovoabutre", 300, 2},
			{"chifre", 300, 2},
			{"chifrebisao", 300, 2},
			{"galhada", 300, 2},
			{"garrarapina", 300, 2},
		}
	}]]
}

Config.ShopLocations = {
	["Negociar produção com Mark"] = {  -- Armazém de Valentine
		{-323.438,801.667,116.886}
  	},
	["Negociar produção com Terry"] = {  -- Armazém de Blackwater
		{-787.620,-1321.850,42.889}
    },
	["Negociar produção com Thomas"] = {  -- Armazém de Strawberry
		{-1789.294,-386.006,159.333}
    },
	["Negociar bebidas com Charles"] = {  -- Saloon de Valentine
		{-313.591,808.850,118.978}
    },
	["Negociar minérios com Bill"] = { 
		{-337.245,-360.421,87.079}
	},
	["Negociar madeira com Castor"] = {
		{-859.245,-1277.866,42.563}
	},
	["Negociar com o Doutor"] = {
		{-286.158,804.269,119.386}
	},
	["Falar com o Açougueiro de Valentine"] = { 
		{-340.330,770.133,116.475}
	},
	["Falar com o Açougueiro de Blackwater"] = {
		{-751.938,-1287.424,43.292}
	},
	["Falar com o Açougueiro de Strawberry"] = {
		{-1751.242,-393.834,156.249}
	},
	--[[["Falar com o Colecionador", 
		{3027.058, 561.334, 44.794}
	}]]
}
