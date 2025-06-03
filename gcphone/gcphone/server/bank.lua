local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oDB = {}
Tunnel.bindInterface("gcphone",oDB)

local webhooktransferencia = "https://discord.com/api/webhooks/813877432222220318/K80mG2HT5UntvX0JkplOuDg2e1tpYpAVNkxrx3cX6zrFYt9QID3VcdHI7NawfuQfLgAf"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterServerEvent("gcphone:233223getBank")
AddEventHandler("gcphone:233223getBank", function()
local source = source 
local user_id = vRP.getUserId(source)
local money = vRP.getBankMoney(user_id)
	TriggerClientEvent("esx:233223setAccountMoney", source, money)
end)

RegisterServerEvent('gcphone:233223transfer')
AddEventHandler('gcphone:233223transfer', function(id,amount)
    local source = source 
	local user_id = vRP.getUserId(source)
	local money = vRP.getBankMoney(user_id)
    local sourceId = vRP.getUserSource(id)
    local nplayeron = vRP.getUserSource(parseInt(id))
    local nuser_id = vRP.getUserId(nplayeron)
	local bankbalance = vRP.getBankMoney(user_id)

	local amount = parseInt(amount)
	local id = parseInt(id)
	if id ~= user_id then
		local nplayer = vRP.getUserSource(parseInt(id))
		if nplayer then
			if (amount > 0) and money >= amount then 
				vRP.setBankMoney(user_id,(money-amount))
				vRP.giveBankMoney(id,amount)
				TriggerClientEvent("Notify",source,"sucesso","Você transferiu: <b>R$"..vRP.format(amount).."</b> para o passaporte: <b>"..id.."</b>")
				if nplayer then
					local identity2 = vRP.getUserIdentity(user_id)
					TriggerClientEvent("Notify",nplayer,"sucesso","Você recebeu: <b>$"..vRP.format(amount).."</b> do passaporte: <b>"..user_id.."</b>.",5000)
					SendWebhookMessage(webhooktransferencia,"```prolog\n[ID]: "..user_id.."  \n[TRANSFERIU]: $"..amount.." \n[PARA O ID]: "..id.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					-- aleatorio = math.random(10000, 99999)
					-- vRP.execute("sRP/inserir_table", {user_id = user_id, extrato = "Você Transferiu pelo Celular <strong>$" .. amount .. "</strong> para o Passaporte: " .. id .. ", e seu saldo ficou em <strong>$" ..  addComma(math.floor(bankbalance - amount)) .. "</strong> - Comprovante " .. "<strong>ALT" .. aleatorio .. "</strong>"})
					-- vRP.execute("sRP/inserir_table", {user_id = id, extrato = "Você Recebeu uma Transferência pelo Celular <strong>$" .. amount .. "</strong> do <strong> Passaporte: " .. user_id .. "</strong> - Comprovante " .. "<strong>ALT" .. aleatorio .. "</strong>"})
				end
			else
				TriggerClientEvent("Notify", source, "aviso", "Você não tem dinheiro o suficiente.")
			end
		else
			TriggerClientEvent("Notify",source,"aviso","cidadão se encontra fora da cidade",5000)
		end
	else
		TriggerClientEvent("Notify", source, "aviso", "Você não pode transferir para você mesmo.")
    end
    MySQL.Async.fetchAll("SELECT * FROM vrp_user_identities WHERE user_id = @identifier", {
        ['@identifier'] = nuser_id,
    }, function(result)
        if result[1] then
            local name = result[1].name .. " " .. result[1].firstname
            MySQL.Async.fetchAll("INSERT INTO bank_transfer (type, identifier, price, name) VALUES (@type, @identifier, @price, @name)", {
                ["@type"] = 1,
                ["@identifier"] = user_id,
                ["@price"] = amount,
                ["@name"] = name
            }, function(results)
            end)
        end
    end)
MySQL.Async.fetchAll("SELECT * FROM vrp_user_identities WHERE user_id = @identifier", {
        ['@identifier'] = user_id,
    }, function(result)
        if result[1] then
            local name = result[1].name .. " " .. result[1].firstname
            MySQL.Async.fetchAll("INSERT INTO bank_transfer (type, identifier, price, name) VALUES (@type, @identifier, @price, @name)", {
                ["@type"] = 2,
                ["@identifier"] = nuser_id,
                ["@price"] = amount,
                ["@name"] = name
            }, function(resultss)
            end)
        end
    end)
end)


--================================================================================================
--==                                           Ad ve Soyad                                      ==
--================================================================================================
function getorfirstname (sourcePlayer, identifier, cb)
    local sourcePlayer = sourcePlayer
    local identifier = identifier
    local firstname = getFirstname(identifier)
	local lastname = getLastname(identifier)
end

function getFirstname(identifier)
    local result = MySQL.Sync.fetchAll("SELECT vrp_user_identities.name FROM vrp_user_identities WHERE vrp_user_identities.user_id = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].name
    end
    return nil
end

function getLastname(identifier)
    local result = MySQL.Sync.fetchAll("SELECT vrp_user_identities.firstname FROM vrp_user_identities WHERE vrp_user_identities.user_id = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].firstname
    end
    return nil
end


function BankGetBilling (accountId, cb)
  local xPlayer = vRP.getUserId(source)
    MySQL.Async.fetchAll([===[
      SELECT * FROM bank_transfer WHERE identifier = @identifier ORDER BY time DESC LIMIT 10
      ]===], { ['@identifier'] = xPlayer }, cb)
  end 
  
  
  function getUserBank(phone_number, firstname, cb)
  MySQL.Async.fetchAll("SELECT name, phone FROM vrp_user_identities WHERE vrp_user_identities.name = @name AND vrp_user_identities.phone = @phone_number", {
    ['@phone_number'] = phone_number,
	['@firstname'] = firstname
  }, function (data)
    cb(data[1])
  end)
end

RegisterServerEvent('gcphone:233223bank_getBilling')
AddEventHandler('gcphone:233223bank_getBilling', function(phone_number, firstname)
  local sourcePlayer = tonumber(source)
  if phone_number ~= nil and phone_number ~= "" and firstname ~= nil and firstname ~= "" then
    getUserBank(phone_number, firstname, function (user)
      local accountId = user and user.id
      BankGetBilling(accountId, function (bankkkkk)
        TriggerClientEvent('gcphone:233223bank_getBilling', sourcePlayer, bankkkkk)
      end)
    end)
  else
    BankGetBilling(nil, function (bankkkkk)
      TriggerClientEvent('gcphone:233223bank_getBilling', sourcePlayer, bankkkkk)
    end)
  end
end)