-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.playSound(dict,name)
	PlaySoundFrontend(-1,dict,name,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMODELPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getModelPlayer()
	local ped = PlayerPedId()
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		return "mp_m_freemode_01"
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		return "mp_f_freemode_01"
	elseif GetEntityModel(ped) == GetHashKey("s_f_y_scrubs_01") then
		return "s_f_y_scrubs_01"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPOSITIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getPositions()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	return vRPserver.mathLegth(coords.x),vRPserver.mathLegth(coords.y),vRPserver.mathLegth(coords.z),vRPserver.mathLegth(GetEntityHeading(ped))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYSKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.applySkin(model)
	local mHash = model

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		RequestModel(mHash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mHash) then
		SetPlayerModel(PlayerId(),mHash)
		SetModelAsNoLongerNeeded(mHash)
	end

	SetPedComponentVariation(PlayerPedId(),1,0,0,2)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADREADY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	NetworkSetFriendlyFireOption(true)
	SetCanAttackFriendly(PlayerPedId(),true,true)
	while true do
		Citizen.Wait(10000)
		if IsPlayerPlaying(PlayerId()) and playerReady then
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			vRPserver._updatePos(x,y,z)
			vRPserver._updateHealth(tvRP.getHealth())
			vRPserver._updateCustomization(tvRP.getCustomization())
			vRPserver._updateWeapons(tvRP.getWeapons())
			vRPserver._updateArmour(tvRP.getArmour())
			vRPserver.updateClothes(json.encode(custom),true)
		end
	end
end)

RegisterNetEvent('save:database')
AddEventHandler('save:database',function()
	if IsPlayerPlaying(PlayerId()) and state_ready then
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		vRPserver._updatePos(x,y,z)
		vRPserver._updateHealth(tvRP.getHealth())
		vRPserver._updateWeapons(tvRP.getWeapons())
		vRPserver._updateCustomization(tvRP.getCustomization())
		vRPserver.updateClothes(json.encode(custom),true)
		
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- PARSEPART
-----------------------------------------------------------------------------------------------------------------------------------------
local function parsePart(key)
	if type(key) == "string" and string.sub(key,1,1) == "p" then
		return true,tonumber(string.sub(key,2))
	else
		return false,tonumber(key)
	end
end

function tvRP.getDrawables(part)
	local isprop, index = parsePart(part)
	if isprop then
		return GetNumberOfPedPropDrawableVariations(PlayerPedId(),index)
	else
		return GetNumberOfPedDrawableVariations(PlayerPedId(),index)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getCustomization()
	local ped = PlayerPedId()
	local custom = {}
	custom.modelhash = GetEntityModel(ped)

	for i = 0,20 do
		custom[i] = { GetPedDrawableVariation(ped,i),GetPedTextureVariation(ped,i),GetPedPaletteVariation(ped,i) }
	end

	for i = 0,10 do
		custom["p"..i] = { GetPedPropIndex(ped,i),math.max(GetPedPropTextureIndex(ped,i),0) }
	end

	return custom
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.setCustomization(custom)
	local r = async()
	Citizen.CreateThread(function()
		if custom then
			local ped = PlayerPedId()
			local mhash = nil

			if custom.modelhash then
				mhash = custom.modelhash
			elseif custom.model then
				mhash = GetHashKey(custom.model)
			end

			if mhash then
				RequestModel(mhash)
				while not HasModelLoaded(mhash) do
					RequestModel(mhash)
					Citizen.Wait(10)
				end

				if HasModelLoaded(mhash) then
				
					local weapons = tvRP.getWeapons()
                    local armour = GetPedArmour(ped)
                    local health = tvRP.getHealth()

                    SetPlayerModel(PlayerId(),mhash)
                    tvRP.setHealth(health)
                    tvRP.giveWeapons(weapons,true)
                    tvRP.setArmour(armour)
                    SetModelAsNoLongerNeeded(mhash)
				end
			end

			ped = PlayerPedId()

			for k,v in pairs(custom) do
				if k ~= "model" and k ~= "modelhash" then
					local isprop,index = parsePart(k)
					if isprop then
						if v[1] < 0 then
							ClearPedProp(ped,index)
						else
							SetPedPropIndex(ped,index,v[1],v[2],true)
						end
					else
						SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
					end
					TriggerEvent("reloadtattos")
				end
			end
		end
		r()
	end)
	return r:wait()
end