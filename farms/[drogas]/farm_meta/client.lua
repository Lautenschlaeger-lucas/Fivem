-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD : ! Jp#2263 | https://discord.gg/HEtBSAJuJU
-----------------------------------------------------------------------------------------------------------------------------------------


local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emp = Tunnel.getInterface('emp')


-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------

local etapa = 0
local componentes = false
local mistura = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDENADAS
-----------------------------------------------------------------------------------------------------------------------------------------

local blipcomponentes = { 1486.16,  6392.24,  20.79}
local blipmistura = {1493.3, 6390.37, 21.26}
local componente = {1492.86, 6390.22, 21.26}
local blipempacotar = {1500.57, 6394.11, 20.79}

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMEÇE A PRODUZIR
-----------------------------------------------------------------------------------------------------------------------------------------

CreateThread(function() 

    while true do
        local ped = PlayerPedId()
        local espera = 1000
        espera = 1     

        local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),blipcomponentes[1],blipcomponentes[2],blipcomponentes[3], true )
            if dist <= 15 and not componentes and etapa == 0 then           
                DrawMarker(23,blipcomponentes[1],blipcomponentes[2],blipcomponentes[3]-0.97,0,0,0,0,0,0,1.0,1.0,0.5,20,20,20,240,0,0,0,0)
                if dist <= 0.6 then 
                    DrawText3D(blipcomponentes[1],blipcomponentes[2],blipcomponentes[3], "~g~E~w~  PARA PEGAR OS COMPONENTES")
                    if IsControlJustPressed(0, 46) and emp.jpcheckPermissao() then
                        componentes = true
                        etapa = 1
                        SetEntityHeading(ped,77.0)
				        emp.jpCongelado()
                        vRP._playAnim(true,{{"pickup_object","pickup_low"}},false)
					    SetTimeout(2000,function()
					        vRP._playAnim(true,{{"anim@heists@box_carry@","idle"}},true)
					        vRP._CarregarObjeto("anim@heists@box_carry@","idle","bkr_prop_meth_sacid",50,28422,0.0,-0.1,-0.18,0.0,0.0,0.0) 
                            TriggerEvent("Notify","sucesso","Você pegou a caixa com os <b>componentes</b>.")
					    end)
                    end
                end
            end
        
            if etapa == 1 and componentes then
                local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), blipmistura[1],blipmistura[2],blipmistura[3], true)
                if dist <=15 then
                    DrawMarker(21,blipmistura[1],blipmistura[2],blipmistura[3]-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
                    if dist <=0.6 then
                        msg ('PRESSIONE ~b~E~w~ PARA COLOCAR OS COMPONENTES NO CHÃO',4,0.5,0.93,0.50,255,255,255,180)
                        if IsControlJustPressed(0, 46) then
                            etapa = 2
                            mistura = false
                            local x,y,z = table.unpack(vec3(1493.17,6390.24,21.26))
                            SetEntityHeading(ped, 97.75)
                            SetEntityCoords(ped, 1493.3, 6390.37, 21.26-1)
                            emp.jpCongelado()
                            vRP.DeletarObjeto() 
                            vRP._playAnim(false,{{'creatures@rottweiler@tricks@','petting_franklin'}},true)
                            Wait(2000)
						    vRP._stopAnim(source,false)
                            acido = CreateObject(GetHashKey('bkr_prop_meth_sacid'), x-0.5, y+0.2, z-1, 1, 0, 1)
                            TriggerEvent('Notify', 'sucesso','Você colocou os componentes no chão')
                        end
                    end    
                end
            end


            if etapa == 2 and mistura == false then
                local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), blipmistura[1],blipmistura[2],blipmistura[3], true)
                if dist <=15 then
                    DrawMarker(21,blipmistura[1],blipmistura[2],blipmistura[3]-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
                    if dist <=0.6 then
                        msg ('PRESSIONE ~b~E~w~ PARA MISTURAR OS COMPONENTES',4,0.5,0.93,0.50,255,255,255,180)
                        if IsControlJustPressed(0, 46) then

                            local x,y,z = table.unpack(vec3(1493.17,6390.24,21.26))
                            local pedRotacao = vec3(180.0, 180.0, 180.0)
                            local animacao = "anim@amb@business@meth@meth_monitoring_cooking@cooking@"
                            
                            repeat 
                            Wait(1)
                            RequestAnimDict(animacao)
                            RequestModel(GetHashKey('bkr_prop_meth_sacid'))
                            until HasAnimDictLoaded(animacao) and HasModelLoaded(GetHashKey('bkr_prop_meth_sacid'))

                            local cena = NetworkCreateSynchronisedScene(x + 5.0 ,y + 2.0, z - 0.4, pedRotacao, 2, false, false, 1148846080, 0, 1.3)
                            
                            NetworkAddPedToSynchronisedScene(ped, cena, animacao, "chemical_pour_long_cooker", 1.5, -4.0, 1, 16, 1148846080, 0)
                            NetworkAddEntityToSynchronisedScene(acido, cena, animacao, "chemical_pour_long_sacid", 4.0, -8.0, 1)
                        
                            Citizen.Wait(150)
                            NetworkStartSynchronisedScene(cena)
            
                            Citizen.Wait(GetAnimDuration(animacao, "chemical_pour_long_cooker") * 258 )
                            TriggerEvent('Notify', 'sucesso', 'Você misturou os ingredientes.')
                            DeleteObject(acido)
              
                            acido = CreateObject(GetHashKey('bkr_prop_meth_sacid'), x-0.5, y+0.2, z-1, 1, 0, 1)              

                            etapa = 3
                            mistura = true

                        end
                    end
                end
            end
            
            if etapa == 3 and mistura == true then 
                local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), blipempacotar[1],blipempacotar[2],blipempacotar[3], true)
                if dist <= 15 then
                    DrawMarker(21,blipempacotar[1],blipempacotar[2],blipempacotar[3]-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
                    if dist <= 0.6 then
                        msg('PRESSIONE ~b~E~w~ PARA EMBALAR A METANFETAMINA',4,0.5,0.93,0.50,255,255,255,180)
                        if IsControlJustPressed(0, 46) then
                            etapa = 0
                            mistura = false
                            componentes = false
                            local x,y,z = table.unpack(vec3(1500.57, 6394.11, 20.79))    
                            local  pedRotacao = vec3(180.0, 180.0, 168.0)

			                local animacao = "anim@amb@business@meth@meth_smash_weight_check@"          

                            repeat 
                                Wait(1)
                                RequestAnimDict(animacao)
                                RequestModel(GetHashKey('bkr_prop_meth_scoop_01a'))
                                RequestModel(GetHashKey('bkr_prop_meth_bigbag_03a'))
                                RequestModel(GetHashKey('bkr_prop_meth_openbag_02'))
                                RequestModel(GetHashKey('bkr_prop_coke_scale_01'))
                            until HasAnimDictLoaded(animacao) and HasModelLoaded(GetHashKey('bkr_prop_meth_scoop_01a')) and 
                            HasModelLoaded(GetHashKey('bkr_prop_meth_bigbag_03a')) and HasModelLoaded(GetHashKey('bkr_prop_meth_openbag_02'))
                            and HasModelLoaded(GetHashKey('bkr_prop_coke_scale_01'))

			                pazinha = CreateObject(GetHashKey('bkr_prop_meth_scoop_01a'), x, y, z, 1, 0, 1)
			                caixa = CreateObject(GetHashKey('bkr_prop_meth_bigbag_03a'), x, y, z, 1, 0, 1)
			                bolsa = CreateObject(GetHashKey('bkr_prop_meth_openbag_02'), x, y, z, 1, 0, 1)
			                balanca = CreateObject(GetHashKey('bkr_prop_coke_scale_01'), x, y, z, 1, 0, 1)
			                
			                local cena1 = NetworkCreateSynchronisedScene(x - 5,y - 0.5, z - 1.0, pedRotacao, 2, false, false, 1148846080, 0, 1.3)
			                local cena2 = NetworkCreateSynchronisedScene(x - 5,y - 0.5, z - 1.0, pedRotacao, 2, false, false, 1148846080, 0, 1.3)
			                NetworkAddPedToSynchronisedScene(ped, cena1, animacao, "break_weigh_char01", 1.5, -4.0, 1, 16, 1148846080, 0)
			                NetworkAddEntityToSynchronisedScene(pazinha, cena1, animacao, "break_weigh_scoop", 4.0, -8.0, 1)
			                NetworkAddEntityToSynchronisedScene(bolsa, cena1, animacao, "break_weigh_methbag01^3", 4.0, -8.0, 1)

			                NetworkAddPedToSynchronisedScene(ped, cena2, animacao, "break_weigh_char01", 1.5, -4.0, 1, 16, 1148846080, 0)
			                NetworkAddEntityToSynchronisedScene(balanca, cena2, animacao, "break_weigh_scale", 4.0, -8.0, 1)
			                NetworkAddEntityToSynchronisedScene(caixa, cena2, animacao, "break_weigh_box01^1", 4.0, -8.0, 1)

			                NetworkStartSynchronisedScene(cena1)
			                NetworkStartSynchronisedScene(cena2)

			                Citizen.Wait(GetAnimDuration(animacao, "break_weigh_char01") * 430)

			                TriggerEvent('Notify', 'sucesso', 'Você embalou a metanfetamina.')

			                DeleteObject(pazinha)
			                DeleteObject(caixa)
			                DeleteObject(bolsa)
			                DeleteObject(balanca)
                            DeleteObject(acido)

                            emp.jpcheckPagamento()

                        end
                    end
                end 
            end 

            if componentes then
                DisableControlAction(0,167,true)
                DisableControlAction(0,21,true)
                DisableControlAction(0,22,true)
            end


        Wait(1)
    end
end)
    
    
    
function msg (text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD : ! Jp#2263 | https://discord.gg/HEtBSAJuJU
-----------------------------------------------------------------------------------------------------------------------------------------   