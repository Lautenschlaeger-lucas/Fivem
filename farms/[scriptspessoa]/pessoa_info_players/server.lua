local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("pessoa_info_player",src)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------	
sRP = {}
Tunnel.bindInterface("pessoa_info_players",sRP)
vCLIENT = Tunnel.getInterface("pessoa_info_players")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURN ID
-----------------------------------------------------------------------------------------------------------------------------------------	
function sRP.returnPlayers(source)
	local user_id = vRP.getUserId(source)
	return user_id
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------	
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
		vCLIENT.getPermission(source,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMSPEC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("admspec",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
		vCLIENT.getPermission(source,true)
	end
end)





--[[-----------------------------------------------------------------------------------------------------------------------------------------
-- GETID
-----------------------------------------------------------------------------------------------------------------------------------------
function src.getId()
    local source = source
	local user_id = vRP.getUserId(source)
    if user_id then
	    return user_id
    else
        return "Sem ID"
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.getPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Owner") then
        return true
    else
        return "Sem permissão"
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET IDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.getIdentity()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if identity then
        return identity
    else
        return "Sem identidade"
    end
end]]