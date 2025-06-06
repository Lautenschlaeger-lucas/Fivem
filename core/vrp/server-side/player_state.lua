-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFAULTCUSTOM
-----------------------------------------------------------------------------------------------------------------------------------------
local customize = {}
for i = 0,19 do
	customize[i] = { 1,0 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	local data = vRP.getUserDataTable(user_id)
	if data then
		if data.customization then
			data.customization = nil
		end

		if data.position then
			if data.position.x == nil or data.position.y == nil or data.position.z == nil then
				data.position = { x = 27.66, y = -1763.32, z = 29.32 }
			end
		else
			data.position = { x = 27.66, y = -1763.32, z = 29.32 }
		end
		vRPclient.teleport(source,data.position.x,data.position.y,data.position.z+0.5)

		if data.skin then
			vRPclient.applySkin(source,data.skin)
		end

		if data.health then
			vRPclient.setHealth(source,data.health)
			vRPclient.setArmour(source,data.armour)
			TriggerClientEvent("statusHunger",source,data.hunger)
			TriggerClientEvent("statusThirst",source,data.thirst)
			TriggerClientEvent("statusStress",source,data.stress)
		end

		if data.inventory == nil then
			data.inventory = {}
		end

		vRPclient.playerReady(source)

		Citizen.Wait(1000)

		-- VRP_BARBERSHOP
		local barberData = vRP.query("vRP/selectSkin",{ user_id = parseInt(user_id) })
		if barberData[1] then
			TriggerClientEvent("vrp_barbershop:setCustomization",source,{ parseInt(barberData[1].fathers),parseInt(barberData[1].kinship),parseInt(barberData[1].eyecolor),parseInt(barberData[1].skincolor),parseInt(barberData[1].acne),parseInt(barberData[1].stains),parseInt(barberData[1].freckles),parseInt(barberData[1].aging),parseInt(barberData[1].hair),parseInt(barberData[1].haircolor),parseInt(barberData[1].haircolor2),parseInt(barberData[1].makeup),parseInt(barberData[1].makeupintensity),parseInt(barberData[1].makeupcolor),parseInt(barberData[1].lipstick),parseInt(barberData[1].lipstickintensity),parseInt(barberData[1].lipstickcolor),parseInt(barberData[1].eyebrow),parseInt(barberData[1].eyebrowintensity),parseInt(barberData[1].eyebrowcolor),parseInt(barberData[1].beard),parseInt(barberData[1].beardintentisy),parseInt(barberData[1].beardcolor),parseInt(barberData[1].blush),parseInt(barberData[1].blushintentisy),parseInt(barberData[1].blushcolor) })
		else
			vRP.execute("vRP/insertSkin",{ user_id = parseInt(user_id) })
		end

		Citizen.Wait(1000)

		-- VRP_SKINSHOP
		local playerData = vRP.getUData(user_id,"Clothings")
		local resultData = json.decode(playerData)
		if resultData == nil then
			resultData = "clean"
		end
		TriggerClientEvent("vrp_skinshop:skinData",source,resultData)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPOSITIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.updatePositions(x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.position = { x = tvRP.mathLegth(x), y = tvRP.mathLegth(y), z = tvRP.mathLegth(z) }
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MATHLEGTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.mathLegth(n)
	return math.ceil(n*100)/100
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryDeleteEntity")
AddEventHandler("tryDeleteEntity",function(index)
	TriggerClientEvent("syncDeleteEntity",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYCLEANENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryCleanEntity")
AddEventHandler("tryCleanEntity",function(index)
	TriggerClientEvent("syncCleanEntity",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIDCHUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function gridChunk(x)
	return math.floor((x + 8192) / 128)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOCHANNEL
-----------------------------------------------------------------------------------------------------------------------------------------
function toChannel(v)
	return (v.x << 8) | v.y
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGRIDZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getGridzone(x,y)
	local gridChunk = vector2(gridChunk(x),gridChunk(y))
	return toChannel(gridChunk)
end