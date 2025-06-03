function YellowGetPagess (accountId, cb)
  if accountId == nil then
    MySQL.Async.fetchAll([===[
      SELECT *
      FROM yellow_tweets
      ORDER BY time DESC LIMIT 130
      ]===], {}, cb)
  end
end

function YellowUsersPagess (phone_number, cb)
    MySQL.Async.fetchAll([===[
      SELECT *
      FROM yellow_tweets
	  WHERE phone_number = @phone_number
      ORDER BY time DESC LIMIT 130
      ]===], {['@phone_number'] = phone_number}, cb)
end

function BankUserTransfer (identifier, cb)
    MySQL.Async.fetchAll([===[
      SELECT *
      FROM bank_transfer
      ]===], {}, cb)
end

function getUserYellow(phone_number, firstname, cb)
  MySQL.Async.fetchAll("SELECT name, phone FROM vrp_users WHERE vrp_users.name = @firstname AND vrp_users.phone = @phone_number", {
    ['@phone_number'] = phone_number,
	['@firstname'] = firstname
  }, function (data)
    cb(data[1])
  end)
end

RegisterServerEvent('gcphone:233223yellow_getUserTweets')
AddEventHandler('gcphone:233223yellow_getUserTweets', function(phone_number)
  local sourcePlayer = tonumber(source)
  local name = getIdentity(source)
    YellowUsersPagess(name.phone_number, function (pagess)
      TriggerClientEvent('gcphone:233223yellow_getUserTweets', sourcePlayer, pagess)
    end)
end)

RegisterServerEvent('gcphone:233223bank_gkst')
AddEventHandler('gcphone:233223bank_gkst', function(identifier)
  local sourcePlayer = tonumber(source)
    BankUserTransfer(nil, function (bankgks)
      TriggerClientEvent('gcphone:233223bank_gkst', sourcePlayer, bankgks)
    end)
end)


function YellowPostPages (phone_number, firstname, lastname, message, image, sourcePlayer, cb)
  local sourcePlayer = tonumber(sourcePlayer) 
  local user_id = vRP.getUserId(sourcePlayer)
  local identity = vRP.getUserIdentity(user_id)
    getUserYellow(phone_number, firstname, function (user)
    MySQL.Async.insert("INSERT INTO yellow_tweets (`phone_number`, `firstname`, `lastname`, `message`, `image`) VALUES(@phone_number, @firstname, @lastname, @message, @image);", {
	  ['@phone_number'] = identity.phone,
	  ['@firstname'] = identity.name,
	  ['@lastname'] = identity.name2,
      ['@message'] = message,
	  ['@image'] = image
    }, function (id)
      MySQL.Async.fetchAll('SELECT * from yellow_tweets WHERE id = @id', {
        ['@id'] = id
      }, function (pagess)
        pages = pagess[1]
        pages['firstname'] = identity.name
        pages['phone_number'] = identity.phone
        TriggerClientEvent('gcphone:233223yellow_newPagess', -1, pages)
        TriggerEvent('gcphone:233223yellow_newPagess', pages)
      end)
    end)
  end)
end

function YellowUsersDelete (yellowId, phone_number, sourcePlayer)
    MySQL.Async.execute('DELETE FROM yellow_tweets WHERE id = @id AND phone_number = @phone_number', {
      ['@id'] = yellowId,
	  ['@phone_number'] = phone_number
    }, function ()
	end)
end

RegisterServerEvent('gcphone:233223yellow_usersDeleteTweet')
AddEventHandler('gcphone:233223yellow_usersDeleteTweet', function(yellowId, phone_number)
  local sourcePlayer = tonumber(source)
  local name = getIdentity(source)
  YellowUsersDelete(yellowId, name.phone_number, sourcePlayer)
end)


function YellowShowError (sourcePlayer, title, message, image)
  TriggerClientEvent('gcphone:233223yellow_showError', sourcePlayer, message, image)
end
function YellowShowSuccess (sourcePlayer, title, message, image)
  TriggerClientEvent('gcphone:233223yellow_showSuccess', sourcePlayer, title, message, image)
end

RegisterServerEvent('gcphone:233223yellow_getPagess')
AddEventHandler('gcphone:233223yellow_getPagess', function(phone_number, firstname)
  local sourcePlayer = tonumber(source)
    YellowGetPagess(nil, function (pagess)
      TriggerClientEvent('gcphone:233223yellow_getPagess', sourcePlayer, pagess)
    end)
end)

function getIdentity(source)
  local source = source 
  local user_id = vRP.getUserId(source)
  local identity = vRP.getUserIdentity(user_id)
  if user_id then 

		return {
			identifier = identity.id,
			name = identity.name,
			firstname = identity.name2,
			phone_number = identity.phone,
		}
	else
		return nil
	end
end

RegisterServerEvent('gcphone:233223yellow_postPagess')
AddEventHandler('gcphone:233223yellow_postPagess', function(firstname, phone_number, lastname, message, image)
  local sourcePlayer = tonumber(source)
  local name = getIdentity(source)
  YellowPostPages(name.phone_number, name.name, name.name2, message, image, sourcePlayer)
end)




