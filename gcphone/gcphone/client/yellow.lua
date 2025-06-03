
RegisterNetEvent("gcphone:233223yellow_getPagess")
AddEventHandler("gcphone:233223yellow_getPagess", function(pagess)
  SendNUIMessage({event = 'yellow_pagess', pagess = pagess})
end)

RegisterNetEvent("gcphone:233223yellow_newPagess")
AddEventHandler("gcphone:233223yellow_newPagess", function(pages)
  SendNUIMessage({event = 'yellow_newPages', pages = pages})
end)

RegisterNetEvent("gcphone:233223yellow_getUserTweets")
AddEventHandler("gcphone:233223yellow_getUserTweets", function(pagess)
  SendNUIMessage({event = 'yellow_UserTweets', pagess = pagess})
end)

RegisterNetEvent("gcphone:233223bank_gkst")
AddEventHandler("gcphone:233223bank_gkst", function(bankgks)
  SendNUIMessage({event = 'bankk_gks', bankgks = bankgks})
end)

RegisterNetEvent("gcphone:233223yellow_showError")
AddEventHandler("gcphone:233223yellow_showError", function(title, message)
  SendNUIMessage({event = 'yellow_showError', message = message, title = title})
end)

RegisterNetEvent("gcphone:233223yellow_showSuccess")
AddEventHandler("gcphone:233223yellow_showSuccess", function(title, message)
  SendNUIMessage({event = 'yellow_showSuccess', message = message, title = title})
end)

RegisterNUICallback('yellow_getPagess', function(data, cb)
  TriggerServerEvent('gcphone:233223yellow_getPagess', data.firstname, data.phone_number)
end)

RegisterNUICallback('yellow_postPages', function(data, cb)
  TriggerServerEvent('gcphone:233223yellow_postPagess', data.firstname or '', data.phone_number or '', data.lastname or '', data.message, data.image)
end)


RegisterNUICallback('yellow_getUserTweets', function(data, cb)
  TriggerServerEvent('gcphone:233223yellow_getUserTweets', data.phone_number)
end)

RegisterNUICallback('bank_gkst', function(data, cb)
  TriggerServerEvent('gcphone:233223bank_gkst', data.identifier)
end)

RegisterNUICallback('yellow_userssDeleteTweet', function(data, cb) 
  TriggerServerEvent('gcphone:233223yellow_usersDeleteTweet', data.yellowId or '', data.phone_number)
end)



