local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
oC = Tunnel.getInterface("oc_producao-armas")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = 1402.46, ['y'] = 1139.92, ['z'] = 109.75 },
	{ ['x'] = -1870.509, ['y'] = 2061.71, ['z'] = 135.434 },
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
	print(data)
	if data == "produzir-ak47" then
		TriggerServerEvent("produzir-armas","ak47")
	elseif data == "produzir-five" then
		TriggerServerEvent("produzir-armas","five")
	elseif data == "produzir-mtar21" then
		TriggerServerEvent("produzir-armas","mtar21")
	elseif data == "produzir-uzi" then
		TriggerServerEvent("produzir-armas","uzi")	
	elseif data == "produzir-mp5" then
		TriggerServerEvent("produzir-armas","mp5")
	elseif data == "produzir-revolver" then
		TriggerServerEvent("produzir-armas","revolver")
	elseif data == "produzir-thompson" then
		TriggerServerEvent("produzir-armas","thompson")

	elseif data == "produzir-cak47" then
			TriggerServerEvent("produzir-armas","cak47")
	elseif data == "produzir-cfive" then
			TriggerServerEvent("produzir-armas","cfive")
	elseif data == "produzir-cmtar21" then
			TriggerServerEvent("produzir-armas","cmtar21")
	elseif data == "produzir-cuzi" then
			TriggerServerEvent("produzir-armas","cuzi")	
	elseif data == "produzir-cmp5" then
			TriggerServerEvent("produzir-armas","cmp5")
	elseif data == "produzir-crevolver" then
			TriggerServerEvent("produzir-armas","crevolver")
	elseif data == "produzir-cthompson" then
			TriggerServerEvent("produzir-armas","cthompson")

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)


RegisterNetEvent("fechar-nui-armas")
AddEventHandler("fechar-nui-armas", function()
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
				DrawText3D(prodMachine.x, prodMachine.y, prodMachine.z, "[~r~E~w~] ~r~BANCADA DE ARMAS~w~.")
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