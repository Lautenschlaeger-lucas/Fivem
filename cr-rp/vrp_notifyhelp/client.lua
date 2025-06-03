RegisterNetEvent('vrp_notifyhelp')
AddEventHandler('vrp_notifyhelp', function(KeyMapping, info, show)
    SendNUIMessage({
        action = 'notification',
        KeyMapping = KeyMapping,
        info = info,
        show = show
    })
end)

RegisterCommand("dxon",function()
	TriggerEvent('vrp_notifyhelp', 'E', 'Banco', true)
end)

RegisterCommand("dxoff",function()
    TriggerEvent('vrp_notifyhelp', 'E', 'Banco', false)
end)

