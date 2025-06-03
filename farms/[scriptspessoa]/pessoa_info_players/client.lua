local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = Tunnel.getInterface("pessoa_info_player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
sRP = {}
Tunnel.bindInterface("pessoa_info_players",sRP)
vSERVER = Tunnel.getInterface("pessoa_info_players")

-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local table = {}
local cPlayer = nil
local esp = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function sRP.getPermission(status)
    cPlayer = status
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMSPEC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("esp",function(source,args,rawCommand)
    if not esp then
        TriggerEvent('chatMessage',"ESP",{255,70,50},"ON")
        esp = true
    else
        esp = false
        TriggerEvent('chatMessage',"ESP",{255,70,50},"OFF")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 3000
        if cPlayer then
            timeDistance = 1000
            for id = 0, 256 do 
                if NetworkIsPlayerActive(id) then
                    if GetPlayerPed(id) ~= PlayerId() then         
                        local players = vSERVER.returnPlayers(GetPlayerServerId(id))
                        table[id] = players 
                    end
                end
            end
        end
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOW ID
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread( function()
    while true do
        local timeDistance = 1000
        if cPlayer then 
            local ped = PlayerPedId()
            timeDistance = 4 
            if esp then
                for k,v in pairs(GetActivePlayers()) do 
                    local coords = GetEntityCoords(ped) 
                    local coords2 = GetEntityCoords(GetPlayerPed(v))
                    local distance = #(coords - vector3(coords2["x"],coords2["y"],coords2["z"]))

                    local pos = GetEntityCoords(GetPlayerPed(v))
                    local forPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 0.0, 0.0)
                    local forPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(v), 0, 0.0, 0.0)   
                    local steamName = GetPlayerName(v)
                    local playerHealth = GetEntityHealth(GetPlayerPed(v))

                    if playerHealth == 1 then
                        playerHealth = 0
                    end

                    local playerArmour = GetPedArmour(GetPlayerPed(v))
                    if playerArmour == 1 then
                        playerArmour = 0
                    end

                    if steamName == nil or steamName == "" or steamName == -1 then
                        steamName = "~r~STEAM NÃO ENCONTRADA"
                    end

                    local playerHealthPercent = playerHealth / 2
                    local playerArmourPercent = playerArmour
                    playerHealthPercent = math.floor(playerHealthPercent)
                    playerArmourPercent = math.floor(playerArmourPercent)

                    if PlayerPedId() ~= GetPlayerPed(v) then
                        if distance <= 400 then 
                            DrawText3D(coords2, "~r~ID~w~: "..table[v].."\n~r~STEAM~w~: "..steamName.."\n~r~VIDA~w~: "..playerHealth.."\n~r~COLETE~w~: "..playerArmour, 255, 255, 255)
                            DrawLine(forPos,forPos2, 252, 3, 3,1000)
                        end
                    end
                end
            end
        end
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(coords, text, r,g,b)
    local onScreen,_x,_y = World3dToScreen2d(coords["x"],coords["y"],coords["z"]-1.5)
    local cam = GetFinalRenderedCamCoord()
    local dist = #(coords - vector3(cam["x"],cam["y"],cam["z"]))
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.0, 0.35)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end