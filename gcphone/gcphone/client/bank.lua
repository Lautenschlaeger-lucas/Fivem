
inMenu                      = true
local bank = 0
local firstname = ''
local lastname = ''

function setBankBalance (value)
      bank = value
      SendNUIMessage({event = 'updateBankbalance', banking = bank})
end

RegisterNetEvent('esx:233223playerLoaded')
AddEventHandler('esx:233223playerLoaded', function(playerData)
      local accounts = playerData.accounts or {}
      for index, account in ipairs(accounts) do 
            if account.name == 'bank' then
                  setBankBalance(account.money)
                  break
            end
      end
end)

RegisterNetEvent('esx:233223setAccountMoney')
AddEventHandler('esx:233223setAccountMoney', function(m)
      setBankBalance(m)
end)


RegisterNetEvent("es:addedBank")
AddEventHandler("es:addedBank", function(m)
      setBankBalance(bank + m)
end)

RegisterNetEvent("es:removedBank")
AddEventHandler("es:removedBank", function(m)
      setBankBalance(bank - m)
end)

RegisterNetEvent('es:displayBank')
AddEventHandler('es:displayBank', function(bank)
      setBankBalance(bank)
end)

RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('gcphone:233223transfer', data.to, data.amountt)
end)
--===============================================
--==             Ad ve Soyad                   ==
--===============================================

RegisterNetEvent("gcphone:233223firstname")
AddEventHandler("gcphone:233223firstname", function(_firstname)
  firstname = _firstname
  SendNUIMessage({event = 'updateMyFirstname', firstname = firstname})
  TriggerServerEvent("gcphone:233223getBank")
end)

RegisterNetEvent("gcphone:233223lastname")
AddEventHandler("gcphone:233223lastname", function(_lastname)
  lastname = _lastname
  SendNUIMessage({event = 'updateMyListname', lastname = lastname})
end)


RegisterNetEvent("gcphone:233223bank_getBilling")
AddEventHandler("gcphone:233223bank_getBilling", function(bankkkkk)
  SendNUIMessage({event = 'bank_billingg', bankkkkk = bankkkkk})
end)

RegisterNUICallback('bank_getBilling', function(data, cb)
  TriggerServerEvent('gcphone:233223bank_getBilling', data.type, data.price, data.name)
end)



