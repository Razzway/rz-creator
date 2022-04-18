---@author Razzway
---@version 3.0

ESX = nil

playerIdentity = {
    firstname = __["undefinited"],
    name = __["undefinited"],
    height = __["undefinited"],
    birthday = __["undefinited"],
    sex = __["undefinited"],
}

CreateThread(function()
    while ESX == nil do
        TriggerEvent(_Config.getESX, function(obj) ESX = obj end)
        Wait(10)
    end
end)

local FirstSpawn, PlayerLoaded = true, false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerLoaded = true
end)

AddEventHandler('playerSpawned', function()
    CreateThread(function()
        while not PlayerLoaded do
            Citizen.Wait(10)
        end
        if FirstSpawn then
            ESX.TriggerServerCallback(_Config.events.skin..':getPlayerSkin', function(skin)
                if skin == nil then
                    Utils:spawnCinematic()
                    _Client.open:createCharacterMenu()
                else
                    TriggerEvent(_Config.events.skinchanger..':loadSkin', skin)
                end
            end)
            FirstSpawn = false
        end
    end)
end)

RegisterNetEvent(_Prefix..':saveSkin')
AddEventHandler(_Prefix..':saveSkin', function()
    TriggerEvent(_Config.events.skinchanger..':getSkin', function(skin)
        TriggerServerEvent(_Config.events.skin..':save', skin)
    end)
end)