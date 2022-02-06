Impound = {}
CoOwner = {}
SellCar = {}
PoliceImpound = {}
Destroy = {}
Config = {
    Locale = 'pl',
	Sprite = 289,
	Colour = 38,
	Colour2 = 37,
	Colour3 = 47
}

Config.Garage = {
	-- Widoczne blipy
	{x = -83.71, y = 6346.47, z = 31.50, blip = true}, -- PALETO
	{x = 75.7923, y = 6365.6025, z = 30.2805+0.9, blip = true}, -- PALETO
	{x = 1488.26, y = 3744.710, z = 33.80, blip = true}, -- SANDY
	{x = 1422.44, y = -1504.34, z = 60.89, blip = true}, -- LS DÓŁ
	{x = 327.750, y = -204.980, z = 54.09, blip = true}, -- LS góra
	{x = -1469.39, y = -657.17, z = 29.50, blip = true}, -- LS lewo
	{x = -3146.09, y = 1084.69, z = 20.69, blip = true},
	{x = 11.17, y = -1742.97, z = 29.3, blip = true},
	{x = 40.07, y = -863.97, z = 30.55, blip = true},
	{x = 885.98, y = -38.22, z = 78.76, blip = true},
	{x = -926.0, y = -163.99, z = 41.88, blip = true},
	{x = 385.51, y = -1657.58, z = 27.3, blip = true},
	{x = -1194.04, y = -1490.86, z = 4.38, blip = true},
	{x = 1688.43, y = 4774.03, z = 41.92, blip = true},  
	{x = 572.16, y = 2724.44, z = 42.06, blip = true},  
	{x = -1879.58, y = -308.17, z = 49.23, blip = true},
	{x = 2769.66, y = 3467.82, z = 55.57, blip = true},
	{x = 333.21, y = -2038.74, z = 21.06, blip = true},
	{x = 1004.04, y = -2336.67, z = 30.51, blip = true},
	{x = -334.79, y = -751.01, z = 33.97, blip = true},  
	{x = -1392.48, y = 80.49, z = 53.95, blip = true},
	{x = -607.7, y = 337.4, z = 85.12, blip = true},  
	{x = -92.24, y = 80.85, z = 71.65, blip = true},
	{x = -801.08, y = -1305.94, z = 5.0, blip = true},
	{x = -2973.64, y = 70.09, z = 11.6, blip = true},
	{x = 2587.52, y = 419.76, z = 108.46, blip = true},
	{x = -1039.03, y = -2714.28, z = 13.81, blip = true},
	{x = -285.45, y = -1011.7, z = 30.38, blip = true},
	{x = 1366.88, y = -579.59, z = 74.38, blip = true},
	{x = 105.75, y = -1940.85, z = 20.8, blip = true},
	{x = -1566.83, y = -252.59, z = 48.26, blip = true},
	{x = -1728.78, y = -445.8, z = 42.54, blip = true},
	{x = -1093.5, y = -1047.61, z = 2.15, blip = true},
	{x = -1055.01, y = -1148.73, z = 2.11, blip = true},
	{x = 461.36, y = 239.93, z = 103.21, blip = true},
	{x = -795.99, y = 319.41, z = 85.68, blip = true},
	{x = -12.07, y = -634.27, z = 35.72, blip = true}, 
	{x = -1467.69, y = -504.56, z = 32.81, blip = true},
	{x = -2322.0051, y = 292.9283, z = 167.5972, blip = true},
	{x = -515.5114, y = -295.2323, z = 35.501, blip = true},
	{x = -1664.0645, y = -889.9105, z = 7.6936, blip = true},
	{x = -2045.963, y = -466.1149, z = 10.5746+1.0, blip = true},
	{x = 162.8165, y = -3335.345, z = 4.9943+1.0, blip = true},
	{x = -1320.74, y = -925.57, z = 11.25, blip = true}, 
	{x = -410.7779, y = 1209.1434, z = 324.6917+0.9, blip = true},
	{x = -2036.1185, y = -259.4178, z = 22.4359+0.9, blip = true},

	--cayoperico
	--{x = 5475.1362, y = -5827.7632, z = 17.9824+1.3, blip = true},
	--{x = 4489.0391, y = -4459.644, z = 3.2856+1.0, blip = true},

	-- Niewidoczne blipy
	{x = -720.96, y = 507.73, z = 108.40, blip = false}, -- revo house
	{x = 852.97, y = -902.79, z = 25.32, blip = false}, -- Mechanik
	{x = 119.8747, y = -131.3839, z = 54.8847, blip = false}, -- cardealer
	{x = 2451.4944, y = 4997.7998, z = 46.0398, blip = false}, -- rzeznik
	{x = 2564.6553, y = 4696.4478, z = 34.0779, blip = false}, -- farmer
	{x = 120.05, y = -1062.05, z = 29.19, blip = false}, -- piekarnia
	{x = -524.4675, y = -888.9473, z = 24.1331, blip = false}, -- weazel news
	{x = -1918.89, y = 2056.68, z = 140.98, blip = false},
	{x = -395.08, y = 6312.73, z = 28.97, blip = false},
	{x = -52.84, y = 6622.55, z = 29.95, blip = false},
	{x = -626.1, y = 56.4, z = 43.73, blip = false},
	{x = -893.9, y = -344.26, z = 34.53, blip = false},
	{x = 1855.43, y = 2590.98, z = 45.67, blip = false},
	{x = 279.34, y = -611.91, z = 43.22, blip = false},
	{x = 323.23, y = -547.83, z = 28.74, blip = false},
	{x = 534.53, y = 6524.09, z = 13.76, blip = false},
	{x = 2111.63, y = 4768.57, z = 41.19, blip = false},
	{x = -116.56, y = 1004.18, z = 235.76, blip = false},
	{x = 838.7579, y = -3237.3801, z = -98.60, blip = false},
	{x = -673.4064, y = 908.9037, z = 229.5074+0.9, blip = false},
	{x = -2584.03, y = 1701.9906, z = 140.4129, blip = false},
	{x = -187.3387, y = -1585.7897, z = 33.875+1.3, blip = false},
	{x = -1532.9789, y = 81.9971, z = 55.817+1.0, blip = false},
	{x = 733.0592, y = -2989.5664, z = -39.9499+1.0, blip = false},
	{x = -824.0345, y = 182.1567, z = 70.8006+1.2, blip = false},
	{x = 928.8199, y = -573.2177, z = 56.3764+1.2, blip = false},
	{x = 943.9417, y = -669.912, z = 57.061+1.2, blip = false},
	{x = 915.408, y = -492.3825, z = 58.0874+1.2, blip = false},
	{x = 1989.6538, y = 3032.6936, z = 45.696+1.7, blip = false},
	{x = 1412.3381, y = 1109.8804, z = 113.8785+1.7, blip = false},
	{x = -1061.8348, y = 302.9888, z = 65.0022+1.7, blip = false},
	{x = 1396.1636, y = 1118.0135, z = 113.8895+1.5, blip = false},
	{x = -709.7434, y = 651.3831, z = 154.2255+1.5, blip = false},
	{x = -1749.7373, y = 365.9608, z = 88.7746+1.5, blip = false},
	{x = 1364.6576, y = -2085.7405, z = 51.0485+1.5, blip = false},
	{x = 313.7811, y = -1104.6948, z = 28.452+1.5, blip = false},
	{x = -1548.8711, y = 428.4748, z = 108.382+1.5, blip = false},
	{x = -2604.8188, y = 1675.7346, z = 141.713, blip = false}, -- Dom FaRgOnS
	{x = -13.6885, y = -1414.7452, z = 28.8617, blip = false}, -- Zieloni
	{x = -1098.7319, y = 359.5399, z = 68.0414, blip = false}, -- Dom Avenidy
	{x = -1547.1282, y = 880.796, z = 180.3436, blip = false}, -- Dom asyniarza
	{x = -948.3535, y = 575.1801, z = 100.2000, blip = false}, -- Dom pk
	{x = -84.3419, y = -822.5928, z = 35.078, blip = false}, -- firma Never 
	{x = 53.6596, y = 476.7289, z = 145.9882, blip = false}, -- Dom Dzikusek 
	{x = 118.7484, y = 1210.8898, z = 207.2243, blip = false}, -- FOD
	{x = 2008.7709, y = 4984.708, z = 41.3293, blip = false}, -- ACG 
	{x = 13.3717, y = 548.4252, z = 176.1719, blip = false}, -- Famili Di Morte 
	{x = -108.9362, y = 833.3428, z = 234.7666, blip = false}, -- THW 
	{x = 584.4418, y = 2788.7898, z = 41.2419, blip = false}, -- UTS
	{x = 821.9487, y = -2333.6594, z = 30.5148, blip = false}, -- OIOM
	{x = 982.1855, y = 982.1855, z = 73.111, blip = false}, -- MDM
	{x = 983.0217, y = -134.5364, z = 74.111, blip = false}, -- Losty
	{x = 1730.8621, y = 4830.605, z = 26.5319, blip = false}, -- Ocean Family
	{x = 797.2075, y = -2299.5796, z = 14.7542, blip = false}, -- NTS
	{x = -1097.1548, y = 4922.5317, z = 215.9822, blip = false}, -- MOB
	{x = 939.6608, y = -1472.2197, z = 30.1525, blip = false}, -- CLK 
	{x = 62.2607, y = 2362.3618, z = 78.5711, blip = false}, -- KGB
	{x = -1975.4038, y = 260.8438, z = 87.2691, blip = false}, -- N1554
	{x = 376.6078, y = -1909.4062, z = 29.3422, blip = false}, -- Biali
	{x = -919.93, y = 109.45, z = 54.37, blip = false}, -- Assynu
	
	--dom
	{x = -2663.9511, y = 1307.2448, z = 146.16+1.5, blip = false},
	-- Prace legalne - widoczne
	{x = 336.11, y = -1475.8, z = 29.62, blip = true}, -- Szpital
	{x = 966.48, y = -1025.75, z = 40.85, blip = true}, -- Mechanik
	-- Prace legalne - tylko dla prac
	{x = 462.3951, y = -1019.2857, z = 27.1511+0.9, role = "police"}, -- Komenda MR
	{x = -1116.07, y = -856.93, z = 13.52, role = "police"}, -- Komenda Vespucci
	{x = 597.5537, y = -1.3315, z = 69.6781, role = "police"}, -- Komenda Vinewood
	{x = 1860.39, y = 3679.43, z = 33.68, role = "police"}, -- Komenda Sandy
	{x = -477.27, y = 6021.38, z = 31.34, role = "police"}, -- Komenda Paleto
	{x = -54.8941, y = -2543.9788, z = 5.06+0.9, role = "police"}, -- Komenda Doki
	{x = 1524.0947, y = 791.8511, z = 76.4973+1.5, role = "police"}, -- Komenda LS Freeway
	{x = 404.963, y = -1630.4169, z = 28.3421+0.9, role = "police"}, -- Komenda Davis
	{x = -699.34, y = 309.91, z = 82.05, role = "ambulance"}, 
	{x = 902.42, y = -183.88, z = 73.89, role = "taxi"},
	{x = -464.1998, y = -2806.8694, z = 5.0503, role = "courier"},
	{x = 966.63, y = 44.88, z = 80.96, role = "casino"},
	{x = 691.7681, y = -960.2361, z = 22.7102, role = "krawiec"},
	{x = 409.2424, y = 6459.0923, z = 28.859, role = "grower"},
	-- Organizacje
	{x = 140.48, y = -705.95, z = 33.13, role = "doj"},
	{x = -579.8293, y = -1608.7816, z = 26.9108, role = "org10"},
	{x = 1727.0644, y = 4821.6405, z = 25.554, role = "org12"},
	{x = 1232.4165, y = -3307.6111, z = 4.554, role = "org10"},
	{x = -1206.1434, y = 267.4731, z = 68.5892+1.2, role = "org11"},
	{x = -1204.65, y = -1317.55, z = 4.96, role = "org3"},
	{x = 4969.3511, y = -5747.6411, z = 18.9304+0.9, role = "org20"},
	{x = 4890.4214, y = -5736.5645, z = 25.4010+0.9, role = "org20"},
	{x = -1391.4294, y = -634.1245, z = 27.7410+0.9, role = "galaxy"},
	{x = 727.9069, y = -1307.095, z = 25.344, role = "org23"},
	{x = -107.6443, y = 832.1492, z = 234.7733, role = "org22"},
	{x = -1977.9406, y = 259.4298, z = 86.2684, role = "org24"},
	{x = -1977.6262, y = 259.9672, z = 87.2684, role = "org10"},
	{x = 454.9472, y = -1882.2933, z = 25.927, role = "org19"},
	{x = -1093.8691, y = 4945.3145, z = 218.1943, role = "org15"},
	{x = -1207.0839, y = -1307.5088, z = 4.9344, role = "org11"}, 
	{x = 203.5003, y = 1222.2382, z = 225.5099, role = "org7"},
	{x = 371.4657, y = -4.3088, z = 83.0397, role = "org12"},

	{x = 919.7728, y = -1246.0504, z = 15.0504, role = "org14"},
	{x = -1791.0529, y = 457.8669, z = 127.3583+1,25, role = "org25"},
	{x = 709.9576, y = -790.6625, z = 15.5243+1,25, role = "org18"},
	{x = 14.9672, y = 548.5425, z = 175.2043+1,25, role = "org13"},
	{x = 939.5541, y = -1474.3398, z = 29.1525+1,25, role = "org15"},
	{x = 160.582, y = 6374.0435, z = 30.5881+0.9, role = "org7"},
	{x = 955.246, y =-1510.9849, z = 31.1384, role = "org7"},
}

Config.Harbors = {
	{x = -910.48, y = -1458.06, z = 1.2, h = 290.0, blip = true},
	{x = 3869.96, y = 4470.27, z = 1.2, h = 267.88, blip = true},
	{x = -500.67, y = 6482.47, z = 1.2, h = 31.31, blip = true},
	{x = -3336.4, y = 992.15, z = 1.2, h = 89.28, blip = true},
	{x = 5101.44, y = -4651.05, z = 1.2, h = 254.95, blip = true},
}

Config.Hangar = {
	{x = -724.58, y = -1444.26, z = 5.0, blip = true},
	{x = 1717.7, y = 3253.4, z = 41.14, h = 103.0, blip = true},
	{x = -1274.51, y = -3386.33, z = 13.94, h = 330.0, blip = true},
	{x = 965.78, y = 42.24, z = 123.13, h = 146.57, blip = false},
	{x = 4432.33, y = -4515.55, z = 4.13, h = 108.73, blip = true},
}

Config.Zones = {
	{x = -2022.76, y = -254.8141, z = 22.473, marker = 1, blip = "Odholowywanie pojazdów", sprite = 289, color = 5, name = "impound", label  = "Naciśnij ~INPUT_CONTEXT~ aby odebrać pojazd"},
	{x = 93.475, y = 6357.0801, z = 30.4259, marker = 1, blip = "Odholowywanie pojazdów", sprite = 289, color = 5, name = "impound", label  = "Naciśnij ~INPUT_CONTEXT~ aby odebrać pojazd"},
	{x = 4965.5327, y = -5786.439, z = 19.9277, marker = 1, name = "impound", label  = "Naciśnij ~INPUT_CONTEXT~ aby odebrać pojazd"},
	{x = -533.7316, y = -190.758, z = 37.2697, marker = 1, name = "coowner", label  = "Naciśnij ~INPUT_CONTEXT~ aby zarządzać pojazdem"},
    {x = -551.6007, y = -190.2991, z = 37.2697, marker = 1, name = "contract", label  = "Naciśnij ~INPUT_CONTEXT~ aby zakupić umowę kupna/sprzedaży pojazdu"},
	{x = 484.66, y = -1097.25, z = 29.2, marker = 2, blip = "Parking policyjny", sprite = 56, color = 3, name = "impoundpd", label  = "Naciśnij ~INPUT_CONTEXT~ wyciągnąć pojazd z parkingu policyjnego"},
	{x = 1870.8511, y = 3702.4045, z = 32.3619, marker = 2, blip = "Parking policyjny", sprite = 56, color = 3, name = "impoundpd", label  = "Naciśnij ~INPUT_CONTEXT~ wyciągnąć pojazd z parkingu policyjnego"},
	{x = -451.27, y = 5990.52, z = 31.34, marker = 2, blip = "Parking policyjny", sprite = 56, color = 3, name = "impoundpd", label  = "Naciśnij ~INPUT_CONTEXT~ wyciągnąć pojazd z parkingu policyjnego"},
    --{x = 2346.78, y = 3052.47, z = 48.17, marker = 2, blip = "Złomowisko", sprite = 380, color = 1, name = "destroy", label  = "Naciśnij ~INPUT_CONTEXT~ aby zezłomować pojazd"},
}