---@author Razzway
---@version 3.0
---@type function _Client.open:starterPackMenu
function _Client.open:starterPackMenu()
    local starterPackMenu = RageUI.CreateMenu(__["starter_kit"], __["how_start"])
    starterPackMenu.Closable = false;

    RageUI.Visible(starterPackMenu, (not RageUI.Visible(starterPackMenu)))
    Utils:CreatePlayerCam()
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_DRUG_DEALER", 0, false)

    while starterPackMenu do
        Wait(0)

        RageUI.IsVisible(starterPackMenu, function()
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.Line()
            RageUI.Button(__["kit_legal"], (__["kit_legal_desc"]):format(_Config.starterPack.legal["cash"], _Config.starterPack.legal["bank"]), {RightLabel = __["choose_this"]}, true, {
                onSelected = function()
                    TriggerServerEvent(_Prefix..":starter:setToPlayer", "legal")
                    Utils:goLift()
                end
            })
            RageUI.Button(__["kit_illegal"], (__["kit_illegal_desc"]):format(_Config.starterPack.illegal["black_money"], _Config.starterPack.illegal["bank"], _Config.starterPack.illegal["weapon"]), {RightLabel = __["choose_this"]}, true, {
                onSelected = function()
                    TriggerServerEvent(_Prefix..":starter:setToPlayer", "illegal")
                    Utils:goLift()
                end
            })
        end)

        if not RageUI.Visible(starterPackMenu) then
            starterPackMenu = RMenu:DeleteType('starterPackMenu', true)
            FreezeEntityPosition(PlayerPedId(), false)
            Utils:KillCam()
        end
    end
end