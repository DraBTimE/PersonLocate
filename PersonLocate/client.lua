-- [ CREDITS TO DraBTimE.#1342 ] --]
-----------------------------------]
-----------------------------------]





ESX = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if ESX == nil then
            TriggerEvent('coward:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(200)
        end
    end
end)
local targetCoordsFromEvent
local isPolice
local havePhone

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


RegisterCommand("lp", function(source, args)
    local playerID = args[1]
    local playerPed = GetPlayerPed(source)
    TriggerServerEvent("HasPhone", playerID)
    Wait(300)
    if havePhone == '1' then
        local targetCoords = targetCoordsFromEvent
        blip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
        SetBlipSprite(blip, 480)
        SetBlipColour(blip, 1)
        SetNewWaypoint(targetCoords.x, targetCoords.y)
        -- TriggerEvent('chat:addMessage', {
            -- args = {'^1[Police] ^4- ^7Person detected and marked in your gps.'}
        -- })
		TriggerEvent("notification", "Person detected and marked in your gps!",1)
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
        
                if GetDistanceBetweenCoords(coords, targetCoords.x, targetCoords.y, targetCoords.z, true) < 10.0 then
                        RemoveBlip(blip)
                end
            end
        end)
    elseif isPolice == '1' then
        -- TriggerEvent('chat:addMessage', {
            -- args = {'^1[Police] ^4- ^7The Person you tryed to find doesnt have a phone on him.'}
        -- })
		TriggerEvent("notification", "The Person you tryed to locate doesnt have a phone on him!",2)
    else
        -- TriggerEvent('chat:addMessage', {
            -- args = {'^1[Police] ^4- ^7You are not a policeman.'}
        -- })
		TriggerEvent("notification", "You are not a Police Officer!",2)
    end
end)

