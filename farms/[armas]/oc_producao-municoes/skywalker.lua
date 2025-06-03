----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-municoes",oC)
-----------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local municoes = {
	{ item = "m-ak47" },
	{ item = "m-five" },
	{ item = "m-asmg" },
	{ item = "m-uzi" },
    { item = "m-smg" },
    { item = "m-revolver" },
    { item = "m-thompson" },
    { item = "m-ak471" },
	{ item = "m-five1" },
	{ item = "m-asmg1" },
	{ item = "m-uzi1" },
    { item = "m-smg1" },
    { item = "m-revolver1" },
    { item = "m-thompson1" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-municao")
AddEventHandler("produzir-municao",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(municoes) do
			if item == v.item then
				if item == "m-ak47" then
                    if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_RIFLE_AMMO") <= vRP.getBackpack(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 60 then  
                                if vRP.tryGetInventoryItem(user_id,"capsula",30) and vRP.tryGetInventoryItem(user_id,"polvora",60) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÃO DE AK47")
                                    vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)

                                    SetTimeout(20000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"WEAPON_RIFLE_AMMO",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições AK47</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>60x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end


                elseif item == "m-five" then
                    if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_PISTOL_AMMO") <= vRP.getBackpack(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 10 then  
                                if vRP.tryGetInventoryItem(user_id,"capsula",30) and vRP.tryGetInventoryItem(user_id,"polvora",10) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÃO DE FIVE SEVEN")
                                    vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)

                                    SetTimeout(20000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"WEAPON_PISTOL_AMMO",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições FiveSeven</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == "m-asmg" then
                    if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_SMG_AMMO") <= vRP.getBackpack(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 50 then  
                                if vRP.tryGetInventoryItem(user_id,"capsula",30) and vRP.tryGetInventoryItem(user_id,"polvora",50) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÃO DE MTAR21")
                                    TriggerClientEvent("bancada-municoes:posicao",source)
                                    vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)

                                    SetTimeout(20000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"WEAPON_SMG_AMMO",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições MTAR21</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>50x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                    
                elseif item == "m-uzi" then
                    if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_SMG_AMMO") <= vRP.getBackpack(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 60 then  
                                if vRP.tryGetInventoryItem(user_id,"capsula",30) and vRP.tryGetInventoryItem(user_id,"polvora",60) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÃO DE UZI")
                                    vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)

                                    SetTimeout(20000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"WEAPON_SMG_AMMO",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições UZI</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>60x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == "m-smg" then
                    if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_SMG_AMMO") <= vRP.getBackpack(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 40 then  
                                if vRP.tryGetInventoryItem(user_id,"capsula",30) and vRP.tryGetInventoryItem(user_id,"polvora",40) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÃO DE SMG")
                                    vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)

                                    SetTimeout(20000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"WEAPON_SMG_AMMO",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições SMG</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>40x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == "m-revolver" then
                    if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_PISTOL_AMMO") <= vRP.getBackpack(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 10 then  
                                if vRP.tryGetInventoryItem(user_id,"capsula",30) and vRP.tryGetInventoryItem(user_id,"polvora",10) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,15000,"PRODUZINDO MUNIÇÃO DE Revolver")
                                    vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)

                                    SetTimeout(15000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"WEAPON_PISTOL_AMMO",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições Revolver</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == "m-thompson" then
                    if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_SMG_AMMO") <= vRP.getBackpack(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"polvora") >= 40 then  
                                if vRP.tryGetInventoryItem(user_id,"capsula",30) and vRP.tryGetInventoryItem(user_id,"polvora",40) then
                                    TriggerClientEvent("fechar-nui-municoes",source)

                                    TriggerClientEvent("progress",source,20000,"PRODUZINDO MUNIÇÃO DE Thompson")
                                    vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)

                                    SetTimeout(20000,function()
                                        vRPclient._stopAnim(source,false)
                                        vRP.giveInventoryItem(user_id,"WEAPON_SMG_AMMO",30)
                                        TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições Thompson</b>.")
                                    end)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>40x Pólvoras</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>30x Capsulas</b>.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == v.item then
                        if item == "m-ak471" then
                            if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_RIFLE_AMMO") <= vRP.getBackpack(user_id) then
                                if vRP.getInventoryItemAmount(user_id,"capsula") >= 10 then
                                    if vRP.getInventoryItemAmount(user_id,"polvora") >= 20 then  
                                        if vRP.tryGetInventoryItem(user_id,"capsula",10) and vRP.tryGetInventoryItem(user_id,"polvora",20) then
                                            TriggerClientEvent("fechar-nui-municoes",source)
        
                                            TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE AK47")
                                            vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
        
                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"WEAPON_RIFLE_AMMO",10)
                                                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições AK47</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>20x Pólvoras</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Capsulas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                            end
        
        
                        elseif item == "m-five1" then
                            if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_PISTOL_AMMO") <= vRP.getBackpack(user_id) then
                                if vRP.getInventoryItemAmount(user_id,"capsula") >= 10 then
                                    if vRP.getInventoryItemAmount(user_id,"polvora") >= 4 then  
                                        if vRP.tryGetInventoryItem(user_id,"capsula",10) and vRP.tryGetInventoryItem(user_id,"polvora",4) then
                                            TriggerClientEvent("fechar-nui-municoes",source)
        
                                            TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE FIVE SEVEN")
                                            vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
        
                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"WEAPON_PISTOL_AMMO",10)
                                                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições FiveSeven</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>4x Pólvoras</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Capsulas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                            end
        
                        elseif item == "m-asmg1" then
                            if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_SMG_AMMO") <= vRP.getBackpack(user_id) then
                                if vRP.getInventoryItemAmount(user_id,"capsula") >= 10 then
                                    if vRP.getInventoryItemAmount(user_id,"polvora") >= 20 then  
                                        if vRP.tryGetInventoryItem(user_id,"capsula",10) and vRP.tryGetInventoryItem(user_id,"polvora",20) then
                                            TriggerClientEvent("fechar-nui-municoes",source)
        
                                            TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE MTAR21")
                                            TriggerClientEvent("bancada-municoes:posicao",source)
                                            vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
        
                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"WEAPON_SMG_AMMO",10)
                                                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições MTAR21</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>20x Pólvoras</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Capsulas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                            end
        
                            
                        elseif item == "m-uzi1" then
                            if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_SMG_AMMO") <= vRP.getBackpack(user_id) then
                                if vRP.getInventoryItemAmount(user_id,"capsula") >= 10 then
                                    if vRP.getInventoryItemAmount(user_id,"polvora") >= 20 then  
                                        if vRP.tryGetInventoryItem(user_id,"capsula",10) and vRP.tryGetInventoryItem(user_id,"polvora",20) then
                                            TriggerClientEvent("fechar-nui-municoes",source)
        
                                            TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE UZI")
                                            vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
        
                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"WEAPON_SMG_AMMO",10)
                                                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições UZI</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>20x Pólvoras</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Capsulas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                            end
        
                        elseif item == "m-smg1" then
                            if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_SMG_AMMO") <= vRP.getBackpack(user_id) then
                                if vRP.getInventoryItemAmount(user_id,"capsula") >= 10 then
                                    if vRP.getInventoryItemAmount(user_id,"polvora") >= 15 then  
                                        if vRP.tryGetInventoryItem(user_id,"capsula",10) and vRP.tryGetInventoryItem(user_id,"polvora",15) then
                                            TriggerClientEvent("fechar-nui-municoes",source)
        
                                            TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE SMG")
                                            vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
        
                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"WEAPON_SMG_AMMO",10)
                                                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições SMG</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>15x Pólvoras</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Capsulas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                            end
        
                        elseif item == "m-revolver1" then
                            if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_PISTOL_AMMO") <= vRP.getBackpack(user_id) then
                                if vRP.getInventoryItemAmount(user_id,"capsula") >= 10 then
                                    if vRP.getInventoryItemAmount(user_id,"polvora") >= 4 then  
                                        if vRP.tryGetInventoryItem(user_id,"capsula",10) and vRP.tryGetInventoryItem(user_id,"polvora",4) then
                                            TriggerClientEvent("fechar-nui-municoes",source)
        
                                            TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE Revolver")
                                            vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
        
                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"WEAPON_PISTOL_AMMO",10)
                                                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições Revolver</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>4x Pólvoras</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Capsulas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                            end
        
                        elseif item == "m-thompson1" then
                            if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_SMG_AMMO") <= vRP.getBackpack(user_id) then
                                if vRP.getInventoryItemAmount(user_id,"capsula") >= 10 then
                                    if vRP.getInventoryItemAmount(user_id,"polvora") >= 15 then  
                                        if vRP.tryGetInventoryItem(user_id,"capsula",10) and vRP.tryGetInventoryItem(user_id,"polvora",15) then
                                            TriggerClientEvent("fechar-nui-municoes",source)
        
                                            TriggerClientEvent("progress",source,10000,"PRODUZINDO MUNIÇÃO DE Thompson")
                                            vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
        
                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"WEAPON_SMG_AMMO",10)
                                                TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>munições Thompson</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>15x Pólvoras</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x Capsulas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                            end
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
    if vRP.hasPermission(user_id,"Motoclube") or vRP.hasPermission(user_id,"Cartel") then
        return true
    end
end