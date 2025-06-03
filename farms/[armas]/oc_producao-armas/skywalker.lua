local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-armas",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armascraft = {
	{ item = "ak47" },
	{ item = "five" },
	{ item = "mtar21" },
    { item = "uzi" },
    { item = "mp5" },
    { item = "revolver" },
    { item = "thompson" },
    { item = "cak47" },
    { item = "cfive" },
    { item = "cmtar21" },
    { item = "cuzi" },
    { item = "cmp5" },
    { item = "crevolver" },
    { item = "cthompson" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-armas")
AddEventHandler("produzir-armas",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(armascraft) do
			if item == v.item then
				if item == "ak47" then
                    if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_ASSAULTRIFLE") <= vRP.getBackpack(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpo-ak47") >= 1 then
                            if vRP.getInventoryItemAmount(user_id,"placademetal") >= 10 then
                                if vRP.getInventoryItemAmount(user_id,"mola") >= 3 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then

                                        if vRP.tryGetInventoryItem(user_id,"corpo-ak47",1) and vRP.tryGetInventoryItem(user_id,"placademetal",10) and vRP.tryGetInventoryItem(user_id,"mola",3) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nui-armas",source)

                                            TriggerClientEvent("progress",source,10000,"Montando AK47")
                                            vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"WEAPON_ASSAULTRIFLE",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>AK47</b>.")
                                            end)
                                        else
                                            print('PEÇAS INSUFICIENTES')
                                        end
                                    else
                                       
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>3x pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de AK-47</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == "five" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_PISTOL_MK2") <= vRP.getBackpack(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"corpo-pistolmk2") >= 1 then
                                if vRP.getInventoryItemAmount(user_id,"placademetal") >= 3 then
                                    if vRP.getInventoryItemAmount(user_id,"mola") >= 1 then
                                        if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                            if vRP.tryGetInventoryItem(user_id,"corpo-pistolmk2",1) and vRP.tryGetInventoryItem(user_id,"placademetal",3) and vRP.tryGetInventoryItem(user_id,"mola",1) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                                TriggerClientEvent("fechar-nui-armas",source)
    
                                                TriggerClientEvent("progress",source,10000,"Montando Pistola")
                                                vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    
                                                SetTimeout(10000,function()
                                                    vRPclient._stopAnim(source,false)
                                                    vRP.giveInventoryItem(user_id,"WEAPON_PISTOL_MK2",1)
                                                    TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Five Seven</b>.")
                                                end)
                                            end
                                        else
                                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>1x pacotes de mola</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>3x placas de metal</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>Corpo de Five Seven</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end

                elseif item == "mtar21" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_ASSAULTSMG") <= vRP.getBackpack(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"corpo-assaultsmg") >= 1 then
                                if vRP.getInventoryItemAmount(user_id,"placademetal") >= 8 then
                                    if vRP.getInventoryItemAmount(user_id,"mola") >= 3 then
                                        if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                            if vRP.tryGetInventoryItem(user_id,"corpo-assaultsmg",1) and vRP.tryGetInventoryItem(user_id,"placademetal",8) and vRP.tryGetInventoryItem(user_id,"mola",3) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                                TriggerClientEvent("fechar-nui-armas",source)
    
                                                TriggerClientEvent("progress",source,10000,"Montando MTAR21")
                                                vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    
                                                SetTimeout(10000,function()
                                                    vRPclient._stopAnim(source,false)
                                                    vRP.giveInventoryItem(user_id,"WEAPON_ASSAULTSMG",1)
                                                    TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>MTAR21</b>.")
                                                end)
                                            end
                                        else
                                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>3x pacotes de mola</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>8x placas de metal</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>Corpo de MTAR21</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end

                    elseif item == "uzi" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_MICROSMG") <= vRP.getBackpack(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"corpo-microsmg") >= 1 then
                                if vRP.getInventoryItemAmount(user_id,"placademetal") >= 6 then
                                    if vRP.getInventoryItemAmount(user_id,"mola") >= 5 then
                                        if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                            if vRP.tryGetInventoryItem(user_id,"corpo-microsmg",1) and vRP.tryGetInventoryItem(user_id,"placademetal",6) and vRP.tryGetInventoryItem(user_id,"mola",5) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                                TriggerClientEvent("fechar-nui-armas",source)
    
                                                TriggerClientEvent("progress",source,10000,"Montando UZI")
                                                --vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                                vRPclient._playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
    
                                                SetTimeout(10000,function()
                                                    vRPclient._stopAnim(source,false)
                                                    vRP.giveInventoryItem(user_id,"WEAPON_MICROSMG",1)
                                                    TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>UZI</b>.")
                                                end)
                                            end
                                        else
                                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>5x pacotes de mola</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x placas de metal</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de UZI</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end

                    elseif item == "mp5" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_SMG") <= vRP.getBackpack(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"corpo-mp5") >= 1 then
                                if vRP.getInventoryItemAmount(user_id,"placademetal") >= 5 then
                                    if vRP.getInventoryItemAmount(user_id,"mola") >= 4 then
                                        if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                            if vRP.tryGetInventoryItem(user_id,"corpo-mp5",1) and vRP.tryGetInventoryItem(user_id,"placademetal",5) and vRP.tryGetInventoryItem(user_id,"mola",4) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                                TriggerClientEvent("fechar-nui-armas",source)
    
                                                TriggerClientEvent("progress",source,10000,"Montando MP5")
                                                vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    
                                                SetTimeout(10000,function()
                                                    vRPclient._stopAnim(source,false)
                                                    vRP.giveInventoryItem(user_id,"WEAPON_SMG",1)
                                                    TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>MP5</b>.")
                                                end)
                                            end
                                        else
                                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>4x pacotes de mola</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>5x placas de metal</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de UZI</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end

                    elseif item == "revolver" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_REVOLVER") <= vRP.getBackpack(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"corpo-revolver") >= 1 then
                                if vRP.getInventoryItemAmount(user_id,"placademetal") >= 6 then
                                    if vRP.getInventoryItemAmount(user_id,"mola") >= 2 then
                                        if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                            if vRP.tryGetInventoryItem(user_id,"corpo-revolver",1) and vRP.tryGetInventoryItem(user_id,"placademetal",6) and vRP.tryGetInventoryItem(user_id,"mola",2) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                                TriggerClientEvent("fechar-nui-armas",source)
    
                                                TriggerClientEvent("progress",source,10000,"Montando Revolver")
                                                vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    
                                                SetTimeout(10000,function()
                                                    vRPclient._stopAnim(source,false)
                                                    vRP.giveInventoryItem(user_id,"WEAPON_REVOLVER",1)
                                                    TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>Revolver</b>.")
                                                end)
                                            end
                                        else
                                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>2x pacotes de mola</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>6x placas de metal</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de Revolver</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end



                    elseif item == "thompson" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("WEAPON_GUSENBERG") <= vRP.getBackpack(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"corpo-thompson") >= 1 then
                                if vRP.getInventoryItemAmount(user_id,"placademetal") >= 8 then
                                    if vRP.getInventoryItemAmount(user_id,"mola") >= 5 then
                                        if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                            if vRP.tryGetInventoryItem(user_id,"corpo-thompson",1) and vRP.tryGetInventoryItem(user_id,"placademetal",8) and vRP.tryGetInventoryItem(user_id,"mola",5) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                                TriggerClientEvent("fechar-nui-armas",source)
    
                                                TriggerClientEvent("progress",source,10000,"Montando Gusenberg")
                                                vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    
                                                SetTimeout(10000,function()
                                                    vRPclient._stopAnim(source,false)
                                                    vRP.giveInventoryItem(user_id,"WEAPON_GUSENBERG",1)
                                                    TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Gusenberg</b>.")
                                                end)
                                            end
                                        else
                                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você precisa de <b>5x pacotes de mola</b>.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>8x placas de metal</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de Gusenberg</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end

                    elseif item == "cak103" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("corpo-ak47") <= vRP.getBackpack(user_id) then
                             if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 100 then
                                    if vRP.tryGetInventoryItem(user_id,"pecadearma",100) then
                                        TriggerClientEvent("fechar-nui-armas",source)
                                        TriggerClientEvent("progress",source,10000,"Montando Corpo da AK47")
                                        vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    
                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"corpo-ak47",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>Corpo</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>100x pecas de arma</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end

                    elseif item == "cfive" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("corpo-pistolmk2") <= vRP.getBackpack(user_id) then
                             if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 25 then
                                    if vRP.tryGetInventoryItem(user_id,"pecadearma",25) then
                                        TriggerClientEvent("fechar-nui-armas",source)
                                        TriggerClientEvent("progress",source,10000,"Montando Corpo da Pistola")
                                        vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    
                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"corpo-pistolmk2",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>Corpo</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>25x pecas de arma</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end

                    elseif item == "cmtar21" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("corpo-assaultsmg") <= vRP.getBackpack(user_id) then
                             if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 100 then
                                    if vRP.tryGetInventoryItem(user_id,"pecadearma",100) then
                                        TriggerClientEvent("fechar-nui-armas",source)
                                        TriggerClientEvent("progress",source,10000,"Montando Corpo da MTAR21")
                                        vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    
                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"corpo-assaultsmg",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>Corpo</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>100x pecas de arma</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end

                    elseif item == "cuzi" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("corpo-microsmg") <= vRP.getBackpack(user_id) then
                             if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 75 then
                                    if vRP.tryGetInventoryItem(user_id,"pecadearma",75) then
                                        TriggerClientEvent("fechar-nui-armas",source)
                                        TriggerClientEvent("progress",source,10000,"Montando Corpo da UZI")

                                        vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    
                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"corpo-microsmg",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>Corpo</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>75x pecas de arma</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end

                    elseif item == "cmp5" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("corpo-mp5") <= vRP.getBackpack(user_id) then
                             if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 75 then
                                    if vRP.tryGetInventoryItem(user_id,"pecadearma",75) then
                                        TriggerClientEvent("fechar-nui-armas",source)
                                        TriggerClientEvent("progress",source,10000,"Montando Corpo da MP5")
                                        vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    
                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"corpo-mp5",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>Corpo</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>75x pecas de arma</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end

                    elseif item == "crevolver" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("corpo-revolver") <= vRP.getBackpack(user_id) then
                             if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 40 then
                                    if vRP.tryGetInventoryItem(user_id,"pecadearma",40) then
                                        TriggerClientEvent("fechar-nui-armas",source)
                                        TriggerClientEvent("progress",source,10000,"Montando Corpo do Revolver")
                                        vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    
                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"corpo-revolver",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>Corpo</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>40x pecas de arma</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                        end

                    elseif item == "cthompson" then
                        if vRP.computeInvWeight(user_id) + vRP.itemWeightList("corpo-thompson") <= vRP.getBackpack(user_id) then
                             if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 100 then
                                    if vRP.tryGetInventoryItem(user_id,"pecadearma",100) then
                                        TriggerClientEvent("fechar-nui-armas",source)
                                        TriggerClientEvent("progress",source,10000,"Montando Corpo da Thompson")
                                        vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    
                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"corpo-thompson",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>Corpo</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>100x pecas de arma</b>.")
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
    if vRP.hasPermission(user_id,"Armas") or vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Owner") then
        return true
    end
end