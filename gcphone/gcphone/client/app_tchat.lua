RegisterNetEvent("gcphone:233223tchat_receive")
AddEventHandler("gcphone:233223tchat_receive", function(message)
  SendNUIMessage({event = 'tchat_receive', message = message})
end)

RegisterNetEvent("gcphone:233223tchat_channeldumpamistocazzo")
AddEventHandler("gcphone:233223tchat_channeldumpamistocazzo", function(channel, messages)
  SendNUIMessage({event = 'tchat_channel', messages = messages})
end)

RegisterNUICallback('tchat_addMessage', function(data, cb)
  TriggerServerEvent('gcphone:233223tchat_addMessage', data.channel, data.message)
end)

RegisterNUICallback('tchat_getChannel', function(data, cb)
  TriggerServerEvent('gcphone:233223tchat_channeldumpamistocazzo', data.channel)
end)


RegisterNUICallback('tchat_receive', function(data, cb)
  TriggerServerEvent('gcphone:233223tchat_receive', data.channel, data.message)
end)

