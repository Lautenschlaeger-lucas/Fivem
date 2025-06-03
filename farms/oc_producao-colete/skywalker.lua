local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-colete",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armas = {
	{ item = "mochila" },
    { item = "colete3" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-arma")
AddEventHandler("produzir-arma",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(armas) do
			if item == v.item then
				if item == "mochila" then
                    if vRP.computeInvWeight(user_id) + vRP.itemWeightList("backpackx") <= vRP.getBackpack(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pano") >= 50 then
                            if vRP.getInventoryItemAmount(user_id,"linha") >= 25 then
                                        if vRP.tryGetInventoryItem(user_id,"pano",50) and vRP.tryGetInventoryItem(user_id,"linha",25) then
                                            TriggerClientEvent("fechar-nui-colete",source)

                                            TriggerClientEvent("progress",source,10000,"Costurando Mochila")
                                            vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"backpackx",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você costurou uma <b>Mochila</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>50x panos</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>25x linhas</b>.")
                                end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                    elseif item == "colete3" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("vest") <= vRP.getBackpack(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"pano") >= 75 then
                                if vRP.getInventoryItemAmount(user_id,"linha") >= 50 then
                                    if vRP.getInventoryItemAmount(user_id,"fibra") >= 20 then
                                            if vRP.tryGetInventoryItem(user_id,"pano",75) and vRP.tryGetInventoryItem(user_id,"linha",50) and vRP.tryGetInventoryItem(user_id,"fibra",20) then
                                                TriggerClientEvent("fechar-nui-colete",source)
    
                                                TriggerClientEvent("progress",source,10000,"Fabricando Colete")
                                                vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    
                                                SetTimeout(10000,function()
                                                    vRPclient._stopAnim(source,false)
                                                    vRP.giveInventoryItem(user_id,"vest",1)
                                                    TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Colete Pesado</b>.")
                                                end)
                                            end
                                        else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>75x panos</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>50x linhas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>20x fibras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end

				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"admin.permissao") then
        return true
    end
end