-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Tools = module("vrp","lib/Tools")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
gcp = {}
Tunnel.bindInterface("gcphone",gcp)
vCLIENT = Tunnel.getInterface("gcphone")

local blips = {}
servicos = {
    {"192", "ems.permissao"}, -- configura aqui as permissões {"numero configurado no config.json", "permissao do grupo"},
	{"911", "police"},
	{"mecanico", "mecanico.permissao"},
	{"uber", "taxista.permissao"},
	{"news", "news.permissao"},
	{"advogado", "advogado.permissao"},
	
}
RegisterServerEvent("gcphone:233223233223ChamarServicos")
AddEventHandler("gcphone:233223233223ChamarServicos", function(number, message)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		if message == "" then
			return
		end

		local x,y,z = vRPclient.getPositions(source)
		local identity = vRP.getUserIdentity(user_id)

		if parseInt(number) == 911 then
			players = vRP.numPermission("Police")
		elseif parseInt(number) == 112 then
			players = vRP.numPermission("Paramedic")
		elseif parseInt(number) == "mecanico" then
			players = vRP.numPermission("Mechanic")	
		elseif parseInt(number) == "uber" then
			players = vRP.numPermission("Taxi")
		end

	
		TriggerClientEvent("Notify",source,"sucesso","Chamado efetuado com sucesso, aguarde no local.",5000)

		local x,y,z = vRPclient.getPositions(source)
		local identity = vRP.getUserIdentity(user_id)
		for k,v in pairs(players) do
			local sourcecall = vRP.getUserSource(v)
			local identitys = vRP.getUserIdentity(v)
			if v and v ~= source then
				async(function()
				--	TriggerClientEvent("chatMessage",v,identity.name.." "..identity.name2,{107,182,84},description)
					local request = vRP.request(sourcecall,"Aceitar o chamado de <b>"..identity.name.." ("..message..")</b>?",30)
					if request then
						TriggerClientEvent("NotifyPush",sourcecall,{ time = os.date("%H:%M:%S - %d/%m/%Y"), text = message, code = 20, title = "Chamado", x = x, y = y, z = z, name = identity.name.." "..identity.name2, phone = identity.phone, rgba = {69,115,41} })
						if not answered then
							answered = true
							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
							TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identitys.name.." "..identitys.name2.."</b>, aguarde no local.",10000)
						else
							TriggerClientEvent("Notify",sourcecall,"negado","Chamado já foi atendido por outra pessoa.",5000)
							vRPclient.playSound(sourcecall,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
						end
					end
				end)
			end
		end
	end
end)


function gcp.checkCelular()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"cellphone") >= 1 then
				TriggerClientEvent("gcphone:233223forceOpenPhone", source)
				gcp.dxfix()
				return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de um <b>Celular</b>, dirija-se até uma <b>Loja de Departamento</b>",8000)
			return 
		end
	end
end



function gcp.checkCelular2()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"cellphone") >= 1 then
				return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de um <b>Celular</b>, alguém está tentando te contatar.",8000)
			return false
		end
	end
end



RegisterCommand("governo",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") then
			local messages = vRP.prompt(source,"Message:","")
			if messages == "" then
				return
			end

			local users = vRP.getUsers()
			for k,v in pairs(users) do
				local id = vRP.getUserSource(parseInt(k))
				local identity = vRP.getUserIdentity(parseInt(k))
				if identity then
					TriggerClientEvent("gcphone:233223receiveMessage",id,_internalAddMessage("4002-8922",identity.phone,"Governo Informa: "..messages,0))
				end
			end

			TriggerClientEvent("Notify",-1,"negado","O Governo lhe enviou uma mensagem <b>via SMS</b>.",5000)
		end
	end
end)


math.randomseed(os.time()) 

function getPhoneRandomNumber()
    local numBase0 = math.random(1000,9999)
	local numBase1 = math.random(0,9999)
	local num = string.format("%04d-%04d",numBase0,numBase1)
	return num
end

function getNumberPhone(identifier)
	local result = MySQL.Sync.fetchAll("SELECT vrp_users.phone FROM vrp_users WHERE vrp_users.id = @identifier",{ ['@identifier'] = identifier })
	if result[1] ~= nil then
		return result[1].phone
	end
	return nil
end
--====================================================================================
--  Utils
--====================================================================================
function getIdentifierByPhoneNumber(phone_number) 
	local result = MySQL.Sync.fetchAll("SELECT vrp_users.id FROM vrp_users WHERE vrp_users.phone = @phone_number",{ ['@phone_number'] = phone_number })
	if result[1] ~= nil then
		return result[1].id
	end
	return nil
end

function getPlayerID(source)
	local player = vRP.getUserId(source)
	return player
end

function getIdentifiant(id)
	for _, v in ipairs(id) do
		return v
	end
end

function getOrGeneratePhoneNumber(sourcePlayer,identifier,cb)
	local myPhoneNumber = getNumberPhone(identifier)
	if myPhoneNumber == '0' or myPhoneNumber == nil then
		repeat
			Citizen.Wait(1)
			myPhoneNumber = vRP.generatePhoneNumber()
			local id = getIdentifierByPhoneNumber(myPhoneNumber)
		until id == nil
		MySQL.Async.insert("UPDATE vrp_users SET phone = @myPhoneNumber WHERE id = @identifier",{ ['@myPhoneNumber'] = myPhoneNumber, ['@identifier'] = identifier },function()
			cb(myPhoneNumber)
		end)
	else
		cb(myPhoneNumber)
	end
end
--====================================================================================
--  Contacts
--====================================================================================
function getContacts(identifier)
	local result = MySQL.Sync.fetchAll("SELECT * FROM phone_users_contacts WHERE phone_users_contacts.identifier = @identifier",{ ['@identifier'] = identifier })
	return result
end


function addContact(source, identifier, number, display)
    local sourcePlayer = tonumber(source)
    MySQL.Async.insert("INSERT INTO phone_users_contacts (`identifier`, `number`,`display`) VALUES(@identifier, @number, @display)", {
        ['@identifier'] = identifier,
        ['@number'] = number,
        ['@display'] = display,
    },function()
        notifyContactChange(sourcePlayer, identifier)
    end)
end

function updateContact(source,identifier,id,number,display)
	local sourcePlayer = tonumber(source)
	MySQL.Async.insert("UPDATE phone_users_contacts SET number = @number, display = @display WHERE id = @id",{ 
		['@number'] = number,
		['@display'] = display,
		['@id'] = id
	},function()
		notifyContactChange(sourcePlayer,identifier)
	end)
end

function deleteContact(source,identifier,id)
	local sourcePlayer = tonumber(source)
	MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier AND `id` = @id",{
		['@identifier'] = identifier,
		['@id'] = id
	})
	notifyContactChange(sourcePlayer,identifier)
end

function deleteAllContact(identifier)
	MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier",{
		['@identifier'] = identifier
	})
end

function notifyContactChange(source, identifier)
    local sourcePlayer = tonumber(source)
    local identifier = identifier
    if sourcePlayer ~= nil then 
        TriggerClientEvent("gcphone:233223contactList", sourcePlayer, getContacts(identifier))
    end
end

RegisterServerEvent('gcphone:233223addContact')
AddEventHandler('gcphone:233223addContact',function(display,phoneNumber)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	addContact(sourcePlayer,identifier,phoneNumber,display)
end)

RegisterServerEvent('gcphone:233223updateContact')
AddEventHandler('gcphone:233223updateContact',function(id,display,phoneNumber)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	updateContact(sourcePlayer,identifier,id,phoneNumber,display)
end)

RegisterServerEvent('gcphone:233223deleteContact')
AddEventHandler('gcphone:233223deleteContact',function(id)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	deleteContact(sourcePlayer,identifier,id)
end)
--====================================================================================
--  Messages
--====================================================================================
function getMessages(identifier)
	local result = MySQL.Sync.fetchAll("SELECT phone_messages.* FROM phone_messages LEFT JOIN vrp_users ON vrp_users.id = @identifier WHERE phone_messages.receiver = vrp_users.phone",{ ['@identifier'] = identifier })
	return result
end

RegisterServerEvent('gcphone:233223_internalAddMessagedumpamistocazzo')
AddEventHandler('gcphone:233223_internalAddMessagedumpamistocazzo', function(transmitter, receiver, message, owner, cb)
	cb(_internalAddMessage(transmitter,receiver,message,owner))
end)


function _internalAddMessage(transmitter,receiver,message,owner)
    local Query = "INSERT INTO phone_messages (`transmitter`,`receiver`,`message`,`isRead`,`owner`) VALUES(@transmitter,@receiver,@message,@isRead,@owner);"
    local Query2 = 'SELECT * from phone_messages WHERE `id` = @id;'
	local Parameters = { ['@transmitter'] = transmitter, ['@receiver'] = receiver, ['@message'] = message, ['@isRead'] = owner, ['@owner'] = owner }
    local id = MySQL.Sync.insert(Query,Parameters)
    return MySQL.Sync.fetchAll(Query2,{ ['@id'] = id })[1]
end

function addMessage(source, identifier, phone_number, message)
	local sourcePlayer = tonumber(source)
	local otherIdentifier = getIdentifierByPhoneNumber(phone_number)
	local myPhone = getNumberPhone(identifier)
	vRP.antiflood(source,"messagegcphone",5)
	if otherIdentifier ~= nil and vRP.getUserSource(otherIdentifier) ~= nil then
		local tomess = _internalAddMessage(myPhone,phone_number,message,0)
            TriggerClientEvent("gcphone:233223receiveMessage",tonumber(vRP.getUserSource(otherIdentifier)),tomess)
    else
        _internalAddMessage(myPhone,phone_number,message,0)
    end
    local memess = _internalAddMessage(phone_number, myPhone, message, 1)
    TriggerClientEvent("gcphone:233223receiveMessage", sourcePlayer, memess)
end

function setReadMessageNumber(identifier, num)
	local mePhoneNumber = getNumberPhone(identifier)
	MySQL.Sync.execute("UPDATE phone_messages SET phone_messages.isRead = 1 WHERE phone_messages.receiver = @receiver AND phone_messages.transmitter = @transmitter",{ 
		['@receiver'] = mePhoneNumber,
		['@transmitter'] = num
	})
end

function deleteMessage(msgId)
	MySQL.Sync.execute("DELETE FROM phone_messages WHERE `id` = @id",{
		['@id'] = msgId
	})
end

function deleteAllMessageFromPhoneNumber(source,identifier,phone_number)
	local source = source
	local identifier = identifier
	local mePhoneNumber = getNumberPhone(identifier)
	MySQL.Sync.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber and `transmitter` = @phone_number",{ ['@mePhoneNumber'] = mePhoneNumber,['@phone_number'] = phone_number })
end

function deleteAllMessage(identifier)
	local mePhoneNumber = getNumberPhone(identifier)
	MySQL.Sync.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber",{
		['@mePhoneNumber'] = mePhoneNumber
	})
end

RegisterServerEvent('gcphone:233223sendMessage')
AddEventHandler('gcphone:233223sendMessage',function(phoneNumber,message)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    addMessage(sourcePlayer,identifier,phoneNumber,message)
end)

RegisterServerEvent('gcphone:233223deleteMessage')
AddEventHandler('gcphone:233223deleteMessage',function(msgId)
	deleteMessage(msgId)
end)


RegisterServerEvent('gcphone:233223deleteMessageNumber')
AddEventHandler('gcphone:233223deleteMessageNumber',function(number)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	deleteAllMessageFromPhoneNumber(sourcePlayer,identifier,number)
end)

RegisterServerEvent('gcphone:233223deleteAllMessage')
AddEventHandler('gcphone:233223deleteAllMessage',function()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	deleteAllMessage(identifier)
end)

RegisterServerEvent('gcphone:233223setReadMessageNumber')
AddEventHandler('gcphone:233223setReadMessageNumber',function(num)
	local sourcePlayer = tonumber(source)  
	local identifier = getPlayerID(source)
	setReadMessageNumber(identifier,num)
end)

RegisterServerEvent('gcphone:233223deleteALL')
AddEventHandler('gcphone:233223deleteALL',function()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	deleteAllMessage(identifier)
	deleteAllContact(identifier)
	appelsDeleteAllHistorique(identifier)
	TriggerClientEvent("gcphone:233223contactList",sourcePlayer,{})
	TriggerClientEvent("gcphone:233223allMessage",sourcePlayer,{})
	TriggerClientEvent("appelsDeleteAllHistorique",sourcePlayer,{})
end)
--====================================================================================
--  Gestion des appels
--====================================================================================
local AppelsEnCours = {}
local PhoneFixeInfo = {}
local lastIndexCall = 10

function getHistoriqueCall(num)
	local result = MySQL.Sync.fetchAll("SELECT * FROM phone_calls WHERE phone_calls.owner = @num ORDER BY time DESC LIMIT 120",{ ['@num'] = num })
	return result
end

function sendHistoriqueCall(src,num)
	local histo = getHistoriqueCall(num)
	TriggerClientEvent('gcphone:233223historiqueCall',src,histo)
end

function saveAppels(appelInfo)
	if appelInfo.extraData == nil or appelInfo.extraData.useNumber == nil then
		MySQL.Async.insert("INSERT INTO phone_calls (`owner`,`num`,`incoming`,`accepts`) VALUES(@owner,@num,@incoming,@accepts)",{ ['@owner'] = appelInfo.transmitter_num, ['@num'] = appelInfo.receiver_num, ['@incoming'] = 1, ['@accepts'] = appelInfo.is_accepts },function()
			notifyNewAppelsHisto(appelInfo.transmitter_src,appelInfo.transmitter_num)
		end)
	end
	if appelInfo.is_valid == true then
		local num = appelInfo.transmitter_num
		if appelInfo.hidden == true then
			mun = "####-####"
		end
		MySQL.Async.insert("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)",{ ['@owner'] = appelInfo.receiver_num, ['@num'] = num, ['@incoming'] = 0, ['@accepts'] = appelInfo.is_accepts },function()
			if appelInfo.receiver_src ~= nil then
				notifyNewAppelsHisto(appelInfo.receiver_src,appelInfo.receiver_num)
			end
		end)
	end
end

function notifyNewAppelsHisto(src,num)
	sendHistoriqueCall(src,num)
end


RegisterServerEvent('gcphone:233223getHistoriqueCall')
AddEventHandler('gcphone:233223getHistoriqueCall',function()
	local sourcePlayer = tonumber(source)
	local srcIdentifier = getPlayerID(source)
	local srcPhone = getNumberPhone(srcIdentifier)
	sendHistoriqueCall(sourcePlayer,num)
end)

RegisterServerEvent('gcphone:233223register_FixePhone')
AddEventHandler('gcphone:233223register_FixePhone', function(phone_number, coords)
	Config.FixePhone[phone_number] = {name = _U('phone_booth'), coords = {x = coords.x, y = coords.y, z = coords.z}}
	TriggerClientEvent('gcphone:233223register_FixePhone', -1, phone_number, Config.FixePhone[phone_number])
end)

RegisterServerEvent('gcphone:233223internal_startCall')
AddEventHandler('gcphone:233223internal_startCall', function(source, phone_number, rtcOffer, extraData)
    
	local rtcOffer = rtcOffer
    if phone_number == nil or phone_number == '' then 
        return
    end

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end

    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local sourcePlayer = tonumber(source)
	local xPlayer = vRP.getUserId(source)
    local identifier = xPlayer

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(identifier)
    end
    local destPlayer = getIdentifierByPhoneNumber(phone_number)
    local is_valid = destPlayer ~= nil and destPlayer ~= identifier
    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = destPlayer ~= nil,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData
    }

	if is_valid == true then
		if vRP.getUserSource(destPlayer) ~= nil then
			srcTo = tonumber(vRP.getUserSource(destPlayer))
                if srcTo ~= nil and vRP.getInventoryItemAmount(vRP.getUserId(srcTo),'cellphone') >= 1 then
                    AppelsEnCours[indexCall].receiver_src = srcTo
                    TriggerEvent('gcphone:233223addCall', AppelsEnCours[indexCall])
                    TriggerClientEvent('gcphone:233223waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                    TriggerClientEvent('gcphone:233223waitingCall', srcTo, AppelsEnCours[indexCall], false)
                else
                    TriggerEvent('gcphone:233223addCall', AppelsEnCours[indexCall])
                    TriggerClientEvent('gcphone:233223waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                end
            end
        else
            TriggerEvent('gcphone:233223addCall', AppelsEnCours[indexCall])
            TriggerClientEvent('gcphone:233223waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
        end

end)

RegisterServerEvent('gcphone:233223startCall')
AddEventHandler('gcphone:233223startCall',function(phone_number,rtcOffer,extraData)
	TriggerEvent('gcphone:233223internal_startCall',source,phone_number,rtcOffer,extraData)
end)

RegisterServerEvent('gcphone:233223233223acceptCall')
AddEventHandler('gcphone:233223233223acceptCall',function(infoCall,rtcAnswer)
	local id = infoCall.id
	if AppelsEnCours[id] ~= nil then
		AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src
		if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src ~= nil then
			AppelsEnCours[id].is_accepts = true
			AppelsEnCours[id].rtcAnswer = rtcAnswer
			TriggerClientEvent('gcphone:233223233223acceptCall',AppelsEnCours[id].transmitter_src,AppelsEnCours[id],true)
			TriggerClientEvent('gcphone:233223233223acceptCall',AppelsEnCours[id].receiver_src,AppelsEnCours[id],false)
			saveAppels(AppelsEnCours[id])
		end
	end
end)

RegisterServerEvent('gcphone:233223233223rejectCall')
AddEventHandler('gcphone:233223233223rejectCall',function(infoCall)
	local id = infoCall.id
	if AppelsEnCours[id] ~= nil then
		if AppelsEnCours[id].transmitter_src ~= nil then
			TriggerClientEvent('gcphone:233223233223rejectCall',AppelsEnCours[id].transmitter_src)
		end
		if AppelsEnCours[id].receiver_src ~= nil then
			TriggerClientEvent('gcphone:233223233223rejectCall',AppelsEnCours[id].receiver_src)
		end

		if AppelsEnCours[id].is_accepts == false then 
			saveAppels(AppelsEnCours[id])
		end
		TriggerEvent('gcphone:233223233223removeCall',AppelsEnCours)
		AppelsEnCours[id] = nil
	end
end)

RegisterServerEvent('gcphone:233223candidates')
AddEventHandler('gcphone:233223candidates',function(callId,candidates)
	if AppelsEnCours[callId] ~= nil then
		local source = source
		local to = AppelsEnCours[callId].transmitter_src
		if source == to then 
			to = AppelsEnCours[callId].receiver_src
		end
		TriggerClientEvent('gcphone:233223candidates',to,candidates)
	end
end)


RegisterServerEvent('gcphone:233223acceptCall')
AddEventHandler('gcphone:233223acceptCall', function(infoCall, rtcAnswer)
	local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onAcceptFixePhone(source, infoCall, rtcAnswer)
            return
        end
        AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src
        if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
            AppelsEnCours[id].is_accepts = true
            AppelsEnCours[id].rtcAnswer = rtcAnswer
            TriggerClientEvent('gcPhone:233223acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
	    SetTimeout(1000, function() -- change to +1000, if necessary.
       		TriggerClientEvent('gcPhone:233223acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
	    end)
            saveAppels(AppelsEnCours[id])
        end
    end
end)

RegisterServerEvent('gcphone:233223rejectCall')
AddEventHandler('gcphone:233223rejectCall', function (infoCall)
	local _source = source
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onRejectFixePhone(source, infoCall)
            return
        end
        if AppelsEnCours[id].transmitter_src ~= nil then
            TriggerClientEvent('gcPhone:233223rejectCall', AppelsEnCours[id].transmitter_src)
        end
        if AppelsEnCours[id].receiver_src ~= nil then
            TriggerClientEvent('gcPhone:233223rejectCall', AppelsEnCours[id].receiver_src)
        end

        if AppelsEnCours[id].is_accepts == false then 
            saveAppels(AppelsEnCours[id])
        end
        TriggerEvent('gcPhone:233223removeCall', AppelsEnCours)
        AppelsEnCours[id] = nil
    end
end)

RegisterServerEvent('gcphone:233223appelsDeleteHistorique')
AddEventHandler('gcphone:233223appelsDeleteHistorique',function(numero)
	local sourcePlayer = tonumber(source)
	local srcIdentifier = getPlayerID(source)
	local srcPhone = getNumberPhone(srcIdentifier)
	MySQL.Sync.execute("DELETE FROM phone_calls WHERE `owner` = @owner AND `num` = @num",{
		['@owner'] = srcPhone,
		['@num'] = numero
	})
end)

function appelsDeleteAllHistorique(srcIdentifier)
	local srcPhone = getNumberPhone(srcIdentifier)
	MySQL.Sync.execute("DELETE FROM phone_calls WHERE `owner` = @owner",{ ['@owner'] = srcPhone })
end

RegisterServerEvent('gcphone:233223appelsDeleteAllHistorique')
AddEventHandler('gcphone:233223appelsDeleteAllHistorique',function()
	local sourcePlayer = tonumber(source)
	local srcIdentifier = getPlayerID(source)
	appelsDeleteAllHistorique(srcIdentifier)
end)


--====================================================================================
--  OnLoad
--====================================================================================
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	local identity = vRP.getUserIdentity(identifier)
	local num = getNumberPhone(identifier)
	local nome = identity.name
	local sobrenome = identity.name2
	if identifier then
		getOrGeneratePhoneNumber(sourcePlayer,identifier,function(myPhoneNumber)
			TriggerClientEvent("gcphone:233223firstname", sourcePlayer, nome)
			TriggerClientEvent("gcphone:233223lastname", sourcePlayer, sobrenome)
			TriggerClientEvent('gcphone:233223myPhoneNumber', sourcePlayer, myPhoneNumber)
			TriggerClientEvent('gcphone:233223contactList', sourcePlayer, getContacts(identifier))
			TriggerClientEvent('gcphone:233223allMessage', sourcePlayer, getMessages(identifier))
		end)
	end
end)

function gcp.dxfix()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	local identity = vRP.getUserIdentity(identifier)
	local num = getNumberPhone(identifier)
	local nome = identity.name
	local sobrenome = identity.name2
	if identifier then
		getOrGeneratePhoneNumber(sourcePlayer,identifier,function(myPhoneNumber)
			TriggerClientEvent("gcphone:233223firstname", sourcePlayer, nome)
			TriggerClientEvent("gcphone:233223lastname", sourcePlayer, sobrenome)
			TriggerClientEvent('gcphone:233223myPhoneNumber', sourcePlayer, myPhoneNumber)
			TriggerClientEvent('gcphone:233223contactList', sourcePlayer, getContacts(identifier))
			TriggerClientEvent('gcphone:233223allMessage', sourcePlayer, getMessages(identifier))
		end)
	end
end

RegisterCommand("dxcell",function(source,args,rawCommand)
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	identity = vRP.getUserIdentity(identifier)
	local num = getNumberPhone(identifier)
	local nome = identity.name
	local sobrenome = identity.name2
	getOrGeneratePhoneNumber(sourcePlayer,identifier,function(myPhoneNumber)
		TriggerClientEvent("gcphone:233223firstname", sourcePlayer, nome)
		TriggerClientEvent("gcphone:233223lastname", sourcePlayer, sobrenome)
		TriggerClientEvent('gcphone:233223myPhoneNumber', sourcePlayer, myPhoneNumber)
		TriggerClientEvent('gcphone:233223contactList', sourcePlayer, getContacts(identifier))
		TriggerClientEvent('gcphone:233223allMessage', sourcePlayer, getMessages(identifier))
	end)
end)
RegisterServerEvent('gcphone:233223allUpdate')
AddEventHandler('gcphone:233223allUpdate',function()
	local sourcePlayer = tonumber(source)
	local identifier = getPlayerID(source)
	local num = getNumberPhone(identifier)
	TriggerClientEvent("gcphone:233223myPhoneNumber",sourcePlayer,num)
	TriggerClientEvent("gcphone:233223contactList",sourcePlayer,getContacts(identifier))
	TriggerClientEvent("gcphone:233223allMessage",sourcePlayer,getMessages(identifier))
	sendHistoriqueCall(sourcePlayer,num)
end)
--====================================================================================
--  App bourse
--====================================================================================
function getBourse()
    --  Format
    --  Array 
    --  Object
    -- 	libelle type String    | Nom
    --  price type number      | Prix actuelle
    --  difference type number | Evolution 

    -- local result = MySQL.Sync.fetchAll("SELECT * FROM `recolt` LEFT JOIN `items` ON items.`id` = recolt.`treated_id` WHERE fluctuation = 1 ORDER BY price DESC",{})
    local result = {
        {
            libelle = 'Google',
            price = 125.2,
            difference =  -12.1
        },
        {
            libelle = 'Microsoft',
            price = 132.2,
            difference = 3.1
        },
        {
            libelle = 'Amazon',
            price = 120,
            difference = 0
        }}
    return result
end

--====================================================================================
--  App ... WIP
--====================================================================================

function onCallFixePhone (source, phone_number, rtcOffer, extraData)
    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end
    local sourcePlayer = tonumber(source)
	local xPlayer = vRP.getUserId(source)
    local identifier = xPlayer

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = '###-####' -- This change was made for public phones without phone number reading in mind
    end

    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = false,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData
     --   coords = Config.FixePhone[phone_number].coords
    }
    
    PhoneFixeInfo[indexCall] = AppelsEnCours[indexCall]

    TriggerClientEvent('gcphone:233223notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcphone:233223waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
end

function onAcceptFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    
    AppelsEnCours[id].receiver_src = source
    if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
        AppelsEnCours[id].is_accepts = true
        AppelsEnCours[id].forceSaveAfter = true
        AppelsEnCours[id].rtcAnswer = rtcAnswer
        PhoneFixeInfo[id] = nil
        TriggerClientEvent('gcphone:233223notifyFixePhoneChange', -1, PhoneFixeInfo)
        TriggerClientEvent('gcphone:233223acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
        SetTimeout(1000, function() -- change to +1000, if necessary.
            TriggerClientEvent('gcphone:233223acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
        end)
        saveAppels(AppelsEnCours[id])
    end
end

function onRejectFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    PhoneFixeInfo[id] = nil
    TriggerClientEvent('gcphone:233223notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcphone:233223rejectCall', AppelsEnCours[id].transmitter_src)
    if AppelsEnCours[id].is_accepts == false then
        saveAppels(AppelsEnCours[id])
    end
    AppelsEnCours[id] = nil 
end

AddEventHandler('onMySQLReady',function()
	MySQL.Async.fetchAll("DELETE FROM phone_messages WHERE (DATEDIFF(CURRENT_DATE,time) > 10)")
end)