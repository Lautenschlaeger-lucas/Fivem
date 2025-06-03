local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
oC = Tunnel.getInterface("oc_producao-colete")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = 713.26, ['y'] = -969.97, ['z'] = 30.4 },
	{ ['x'] = 718.675, ['y'] = -962.477, ['z'] = 30.3958 },
}

-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end

-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "produzir-mochila" then
		TriggerServerEvent("produzir-arma","mochila")
	elseif data == "produzir-colete3" then
		TriggerServerEvent("produzir-arma","colete3")	

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

RegisterNetEvent("bancada-armas:posicao")
AddEventHandler("bancada-armas:posicao", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped,169.56)
	SetEntityCoords(ped,1403.8035888672,1153.3852539062,114.33352661133-1,false,false,false,false)
end)

RegisterNetEvent("fechar-nui-colete")
AddEventHandler("fechar-nui-colete", function()
	ToggleActionMenu()
	onmenu = false
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 500
		for k,v in pairs(prodMachine) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local prodMachine = prodMachine[k]
			local idBancada = prodMachine[id]
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prodMachine.x, prodMachine.y, prodMachine.z, true ) <= 1 and not onmenu then
				DrawText3D(prodMachine.x, prodMachine.y, prodMachine.z, "[~r~E~w~] Para acessar a ~r~BANCADA DE COSTURA~w~.")
			end
			if distance <= 15 then
				idle = 5
				DrawMarker(23, prodMachine.x, prodMachine.y, prodMachine.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				if distance <= 1.2 then
					idle = 5
					if IsControlJustPressed(0,38) and oC.checkPermissao() then
						ToggleActionMenu()
						onmenu = true
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end