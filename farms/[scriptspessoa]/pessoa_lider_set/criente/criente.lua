                                                        ---------------------------------------------------------
                                                        --                                                     --
                                                        --██▓███  ▓█████   ██████   ██████  ▒█████   ▄▄▄       --
                                                        --▓██░  ██▒▓█   ▀ ▒██    ▒ ▒██    ▒ ▒██▒  ██▒▒████▄    --
                                                        --▓██░ ██▓▒▒███   ░ ▓██▄   ░ ▓██▄   ▒██░  ██▒▒██  ▀█▄  --
                                                        --▒██▄█▓▒ ▒▒▓█  ▄   ▒   ██▒  ▒   ██▒▒██   ██░░██▄▄▄▄██ --
                                                        --▒██▒ ░  ░░▒████▒▒██████▒▒▒██████▒▒░ ████▓▒░ ▓█   ▓██▒--
                                                        --▒▓▒░ ░  ░░░ ▒░ ░▒ ▒▓▒ ▒ ░▒ ▒▓▒ ▒ ░░ ▒░▒░▒░  ▒▒   ▓▒█░--
                                                        --░▒ ░      ░ ░  ░░ ░▒  ░ ░░ ░▒  ░ ░  ░ ▒ ▒░   ▒   ▒▒ ░--
                                                        --░░          ░   ░  ░  ░  ░  ░  ░  ░ ░ ░ ▒    ░   ▒   --
                                                        --            ░  ░      ░        ░      ░ ░        ░  ░--
                                                        ---------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------- CONEXÃO ----------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = Tunnel.getInterface("pessoa_lider_set")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------- ADICIONAR SET GANG ---------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("setgang",function(source,args)
    if src.checkPermissao() then
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -25.49,-1404.45,24.57--[[families]], true ) < 20 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 116.07,-1997.14,12.61 --[[ballas]], true ) < 20 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 470.83,-1894.33,26.1 --[[vagos]], true ) < 20 then
            src.menuSetarGang()
        else
            TriggerEvent("Notify","negado","Você não está no seu <b>QG</b>.",5000)
        end
    else
        TriggerEvent("Notify","negado","Você não possui <b>permissão</b>.",5000)
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------- REMOVER SET GANG ----------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remgang",function(source,args)
    if src.checkPermissao() then
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -25.49,-1404.45,24.57--[[families]], true ) < 20 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 116.07,-1997.14,12.61 --[[ballas]], true ) < 20 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 470.83,-1894.33,26.1 --[[vagos]], true ) < 20 then
            src.menuRemoverGang()
        else
            TriggerEvent("Notify","negado","Você não está no seu <b>QG</b>.",5000)
        end
    else
        TriggerEvent("Notify","negado","Você não possui <b>permissão</b>.",5000)
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------- ADICIONAR SET FAC ---------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("setfac",function(source,args)
    if src.checkPermissao() then
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 369.6, 277.56, 91.2 --[[GALAXY]], true ) < 50 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -573.97, 291.03, 79.18 --[[TEQUILA LA]], true ) < 50 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -624.81, 234.81, 81.88, --[[CAFETERIA]] true ) < 50 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 741.28, -821.03, 22.67, --[[ARCADE]] true ) < 50 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 112.56, -1287.4, 28.46, --[[VANILLA]] true ) < 50 then 
            src.menuSetarFac()
        else
            TriggerEvent("Notify","negado","Você não está no seu <b>QG</b>.",5000)
        end
    else
        TriggerEvent("Notify","negado","Você não possui <b>permissão</b>.",5000)
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------- REMOVER SET FAC ----------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remfac",function(source,args)
    if src.checkPermissao() then
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 369.6, 277.56, 91.2 --[[GALAXY]], true ) < 50 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -573.97, 291.03, 79.18 --[[TEQUILA LA]], true ) < 50 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -624.81, 234.81, 81.88, --[[CAFETERIA]] true ) < 50 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 741.28, -821.03, 22.67, --[[ARCADE]] true ) < 50 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 112.56, -1287.4, 28.46, --[[VANILLA]] true ) < 50 then 
            src.menuRemoverFac()
        else
            TriggerEvent("Notify","negado","Você não está no seu <b>QG</b>.",5000)
        end
    else
        TriggerEvent("Notify","negado","Você não possui <b>permissão</b>.",5000)
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------- ADICIONAR SET ORG ---------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("setorg",function(source,args)
    if src.checkPermissao() then
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 453.07, -986.64, 30.69 --[[DP]], true ) < 50 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 327.34, -590.78, 43.29 --[[HOSPITAL]], true ) < 50 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -211.82, -1325.18, 30.9 --[[MECANICO]], true ) < 50 then
            src.menuSetarGang()
        else
            TriggerEvent("Notify","negado","Você não está no seu <b>QG</b>.",5000)
        end
    else
        TriggerEvent("Notify","negado","Você não possui <b>permissão</b>.",5000)
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------- REMOVER SET ORG ----------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remorg",function(source,args)
    if src.checkPermissao() then
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 453.07, -986.64, 30.69 --[[DP]], true ) < 50 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 327.34, -590.78, 43.29 --[[HOSPITAL]], true ) < 50 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -211.82, -1325.18, 30.9 --[[MECANICO]], true ) < 50 then
            src.menuRemoverGang()
        else
            TriggerEvent("Notify","negado","Você não está no seu <b>QG</b>.",5000)
        end
    else
        TriggerEvent("Notify","negado","Você não possui <b>permissão</b>.",5000)
    end
end)