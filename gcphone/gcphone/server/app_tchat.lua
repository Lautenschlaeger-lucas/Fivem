local webhookchatilegal = "https://discord.com/api/webhooks/813877296150085662/GBL5Z7WibcbpyEqSNqIDG-Jo7l39mPq2zv7Y9-XYYh83KhqKFVBymQpR_EkRdJPIttwk"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function TchatGetMessageChannel (channel, cb)
    MySQL.Async.fetchAll("SELECT * FROM phone_app_chat WHERE channel = @channel ORDER BY time DESC LIMIT 100", { 
        ['@channel'] = channel
    }, cb)
end

function TchatAddMessage (channel, message)
  local source = source
  local Query = "INSERT INTO phone_app_chat (`channel`, `message`) VALUES(@channel, @message);"
  local Query2 = 'SELECT * from phone_app_chat WHERE `id` = @id;'
  local sender = vRP.getUserId(source)
  local Parameters = {
    ['@channel'] = channel,
    ['@message'] = message,
    ['@sender'] = sender 
  }
  SendWebhookMessage(webhookchatilegal,"```prolog\n[CANAL] " ..channel.. "\n[MENSAGEM] " ..message.. "\n[ID] " ..sender.."```")
  MySQL.Async.insert(Query, Parameters, function (id)
    MySQL.Async.fetchAll(Query2, { ['@id'] = id }, function (reponse)
      TriggerClientEvent('gcphone:233223tchat_receive', -1, reponse[1])
    end)
  end)
end


RegisterServerEvent('gcphone:233223tchat_channeldumpamistocazzo')
AddEventHandler('gcphone:233223tchat_channeldumpamistocazzo', function(channel)
  local sourcePlayer = tonumber(source)
  TchatGetMessageChannel(channel, function (messages)
    TriggerClientEvent('gcphone:233223tchat_channeldumpamistocazzo', sourcePlayer, channel, messages)
  end)
end)

RegisterServerEvent('gcphone:233223tchat_addMessage')
AddEventHandler('gcphone:233223tchat_addMessage', function(channel, message)
  TchatAddMessage(channel, message)
end)



