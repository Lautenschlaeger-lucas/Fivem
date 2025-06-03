-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("vrp_tencode",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local codes = {
	[1] = {"confronto em andamento", codigo = "QRU"},
	[2] = {"Oficial ferido", codigo = "QRT"},
	[3] = {"Localização", codigo = "QTH"},
	[4] = {"Homem armado", codigo = "QRU"},
	[5] = {"Parando veículo suspeito", codigo = "QRV"},
	[6] = {"Acidente de trânsito", codigo = "QSF"},
	[7] = {"Reforço solicitado", codigo = "QRR"},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDCODE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.sendCode(code)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local x,y,z = vRPclient.getPositions(source)
		local identity = vRP.getUserIdentity(user_id)
		local copAmount = vRP.numPermission("Police")
		for k,v in pairs(copAmount) do
			print(codes[parseInt(code)][1])
			async(function()
				
				TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = codes[parseInt(code)]['codigo'], title = codes[parseInt(code)][1], x = x, y = y, z = z, name = identity.name.." "..identity.name2, rgba = {140,35,35} })
			end)
		end
	end
end