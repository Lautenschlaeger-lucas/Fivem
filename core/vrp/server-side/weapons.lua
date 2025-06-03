-----------------------------------------------------------------------------------------------------------------------------------------
-- GET WEAPONS ID
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getWeaponsId(user_id)
    local infos = vRP.query("vRP/get_weapon",{ user_id = user_id })
	return infos
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD WEAPONS ID
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.addWeaponId(user_id,weapon,ammo)
    local data = vRP.getWeaponsId(user_id)
    if data then
	    for k, v in pairs(data) do
	    	if v.weapon == weapon then
                local newammo = v.ammo + ammo
                vRP.execute("vRP/del_weapon", { user_id = user_id, weapon = weapon })
                vRP.execute("vRP/add_weapon",{ user_id = user_id, weapon = weapon, ammo = newammo })
            elseif not v.weapon then
                vRP.execute("vRP/add_weapon",{ user_id = user_id, weapon = weapon, ammo = ammo })
            end
        end
    end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM AMMO ID
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.remAmmoWeaponId(user_id,weapon,ammo)
    local data = vRP.getWeaponsId(user_id)
    if data then
        for k, v in pairs(data) do
            if v.weapon == weapon then
                vRP.execute("vRP/del_weapon", { user_id = user_id, weapon = weapon })
                vRP.execute("vRP/add_weapon",{ user_id = user_id, weapon = weapon, ammo = ammo })
            elseif not v.weapon then
                vRP.execute("vRP/add_weapon",{ user_id = user_id, weapon = weapon, ammo = ammo })
            end
        end
    end
	return true
end