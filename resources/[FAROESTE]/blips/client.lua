local BLIP_COLORS = {
    LIGHT_BLUE = 'BLIP_MODIFIER_MP_COLOR_1',
    DARK_RED = 'BLIP_MODIFIER_MP_COLOR_2',
    PURPLE = 'BLIP_MODIFIER_MP_COLOR_3',
    ORANGE = 'BLIP_MODIFIER_MP_COLOR_4',
    TEAL = 'BLIP_MODIFIER_MP_COLOR_5',
    LIGHT_YELLOW = 'BLIP_MODIFIER_MP_COLOR_6',
    PINK = 'BLIP_MODIFIER_MP_COLOR_7',
    GREEN = 'BLIP_MODIFIER_MP_COLOR_8',
    DARK_TEAL = 'BLIP_MODIFIER_MP_COLOR_9',
    RED = 'BLIP_MODIFIER_MP_COLOR_10',
    LIGHT_GREEN = 'BLIP_MODIFIER_MP_COLOR_11',
    TEAL2 = 'BLIP_MODIFIER_MP_COLOR_12',
    BLUE = 'BLIP_MODIFIER_MP_COLOR_13',
    DARK_PUPLE = 'BLIP_MODIFIER_MP_COLOR_14',
    DARK_PINK = 'BLIP_MODIFIER_MP_COLOR_15',
    DARK_DARK_RED = 'BLIP_MODIFIER_MP_COLOR_16',
    GRAY = 'BLIP_MODIFIER_MP_COLOR_17',
    PINKISH = 'BLIP_MODIFIER_MP_COLOR_18',
    YELLOW_GREEN = 'BLIP_MODIFIER_MP_COLOR_19',
    DARK_GREEN = 'BLIP_MODIFIER_MP_COLOR_20',
    BRIGHT_BLUE = 'BLIP_MODIFIER_MP_COLOR_21',
    BRIGHT_PURPLE = 'BLIP_MODIFIER_MP_COLOR_22',
    YELLOW_ORANGE = 'BLIP_MODIFIER_MP_COLOR_23',
    BLUE2 = 'BLIP_MODIFIER_MP_COLOR_24',
    TEAL3 = 'BLIP_MODIFIER_MP_COLOR_25',
    TAN = 'BLIP_MODIFIER_MP_COLOR_26',
    OFF_WHITE = 'BLIP_MODIFIER_MP_COLOR_27',
    LIGHT_YELLOW2 = 'BLIP_MODIFIER_MP_COLOR_28',
    LIGHT_PINK = 'BLIP_MODIFIER_MP_COLOR_29',
    LIGHT_RED = 'BLIP_MODIFIER_MP_COLOR_30',
    LIGHT_YELLOW3 = 'BLIP_MODIFIER_MP_COLOR_31',
    WHITE = 'BLIP_MODIFIER_MP_COLOR_32'
}


local blips = {
	--SHERIFF
	{name = "Sheriff", sprite = 1047294027, x = -3622.86, y = -2605.45, z = 13.34}, --ARMADILLO
	{name = "Sheriff", sprite = 1047294027, x = -5527.6, y = -2953.36, z = -0.7}, --TUMBLEWEED
	{name = "Sheriff", sprite = 1047294027, x = -759.17, y = -1266.61, z = 44.06}, --BLAKCWATER
	{name = "Sheriff", sprite = 1047294027, x = -1808.51, y = -348.13, z = 164.65}, --STRAWBERRY
	{name = "Sheriff", sprite = 1047294027, x = -275.95, y = 804.97, z = 119.38}, --VALENTINE
	{name = "Sheriff", sprite = 1047294027, x = 1359.64, y = -1304.43, z = 77.77},-- color = BLIP_COLORS.BLUE2}, --RHODES
	{name = "Sheriff", sprite = 1047294027, x = 2908.20, y = 1311.53, z = 44.94},-- color = BLIP_COLORS.BLUE2}, -- ANNESBURGS
	{name = "Departamento de Polícia", sprite = 1047294027, x = 2512.04, y = -1308.5, z = 48.95},-- color = BLIP_COLORS.BLUE2}, --SAINT DENIS

	-- LOJA DE ARMAS
	{name = "Loja de Armas", sprite = -145868367, x = -280.594, y = 780.933, z = 120.246}, -- valentine

	-- ESTABULO
	{name = "Estábulo de Valentine", sprite = 1938782895, x = -366.08, y = 787.01, z = 116.17}, -- valentine
	{name = "Estábulo de Blackwater", sprite = 1938782895, x = -874.02, y = -1364.78, z = 43.53}, -- blackwater
	{name = "Estábulo de Strawberry", sprite = 1938782895, x = -1777.02, y = -440.15, z = 154.96}, -- strawberry
	{name = "Estábulo de Saint Dennis", sprite = 1938782895, x = 2502.5, y = -1455.33, z = 46.31},-- color = BLIP_COLORS.TAN}, -- saint dennis
	{name = "Estábulo de Annesburg", sprite = 1938782895, x = 2970.73, y = 1427.97, z = 44.71}, -- annesburg

	-- SALOON
	{name = "Saloon das Pavão", sprite = 1242464081, x = -308.532, y = 804.939, z = 119.804},
	{name = "Saloon dos Baxter", sprite = 595820042, x = -240.800, y = 770.333, z = 118.330},

	-- LEILÃO
	-- Saloons
	{name = "Será Leiloado", sprite = 249721687, x = -815.307, y = -1320.020, z = 44.339}, -- BlackWater
	{name = "Será Leiloado", sprite = 249721687, x = 2635.813, y = -1225.298, z = 53.376}, -- Saint Denis
	{name = "Será Leiloado", sprite = 249721687, x = 2795.543, y = -1169.044, z = 47.924}, -- Saint Denis Velho
	{name = "Será Leiloado", sprite = 249721687, x = 1348.306, y = -1375.794, z = 80.476}, -- Rhodes
	{name = "Será Leiloado", sprite = 249721687, x = 2945.913, y = 523.350, z = 45.361}, -- Van Horn
	{name = "Será Leiloado", sprite = 249721687, x = -5514.806,y = -2908.321, z = -1.756}, -- Tumbleweed
	-- Armeiro
	{name = "Será Leiloado", sprite = 249721687, x = 1325.247, y = -1321.357, z = 77.886}, -- Rhodes
	{name = "Será Leiloado", sprite = 249721687, x = -5507.814,y = -2965.209, z = -0.635}, -- Tumbleweed
	-- Armazens
	{name = "Será Leiloado", sprite = 249721687, x = 1327.576, y = -1292.234, z = 77.020}, -- Rhodes
	{name = "Será Leiloado", sprite = 249721687, x = 2827.527, y = -1316.725, z = 46.926}, -- Saint Denis
	{name = "Será Leiloado", sprite = 249721687, x = 3027.245, y = 562.136, z = 44.719}, -- Van Horn
	{name = "Será Leiloado", sprite = 249721687, x = -5488.006, y = -2938.016, z = -0.407}, -- Tumbleweed
	-- Doctor
	{name = "Será Leiloado", sprite = 249721687, x = 2721.739, y = -1229.691, z = 51.130}, -- Saint Denis
	{name = "Será Leiloado", sprite = 249721687, x = 2946.527, y = 1319.625, z = 44.816}, -- Saint Denis
	
	
	-- JORNAL
	{name = "Jornal Dakota", sprite = 587827268, x = -266.096, y = 778.333, z = 122.404}, 

	-- ALFAIATE
	{name = "Alfaiataria da Dona Rell", sprite = 1195729388, x = -765.022, y = -1292.413, z = 45.067}, 
	{name = "Alfaiataria", sprite = 1195729388, x = 2552.441, y = -1166.584, z = 53.684},

	-- ACOUGUE
	{name = "Açougue de Strawberry", sprite = -1665418949, x = -1753.07, y = -394.78, z = 156.18}, --Cabana de Açougue de Strawberry
	{name = "Açougue de Valentine", sprite = -1665418949, x = -341.08, y = 767.16, z = 116.71}, --Cabana de Açougue de Valentine
	{name = "Açougue de Blackwater", sprite = -1665418949, x = -751.078, y = -1284.776, z = 43.276}, --Cabana de Açougue de Blackwater

	--DOCTOR
	{name = "Doctor", sprite = -1739686743, x = -288.0, y = 804.56, z = 119.39},

	--BARBEIRO
	{name = 'Barbeiro de Valentine', sprite = -2090472724, x = -307.167, y = 811.311, z = 118.980 },
	{name = 'Barbeiro de Blackwater', sprite = -2090472724, x = -813.676, y = -1367.347, z = 43.886 }, 

	--BANCOS
	{name = "Banco de Valentine", sprite = -60720396, x = -308.52, y = 775.99, z = 118.7},
	{name = "Banco de Blackwater", sprite = -60720396, x = -813.09, y = -1277.52, z = 43.64}, 
	{name = "Banco de Saint Denis", sprite = -60720396, x = 2642.879, y = -1296.995, z = 52.252},-- color = BLIP_COLORS.LIGHT_YELLOW2}, -- saint DENIS
	{name = "Banco de Rhodes", sprite = -60720396, x = 1299.520, y = -1300.899, z = 77.625}, --color = BLIP_COLORS.LIGHT_YELLOW2}, -- rhodes

	-- CORREIOS
    {name = "Carteiro", sprite = 1861010125, x = -174.02, y = 633.27, z = 114.09}, -- valentine

	--HOTEIS
	{name = "Hotel", sprite = -211556852, x = -325.225, y = 764.678, z = 124.506},

	--EMPREITERA
	{name = "Empreiteira", sprite = -426139257, x = -355.94, y = 810.54, z = 116.22},

	-- Armazens
	{name = "Terry", sprite = -1954662204, x = -785.338, y = -1323.850, z = 43.884}, -- Blackwater
	{name = "Merida", sprite = -1954662204, x = -322.327, y = 804.016, z = 117.886}, -- Valentine
	{name = "Thomas", sprite = -1954662204, x = -1789.752, y = -385.738, z = 160.333}, -- Starwberry

	-- Moinho
	{name = "Mery", sprite = 669307703, x = 1054.110, y = -1122.900, z = 67.889}, -- Rhodes

	-- ADUBO
	{name = "Decomposição", sprite = 552659337, x = -873.370, y = 318.540, z = 96.288}, -- Valentine
	{name = "Horta do Big Billy", sprite = 552659337, x = 1363.859, y = -1288.305, z = 76.123}, -- Valentine

	-- MONTANHAS
	{name = "Monte Shann", sprite = -902701436, x = -2018.557, y = 56.249, z = 332.376}, 
	{name = "Monte Hagen", sprite = -902701436, x = -1625.058, y = 1286.668, z = 371.754}, 
	{name = "Monte Grizzlies", sprite = -902701436, x = 1084.537, y = 1718.977, z = 382.057}, 

	-- Lojas 
	{name = "Castor", sprite = 1904459580, x = -859.689, y = -1277.975, z = 43.563},
	{name = "Francis", sprite = -758970771, x = -368.663, y = 801.739, z = 116.139},
	{name = "Ferreiro", sprite = -758970771, x = -872.998, y = -1394.956, z = 43.369},
	
	-- Processos
	{name = "Carpintaria", sprite = 1904459580, x = -1824.943, y = -422.822, z = 162.695},

	{ name = 'Aluguel de Carroça', sprite = -243818172, x = -334.912, y = 758.506, z = 116.813 },

	{ name = 'Cemitério', sprite = -695368421, x = -979.500, y = -1191.326, z = 60.623 },
	{ name = 'Cemitério', sprite = -695368421, x = -234.513, y = 819.405, z = 60.623 },
	{ name = 'Cemitério', sprite = -695368421, x = 1287.989, y = -1225.074, z = 82.759 },
}

local blipsLoaded = {}

Citizen.CreateThread(
	function()
		for _, info in pairs(blips) do
			local blipId = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, info.x, info.y, info.z)

			SetBlipSprite(blipId, info.sprite, 1);
			
			if info.color then
				Citizen.InvokeNative(0x662D364ABF16DE2F, blipId, GetHashKey(info.color));
			else 
				Citizen.InvokeNative(0x662D364ABF16DE2F, blipId, GetHashKey(BLIP_COLORS.WHITE));
			end
			
			local varString = CreateVarString(10, 'LITERAL_STRING', info.name);
			Citizen.InvokeNative(0x9CB1A1623062F402, blipId, varString)
			
			table.insert(blipsLoaded, blipId)
		end
	end
)


AddEventHandler(
	"onResourceStop",
	function(resourceName)
		if resourceName == GetCurrentResourceName() then
			for _, blip in pairs(blipsLoaded) do
				RemoveBlip(blip)
			end
		end
	end
)