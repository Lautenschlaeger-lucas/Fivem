-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD : ! Jp#2263 | https://discord.gg/HEtBSAJuJU
-----------------------------------------------------------------------------------------------------------------------------------------


local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emp = {}

Tunnel.bindInterface('emp',emp)

quantidade = {}

function emp.lkquantidade()
    local source = source
    if quantidade[source] == nil then
        quantidade[source] = 3
    end
end

function emp.jpcheckPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Drogas") then
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você não deveria estar aqui.")
		return false
    end
end

function emp.jpcheckPagamento()
	emp.lkquantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveInventoryItem(user_id,"meth",quantidade[source])
		quantidade[source] = nil
		return true
	end
end

function emp.jpCongelado()
	local source = source
	FreezeEntityPosition(source, true)
	SetTimeout(2000,function()
		FreezeEntityPosition(source, false)
	end)
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD : ! Jp#2263 | https://discord.gg/HEtBSAJuJU
-----------------------------------------------------------------------------------------------------------------------------------------