local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPg = Proxy.getInterface("xpk_elevador")

local open = false
function killTutorialMenu()
SetNuiFocus( false, false )
    SendNUIMessage({
      infos = false
    })
    open = false
end


Citizen.CreateThread(function()
  while true do
    if isNearInfos() then
      if IsControlJustPressed(1, 38) then
        if not open then
          SetNuiFocus(true,true)
          SendNUIMessage({
            infos = true
          })
          open = true
        end
      end
    end
    Citizen.Wait(3)
  end
end)


function isNearInfos()
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(cfg.infos) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= 2) then
      return true
    end
  end
end

RegisterNUICallback('andar1', function(data, cb)
TriggerServerEvent("andar1")
killTutorialMenu()    
Fade(1200)    
  cb('ok')
end)


RegisterNUICallback('andar2', function(data, cb)
TriggerServerEvent("andar2")
killTutorialMenu()    
Fade(1200)    
  cb('ok')
end)

function Fade(time)
	DoScreenFadeOut(800)
	Wait(time)
	DoScreenFadeIn(800)
end