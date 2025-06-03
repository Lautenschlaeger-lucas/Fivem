local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("emp_drogas",emP)
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local quantidade = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(2,4)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkItens()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.getInventoryItemAmount(user_id,"maconha") or vRP.getInventoryItemAmount(user_id,"cocaina") or vRP.getInventoryItemAmount(user_id,"metanfetamina") >= quantidade[source]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserAptitudes(user_id)
		if data then
			if vRP.tryGetInventoryItem(user_id,"cocaina",quantidade[source]) or vRP.tryGetInventoryItem(user_id,"metanfetamina",quantidade[source]) or vRP.tryGetInventoryItem(user_id,"maconha",quantidade[source]) then
				local price = math.random(150,250)
				local policia = vRP.getUsersByPermission("policia.permissao")
				vRP.giveInventoryItem(user_id,"dinheirosujo",math.random(350,400)*quantidade[source]+(#policia*50))
				vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
				TriggerClientEvent("vrp_sound:source",source,'coin',0.2)
				TriggerClientEvent("Notify",source,"sucesso","Entrega concluída, você recebeu dinheiro sujo!</b>.",8000)
				quantidade[source] = nil
			end
		end
	end
end

function emP.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.searchTimer(user_id,120)
		TriggerClientEvent("Notify",source,"aviso","A policia foi acionada.",8000)
		local soldado = vRP.getUsersByPermission("policia.permissao")

		if parseInt(#soldado) <= 3 then
			TriggerClientEvent("lockCops",source)
		end

		local x,y,z = vRPclient.getPosition(source)
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent("NotifyPush",player,{ code = 18, title = "Recebemos uma denuncia de drogas, verifique o ocorrido.", x = x, y = y, z = z, badge = "Murder." })
				end)
			end
			Citizen.Wait(10)
		end
	end
end