ESX = nil
TriggerEvent('coward:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent("HasPhone")
AddEventHandler("HasPhone", function(data)
        local hasPhone = '0'
        TriggerClientEvent('HavePhone',source,hasPhone)
        local xPlayer = ESX.GetPlayerFromId(data)
        local sPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('IsPolice',source,isPolice)
        if sPlayer.job.name == 'police' then
            local isPolice = '1'
            TriggerClientEvent('IsPolice',source,isPolice)
        end
        print(xPlayer.getInventoryItem('phone').count)
        if sPlayer.job.name == 'police' and xPlayer.getInventoryItem('phone').count > 0 then -- Here you can change the job from police to want you want the job to be.
            hasPhone = '1'
		    TriggerClientEvent('HavePhone',source,hasPhone)
            local PlayerPed = GetPlayerPed(data)
            local targetCoords = GetEntityCoords(PlayerPed)
            TriggerClientEvent('TargetCoords',source,targetCoords)
        else
            local hasPhone = '0'
            TriggerClientEvent('HavePhone',source,hasPhone)
        end
end)
