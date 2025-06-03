----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("oc_producao-municoes")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = 986.804, ['y'] = -92.951, ['z'] = 74.84 },
	{ ['x'] = 897.134, ['y'] = -2115.352, ['z'] = 30.763 }
}


-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "produzir-m-ak47" then
		TriggerServerEvent("produzir-municao","m-ak47")

	elseif data == "produzir-m-five" then
		TriggerServerEvent("produzir-municao","m-five")

	elseif data == "produzir-m-asmg" then
		TriggerServerEvent("produzir-municao","m-asmg")

	elseif data == "produzir-m-uzi" then
		TriggerServerEvent("produzir-municao","m-uzi")

	elseif data == "produzir-m-smg" then
		TriggerServerEvent("produzir-municao","m-smg")

	elseif data == "produzir-m-revolver" then
		TriggerServerEvent("produzir-municao","m-revolver")

	elseif data == "produzir-m-thompson" then
		TriggerServerEvent("produzir-municao","m-thompson")

	elseif data == "produzir-m-ak471" then
			TriggerServerEvent("produzir-municao","m-ak471")
	
		elseif data == "produzir-m-five1" then
			TriggerServerEvent("produzir-municao","m-five1")
	
		elseif data == "produzir-m-asmg1" then
			TriggerServerEvent("produzir-municao","m-asmg1")
	
		elseif data == "produzir-m-uzi1" then
			TriggerServerEvent("produzir-municao","m-uzi1")
	
		elseif data == "produzir-m-smg1" then
			TriggerServerEvent("produzir-municao","m-smg1")
	
		elseif data == "produzir-m-revolver1" then
			TriggerServerEvent("produzir-municao","m-revolver1")
	
		elseif data == "produzir-m-thompson1" then
			TriggerServerEvent("produzir-municao","m-thompson1")

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

RegisterNetEvent("fechar-nui-municoes")
AddEventHandler("fechar-nui-municoes", function()
	ToggleActionMenu()
	onmenu = false


	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local bowz,cdz = GetGroundZFor_3dCoord(986.81500244141,-92.774543762207,74.845855712891)
	local distance = GetDistanceBetweenCoords(986.81500244141,-92.77, cdz, x, y, z, true)

	if distance < 3.2 then
		TriggerEvent("municao:posicao1")	
	else
		TriggerEvent("municao:posicao2")
	end
end)

RegisterNetEvent("municao:posicao1")
AddEventHandler("municao:posicao1", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped, 184.91)
	SetEntityCoords(ped, 986.81500244141,-92.774543762207,74.845855712891-0.90,false,false,false,false)
end)

RegisterNetEvent("municao:posicao2")
AddEventHandler("municao:posicao2", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped, 184.91)
	SetEntityCoords(ped, 897.36413574219,-2115.3698730469,30.763425827026-0.90,false,false,false,false)
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000

		for k,v in pairs(prodMachine) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local prodMachine = prodMachine[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prodMachine.x, prodMachine.y, prodMachine.z, true ) < 1.2 and not onmenu then
				DrawText3D(prodMachine.x, prodMachine.y, prodMachine.z, "[~r~E~w~] Para acessar a ~r~BANCADA DE MUNIÇÕES~w~.")
			end
			if distance <= 5 then
				DrawMarker(23, prodMachine.x, prodMachine.y, prodMachine.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				idle = 5
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
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