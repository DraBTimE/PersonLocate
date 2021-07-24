ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent("HasPhone")
AddEventHandler("HasPhone", function(data)
        TriggerClientEvent('HavePhone',source,false)
        local sPlayer = ESX.GetPlayerFromId(source);
        TriggerClientEvent('IsPolice',source,sPlayer.job.name == 'police')
        local xPlayer = ESX.GetPlayerFromId(data);
        local item = xPlayer.getInventoryItem("bread").count;
        TriggerClientEvent('HavePhone',source,item > 0)
        TriggerClientEvent('IsPolice',source,sPlayer.job.name == 'police')
        TriggerClientEvent('TargetCoords',source,GetEntityCoords(GetPlayerPed(data)))
end)
