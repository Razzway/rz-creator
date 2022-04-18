---@author Razzway
---@version 3.0
---@type function _Client.open:selectSpawnMenu
function _Client.open:selectSpawnMenu()
    local selectSpawnMenu = RageUI.CreateMenu(__["spawn"], __["choose_spawn"])
    selectSpawnMenu.Closable = false;

    RageUI.Visible(selectSpawnMenu, (not RageUI.Visible(selectSpawnMenu)))
    Utils:CreatePlayerCam()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_TOURIST_MAP", 0, false)

    while selectSpawnMenu do
        Wait(0)

        RageUI.IsVisible(selectSpawnMenu, function()
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.Line()
            for _,spawn in pairs(_Config.afterSpawn) do
                RageUI.Button(arrow.. spawn.name, nil, {RightLabel = __["choose_this"]}, true, {
                    onSelected = function()
                        selectedName = spawn.name
                        selectedPos = spawn.pos
                        selectedHeading = spawn.head
                        Utils:endIdentity()
                    end
                })
            end
            RageUI.Line()
        end)

        if not RageUI.Visible(selectSpawnMenu) then
            selectSpawnMenu = RMenu:DeleteType('selectSpawnMenu', true)
            FreezeEntityPosition(PlayerPedId(), false)
            Utils:KillCam()
        end
    end
end