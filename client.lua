
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local kordinat = { -- 3 Farklı kordinatın parasını ayrı olarak ayarlıyabilirsiniz 
    {x = 519.9004, y = 168.6675, z = 99.663, para = 750, npc = {x = 515.0723, y = 167.9203, z = 98.368, h = 274.39}}, 
    {x = 151.5323, y = -3080.26, z = 6.2840, para = 750, npc = {x = 154.2611, y = -3082.70, z = 4.8963, h = 97.78}}, 
    {x = 146.9751, y = 320.9965, z = 112.33, para = 750, npc = {x = 150.5802, y = 322.7590, z = 111.33, h = 107.78}}, 
}



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k,v in pairs(kordinat) do
            
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                if dist <= 5 then
                    DrawText3Ds(v.x, v.y, v.z -0.5, "[~r~E~w~] - Aracı Boyat ~g~$~g~"..v.para)
                    if IsControlJustPressed(0, Keys['E']) then
                        ESX.TriggerServerCallback("ra1der_carcolor", function(cb)
                            if cb then 
                                local dispatchoran = math.random(0, 100)
                                if dispatchoran >= 70 then  -- %kaç oranla bildirim gitmesini istiyorsanız 70'i değiştiriniz
                                    local ra1der_ped = PlayerPedId()
                                    TriggerServerEvent('m3:dispatch:notify', 'İllegal Modifiye Yapılıyor!', '', '', GetEntityCoords(ra1der_ped)) -- Farklı dispatch kullanıyorsanız kendinize göre düzenleyiniz.
                                end
                                exports['mythic_progbar']:Progress({
                                    name = "ra1der_randomcolor",
                                    duration = Config.Sure,
                                    label = "Araç Boyanıyor!",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                }, function(cancelled)
                                    if not cancelled then
                                    end
                                end) 
                                for r = 1, Config.RSure do 
                                    Wait(1) 
                                    if IsControlJustPressed(0, 178) then
                                            TriggerServerEvent("ra1der_paraiade", v.para)-- iptal edildiğinde aldığı parayı verir
                                            exports['mythic_notify']:SendAlert('error', 'İşlem İptal Edlidi')
                                            return
                                    elseif r == Config.Sure then 
                                    end
                                end
                                exports['mythic_notify']:SendAlert('success', 'Araç Başarıyla Boyandı!')
                                local sans = math.random(1,100)
                                local ped = PlayerPedId()
                                local vehicle = GetVehiclePedIsIn(ped, false)
                                
                                if sans >= 0 and sans <= 5 then
                                    SetVehicleColours(vehicle, sans)
                                elseif sans > 5 and sans <= 10 then
                                    SetVehicleColours(vehicle, sans)
                                elseif sans > 10 and sans <= 20 then
                                    SetVehicleColours(vehicle, sans)
                                elseif sans > 20 and sans <= 30 then
                                    SetVehicleColours(vehicle, sans)
                                elseif sans > 30 and sans <= 40 then
                                    SetVehicleColours(vehicle, sans)
                                elseif sans > 40 and sans <= 50 then
                                    SetVehicleColours(vehicle, sans)
                                elseif sans > 50 and sans <= 60 then
                                    SetVehicleColours(vehicle, sans)
                                elseif sans > 60 and sans <= 70 then
                                    SetVehicleColours(vehicle, sans)
                                elseif sans > 70 and sans <= 80 then
                                    SetVehicleColours(vehicle, sans)
                                elseif sans > 80 and sans <= 90 then
                                    SetVehicleColours(vehicle, sans)
                                elseif sans > 90 and sans <= 100 then
                                    SetVehicleColours(vehicle, sans)
                                end
                            elseif not cb then 
                                exports['mythic_notify']:SendAlert('error', 'Yeterli Paran Yok!')
                            end
                        end, v.para)
                    end
                end
            end
        end
    end
end)

function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    if onScreen then
        local factor = #text / 370
        SetTextScale(0.27, 0.27)
        SetTextFont(10)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        DrawRect(_x, _y + 0.0120, 0.006 + factor, 0.024, 0, 0, 0, 155)
    end
end
  
Citizen.CreateThread(function()
	RequestModel(Config.npcHash)
		while not HasModelLoaded(Config.npcHash) do
			Wait(1)
		end
        for k,v in pairs(kordinat) do  
            meth_dealer_seller = CreatePed(1, Config.NPCHash, v.npc.x, v.npc.y, v.npc.z, v.npc.h, false, true)
            SetBlockingOfNonTemporaryEvents(meth_dealer_seller, true)
            SetPedDiesWhenInjured(meth_dealer_seller, false)
            SetPedCanPlayAmbientAnims(meth_dealer_seller, true)
            SetPedCanRagdollFromPlayerImpact(meth_dealer_seller, false)
            SetEntityInvincible(meth_dealer_seller, true)
            FreezeEntityPosition(meth_dealer_seller, true)
            TaskStartScenarioInPlace(meth_dealer_seller, "WORLD_HUMAN_SMOKING", 0, true);
        end
end)
