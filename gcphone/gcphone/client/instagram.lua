--====================================================================================
-- #XenKnighT : GÜRKAN SELİM ALBAYRAK
--====================================================================================

RegisterNetEvent("gcphone:233223insto_getinstas")
AddEventHandler("gcphone:233223insto_getinstas", function(instas)
  SendNUIMessage({event = 'insto_instas', instas = instas})
  SetNuiFocus(true, true)
end)

RegisterNetEvent("gcphone:233223insto_getFavoriteinstas")
AddEventHandler("gcphone:233223insto_getFavoriteinstas", function(instas)
  SendNUIMessage({event = 'insto_favoriteinstas', instas = instas})
end)

RegisterNetEvent("gcphone:233223insto_newinstas")
AddEventHandler("gcphone:233223insto_newinstas", function(inap)
  SendNUIMessage({event = 'insto_newinap', inap = inap})
end)

RegisterNetEvent("gcphone:233223insto_updateinapLikes")
AddEventHandler("gcphone:233223insto_updateinapLikes", function(inapId, likes)
  SendNUIMessage({event = 'insto_updateinapLikes', inapId = inapId, likes = likes})
end)

RegisterNetEvent("gcphone:233223insto_setAccount")
AddEventHandler("gcphone:233223insto_setAccount", function(username, password, avatarUrl)
  SendNUIMessage({event = 'insto_setAccount', forename = forename, surname = surname, username = username, password = password, avatarUrl = avatarUrl})
end)

RegisterNetEvent("gcphone:233223insto_createAccount")
AddEventHandler("gcphone:233223insto_createAccount", function(account)
  SendNUIMessage({event = 'insto_createAccount', account = account})
end)

RegisterNetEvent("gcphone:233223insto_showError")
AddEventHandler("gcphone:233223insto_showError", function(title, message, image)
  SendNUIMessage({event = 'insto_showError', message = message, title = title, image = image})
end)

RegisterNetEvent("gcphone:233223insto_showSuccess")
AddEventHandler("gcphone:233223insto_showSuccess", function(title, message, image, filters)
  SendNUIMessage({event = 'insto_showSuccess', message = message, title = title, image = image, filters = filters})
end)

RegisterNetEvent("gcphone:233223insto_setinapLikes")
AddEventHandler("gcphone:233223insto_setinapLikes", function(inapId, isLikes)
  SendNUIMessage({event = 'insto_setinapLikes', inapId = inapId, isLikes = isLikes})
end)



RegisterNUICallback('insto_login', function(data, cb)
  TriggerServerEvent('gcphone:233223insto_login', data.username, data.password)
end)
RegisterNUICallback('insto_changePassword', function(data, cb)
  TriggerServerEvent('gcphone:233223insto_changePassword', data.forename, data.surname, data.username, data.password, data.newPassword)
end)


RegisterNUICallback('insto_createAccount', function(data, cb)
  TriggerServerEvent('gcphone:233223insto_createAccount', data.forename, data.surname, data.username, data.password, data.avatarUrl)
end)

RegisterNUICallback('insto_getinstas', function(data, cb)
  TriggerServerEvent('gcphone:233223insto_getinstas', data.forename, data.surname, data.username, data.password)
end)

RegisterNUICallback('insto_getFavoriteinstas', function(data, cb)
  TriggerServerEvent('gcphone:233223insto_getFavoriteinstas', data.forename, data.surname, data.username, data.password)
end)

RegisterNUICallback('insto_postinap', function(data, cb)
  TriggerServerEvent('gcphone:233223insto_postinstas', data.username or '', data.password or '', data.message or '', data.image or '', data.filters)
end)

RegisterNUICallback('insto_toggleLikeinap', function(data, cb)
  TriggerServerEvent('gcphone:233223insto_toogleLikeinap', data.forename or '', data.surname or '', data.username or '', data.password or '', data.inapId)
end)

RegisterNUICallback('insto_setAvatarUrl', function(data, cb)
  TriggerServerEvent('gcphone:233223insto_setAvatarUrl', data.username or '', data.password or '', data.avatarUrl)
end)


RegisterNUICallback('takeInsPhoto', function(data, cb)
	CreateMobilePhone(1)
  CellCamActivate(true, true)
  takeInsPhoto = true
  Citizen.Wait(0)
  SetNuiFocus(false)
  if hasFocus == true then
    SetNuiFocus(false, false)
    hasFocus = false
  end
	while takeInsPhoto do
    Citizen.Wait(0)

		if IsControlJustPressed(1, 27) then -- Toogle Mode
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
    elseif IsControlJustPressed(1, 177) then -- CANCEL
      DestroyMobilePhone()
      CellCamActivate(false, false)
      cb(json.encode({ url = nil }))
      takeInsPhoto = false
      TriggerEvent('gcphone:233223bugfix')
      break
    elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
			exports['screenshot-basic']:requestScreenshotUpload(data.url, data.field, function(data)
        local resp = json.decode(data)
        DestroyMobilePhone()
        CellCamActivate(false, false)
        cb(json.encode({ url = resp.files[1].url })) 
      SetNuiFocus(true, true)		
      end)
      takeInsPhoto = false
		end
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(19)
    HideHudAndRadarThisFrame()
  end
  Citizen.Wait(1000)
  PhonePlayAnim('text', false, true)
end)


RegisterNUICallback('takeInsPro', function(data, cb)
	CreateMobilePhone(1)
  CellCamActivate(true, true)
  takeInsPro = true
  Citizen.Wait(0)
  SetNuiFocus(false)
  if hasFocus == true then
    SetNuiFocus(false, false)
    hasFocus = false
  end
	while takeInsPro do
    Citizen.Wait(0)

		if IsControlJustPressed(1, 27) then -- Toogle Mode
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
    elseif IsControlJustPressed(1, 177) then -- CANCEL
      DestroyMobilePhone()
      CellCamActivate(false, false)
      cb(json.encode({ url = nil }))
      takeInsPro = false
      TriggerEvent('gcphone:233223bugfix')
      break
    elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
			exports['screenshot-basic']:requestScreenshotUpload(data.url, data.field, function(data)
        local resp = json.decode(data)
        DestroyMobilePhone()
        CellCamActivate(false, false)
        cb(json.encode({ url = resp.files[1].url })) 
      SetNuiFocus(true, true)		
      end)
      takeInsPro = false
		end
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(19)
    HideHudAndRadarThisFrame()
  end
  Citizen.Wait(1000)
  PhonePlayAnim('text', false, true)
end)

