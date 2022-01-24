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


	--DELEGACIAS
	{name = "Sheriff", sprite = 1047294027, x = -3622.86,   y = -2605.45,   z = 13.34},     --ARMADILLO
	{name = "Sheriff", sprite = 1047294027, x = -5527.6,    y = -2953.36,   z = -0.7},      --TUMBLEWEED
	{name = "Sheriff", sprite = 1047294027, x = -759.17,    y = -1266.61,   z = 44.06},     --BLACKWATER
	{name = "Sheriff", sprite = 1047294027, x = -1808.51,   y = -348.13,    z = 164.65},    --STRAWBERRY
	{name = "Sheriff", sprite = 1047294027, x = -275.95,    y = 804.97,     z = 119.38},    --VALENTINE
	{name = "Sheriff", sprite = 1047294027, x = 1359.64,    y = -1304.43,   z = 77.77},     --RHODES
	--{name = "Sheriff", sprite = 1047294027, x = 2908.20,    y = 1311.53,    z = 44.94},     -- ANNESBURGS

	-- {name = "Departamento de Polícia", sprite = 778811758, x = 2512.04,  y = -1308.5,  z = 48.95},--SAINT DENIS
	{name = "Penitenciária Federal", sprite = 778811758,   x = 3363.802, y = -681.128, z = 55.972},--SAINT DENIS

    -- PADARIA
	{name = "Padaria", sprite = 935247438, x = -339.566, y = 796.852, z = 117.116},-- color = BLIP_COLORS.BLUE2}, VALENTINE
	{name = "Padaria", sprite = 935247438, x = -807.166, y = -1344.028,z = 48.914},-- color = BLIP_COLORS.BLUE2}, BLACKWATER  
    	         
    -- BANCOS
	{name = "Banco", sprite = -2128054417, x = -308.430,    y = 776.006,    z = 118.702},   -- VALENTINE
	{name = "Banco", sprite = -2128054417, x = 1292.454,    y = -1301.678,  z = 77.040},    -- RHODES
	--{name = "Banco", sprite = -2128054417, x = 2644.488,    y = -1293.186,  z = 52.281},    -- SAINT DENIS
	{name = "Banco", sprite = -2128054417, x = -813.216,    y = -1277.524,  z = 43.638},    -- BLACKWATER
	{name = "Banco", sprite = -2128054417, x = -3665.195,   y = -2623.614,  z = -13.988},   -- ARMADILLO

    -- SALOONS E BARES
	{name = "Saloon", sprite = 1879260108, x = -815.748,    y = -1318.266,  z = 43.679},   -- BW
	{name = "Saloon", sprite = 1879260108, x = -308.430,    y = 798.833,    z = 119.514},  -- VA
	{name = "Saloon", sprite = 1879260108, x = 1341.898,    y = -1374.989,  z = 80.481},   -- RH
	--{name = "Saloon", sprite = 1879260108, x = 2637.960,    y = -1224.851,  z = 53.380},   -- SD
	{name = "Saloon", sprite = 1879260108, x = -5514.696,   y = -2911.559,  z = -1.751},   -- TW
	{name = "Saloon", sprite = 1879260108, x = -3705.399,   y = -2593.321,  z = -13.320},  -- AR

	--{name = "Bar", sprite = 1879260108, x = 2793.865,       y = -1169.073,  z = 47.927},   -- SD
	--{name = "Bar", sprite = 1879260108, x = 2947.905,       y = 526.228,    z = 45.329},   -- VH
	{name = "Bar", sprite = 1879260108, x = -244.569,       y = 767.648,    z = 119.134},  -- VA

    -- ARMAZENS
	{name = "Armazém", sprite = 1475879922, x = -1790.265,  y = -387.046,   z = 161.764},  -- ST 
	{name = "Armazém", sprite = 1475879922, x = 1330.491,   y = -1292.868,  z = 76.950},   -- RH
	{name = "Armazém", sprite = 1475879922, x = -323.397,   y = 802.180,    z = 118.554},  -- VA
	{name = "Armazém", sprite = 1475879922, x = -3680.037,  y = -2624.379,  z = -13.428},  -- AR
	{name = "Armazém", sprite = 1475879922, x = -5487.486,  y = -2938.615,  z = -0.388},   -- TW
	--{name = "Armazém", sprite = 1475879922, x = 1420.301,   y = 377.391,    z = 90.321},   -- EMERALD
	--{name = "Armazém", sprite = 1475879922, x = 2830.792,   y = -1311.865,  z = 46.756},   -- SD
	--{name = "Armazém", sprite = 1475879922, x = 3027.268,   y = 562.206,    z = 44.723},   -- VH

    -- DOCTORS
	{name = "Doutor", sprite = -1739686743, x = -288.139,   y = 812.318,    z = 118.870},  -- VA
	--{name = "Doutor", sprite = -1739686743, x = 2731.146,   y = -1231.290,  z = 50.370},   -- SD
	{name = "Doutor", sprite = -1739686743, x = -1805.397,  y = -431.758,   z = 159.572},  -- ST

    -- PORTOS
	-- {name = "Porto", sprite = -1018164873, x = -688.530,    y = -1243.955,  z = 43.891},   -- BW
	-- {name = "Porto", sprite = -1018164873, x = 2670.326,    y = -1551.459,  z = 46.408},   -- ST
	-- {name = "Porto", sprite = -1018164873, x = 3020.311,    y = 1346.261,   z = 42.713},   -- ANN
	-- {name = "Porto", sprite = -1018164873, x = -1360.215,   y = -2334.438,  z = 43.623},   -- PORTO LADRÃO 1
	-- {name = "Porto", sprite = 2005921736, x = 890.561,      y = -1776.030,  z = 42.137},   -- RH
	-- {name = "Porto", sprite = 2005921736, x = -1182.360,    y = -1955.231,  z = 44.274},   -- PORTO LADRÃO 2
	-- {name = "Porto", sprite = 2005921736, x = 337.289,      y = -685.081,   z = 42.969},   -- PEIXES LENDARIOS
	-- {name = "Porto", sprite = 2005921736, x = -2017.416,    y = -3048.529,  z = -10.594},  -- FRONTEIRA
	{name = "Porto", sprite = 2005921736, x = 3266.964,     y = -716.300,   z = 42.032},   -- PENITENCIARIA

    -- -- FORTES DO EXÉRCITO
	--{name = "Forte do Exército", sprite = 2113496404, x = 347.158,     y = 1491.489,   z = 184.445},  -- WALLACE
	--{name = "Forte do Exército", sprite = 2113496404, x = 2450.293,    y = 293.308,    z = 79.027},   -- ABANDONADO
	--{name = "Forte do Exército", sprite = 2113496404, x = -4206.428,   y = -3445.589,  z = 44.594},   -- MERCER

    -- MINAS
	-- {name = "Mina de Carvão", sprite = 1220803671, x = 2785.193,  y = 1338.916,  z = 71.306},   -- ANNESBURG 1
	-- {name = "Mina de Ferro", sprite = 1220803671, x = -5963.993, y = -3201.232, z = -21.413},  -- TUMBLEWEED
	-- {name = "Mina de Cobre e Ouro", sprite = 1220803671, x = -1405.648, y = 1158.018,  z = 226.342},  -- MONTE HAGEN
	-- {name = "Cavernas", sprite = 1220803671, x = 2296.597,  y = 1068.627,  z = 90.117},   -- CACHOEIRA
	-- {name = "Cavernas", sprite = 1220803671, x = -2111.463, y = 78.291,    z = 254.191},  -- MONTE SHANN
	-- {name = "Cavernas", sprite = 1220803671, x = -2323.350, y = 95.539,    z = 221.435},  -- MONTE SHANN2

    -- CARPINTEIRO
	--{name = "Big Mill Construtora", sprite = 1586273744, x = -859.276,   y = -1277.169,  z = 43.089},   -- BW
	{name = "Madeireira BW", sprite = -426139257, x = -869.780,   y = -1302.957,  z = 43.264},     ------------------- BW
	{name = "Carpinteiro", sprite = -426139257, x = -1821.686,  y = -427.712,   z = 160.312},  -- ST
	--{name = "Coveiro", sprite = -426139257, x = -3654.609,  y = -2604.808,  z = -13.562},  -- AR
	--{name = "Coveiro", sprite = -426139257, x = 1311.115,   y = -1309.115,  z = 77.922},   -- RH

    -- LENHADOR
	--{name = "Corte de árvores", sprite = 1904459580, x = -1418.030, y = -223.012,   z = 102.753},     ------------------- MONTOS REST
	--{name = "Corte de árvores", sprite = 1904459580, x = -2282.614, y = -1408.808,  z = 142.876},   ------------------- TALL TREES	
	
    -- ESTABULOS
	--{name = "Estábulo", sprite = 564457427, x = 1198.855,   y = -190.119,   z = 101.379}, -- PRÓXIMO A EMERALD
	--{name = "Estábulo", sprite = 564457427, x = -3693.211,  y = -2552.577,  z = -13.581}, -- AR
	--{name = "Estábulo", sprite = 564457427, x = 1455.800,   y = -1372.349,  z = 78.846}, -- RH
	--{name = "Estábulo", sprite = 564457427, x = 965.731,    y = -1831.738,  z = 46.470}, -- RH Mansão
	--{name = "Estábulo", sprite = 564457427, x = 2505.427,   y = -1443.186,  z = 46.314}, -- ST
	--{name = "Estábulo", sprite = 564457427, x = -1336.145,  y = 2397.185,   z = 307.430}, -- COLTER
	--{name = "Estábulo", sprite = 564457427, x = -2420.598,  y = -2398.234,  z = 61.634}, -- MAC FARLANE
	--{name = "Estábulo", sprite = 564457427, x = -5520.338,  y = -3043.717,  z = 0.182}, -- TW
	{name = "Estábulo", sprite = 564457427, x = -372.338,   y = 789.243,    z = 116.778}, -- VA 
	{name = "Estábulo", sprite = 564457427, x = -865.010,   y = -1366.296,  z = 44.390}, -- BW
	{name = "Estábulo", sprite = 564457427, x = 2503.401, 	y = -1443.471, 	z = 46.320}, -- BW
	--{name = "Estábulo", sprite = 564457427, x = 2960.333,   y = 799.365,    z = 51.411}, -- VAN HORN
	
    -- ESTABULOS DE CARROÇAS
	-- {name = "Armazém de Carroças", sprite = 1012165077, x = -3713.115,  y = -2573.001,  z = -13.724}, 	 ------------------- AR
	-- {name = "Armazém de Carroças", sprite = 1012165077, x = -4833.699,  y = -2679.770,  z = -12.702},    ------------------- TW
	-- {name = "Armazém de Carroças", sprite = 1012165077, x = -269.527,   y = 689.652,    z = 113.414},    ------------------- VA 
	-- {name = "Armazém de Carroças", sprite = 1012165077, x = 2510.369,   y = -1456.939,  z = 46.314},     ------------------- ST
	-- {name = "Armazém de Carroças", sprite = 1012165077, x = 2933.206,   y = 560.723,    z = 45.853},     ------------------- VH
	-- {name = "Armazém de Carroças", sprite = 1012165077, x = 1885.972,   y = -1345.838,  z = 42.509},     ------------------- GRAY
	-- {name = "Armazém de Carroças", sprite = -243818172, x = 1410.146,   y = 274.842,    z = 89.534},     ------------------- Emerald
	-- {name = "Armazém de Carroças", sprite = -243818172, x = -967.922,	y = -1324.436,	z = 51.099},     ------------------- BW

	-- {name = "Armazém de Carroças", sprite = 1012165077, x = -4833.699,  y = -2679.770,  z = -12.702},     -- PRÓXIMO A EMERALD
	-- {name = "Armazém de Carroças", sprite = 1012165077, x = -1336.145,  y = 2397.185,   z = 307.430},-- COLTER
	-- {name = "Armazém de Carroças", sprite = 1012165077, x = -2420.598,  y = -2398.234,  z = 61.634},-- MAC FARLANE
	-- {name = "Armazém de Carroças", sprite = 1012165077, x = -865.010,   y = -1366.296,  z = 44.390},     -- BW
	-- {name = "Armazém de Carroças", sprite = 1012165077, x = 2960.333,   y = 799.365,    z = 51.411},       -- VAN HORN
    
    -- AÇOUGUES
	{name = "Açougue", sprite = -1665418949, x = -1979.979, y = -1647.218,  z = 117.260},   -- MANZANITA
	{name = "Açougue", sprite = -1665418949, x = -1753.372, y = -394.845,   z = 156.479},   -- ST
	{name = "Açougue", sprite = -1665418949, x = 1295.324,  y = -1278.508,  z = 77.226},   -- RH
	{name = "Açougue", sprite = -1665418949, x = -341.153,  y = 767.339,    z = 116.255},   -- VA 
	{name = "Açougue", sprite = -1665418949, x = -3691.435, y = -2621.172,  z = -13.729},    -- AR
	{name = "Açougue", sprite = -1665418949, x = -5508.176, y = -2947.713,  z = -1.870},     --TW
	--{name = "Açougue", sprite = -1665418949, x = 2817.972,  y = -1329.899,  z = 46.519},      -- SD
    
    -- CORREIOS / ESTAÇÕES DE TREM
	{name = "Correio", sprite = 1475382911, x = 2747.090,   y = -1395.012, z = 46.183},    -- SD
	{name = "Correio", sprite = 1475382911, x = -874.777,   y = -1332.494, z = 48.040},    -- BW
	-- {name = "Correio", sprite = 1475382911, x = 2985.913,   y = 568.541,   z = 44.628},    -- VH
	-- {name = "Estação de Trem", sprite = 1258184551, x = -1095.813,  y = -575.737,   z = 84.146},     -- RIGGS
	-- {name = "Estação de Trem", sprite = 1258184551, x = -1303.382,  y = 394.199,    z = 95.429},     -- WALLACE
	-- {name = "Estação de Trem", sprite = 1258184551, x = -336.965,   y = -355.405,   z = 90.028},     -- BENEDICT
	-- {name = "Estação de Trem", sprite = 1258184551, x = -3733.975,  y = -2597.958,  z = -12.928},     -- AR
	-- {name = "Estação de Trem", sprite = 1258184551, x = -178.910,   y = 626.831,    z = 114.551},     -- VA
	-- {name = "Estação de Trem", sprite = 1258184551, x = 1225.183,   y = -1293.059,  z = 77.796},     -- RH
	-- {name = "Estação de Trem", sprite = 1258184551, x = 1521.984,   y = 439.484,    z = 90.681},     -- EMERALD
	-- {name = "Estação de Trem", sprite = 1258184551, x = 2931.754,   y = 1283.120,   z = 44.653},     -- AN
	-- {name = "Estação de Trem", sprite = 1258184551, x = -2495.297,  y = -2426.242,  z = 60.600},     -- RANCHO MAC FARLANES
    
    -- GOVERNADOR
	{name = "MANSÃO DA GOVERNADORA", sprite = 60954128, x = 2342.936, y = -1216.454, z = 44.994},     -- SD

    -- GOVERNADOR
	--{name = "CASSINO", sprite = 1243830185, x = 3288.311, y = -1315.983, z = 42.771},     -- SD
	
    -- MOINHOS / CRAFTS
	{name = "Processamento de Algodão", sprite = -924533810, x = 1406.650, y = -1284.432, z = 80.987},     -- RH
	{name = "Fabrica de Enlatados", sprite = -1236018085, x = 1420.563, y = 379.628, z = 90.386},     -- EMERALD

    -- BARBEIRO
	{name = "Barbearia", sprite = -2090472724, x = 2655.406,y = -1179.950,  z = 53.279},     -- SD
	{name = "Barbearia", sprite = -2090472724, x = -306.853,y = 814.385,    z = 118.483},     -- VA
	{name = "Barbearia", sprite = -2090472724, x = -814.791,y = -1367.461,  z = 43.970},     -- BW
	{name = "Barbearia", sprite = -2090472724, x = 1298.505,y = -1132.126,  z = 80.912},     -- RH

    -- HOTEIS
	-- {name = "Hotel", sprite = -211556852, x = -326.322,y = 778.045, z = 120.303},     -- VA
	-- {name = "Hotel", sprite = -211556852, x = 2947.511,y = 1331.855,z = 44.456},    -- ANN
	-- {name = "Hotel", sprite = -211556852, x = 2977.706,y = 576.562, z = 47.877},     -- VH

    -- ARMEIRO
	--{name = "Armeiro", sprite = 202506373, x = 2946.496,    y = 1319.688,   z = 44.820},     -- AN
	{name = "Armeiro", sprite = 202506373, x = -281.062,    y = 780.318,    z = 120.120},     -- VA
	{name = "Armeiro", sprite = 202506373, x = 1325.145,    y = -1322.203,  z = 78.645},     -- RH
	{name = "Armeiro", sprite = 202506373, x = 2716.448,    y = -1285.448,  z = 49.631},     -- SD
	{name = "Armeiro", sprite = 202506373, x = -5510.021,   y = -2961.415,  z = -0.640},     -- TW

    -- FERREIRO
	{name = "Ferreiro", sprite = -758970771, x = -367.616,  y = 799.453,     z = 116.252},     -- VA
	--{name = "Ferreiro", sprite = -758970771, x = -3682.172, y = -2565.264,   z = -13.559},     -- AR
	{name = "Ferreiro", sprite = -758970771, x = -867.532,  y = -1390.029,   z = 43.220},     --BW
	--{name = "Ferreiro", sprite = -758970771, x = -2397.524, y = -2379.724,   z = 61.193},     -- FARLANE
	--{name = "Ferreiro", sprite = -758970771, x = 2969.534,  y = 791.516,     z = 51.403},     -- VAN HORN
	--{name = "Ferreiro", sprite = -758970771, x = -2591.075, y = 409.177,     z = 148.874},     -- BIG VALLEY
	--{name = "Ferreiro", sprite = -758970771, x = 2881.113,  y = 1358.082,    z = 63.030},     -- ANNESBURG

    -- ALFAITARIA
	{name = "Alfaiataria", sprite = 1496995379, x = 2552.403,y = -1166.777,z = 53.684},     --SD
	{name = "Alfaiataria", sprite = 1496995379, x = -760.060,y = -1292.879,z = 44.837},     -- BW

    -- CEMITÉRIOS
	-- {name = "Cemitério", sprite = 350569997, x = 2725.077,  y = -1067.862,   z = 47.405},     -- SD
	{name = "Cemitério", sprite = 350569997, x = 1455.265,  y = 418.937,     z = 93.596},     -- EMERALD
	{name = "Cemitério", sprite = 350569997, x = -1000.160, y = -1193.123,   z = 60.338},     -- BLACKWATER
	{name = "Cemitério", sprite = 350569997, x = 1271.605,  y = -1232.354,   z = 79.684},     -- RHODES
	{name = "Cemitério", sprite = 350569997, x = -232.233,  y = 822.051,     z = 125.667},     -- VALENTINE
	{name = "Cemitério", sprite = 350569997, x = -3313.530, y = -2866.073,   z = -4.997},     -- ARMADILLO
	{name = "Cemitério", sprite = 350569997, x = -4446.702, y = -2694.213,   z = -11.544},     -- ARMADILLO/TUMBLEWEED
	{name = "Cemitério", sprite = 350569997, x = -5450.294, y = -2909.952,   z = 0.405},     -- TUMBLEWEED
	
	-- MOINHOS
	{name = "Moinho da Eva", sprite = 669307703, x = 1056.941,  y = -1127.715,   z = 66.898},     -- RHODES
	{name = "Moinho do Kab", sprite = 669307703, x = -947.695,  y = -1336.027,   z = 50.693},     -- BLACKWATER
		
		-- TIA MAGGIE
	{name = "Tia Maggie", sprite = -1733535731, x = -1676.415, y = -341.063, z = 169.785},     -- STRAWBERRY
		-- Big Billy
	{name = "Big Billy", sprite = 669307703, x = 1436.732, y = 332.411, z = 88.752},     -- Emerald
		-- Colecionador
	{name = "Algernon Wasp", sprite = -1944395098, x = 2588.002, y = -1011.159, z = 44.249},     -- Emerald


    -- CAMPO DE PETRÓLEO
	--{name = "Campo de Petróleo", sprite = 1391579593, x = 525.305,y = 632.304,z = 130.672},     ------------------- MUDAR COORDENADA

    -- CAMPO DE TREINAMENTO PARA CAVALOS
	-- {name = "Aras", sprite = -73168905, x = -2455.481, y = -2367.582,   z = 61.176},     ------------------- MAC FARLANES
	-- {name = "Aras", sprite = -73168905, x = -1579.734, y = -1421.007,   z = 81.516},     ------------------- JOHN
	-- {name = "Aras", sprite = -73168905, x = -2542.792, y = 428.226,     z = 147.797},     ------------------- BIG VALLEY
    
    -- PESCARIA
    -- {name = "Acessórios de pesca", sprite = -852241114, x = 336.685,   y = -672.240,  z = 42.818},
    -- {name = "Acessórios de pesca", sprite = -852241114, x = 2163.294,  y = -617.692,  z = 42.879},
    -- {name = "Acessórios de pesca", sprite = -852241114, x = -1166.477, y = -1939.095, z = 42.297},

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