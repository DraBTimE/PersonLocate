ESX = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if ESX == nil then
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(200)
        end
    end
end)
local targetCoordsFromEvent
local isPolice
local havePhone


Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/locate', 'Locate Person', {{ name="id", help="The target id" },})
end)


RegisterNetEvent('HavePhone')
AddEventHandler('HavePhone', function(data)
    havePhone = data
end)

RegisterNetEvent('TargetCoords')
AddEventHandler('TargetCoords', function(data)
    targetCoordsFromEvent = data
end)

RegisterNetEvent('IsPolice')
AddEventHandler('IsPolice', function(data)
    isPolice = data
end)


RegisterCommand("locate", function(source, args)
    local playerID = args[1]
    local playerPed = GetPlayerPed(source)
    TriggerServerEvent("HasPhone", playerID)
    Wait(300)
    if havePhone and isPolice then
        blip = AddBlipForCoord(targetCoordsFromEvent.x, targetCoordsFromEvent.y, targetCoordsFromEvent.z)
        SetBlipSprite(blip, 480)
        SetBlipColour(blip, 1)
        SetNewWaypoint(targetCoordsFromEvent.x, targetCoordsFromEvent.y)
		TriggerEvent("notification", "Person detected and marked in your gps!",1)
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                if #(coords-targetCoordsFromEvent) < 10.0 then
                        RemoveBlip(blip)
                end
            end
        end)
    elseif isPolice then
		TriggerEvent("notification", "The Person you tryed to locate doesnt have a phone on him!",2)
    else
		TriggerEvent("notification", "You are not a Police Officer!",2)
    end
end)



AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('chat:removeSuggestion', '/locate')
	end
end)
