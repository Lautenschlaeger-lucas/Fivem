------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------- CONEXÃO ----------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = Tunnel.getInterface("pessoa_area_pvp")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------- VARIÁVEIS --------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local jogando = false
local cooldown = 0


function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------- INICIAR PVP ------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pvp",function(source,args)
	local ped = PlayerPedId()
	if not jogando then
		vRP.playSound("Menu_Accept","Phone_SoundSet_Default")
		jogando = true
		src.addGroup()
		src.teleport()
		cooldown = 5
		
		SetPedArmour(ped,100)
		RemoveAllPedWeapons(ped,true)
		weaponPed("WEAPON_KNIFE",0)
		weaponPed("WEAPON_BAT",0)
		weaponPed("WEAPON_STUNGUN",0)
		weaponPed("WEAPON_PISTOL50",250)
		weaponPed("WEAPON_COMBATPDW",250)
		weaponPed("WEAPON_PUMPSHOTGUN_MK2",250)
		weaponPed("WEAPON_SPECIALCARBINE_MK2",250)
		weaponPed("WEAPON_GRENADE",25)

		ShowNotification("<b>Você entrou na arena PVP</b>.",5000)
		ShowNotification("<b>Pressione ~y~F7~w~ para sair da arena</b>.",10000)
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------- COMANDO REVIVER --------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("respawn",function(source,args)
	local ped = PlayerPedId()
	if jogando then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -2176.49, 5189.08, 16.91, true ) < 300 and vRP.isInComa() then
			src.Respawn()
			src.teleport()
			ShowNotification("<b>Você respawnou</b>.",5000)
			vRP.playSound("Menu_Accept","Phone_SoundSet_Default")
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------- COMANDO ARMAS --------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("armas",function(source,args)
	local ped = PlayerPedId()
	if jogando then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -2176.49, 5189.08, 16.91, true ) < 300 then
			RemoveAllPedWeapons(ped,true)
			weaponPed("WEAPON_NIGHTSTICK",0)
			weaponPed("WEAPON_FLASHLIGHT",0)
			weaponPed("WEAPON_STUNGUN",0)
			weaponPed("WEAPON_PISTOL50",250)
			weaponPed("WEAPON_COMBATPDW",250)
			weaponPed("WEAPON_PUMPSHOTGUN_MK2",250)
			weaponPed("WEAPON_SPECIALCARBINE_MK2",250)
			weaponPed("WEAPON_GRENADE",25)
			
			TriggerEvent("Notify","importante","Pack <b>EVENTO</b> aplicado com sucesso.",10000)
			vRP.playSound("Menu_Accept","Phone_SoundSet_Default")
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------- THREAD SAIR --------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if jogando then
			if cooldown > 0 then
				cooldown = cooldown - 1
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local ms = 1
		if jogando then
			DrawMarker(1,-2176.49, 5189.08, 16.91-50,0,0,0,0.0,0,0,300.0,300.0,300.0,0,0,0,1000,0,0,0,1)
			if cooldown < 1 then
				if IsControlJustPressed(0,168) then
					jogando = false
					vRP.playSound("Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
					TriggerEvent("Notify","importante","<b>Você saiu da arena PVP</b>.",10000)
					src.remGroup()
					SetPedArmour(ped,0)
					RemoveAllPedWeapons(ped,true)
					src.teleportBack()
				end
			end
		end
		Citizen.Wait(ms)
	end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local ms = 5000
		if jogando then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -2176.49, 5189.08, 16.91, true ) > 300 then
				jogando = false
				vRP.playSound("Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				TriggerEvent("Notify","importante","<b>Você saiu da arena PVP</b>.",10000)
				src.remGroup()
				SetPedArmour(ped,0)
				RemoveAllPedWeapons(ped,true)
				src.teleportBack()
			end
		end
		Citizen.Wait(ms)
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------- FUNÇÃO WEAPONPED ---------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function weaponPed(weapon,ammoclip)
	GiveWeaponToPed(GetPlayerPed(-1),GetHashKey(weapon),ammoclip,false,true)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------- FUNÇÃO NOTIFICAR ---------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end