local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

L1s = {}
Tunnel.bindInterface("l1_tattoos",L1s)
L1c = Tunnel.getInterface("l1_tattoos")

tattooListPrice = {
	["mpairraces_overlays"] = 1000,
	["mpbiker_overlays"] = 1000,
	["mpchristmas2_overlays"] = 1000,
	["mpgunrunning_overlays"] = 1000,
	["mphipster_overlays"] = 1000,
	["mpimportexport_overlays"] = 1000,
	["mplowrider_overlays"] = 1000,
	["mplowrider2_overlays"] = 1000,
	["mpluxe_overlays"] = 1000,
	["mpluxe2_overlays"] = 1000,
	["mpsmuggler_overlays"] = 1000,
	["mpstunt_overlays"] = 1000,
	["multiplayer_overlays"] = 1000
}
function L1s.buyTattoos(data)
	local _source = source
	local user_id = vRP.getUserId(_source)
	if user_id then
		if data.tattooIndex then
			if vRP.tryPayment(user_id,tattooListPrice[data.tattooType]) then
				L1c.setSpecifiedTattoo(_source,data.tattooIndex,data.tattooType)
				TriggerClientEvent("Notify",_source,"sucesso","Pagou <b>$"..tattooListPrice[data.tattooType].." dólares</b>.",8000)
				L1c.refreshNUITattoos(_source)
			else
				TriggerClientEvent("Notify",_source,"negado","Dinheiro insuficiente.",8000)
			end
		end
	end
end

function L1s.saveTattoos(data)
	local _source = source
	local user_id = vRP.getUserId(_source)
	if user_id then
		vRP.setUData(parseInt(user_id),"vRP:tattoos:L1",json.encode(data))
	end
end

function L1s.getUserTattooDataAndPrices(data)
	local _source = source
	local user_id = vRP.getUserId(_source)
	if user_id then
		local resultTable = {}
		local myTattoos,cfg = L1c.getTattoosAndCFG(_source)
		for k,v in pairs(cfg.tattoos[data.tattooType]._list) do
			local owned = false
			if myTattoos then
				if myTattoos[k] then owned = true; end
			end
			table.insert(resultTable,{
				_index = k,
				_name = v,
				_owned = tostring(owned),
				_price = parseInt(tattooListPrice[data.tattooType])
			})
		end
		return resultTable
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		local value = vRP.getUData(parseInt(user_id),"vRP:tattoos:L1")
		local custom = json.decode(value) or {}
		if value then
			L1c.setTattoos(source,custom)
		end
	end
end)
