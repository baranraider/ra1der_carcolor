ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)



ESX.RegisterServerCallback("ra1der_carcolor", function(source, cb, para)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('cash').count >= para then
        xPlayer.removeInventoryItem('cash', para )
        cb(true)
      else
        cb(false)
      end
end)

RegisterServerEvent("ra1der_paraiade")
AddEventHandler("ra1der_paraiade", function(para)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem("cash", para)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if GetCurrentResourceName() ~= 'ra1der_carcolor' then
        print('^0[^3ra1der_carcolor^0] ^3- ^1 Script adını değiştirdiniz, scripti kullanabilmek için script adını eski haline çevirin!')
        Citizen.Wait(5000)
            os.exit()
        end
    end
end)