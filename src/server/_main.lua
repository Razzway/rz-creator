---@author Razzway
---@version 3.0

ESX = nil

TriggerEvent(_Config.getESX, function(lib) ESX = lib end)

RegisterServerEvent(_Prefix..":setBuckets")
AddEventHandler(_Prefix..":setBuckets", function(bool)
    local _src = source
    if bool then SetPlayerRoutingBucket(_src, GetPlayerIdentifier(_src)) else SetPlayerRoutingBucket(_src, 0) end
end)

RegisterServerEvent(_Prefix..':identity:setIdentity')
AddEventHandler(_Prefix..':identity:setIdentity', function(playerInfo)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `height` = @height, `dateofbirth` = @dateofbirth, `sex` = @sex WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier,
        ['@firstname'] = playerInfo.firstname,
        ['@lastname'] = playerInfo.name,
        ['@height'] = playerInfo.height,
        ['@dateofbirth'] = playerInfo.birthday,
        ['@sex'] = playerInfo.sex,
    })
    if (_Config.consoleLogs) then
        print(("Le joueur ^3%s^7 a créé son identité ^3-->^7 [ Prénom : ^5%s^7 | Nom : ^6%s^7 | Taille : ^2%s^7 | Anniv : ^1%s^7 | Sexe : ^4%s^7 ]"):format(GetPlayerName(xPlayer.source), playerInfo.firstname, playerInfo.name, playerInfo.height, playerInfo.birthday, playerInfo.sex))
    end
    if (_ServerConfig.enableLogs) then
        logs:sendToDiscord(_ServerConfig.wehbook.identity, __["razzway_logs"], __["identity_logs_title"], (__["player_identity"]):format(GetPlayerName(xPlayer.source), __["line_separator"], playerInfo.firstname, playerInfo.name, playerInfo.height, playerInfo.birthday, playerInfo.sex), _ServerConfig.color.cyan)
    end
end)

---@class Cardinal
Cardinal = {};
Cardinal.sizeProtect = 30

RegisterServerEvent(_Prefix..":starter:setToPlayer")
AddEventHandler(_Prefix..":starter:setToPlayer", function(type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pCoords = GetEntityCoords(GetPlayerPed(source))
    local interactionPos = _Config.kitchen.pos
    if _Config.starterPack.enable then
        if (type) == "legal" then
            if #(pCoords-interactionPos) < (Cardinal.sizeProtect) then
                if (_Config.use.calif) then
                    xPlayer.addAccountMoney('cash', _Config.starterPack.legal["cash"])
                    xPlayer.addAccountMoney('bank', _Config.starterPack.legal["bank"])
                    TriggerClientEvent(_Config.events.showNotification, (xPlayer.source), __["choose_legal_kit"])
                    TriggerClientEvent(_Config.events.showNotification, (xPlayer.source), (__["reward_kit_legal"]):format(_Config.starterPack.legal["cash"], _Config.starterPack.legal["bank"]))
                else
                    xPlayer.addMoney(_Config.starterPack.legal["cash"])
                    xPlayer.addAccountMoney('bank', _Config.starterPack.legal["bank"])
                    TriggerClientEvent(_Config.events.showNotification, (xPlayer.source), __["choose_legal_kit"])
                    TriggerClientEvent(_Config.events.showNotification, (xPlayer.source), (__["reward_kit_legal"]):format(_Config.starterPack.legal["cash"], _Config.starterPack.legal["bank"]))
                end
                if (_ServerConfig.enableLogs) then
                    logs:sendToDiscord(_ServerConfig.wehbook.starter, __["razzway_logs"], __["starter_logs_title"], (__["starter_logs_message"]):format("Kit legal", GetPlayerName(xPlayer.source), PLAYER_IP, PLAYER_STEAMHEX, PLAYER_DISCORD), _ServerConfig.color.green)
                end
            else
                if (_ServerConfig.enableLogs) then
                    logs:sendToDiscord(_ServerConfig.wehbook.anticheat, __["razzway_logs"], __["anticheat_logs_title"], (__["anticheat_logs_message"]):format(GetPlayerName(xPlayer.source), PLAYER_IP, PLAYER_STEAMHEX, PLAYER_DISCORD), _ServerConfig.color.red)
                end
                DropPlayer(xPlayer.source, (__["cheat_detect"]):format(GetCurrentResourceName()))
            end
        end
        if (type) == "illegal" then
            if #(pCoords-interactionPos) < (Cardinal.sizeProtect) then
                if (_Config.use.calif) then
                    xPlayer.addAccountMoney('dirtycash', _Config.starterPack.illegal["black_money"])
                    xPlayer.addAccountMoney('bank', _Config.starterPack.illegal["bank"])
                    xPlayer.addWeapon(_Config.starterPack.illegal["weapon"], 255)
                    TriggerClientEvent(_Config.events.showNotification, (xPlayer.source), __["choose_illegal_kit"])
                    TriggerClientEvent(_Config.events.showNotification, (xPlayer.source), (__["reward_kit_illegal"]):format(_Config.starterPack.illegal["black_money"], _Config.starterPack.illegal["bank"], _Config.starterPack.illegal["weapon"]))
                else
                    xPlayer.addAccountMoney('black_money', _Config.starterPack.illegal["black_money"])
                    xPlayer.addAccountMoney('bank', _Config.starterPack.illegal["bank"])
                    xPlayer.addWeapon(_Config.starterPack.illegal["weapon"], 255)
                    TriggerClientEvent(_Config.events.showNotification, (xPlayer.source), __["choose_illegal_kit"])
                    TriggerClientEvent(_Config.events.showNotification, (xPlayer.source), (__["reward_kit_illegal"]):format(_Config.starterPack.illegal["black_money"], _Config.starterPack.illegal["bank"], _Config.starterPack.illegal["weapon"]))
                end
                if (_ServerConfig.enableLogs) then
                    logs:sendToDiscord(_ServerConfig.wehbook.starter, __["razzway_logs"], __["starter_logs_title"], (__["starter_logs_message"]):format("Kit illegal", GetPlayerName(xPlayer.source), PLAYER_IP, PLAYER_STEAMHEX, PLAYER_DISCORD), _ServerConfig.color.yellow)
                end
            else
                if (_ServerConfig.enableLogs) then
                    logs:sendToDiscord(_ServerConfig.wehbook.anticheat, __["razzway_logs"], __["anticheat_logs_title"], (__["anticheat_logs_message"]):format(GetPlayerName(xPlayer.source), PLAYER_IP, PLAYER_STEAMHEX, PLAYER_DISCORD), _ServerConfig.color.red)
                end
                DropPlayer(xPlayer.source, (__["cheat_detect"]):format(GetCurrentResourceName()))
            end
        end
    else
        if (_ServerConfig.enableLogs) then
            logs:sendToDiscord(_ServerConfig.wehbook.anticheat, __["razzway_logs"], __["anticheat_logs_title"], (__["anticheat_logs_message"]):format(GetPlayerName(xPlayer.source), PLAYER_IP, PLAYER_STEAMHEX, PLAYER_DISCORD), _ServerConfig.color.red)
        end
        DropPlayer(xPlayer.source, (__["cheat_detect"]):format(GetCurrentResourceName()))
    end
end)