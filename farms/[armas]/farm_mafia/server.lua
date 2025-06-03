local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("farm_mafia",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(2,5)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + vRP.itemWeightList("pecadearma") and vRP.itemWeightList("mola") * parseInt(quantidade[source]) <= vRP.getBackpack(user_id) then
		vRP.giveInventoryItem(user_id,"pecadearma",quantidade[source])
		vRP.giveInventoryItem(user_id,"mola",3)
		vRP.giveInventoryItem(user_id,"gatilho",3)
		vRP.giveInventoryItem(user_id,"placademetal",3)
		TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "RECEBEU",vRP.itemIndexList("pecadearma"),vRP.format(parseInt(quantidade[source])),vRP.itemNameList("pecadearma") })
		TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "RECEBEU",vRP.itemIndexList("gatilho"),vRP.format(parseInt(3)),vRP.itemNameList("gatilho") })
		TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "RECEBEU",vRP.itemIndexList("placademetal"),vRP.format(parseInt(3)),vRP.itemNameList("placademetal") })
		quantidade[source] = nil
	
		return true
		end
	end
end