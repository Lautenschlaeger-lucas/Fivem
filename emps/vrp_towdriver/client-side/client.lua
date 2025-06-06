-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("vrp_towdriver",cnVRP)
vSERVER = Tunnel.getInterface("vrp_towdriver")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blip = nil
local inService = false
local vehCoords = 0
local vehSelect = 0
local vehicleNet = 0
local posLocate = 1
local timeSeconds = 0
local tow = nil
local towed = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATES
-----------------------------------------------------------------------------------------------------------------------------------------
local locates = {
	{ 408.99,-1622.82,29.3,405.29,-1634.61,29.3 },
	{ 1707.88,4791.9,41.99,1712.13,4803.96,41.78 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehicles = {
	[1] = { "blista" },
	[2] = { "brioso" },
	[3] = { "dilettante" },
	[4] = { "issi2" },
	[5] = { "panto" },
	[6] = { "prairie" },
	[7] = { "rhapsody" },
	[8] = { "cogcabrio" },
	[9] = { "exemplar" },
	[10] = { "f620" },
	[11] = { "felon" },
	[12] = { "felon2" },
	[13] = { "jackal" },
	[14] = { "oracle" },
	[15] = { "oracle2" },
	[16] = { "sentinel" },
	[17] = { "sentinel2" },
	[18] = { "windsor" },
	[19] = { "windsor2" },
	[20] = { "zion" },
	[21] = { "zion2" },
	[22] = { "akuma" },
	[23] = { "avarus" },
	[24] = { "bagger" },
	[25] = { "bati" },
	[26] = { "bati2" },
	[27] = { "bf400" },
	[28] = { "carbonrs" },
	[29] = { "daemon" },
	[30] = { "daemon2" },
	[31] = { "defiler" },
	[32] = { "diablous" },
	[33] = { "diablous2" },
	[34] = { "double" },
	[35] = { "enduro" },
	[36] = { "esskey" },
	[37] = { "faggio" },
	[38] = { "faggio2" },
	[39] = { "faggio3" },
	[40] = { "fcr" },
	[41] = { "fcr2" },
	[42] = { "gargoyle" },
	[43] = { "hakuchou" },
	[44] = { "hakuchou2" },
	[45] = { "hexer" },
	[46] = { "innovation" },
	[47] = { "lectro" },
	[48] = { "manchez" },
	[49] = { "nemesis" },
	[50] = { "nightblade" },
	[51] = { "pcj" },
	[52] = { "ruffian" },
	[53] = { "sanchez" },
	[54] = { "sanchez2" },
	[55] = { "sanctus" },
	[56] = { "sovereign" },
	[57] = { "thrust" },
	[58] = { "vader" },
	[59] = { "vindicator" },
	[60] = { "vortex" },
	[61] = { "wolfsbane" },
	[62] = { "zombiea" },
	[63] = { "zombieb" },
	[64] = { "blade" },
	[65] = { "buccaneer" },
	[66] = { "buccaneer2" },
	[67] = { "chino" },
	[68] = { "chino2" },
	[69] = { "clique" },
	[70] = { "coquette3" },
	[71] = { "deviant" },
	[72] = { "dominator" },
	[73] = { "dominator3" },
	[74] = { "dukes" },
	[75] = { "faction" },
	[76] = { "faction2" },
	[77] = { "speedo2" },
	[78] = { "faction3" },
	[79] = { "ellie" },
	[80] = { "gauntlet" },
	[81] = { "gauntlet2" },
	[82] = { "hermes" },
	[83] = { "hotknife" },
	[84] = { "moonbeam2" },
	[85] = { "nightshade" },
	[86] = { "picador" },
	[87] = { "slamvan3" },
	[88] = { "bfinjection" },
	[89] = { "bifta" },
	[90] = { "dubsta3" },
	[91] = { "sandking" },
	[92] = { "sandking2" },
	[93] = { "baller" },
	[94] = { "baller2" },
	[95] = { "dubsta" },
	[96] = { "dubsta2" },
	[97] = { "granger" },
	[98] = { "habanero" },
	[99] = { "seminole" },
	[100] = { "toros" },
	[101] = { "asterope" },
	[102] = { "cog55" },
	[103] = { "glendale" },
	[104] = { "romero" },
	[105] = { "premier" },
	[106] = { "primo2" },
	[107] = { "banshee" },
	[108] = { "blista2" },
	[109] = { "buffalo" },
	[110] = { "blista3" },
	[111] = { "carbonizzare" },
	[112] = { "comet3" },
	[113] = { "deveste" },
	[114] = { "elegy" },
	[115] = { "elegy2" },
	[116] = { "furoregt" },
	[117] = { "hotring" },
	[118] = { "jester2" },
	[119] = { "massacro2" },
	[120] = { "ninef2" },
	[121] = { "ruston" },
	[122] = { "verlierer2" },
	[123] = { "btype" },
	[124] = { "btype2" },
	[125] = { "btype3" },
	[126] = { "coquette2" },
	[127] = { "feltzer3" },
	[128] = { "infernus2" },
	[129] = { "rapidgt3" },
	[130] = { "stinger" },
	[131] = { "viseris" },
	[132] = { "turismo2" },
	[133] = { "autarch" },
	[134] = { "cyclone" },
	[135] = { "entityxf" },
	[136] = { "nero2" },
	[137] = { "prototipo" },
	[138] = { "sultanrs" },
	[139] = { "tyrus" },
	[140] = { "zentorno" },
	[141] = { "bison2" },
	[142] = { "bobcatxl" },
	[143] = { "burrito2" },
	[144] = { "minivan2" },
	[145] = { "taco" },
	[146] = { "sabregt2" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local coords = {
	[1] = {
		{ -678.88,-2062.74,8.93,137.05 },
		{ -555.97,-2320.0,13.73,294.73 },
		{ 91.51,-2230.55,6.04,230.85 },
		{ 371.34,-2667.73,6.01,209.14 },
		{ 615.39,-2783.61,6.06,213.8 },
		{ 901.4,-2912.33,5.91,307.04 },
		{ 1263.45,-2564.41,42.77,275.74 },
		{ 1575.9,-2418.37,84.79,91.27 },
		{ 1403.85,-2064.81,52.0,168.88 },
		{ 1659.02,-1846.19,109.18,339.43 },
		{ 1550.17,-1366.6,86.21,233.15 },
		{ 1290.61,-1342.81,44.59,10.18 },
		{ 1147.79,-1328.82,34.66,100.22 },
		{ 1192.38,-1153.88,27.51,60.03 },
		{ 1353.89,-1019.26,39.45,252.55 },
		{ 1553.89,-949.94,69.09,27.24 },
		{ 1404.04,-760.89,68.38,55.75 },
		{ 1312.35,-396.62,67.94,285.72 },
		{ 1273.98,-41.16,62.1,305.18 },
		{ 1292.75,262.33,81.0,56.09 },
		{ 776.71,223.33,85.56,211.55 },
		{ 715.17,292.8,104.58,198.94 },
		{ 551.23,825.52,199.92,36.53 },
		{ 356.45,930.79,203.85,174.56 },
		{ 262.9,798.38,195.8,28.41 },
		{ 46.49,630.98,207.4,90.44 },
		{ -278.18,736.87,207.92,64.87 },
		{ -552.0,832.58,198.09,328.58 },
		{ -465.61,644.25,144.19,40.03 },
		{ -575.59,497.89,106.32,5.72 },
		{ -1326.6,230.7,58.78,75.79 },
		{ -1614.1,230.27,59.86,95.84 },
		{ -1842.52,84.82,78.15,267.93 },
		{ -1675.02,-226.12,55.1,115.14 },
		{ -1881.65,-286.84,49.28,231.38 },
		{ -2040.04,-265.75,23.39,305.54 },
		{ -2187.76,-428.14,12.63,209.48 },
		{ -1928.1,-782.83,1.77,110.69 },
		{ -1864.51,-1214.09,13.02,67.89 },
		{ -1529.54,-1182.51,0.93,297.58 },
		{ -1490.01,-1480.79,3.58,191.24 },
		{ -1255.35,-1400.27,4.2,229.86 },
		{ -1198.39,-1834.45,3.98,207.77 },
		{ -1151.45,-1982.15,13.17,175.45 },
		{ -892.01,-2157.21,8.93,139.24 },
		{ 909.93,-1748.37,30.48,242.2 },
		{ 928.29,-1947.68,30.68,84.81 },
		{ 1219.09,-2086.98,44.94,335.87 },
		{ 1381.4,-2030.15,53.01,114.69 },
		{ 1355.02,-1579.28,53.6,217.53 },
		{ 1189.47,-1414.74,35.11,176.27 },
		{ 995.77,-1404.13,31.26,316.7 },
		{ 762.88,-1408.79,26.53,256.11 },
		{ 833.61,-1264.14,26.31,84.39 },
		{ 725.07,-1262.26,26.23,302.6 },
		{ 866.59,-1187.47,25.32,78.62 },
		{ 903.36,-1057.07,32.83,45.62 },
		{ 1154.26,-1032.39,43.52,207.6 },
		{ 1299.33,-686.62,65.51,345.45 },
		{ 1280.56,-409.95,69.09,29.58 },
		{ 1140.05,-234.73,69.08,69.82 },
		{ 1072.28,-238.98,69.57,244.25 },
		{ 901.81,-85.85,78.77,302.29 },
		{ 974.94,189.52,80.84,257.02 },
		{ 741.24,61.8,82.59,319.58 },
		{ 745.09,130.17,79.71,238.75 },
		{ 678.7,216.02,93.47,63.38 },
		{ 604.97,311.16,106.35,121.74 },
		{ 535.8,122.94,97.13,335.34 },
		{ 234.42,252.1,105.55,335.33 },
		{ 185.5,386.9,108.43,250.76 },
		{ 43.91,307.23,110.95,154.21 },
		{ -108.72,265.72,97.7,90.24 },
		{ -312.35,133.64,67.68,85.8 },
		{ -418.84,110.4,65.1,295.33 },
		{ -515.65,64.84,52.59,80.6 },
		{ -684.32,-1.97,38.46,102.7 },
		{ -937.72,-130.46,37.58,115.31 },
		{ -940.0,-260.51,39.1,282.1 },
		{ -727.91,-361.89,34.76,275.1 },
		{ -610.68,-452.41,34.67,87.7 },
		{ -654.71,-613.67,33.03,205.24 },
		{ -406.27,-852.04,31.56,261.34 },
		{ -554.65,-935.69,23.84,312.83 },
		{ -582.19,-1127.25,22.18,150.62 },
		{ -589.2,-1184.9,17.5,85.57 },
		{ -776.06,-1680.11,28.56,181.09 },
		{ -516.5,-1780.35,21.32,212.52 },
		{ -364.0,-1687.18,18.7,328.38 },
		{ 1057.82,489.5,94.52,39.13 },
		{ 691.5,604.13,128.92,337.8 },
		{ 620.29,344.41,112.98,187.79 },
		{ 224.28,386.56,106.25,111.61 },
		{ -182.74,320.06,97.38,179.11 },
		{ -330.75,211.79,87.49,5.87 },
		{ -461.6,279.42,82.85,173.95 },
		{ -655.68,308.98,82.45,175.15 },
		{ -815.29,381.91,87.55,270.36 },
		{ -846.27,521.31,90.2,104.59 },
		{ -1272.54,450.8,94.56,16.49 },
		{ -1409.4,537.71,122.41,98.97 },
		{ -1494.76,415.6,110.69,44.99 },
		{ -1689.22,484.16,128.46,205.79 },
		{ -1939.6,582.72,118.74,72.29 },
		{ -1871.92,686.8,128.75,41.18 },
		{ -1989.59,583.12,117.26,254.68 },
		{ -2002.32,367.32,94.06,188.73 },
		{ -2353.53,263.85,164.56,205.71 },
		{ -2284.65,476.12,172.96,218.74 },
		{ -2020.89,138.31,105.08,260.71 },
		{ -1655.17,73.84,63.03,164.64 },
		{ -1633.58,-190.32,55.15,277.67 },
		{ -1821.41,-253.22,40.98,100.22 },
		{ -1729.53,-732.98,9.97,317.92 },
		{ -1272.95,-1162.2,5.63,120.01 },
		{ -1295.21,-1233.12,4.07,290.87 },
		{ -1231.59,-1222.87,6.51,281.49 },
		{ -1200.56,-1481.48,3.96,213.34 },
		{ -1155.54,-1534.31,3.84,215.62 },
		{ -943.72,-1527.28,4.64,178.88 },
		{ -963.67,-1282.29,4.75,339.67 },
		{ -828.84,-1217.26,6.52,322.9 },
		{ -871.23,-1139.9,5.99,28.74 },
		{ -716.97,-1113.08,10.67,30.11 },
		{ -635.59,-1061.79,16.53,51.43 },
		{ -612.57,-979.15,21.28,173.92 },
		{ -575.61,-871.78,25.28,354.74 },
		{ -475.21,-958.19,23.19,274.62 },
		{ -465.93,-928.88,23.26,88.51 },
		{ -562.5,-979.31,21.76,108.23 },
		{ -401.28,-1137.66,29.22,299.08 },
		{ -51.03,-1166.63,25.68,11.23 },
		{ 87.02,-1144.18,29.03,63.46 },
		{ -13.38,-1504.38,29.71,49.87 },
		{ 204.99,-1797.02,27.7,53.05 },
		{ 170.9,-1706.75,28.87,49.25 },
		{ 382.64,-1661.42,47.88,53.59 },
		{ 179.95,-1515.43,28.72,312.0 },
		{ -188.81,-1272.73,30.79,0.33 },
		{ -182.51,-1313.52,30.88,2.72 },
		{ -67.05,-1261.33,28.69,267.35 },
		{ 94.01,-386.87,40.85,244.11 },
		{ 343.42,267.51,103.08,278.1 },
		{ 456.81,21.94,87.06,57.82 },
		{ 300.08,-692.72,28.61,72.25 },
		{ 488.42,-1313.78,28.55,116.95 },
		{ 528.59,-1751.94,28.38,327.93 },
		{ 309.16,-2025.29,19.72,140.25 },
		{ 39.83,-1709.61,28.61,314.69 },
		{ -182.84,-1588.07,34.07,340.54 },
		{ -389.47,-1877.03,19.83,196.75 },
		{ -425.11,-1685.89,18.33,334.5 },
		{ -955.0,-2598.35,13.15,242.07 },
		{ -752.1,-2292.36,12.25,60.19 },
		{ -1125.58,-1994.87,12.47,232.15 },
		{ -681.24,-1411.77,4.31,261.08 },
		{ -869.98,-1238.25,4.78,45.91 },
		{ -1359.69,-1177.84,3.77,175.67 },
		{ -1072.8,-1651.74,3.8,329.29 },
		{ -1070.96,-1664.43,3.77,316.57 },
		{ -693.88,-985.82,19.7,200.58 },
		{ -1002.09,-1139.02,1.39,209.59 },
		{ -301.89,-618.25,32.79,298.03 },
		{ -158.14,-647.43,31.71,246.34 },
		{ -0.41,-686.51,31.63,272.87 },
		{ 224.68,-615.83,28.04,243.57 },
		{ 230.61,-781.47,30.0,43.66 },
		{ 246.05,-757.36,33.93,226.03 },
		{ 328.15,-626.84,28.6,247.63 },
		{ 47.71,-871.84,29.74,348.96 },
		{ -7.07,-826.95,29.95,80.93 },
		{ -87.63,-725.72,33.92,86.17 },
		{ -359.34,-122.4,37.99,26.68 },
		{ -489.15,-57.9,39.3,267.48 },
		{ -574.41,-136.78,35.72,31.61 },
		{ -799.95,-160.21,36.74,34.99 },
		{ -1699.62,65.74,64.34,218.55 },
		{ -2327.56,280.2,168.77,156.07 },
		{ -1988.12,546.72,109.92,55.8 },
		{ -1679.71,489.85,128.17,289.15 },
		{ -1411.09,538.53,122.0,278.66 },
		{ -60.32,351.6,111.71,54.44 },
		{ 136.51,312.84,111.44,272.34 },
		{ 185.7,306.1,104.69,260.74 },
		{ 303.99,263.87,104.82,277.48 },
		{ 338.66,-186.49,56.95,67.92 },
		{ 188.43,-153.02,56.07,75.69 },
		{ 952.04,-143.02,74.34,56.91 },
		{ 981.36,-1048.62,40.82,153.17 },
		{ 6.41,-1615.32,29.18,52.71 },
		{ 1.97,-1596.21,29.14,329.83 },
		{ 148.79,-1000.37,29.21,70.69 },
		{ 150.08,-1029.76,29.2,252.65 },
		{ 139.29,-1073.18,29.2,350.05 },
		{ 247.6,-580.74,43.12,156.31 },
		{ 910.3,-255.35,69.02,185.32 },
		{ 301.31,-239.31,54.04,14.68 },
		{ -1568.25,-1004.4,13.02,205.73 },
		{ -1520.49,-860.79,22.94,322.12 },
		{ -1329.97,-827.42,16.79,46.25 },
		{ 794.24,-987.09,26.01,357.71 },
		{ 748.64,-1017.92,26.59,273.29 },
		{ 677.87,-1004.54,35.03,94.84 },
		{ 413.57,-646.7,28.51,264.45 },
		{ 396.27,-644.1,28.51,92.08 },
		{ 169.3,-3236.16,5.84,95.35 },
		{ 170.57,-3272.08,5.79,105.34 },
		{ 450.2,-3040.97,6.07,90.71 },
		{ 510.07,-3049.98,6.07,182.67 },
		{ 516.76,-3049.53,6.07,178.45 },
		{ 779.24,-2971.83,5.81,253.83 },
		{ 768.3,-2964.36,5.81,307.18 },
		{ 1153.51,-3158.87,5.91,180.01 },
		{ 1146.89,-3250.06,5.91,1.14 },
		{ -330.58,-975.7,31.09,143.9 },
		{ -338.92,-948.51,31.09,265.79 },
		{ -334.99,-937.8,31.09,259.52 },
		{ -325.92,-929.5,31.24,70.3 },
		{ -342.92,-930.03,31.09,60.35 },
		{ -357.8,-926.71,31.09,86.76 },
		{ 140.96,-944.38,29.63,340.82 },
		{ 748.18,-1180.58,24.54,288.33 },
		{ 787.09,-1205.78,26.68,183.0 },
		{ 788.44,-1269.89,26.24,211.15 },
		{ 618.39,-1425.57,30.08,90.68 },
		{ 423.98,102.21,100.22,253.48 },
		{ 403.82,134.14,101.83,71.29 },
		{ 290.48,147.7,103.97,276.67 },
		{ 77.33,89.78,78.71,251.2 },
		{ 58.57,20.35,69.45,152.88 },
		{ 165.62,-30.69,67.83,184.63 },
		{ -617.83,-926.18,22.83,294.73 },
		{ 900.94,-1063.89,32.83,177.24 },
		{ 877.81,47.64,77.56,318.61 },
		{ 286.09,-830.87,28.41,157.95 },
		{ 250.8,-774.09,29.89,245.28 },
		{ -11.63,-1080.97,25.88,300.2 },
		{ 146.25,-1341.63,28.41,214.54 },
		{ 18.29,-1392.23,28.53,92.08 },
		{ -18.09,-1412.47,28.52,88.89 },
		{ -218.82,-1379.98,30.47,297.23 },
		{ -181.02,-1381.55,30.47,209.98 },
		{ -318.57,-1541.63,26.89,169.85 },
		{ -380.28,-1839.96,21.03,197.08 },
		{ -366.96,-1869.26,19.74,203.9 },
		{ -377.64,-1874.94,19.73,25.25 },
		{ -87.92,-2025.8,17.23,164.7 },
		{ -257.85,-2073.01,26.83,32.27 },
		{ -57.66,-1688.72,28.7,141.84 },
		{ -20.11,-1676.75,28.7,307.95 },
		{ 173.4,-1709.06,28.49,45.38 },
		{ 383.3,-1649.91,26.51,318.97 },
		{ 477.87,-1890.37,25.3,305.8 },
		{ 523.72,-1652.59,28.52,305.88 },
		{ 323.95,-1473.75,29.02,46.13 },
		{ 395.96,-1285.22,32.76,50.4 },
		{ 306.45,-1241.17,28.76,84.08 },
		{ 143.74,-1079.83,28.4,182.83 },
		{ 172.74,-688.68,32.33,343.8 },
		{ 148.0,-746.56,32.34,156.76 },
		{ -18.75,-571.37,36.95,160.33 },
		{ 71.69,122.39,78.39,339.26 },
		{ 66.02,124.42,78.37,157.82 },
		{ -89.09,93.7,71.54,333.48 },
		{ -1567.67,-241.38,48.69,330.77 },
		{ -1484.3,-589.38,22.48,218.25 },
		{ -1326.14,-394.96,35.66,32.48 },
		{ -1273.35,-545.47,30.12,220.36 },
		{ -1238.07,-663.22,25.1,131.36 },
		{ -1229.88,-665.05,29.93,130.64 },
		{ -1186.16,-742.87,19.31,128.33 },
		{ -1130.67,-763.28,17.97,271.11 },
		{ -1107.76,-799.52,17.3,236.09 },
		{ -1053.12,-1684.13,3.99,11.13 },
		{ -1059.25,-1425.55,4.83,258.68 },
		{ -1038.65,-1428.26,4.83,251.74 },
		{ -1034.11,-1335.63,4.84,255.85 },
		{ 796.82,-814.9,26.2,111.25 },
		{ -7.65,-1388.81,29.39,10.52 },
		{ -160.47,-858.88,29.58,344.32 },
		{ -863.7,-264.73,40.06,137.88 },
		{ -1400.23,-943.43,10.52,31.16 },
		{ -889.16,-1066.99,2.17,7.1 },
		{ -313.72,-638.61,33.11,173.85 },
		{ 171.82,-35.17,68.01,181.76 },
		{ -162.39,-51.08,53.18,70.64 },
		{ -162.46,-51.05,53.18,73.31 },
		{ -548.41,324.82,83.63,267.28 },
		{ -1381.75,-144.89,48.11,91.97 },
		{ -306.55,-1844.21,25.02,261.57 },
		{ -516.66,-2181.18,6.49,237.65 },
		{ -602.87,-1221.88,14.41,311.29 },
		{ -171.97,-1442.66,31.33,45.85 },
		{ 235.71,-2097.9,17.31,319.25 },
		{ 817.64,-1971.94,29.16,350.37 },
		{ 1357.91,-1609.33,52.92,51.21 },
		{ 1045.28,-2176.39,31.48,354.74 },
		{ 1221.3,-1215.91,35.91,272.51 },
		{ 1069.22,-428.42,66.71,278.36 },
		{ 1224.85,-287.95,69.72,108.65 },
		{ 455.52,253.23,103.21,249.88 },
		{ -325.0,475.18,110.62,149.75 },
		{ -730.2,-370.92,34.97,328.46 },
		{ -1241.52,-1397.79,4.18,21.08 },
		{ -1068.14,-1701.32,4.44,22.85 },
		{ -690.64,-1708.5,25.08,283.72 },
		{ -83.91,-1318.45,29.21,92.8 },
		{ 93.87,-643.13,31.55,333.92 },
		{ -939.71,-585.18,19.05,14.02 },
		{ -341.95,-925.67,31.09,62.03 },
		{ 496.76,-843.64,24.86,183.93 },
		{ -44.56,-1840.49,26.21,144.99 },
		{ -1535.86,-434.38,35.45,233.04 },
		{ -1734.86,-734.15,10.42,322.22 },
		{ -2151.25,-377.39,13.14,170.25 },
		{ -1834.98,-309.75,42.85,272.91 },
		{ -1321.44,-30.9,49.61,196.7 },
		{ 692.85,-391.26,41.31,62.99 },
		{ 825.82,-318.03,57.52,198.24 },
		{ 1370.71,-749.63,67.09,48.01 },
		{ 1197.72,-1055.14,41.37,122.04 },
		{ 1190.22,-1414.07,34.55,174.96 },
		{ 775.94,-1415.32,26.19,273.07 },
		{ 694.28,-1002.96,22.48,0.82 },
		{ 99.34,-148.3,54.25,163.12 },
		{ -362.71,-101.2,45.09,344.14 }
	},
	[2] = {
		{ 1456.49,4514.81,52.52,139.24 },
		{ 1395.66,4322.23,40.21,145.54 },
		{ 1272.86,4338.31,41.25,243.78 },
		{ 1234.02,4490.92,50.03,37.66 },
		{ 1187.59,4408.34,59.96,354.41 },
		{ 847.14,4394.26,51.57,211.69 },
		{ 789.86,4198.1,42.71,216.79 },
		{ 705.0,4175.57,40.79,137.07 },
		{ 744.11,4238.23,55.92,63.22 },
		{ 2204.92,4655.41,31.56,274.54 },
		{ 2333.82,4746.82,35.35,129.38 },
		{ 2396.15,4599.57,31.13,209.46 },
		{ 2592.72,4629.94,33.61,278.43 },
		{ 2588.57,4453.86,38.45,170.76 },
		{ 2507.89,4218.43,39.92,124.18 },
		{ 2473.69,4117.46,38.07,119.12 },
		{ 2503.15,4080.19,38.64,242.66 },
		{ 2411.63,3959.3,36.31,127.23 },
		{ 2815.24,4266.44,50.23,198.72 },
		{ 2810.76,4463.07,48.02,61.9 },
		{ 2713.5,4851.74,33.53,76.88 },
		{ 2575.76,5189.28,44.66,180.52 },
		{ 2527.07,5263.46,52.59,210.4 },
		{ 2391.73,5214.5,55.27,15.03 },
		{ 2361.43,5040.59,45.57,234.2 },
		{ 1969.25,5179.28,47.87,148.98 },
		{ 2823.27,4969.04,33.59,308.16 },
		{ 2639.28,5190.84,43.27,56.27 },
		{ 2490.06,5478.84,43.13,228.89 },
		{ 2204.09,5577.79,53.79,176.87 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coordsPed = GetEntityCoords(ped)

			for k,v in pairs(locates) do
				local distance = #(coordsPed - vector3(v[1],v[2],v[3]))
				if distance <= 10 then
					timeDistance = 4
					DrawMarker(21,v[1],v[2],v[3]-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,240,203,88,50,0,0,0,1)
					if IsControlJustPressed(1,38) and distance <= 2 and not inService then
						startthreadservice()
						startthreadservicetwo()
						startthreadserviceseconds()
						inService = true
						posLocate = parseInt(k)
						vehSelect = math.random(#vehicles)
						vehCoords = math.random(#coords[posLocate])
						TriggerEvent("Notify","sucesso","Trabalho iniciado, vá para a marcaçao e traga o veiculo estragado para o patio.",5000)

						if not DoesBlipExist(blip) then
							blip = AddBlipForCoord(coords[posLocate][vehCoords][1],coords[posLocate][vehCoords][2],coords[posLocate][vehCoords][3])
							SetBlipSprite(blip,1)
							SetBlipColour(blip,84)
							SetBlipScale(blip,0.4)
							SetBlipAsShortRange(blip,false)
							SetBlipRoute(blip,true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString("Veiculo Danificado")
							EndTextCommandSetBlipName(blip)
						end
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadservice()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				local distance = #(coords - vector3(locates[posLocate][4],locates[posLocate][5],locates[posLocate][6]))
				if distance <= 30 then
					timeDistance = 4
					DrawMarker(23,locates[posLocate][4],locates[posLocate][5],locates[posLocate][6]-0.95,0,0,0,0,0,0,14.0,14.0,1.0,240,203,88,50,0,0,0,0)
					if IsControlJustPressed(1,38) and not IsPedInAnyVehicle(ped) and timeSeconds <= 0 and distance <= 10 and towed == nil then
						timeSeconds = 2
						local vehicle,vehNet,vehPlate,vehName = vRP.vehList(7)
						if IsEntityAVehicle(vehicle) then
							if vehName == vehicles[vehSelect][1] then
								vehicleNet = 0
								inService = false
								vSERVER.paymentMethod()
								TriggerServerEvent("vrp_garages:DeleteVehicle",VehToNet(vehicle),GetVehicleNumberPlateText(vehicle))
							end
						end
					end
				end
			end
			Citizen.Wait(timeDistance)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadservicetwo()
	Citizen.CreateThread(function()
		while true do
			if inService then
				local ped = PlayerPedId()
				local coordsPed = GetEntityCoords(ped)
				local distance = #(coordsPed - vector3(coords[posLocate][vehCoords][1],coords[posLocate][vehCoords][2],coords[posLocate][vehCoords][3]))
				if distance <= 30 and vehicleNet == 0 then
					spawnVehicle(vehicles[vehSelect][1],coords[posLocate][vehCoords][1],coords[posLocate][vehCoords][2],coords[posLocate][vehCoords][3],coords[posLocate][vehCoords][4])

					if DoesBlipExist(blip) then
						RemoveBlip(blip)
						blip = nil
					end
				end
			end
			Citizen.Wait(1000)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadserviceseconds()
	Citizen.CreateThread(function()
		while true do
			if timeSeconds > 0 then
				timeSeconds = timeSeconds - 1
			end
			Citizen.Wait(1000)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function spawnVehicle(vehName,x,y,z,h)
	local mHash = GetHashKey(vehName)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		RequestModel(mHash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mHash) then
		local _,cdz = GetGroundZFor_3dCoord(x,y,z+1)
		local nveh = CreateVehicle(mHash,x,y,cdz,h,true,false)

		NetworkRegisterEntityAsNetworked(nveh)
		while not NetworkGetEntityIsNetworked(nveh) do
			Citizen.Wait(10)
		end

		SetEntityAsMissionEntity(nveh,true,true)
		SetVehicleOnGroundProperly(nveh)
		SetVehicleEngineHealth(nveh,100.0)
		SetVehicleBodyHealth(nveh,100.0)
		SetVehicleFuelLevel(nveh,0.0)

		local netid = VehToNet(nveh)
		SetNetworkIdExistsOnAllMachines(netid,true)
		NetworkSetNetworkIdDynamic(netid,true)
		SetNetworkIdCanMigrate(netid,false)
		for _,i in ipairs(GetActivePlayers()) do
			SetNetworkIdSyncToPlayer(netid,i,true)
		end

		SetModelAsNoLongerNeeded(mHash)

		vehicleNet = nveh
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.towPlayer()
	local vehicle = GetPlayersLastVehicle()
	if IsVehicleModel(vehicle,GetHashKey("flatbed")) and not IsPedInAnyVehicle(PlayerPedId()) then
		towed = vRP.getNearVehicle(11)
		if DoesEntityExist(vehicle) and DoesEntityExist(towed) then
			if tow then
				vSERVER.tryTow(VehToNet(vehicle),VehToNet(tow),"out")
				towed = nil
				tow = nil
			else
				if vehicle ~= towed then
					vSERVER.tryTow(VehToNet(vehicle),VehToNet(towed),"in")
					tow = towed
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_towdriver:syncTow")
AddEventHandler("vrp_towdriver:syncTow",function(vehid01,vehid02,mod)
	if NetworkDoesNetworkIdExist(vehid01) and NetworkDoesNetworkIdExist(vehid02) then
		local vehicle = NetToEnt(vehid01)
		local towed = NetToEnt(vehid02)
		if DoesEntityExist(vehicle) and DoesEntityExist(towed) then
			if mod == "in" then
				local min,max = GetModelDimensions(GetEntityModel(towed))
				AttachEntityToEntity(towed,vehicle,GetEntityBoneIndexByName(vehicle,"bodyshell"),0,-2.2,0.4-min.z,0,0,0,1,1,0,1,0,1)
			elseif mod == "out" then
				AttachEntityToEntity(towed,vehicle,20,-0.5,-18.0,-0.2,0.0,0.0,0.0,false,false,true,false,20,true)
				DetachEntity(towed,false,false)
				SetVehicleOnGroundProperly(towed)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkService()
	return inService
end