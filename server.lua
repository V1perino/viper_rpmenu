ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('viper_menupersonal:getJob')
AddEventHandler('viper_menupersonal:getJob', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.label
    return job
end)

RegisterNetEvent('viper_menupersonal:getJobLabel')
AddEventHandler('viper_menupersonal:getJobLabel', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local jobgrade = xPlayer.job.grade_label
    return jobgrade
end)

