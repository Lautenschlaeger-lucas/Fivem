-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("vrp_survival",cnVRP)
vSERVER = Tunnel.getInterface("vrp_survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local deadPlayer = false
local deathtimer = 500
local blockControls = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 100
		local ped = PlayerPedId()
		x,y,z = table.unpack(GetEntityCoords(ped))
		if GetEntityHealth(ped) <= 101 and deathtimer >= 0 then
			if not deadPlayer then
				timeDistance = 100
				deadPlayer = true
				local coords = GetEntityCoords(ped)
				NetworkResurrectLocalPlayer(coords,true,true,false)
				deathtimer = 500

				if not IsEntityPlayingAnim(ped,"dead","dead_a",3) and not IsPedInAnyVehicle(ped) then
					vRP.playAnim(false,{"dead","dead_a"},true)
				end
				
				SetEntityHealth(ped,101)
				SetEntityInvincible(ped,true)

				TriggerEvent("radio:outServers")
				TriggerServerEvent("vrp_inventory:Cancel")
			else
				if deathtimer > 0 then
					timeDistance = 4
					SetEntityHealth(ped,101)
					DrawText3D(x,y,z,"AGUARDE ~r~"..deathtimer.."~w~ SEGUNDOS.")

					if not IsEntityPlayingAnim(ped,"dead","dead_a",3) and not IsPedInAnyVehicle(ped) then
						vRP.playAnim(false,{"dead","dead_a"},true)
					end
				else
					timeDistance = 4
					DrawText3D(x,y,z,"DIGITE ~r~/GG~w~.")
					
					if not IsEntityPlayingAnim(ped,"dead","dead_a",3) and not IsPedInAnyVehicle(ped) then
						vRP.playAnim(false,{"dead","dead_a"},true)
					end
				
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATHTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if deadPlayer and deathtimer > 0 then
			deathtimer = deathtimer - 1
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gg",function(source,args,rawCommand)
	if deathtimer <= 0 then
		vSERVER.ResetPedToHospital()
	else
		TriggerEvent("Notify","aviso","AGUARDE: <b>"..deathtimer.."</b> OU CHAME OS <b>PARAMÉDICOS</b>.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISHDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.finishDeath()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 101 then
		deadPlayer = false
		ClearPedBloodDamage(ped)
		SetEntityHealth(ped,200)
		SetEntityInvincible(ped,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEADPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.deadPlayer()
	return deadPlayer
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVEPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.revivePlayer(health)
	SetEntityHealth(PlayerPedId(),health)
	SetEntityInvincible(PlayerPedId(),false)

	if deadPlayer then
		deadPlayer = false
		ClearPedTasks(PlayerPedId())
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_survival:CheckIn")
AddEventHandler("vrp_survival:CheckIn",function()
	SetEntityHealth(PlayerPedId(),102)
	SetEntityInvincible(PlayerPedId(),false)

	Citizen.Wait(500)

	deadPlayer = false
	blockControls = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("updatePrison")
AddEventHandler("updatePrison",function()
	SetEntityHealth(PlayerPedId(),110)
	SetEntityInvincible(PlayerPedId(),false)

	if deadPlayer then
		deadPlayer = false
		blockControls = true
		ClearPedTasks(PlayerPedId())
		TriggerEvent("resetBleeding")
		TriggerEvent("resetDiagnostic")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKCONTROLS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 100
		local ped = PlayerPedId()
		if blockControls or deadPlayer then
			timeDistance = 4
			DisablePlayerFiring(ped,true)
			DisableControlAction(1,22,true)
			DisableControlAction(1,73,true)
			DisableControlAction(1,167,true)
			DisableControlAction(1,29,true)
			DisableControlAction(1,182,true)
			DisableControlAction(1,187,true)
			DisableControlAction(1,189,true)
			DisableControlAction(1,190,true)
			DisableControlAction(1,188,true)
			DisableControlAction(1,311,true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTCURE
-----------------------------------------------------------------------------------------------------------------------------------------
local cure = false
function cnVRP.startCure()
	local ped = PlayerPedId()

	if cure then
		return
	end

	cure = true
	TriggerEvent("Notify","sucesso","O tratamento começou, espere o paramédico libera-lo.",3000)

	if cure then
		repeat
			Citizen.Wait(1000)
			if GetEntityHealth(ped) > 101 then
				SetEntityHealth(ped,GetEntityHealth(ped)+1)
			end
		until GetEntityHealth(ped) >= 200 or GetEntityHealth(ped) <= 101
			TriggerEvent("Notify","sucesso","Tratamento concluído.",3000)
			cure = false
			blockControls = false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local beds = {
	{ GetHashKey("v_med_bed1"),0.0,0.0 },
	{ GetHashKey("v_med_bed2"),0.0,0.0 },
	{ -1498379115,1.0,90.0 },
	{ -1519439119,1.0,0.0 },
	{ -289946279,1.0,0.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPEDINBED
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.SetPedInBed()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	for k,v in pairs(beds) do
		local object = GetClosestObjectOfType(x,y,z,0.9,v[1],0,0,0)
		if DoesEntityExist(object) then
			local x2,y2,z2 = table.unpack(GetEntityCoords(object))
			
			SetEntityCoords(ped,x2,y2,z2+v[2])
			SetEntityHeading(ped,GetEntityHeading(object)+v[3]-180.0)

			vRP.playAnim(false,{"dead","dead_a"},true)

			SetTimeout(7000,function()
				TriggerServerEvent("vrp_inventory:Cancel")
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCREENFADEINOUT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_survival:FadeOutIn")
AddEventHandler("vrp_survival:FadeOutIn",function()
	DoScreenFadeOut(1000)
	Citizen.Wait(5000)
	DoScreenFadeIn(1000)
end)