---@author Razzway
---@version 3.0
local grrRazzway = false
local loading = 0.0

---@type function _Client.open:createCharacterMenu
function _Client.open:createCharacterMenu()
    local createCharacterMenu = RageUI.CreateMenu(_Config.serverName, __["welcome"])
    createCharacterMenu.Closable = false;

    RageUI.Visible(createCharacterMenu, (not RageUI.Visible(createCharacterMenu)))

    while createCharacterMenu do
        RageUI.IsVisible(createCharacterMenu, function()
            Wait(0)
            RageUI.Line()
            RageUI.Button(__["create_my_character"], __["create_character_desc"], {}, not grrRazzway, {
                onSelected = function()
                    grrRazzway = true
                end
            })
            RageUI.Line()
            if grrRazzway then
                RageUI.PercentagePanel(loading, "Création de vos données... ~b~"..math.floor(loading*100).."%", "", "", {})

                if loading < 1.0 then
                    loading = loading + 0.002
                else
                    loading = 0
                end

                if loading >= 1.0 then
                    DoScreenFadeOut(2000)
                    while not IsScreenFadedOut() do Wait(1) end
                    Wait(1200)
                    Utils:KillCam()
                    SetEntityCoords(PlayerPedId(), _Config.firstSpawn.pos, false, false, false, false)
                    SetEntityHeading(PlayerPedId(), _Config.firstSpawn.heading)
                    Utils:SetPlayerBuckets(true)
                    Utils:PlayAnimeCreator()
                    Utils:CreatePlayerCam()
                    SetEntityInvincible(PlayerPedId(), false)
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    DoScreenFadeIn(750)
                    _Client.open:identityMenu()
                end
            end
        end)

        if not RageUI.Visible(createCharacterMenu) then
            createCharacterMenu = RMenu:DeleteType('createCharacterMenu', true)
        end
    end
end
