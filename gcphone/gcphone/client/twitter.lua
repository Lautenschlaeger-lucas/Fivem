--====================================================================================
-- #Author: Jonathan D @ Gannon
--====================================================================================

RegisterNetEvent("gcphone:233223twitter_getTweets")
AddEventHandler("gcphone:233223twitter_getTweets", function(tweets)
  SendNUIMessage({event = 'twitter_tweets', tweets = tweets})
end)

RegisterNetEvent("gcphone:233223twitter_getFavoriteTweets")
AddEventHandler("gcphone:233223twitter_getFavoriteTweets", function(tweets)
  SendNUIMessage({event = 'twitter_favoritetweets', tweets = tweets})
end)

RegisterNetEvent("gcphone:233223twitter_getUserTweets")
AddEventHandler("gcphone:233223twitter_getUserTweets", function(tweets)
  SendNUIMessage({event = 'twitter_UserTweets', tweets = tweets})
end)

RegisterNetEvent("gcphone:233223twitter_newTweets")
AddEventHandler("gcphone:233223twitter_newTweets", function(tweet)
  SendNUIMessage({event = 'twitter_newTweet', tweet = tweet})
end)

RegisterNetEvent("gcphone:233223twitter_updateTweetLikes")
AddEventHandler("gcphone:233223twitter_updateTweetLikes", function(tweetId, likes)
  SendNUIMessage({event = 'twitter_updateTweetLikes', tweetId = tweetId, likes = likes})
end)

RegisterNetEvent("gcphone:233223twitter_setAccount")
AddEventHandler("gcphone:233223twitter_setAccount", function(username, password, avatarUrl)
  SendNUIMessage({event = 'twitter_setAccount', username = username, password = password, avatarUrl = avatarUrl})
end)

RegisterNetEvent("gcphone:233223twitter_createAccount")
AddEventHandler("gcphone:233223twitter_createAccount", function(account)
  SendNUIMessage({event = 'twitter_createAccount', account = account})
end)

RegisterNetEvent("gcphone:233223twitter_showError")
AddEventHandler("gcphone:233223twitter_showError", function(title, message, image)
  SendNUIMessage({event = 'twitter_showError', message = message, image = image, title = title})
end)

RegisterNetEvent("gcphone:233223twitter_showSuccess")
AddEventHandler("gcphone:233223twitter_showSuccess", function(title, message, image)
  SendNUIMessage({event = 'twitter_showSuccess', message = message, image = image, title = title})
end)

RegisterNetEvent("gcphone:233223twitter_setTweetLikes")
AddEventHandler("gcphone:233223twitter_setTweetLikes", function(tweetId, isLikes)
  SendNUIMessage({event = 'twitter_setTweetLikes', tweetId = tweetId, isLikes = isLikes})
end)





RegisterNUICallback('twitter_userssDeleteTweet', function(data, cb) 
  TriggerServerEvent('gcphone:233223twitter_usersDeleteTweet', data.username or '', data.password or '', data.tweetId)
end)

RegisterNUICallback('twitter_login', function(data, cb)
  TriggerServerEvent('gcphone:233223twitter_login', data.username, data.password)
end)
RegisterNUICallback('twitter_changePassword', function(data, cb)
  TriggerServerEvent('gcphone:233223twitter_changePassword', data.username, data.password, data.newPassword)
end)


RegisterNUICallback('twitter_createAccount', function(data, cb)
  TriggerServerEvent('gcphone:233223twitter_createAccount', data.username, data.password, data.avatarUrl)
end)

RegisterNUICallback('twitter_getTweets', function(data, cb)
  TriggerServerEvent('gcphone:233223twitter_getTweets', data.username, data.password)
end)

RegisterNUICallback('twitter_getFavoriteTweets', function(data, cb)
  TriggerServerEvent('gcphone:233223twitter_getFavoriteTweets', data.username, data.password)
end)

RegisterNUICallback('twitter_getUserTweets', function(data, cb)
  TriggerServerEvent('gcphone:233223twitter_getUserTweets', data.username, data.password)
end)

RegisterNUICallback('twitter_postTweet', function(data, cb)
  TriggerServerEvent('gcphone:233223twitter_postTweets', data.username or '', data.password or '', data.message or '', data.image)
end)

RegisterNUICallback('twitter_toggleLikeTweet', function(data, cb)
  TriggerServerEvent('gcphone:233223twitter_toogleLikeTweet', data.username or '', data.password or '', data.tweetId)
end)

RegisterNUICallback('twitter_setAvatarUrl', function(data, cb)
  TriggerServerEvent('gcphone:233223twitter_setAvatarUrl', data.username or '', data.password or '', data.avatarUrl)
end)