ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent("HasPhone")
AddEventHandler("HasPhone", function(data)
        local sPlayer, xPlayer = ESX.GetPlayerFromId(source), ESX.GetPlayerFromId(data);
        local item = xPlayer.getInventoryItem("bread").count;
        TriggerClientEvent('HavePhone',source,item > 0)
        TriggerClientEvent('IsPolice',source,sPlayer.job.name == 'police')
        TriggerClientEvent('TargetCoords',source,GetEntityCoords(GetPlayerPed(data)))
end)
