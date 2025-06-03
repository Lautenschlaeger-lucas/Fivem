                                                        ---------------------------------------------------------
                                                        --                                                     --
                                                        --██▓███  ▓█████   ██████   ██████  ▒█████   ▄▄▄       --
                                                        --▓██░  ██▒▓█   ▀ ▒██    ▒ ▒██    ▒ ▒██▒  ██▒▒████▄    --
                                                        --▓██░ ██▓▒▒███   ░ ▓██▄   ░ ▓██▄   ▒██░  ██▒▒██  ▀█▄  --
                                                        --▒██▄█▓▒ ▒▒▓█  ▄   ▒   ██▒  ▒   ██▒▒██   ██░░██▄▄▄▄██ --
                                                        --▒██▒ ░  ░░▒████▒▒██████▒▒▒██████▒▒░ ████▓▒░ ▓█   ▓██▒--
                                                        --▒▓▒░ ░  ░░░ ▒░ ░▒ ▒▓▒ ▒ ░▒ ▒▓▒ ▒ ░░ ▒░▒░▒░  ▒▒   ▓▒█░--
                                                        --░▒ ░      ░ ░  ░░ ░▒  ░ ░░ ░▒  ░ ░  ░ ▒ ▒░   ▒   ▒▒ ░--
                                                        --░░          ░   ░  ░  ░  ░  ░  ░  ░ ░ ░ ▒    ░   ▒   --
                                                        --            ░  ░      ░        ░      ░ ░        ░  ░--
                                                        ---------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------- CONEXÃO ----------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("pessoa_lider_set",src)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------- PERMISSÃO ------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.checkPermissao()
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"setmenu.permissao") then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>permissão</b> para setar jogadores.",5000)
			return false
		end
	end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------- MENU SETAR FAC ------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.menuSetarFac()
	local source = source
	local user_id = vRP.getUserId(source)
	local id = vRP.prompt(source,"Qual id deseja setar?","")
	local set = vRP.prompt(source,"Qual set deseja colocar no id selecionado anteriormente?","")
	if id == "" or set == "" then
		return
		TriggerClientEvent("Notify",source,"negado","Opção não encontrada.",5000)
	end
	if user_id then
		if set == "motoclube" then
			if vRP.hasPermission(user_id,"lider-motoclube.permissao") then
				vRP.addUserGroup(parseInt(id),"motoclube")
				TriggerClientEvent("Notify",source,"sucesso","Você setou o passaporte <b>"..id.."</b> no set de: <b>"..set.."</b>.",5000)
			end
		end
		if set == "mafia" then
			if vRP.hasPermission(user_id,"lider-mafia.permissao") then
				vRP.addUserGroup(parseInt(id),"mafia")
				TriggerClientEvent("Notify",source,"sucesso","Você setou o passaporte <b>"..id.."</b> no set de: <b>"..set.."</b>.",5000)
			end
		end
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------- MENU REMOVER FAC -------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.menuRemoverFac()
	local source = source
	local user_id = vRP.getUserId(source)
	local id = vRP.prompt(source,"Qual id deseja remover?","")
	local set = vRP.prompt(source,"Qual set deseja remover do id selecionado anteriormente?","")
	if id == "" or set == "" then
		return
		TriggerClientEvent("Notify",source,"negado","Opção não encontrada.",5000)
	end
	if user_id then
		if set == "motoclub" then
			if vRP.hasPermission(user_id,"lider-motoclube.permissao") then
				vRP.removeUserGroup(parseInt(id),"motoclube")
				TriggerClientEvent("Notify",source,"sucesso","Você removeu o set de: <b>"..set.."</b> do passaporte: "..id.."</b>.",5000)
			end
		end
		if set == "mafia" then
			if vRP.hasPermission(user_id,"lider-mafia.permissao") then
				vRP.removeUserGroup(parseInt(id),"mafia")
				TriggerClientEvent("Notify",source,"sucesso","Você removeu o set de: <b>"..set.."</b> do passaporte: "..id.."</b>.",5000)
			end
		end
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------- MENU SETAR GANG ------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.menuSetarGang()
	local source = source
	local user_id = vRP.getUserId(source)
	local id = vRP.prompt(source,"Qual id deseja setar?","")
	local set = vRP.prompt(source,"Qual set deseja colocar no id selecionado anteriormente?","")
	if id == "" or set == "" then
		return
		TriggerClientEvent("Notify",source,"negado","Opção não encontrada.",5000)
	end
	if user_id then
		if set == "ballas" then
			if vRP.hasPermission(user_id,"lider-ballas.permissao") then
				vRP.addUserGroup(parseInt(id),"ballas")
				TriggerClientEvent("Notify",source,"sucesso","Você setou o passaporte <b>"..id.."</b> no set de: <b>"..set.."</b>.",5000)
			end
		end
		if set == "vagos" then
			if vRP.hasPermission(user_id,"lider-vagos.permissao") then
				vRP.addUserGroup(parseInt(id),"vagos")
				TriggerClientEvent("Notify",source,"sucesso","Você setou o passaporte <b>"..id.."</b> no set de: <b>"..set.."</b>.",5000)
			end
		end
		if set == "families" then
			if vRP.hasPermission(user_id,"lider-families.permissao") then
				vRP.addUserGroup(parseInt(id),"families")
				TriggerClientEvent("Notify",source,"sucesso","Você setou o passaporte <b>"..id.."</b> no set de: <b>"..set.."</b>.",5000)
			end
		end
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------- MENU REMOVER GANG -------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.menuRemoverGang()
	local source = source
	local user_id = vRP.getUserId(source)
	local id = vRP.prompt(source,"Qual id deseja remover?","")
	local set = vRP.prompt(source,"Qual set deseja remover do id selecionado anteriormente?","")
	if id == "" or set == "" then
		return
		TriggerClientEvent("Notify",source,"negado","Opção não encontrada.",5000)
	end
	if user_id then
		if set == "ballas" then
			if vRP.hasPermission(user_id,"lider-ballas.permissao") then
				vRP.removeUserGroup(parseInt(id),"ballas")
				TriggerClientEvent("Notify",source,"sucesso","Você removeu o set de: <b>"..set.."</b> do passaporte: "..id.."</b>.",5000)
			end
		end
		if set == "vagos" then
			if vRP.hasPermission(user_id,"lider-vagos.permissao") then
				vRP.removeUserGroup(parseInt(id),"vagos")
				TriggerClientEvent("Notify",source,"sucesso","Você removeu o set de: <b>"..set.."</b> do passaporte: "..id.."</b>.",5000)
			end
		end
		if set == "families" then
			if vRP.hasPermission(user_id,"lider-families.permissao") then
				vRP.removeUserGroup(parseInt(id),"families")
				TriggerClientEvent("Notify",source,"sucesso","Você removeu o set de: <b>"..set.."</b> do passaporte: "..id.."</b>.",5000)
			end
		end
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------- MENU SETAR ORG ----------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.menuSetarOrg()
	local source = source
	local user_id = vRP.getUserId(source)
	local id = vRP.prompt(source,"Qual id deseja setar?","")
	local set = vRP.prompt(source,"Qual set deseja colocar no id selecionado anteriormente?","")
	if id == "" or set == "" then
		return
		TriggerClientEvent("Notify",source,"negado","Opção não encontrada.",5000)
	end
	if user_id then
		if set == "ems" then
			if vRP.hasPermission(user_id,"diretor-geral.permissao") then
				vRP.addUserGroup(parseInt(id),"ems")
				TriggerClientEvent("Notify",source,"sucesso","Você setou o passaporte <b>"..id.."</b> no set de: <b>"..set.."</b>.",5000)
			end
		end
		if set == "policia" then
			if vRP.hasPermission(user_id,"chefe-policia.permissao") then
				vRP.addUserGroup(parseInt(id),"policia")
				TriggerClientEvent("Notify",source,"sucesso","Você setou o passaporte <b>"..id.."</b> no set de: <b>"..set.."</b>.",5000)
			end
		end
		if set == "mecanico" then
			if vRP.hasPermission(user_id,"lider-mecanico.permissao") then
				vRP.addUserGroup(parseInt(id),"mecanico")
				TriggerClientEvent("Notify",source,"sucesso","Você setou o passaporte <b>"..id.."</b> no set de: <b>"..set.."</b>.",5000)
			end
		end
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------- MENU REMOVER ORG --------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function src.menuRemoverOrg()
	local source = source
	local user_id = vRP.getUserId(source)
	local id = vRP.prompt(source,"Qual id deseja remover?","")
	local set = vRP.prompt(source,"Qual set deseja remover do id selecionado anteriormente?","")
	if id == "" or set == "" then
		return
		TriggerClientEvent("Notify",source,"negado","Opção não encontrada.",5000)
	end
	if user_id then
		if set == "ems" then
			if vRP.hasPermission(user_id,"diretor-geral.permissao") then
				vRP.removeUserGroup(parseInt(id),"ems")
				vRP.removeUserGroup(parseInt(id),"ems-ptr")
				vRP.removeUserGroup(parseInt(id),"paisana-ems")
				TriggerClientEvent("Notify",source,"sucesso","Você removeu o set de: <b>"..set.."</b> do passaporte: "..id.."</b>.",5000)
			end
		end
		if set == "policia" then
			if vRP.hasPermission(user_id,"chefe-policia.permissao") then
				vRP.removeUserGroup(parseInt(id),"policia")
				vRP.removeUserGroup(parseInt(id),"policia-ptr")
				vRP.removeUserGroup(parseInt(id),"paisana-policia")
				TriggerClientEvent("Notify",source,"sucesso","Você removeu o set de: <b>"..set.."</b> do passaporte: "..id.."</b>.",5000)
			end
		end
		if set == "mecanico" then
			if vRP.hasPermission(user_id,"lider-mecanico.permissao") then
				vRP.removeUserGroup(parseInt(id),"mecanico")
				vRP.removeUserGroup(parseInt(id),"mecanico-ptr")
				vRP.removeUserGroup(parseInt(id),"paisana-mecanico")
				TriggerClientEvent("Notify",source,"sucesso","Você removeu o set de: <b>"..set.."</b> do passaporte: "..id.."</b>.",5000)
			end
		end
    end
end


--## futuro possivel update
--[[local permissao = ""

RegisterCommand("recrutar", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserSource(parseInt(args[1]))
    local nuser_id = vRP.getUserId(nplayer)
    local nome_contratado = vRP.getUserIdentity(nplayer)
    local nome_chefe = vRP.getUserIdentity(user_id)
    if nuser_id and user_id ~= nuser_id then
        if vRP.hasPermission(user_id,"manager.permissao") then
            permissao = "Policia"
    elseif vRP.hasPermission(user_id,"admin.permissao") then
            permissao = "Policia"
        end
        if permissao ~= "" then
            if vRP.request(nplayer,"Tem a certeza que deseja ser contratado por: " ..nome_chefe.name.." "..nome_chefe.firstname.."",15) then
                vRP.addUserGroup(parseInt(args[1]),permissao)
                TriggerClientEvent("Notify",source,"aviso","Voce contratou com sucesso:"..nome_contratado.name.." "..nome_contratado.firstname.."")
                TriggerClientEvent("Notify",nplayer,"aviso","Voce foi contratado por:"..nome_chefe.name.." "..nome_chefe.firstname.."")
            else    
                TriggerClientEvent("Notify", source,"aviso","solicitação recusada." )
            end
        else
            TriggerClientEvent("Notify",source,"aviso","Voce não tem permissao." )
        end
    else
        TriggerClientEvent("Notify",source,"aviso","Passaporte não encontrado ou Invalido" ) 
    end    
end)]]