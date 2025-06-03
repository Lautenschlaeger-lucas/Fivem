local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","xpk_elevador")


RegisterServerEvent("andar1")
AddEventHandler("andar1",function()
local user_id = vRP.getUserId(source)
local player = vRP.getUserSource(user_id)
    if user_id then
        vRPclient.teleport(source,-28.96,-1094.33,26.45)
    end
end)

RegisterServerEvent("andar2")
AddEventHandler("andar2",function()
local user_id = vRP.getUserId(source)
local player = vRP.getUserSource(user_id)
    if user_id then
        vRPclient.teleport(source,-24.5,-1106.62,35.92)
    end
end)
