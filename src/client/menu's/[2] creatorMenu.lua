---@author Razzway
---@version 3.0
---@type function _Client.open:creatorMenu
function _Client.open:creatorMenu()
    local creatorMenu = RageUI.CreateMenu(__["create_character"], "Faites votre personnage")
    local myAppearanceMenu = RageUI.CreateSubMenu(creatorMenu, __["create_character"], "Mon apparence")
    local myOutfitMenu = RageUI.CreateSubMenu(creatorMenu, __["create_character"], "Choisir une tenue")

    creatorMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = __["right_rotation"]})
    creatorMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = __["left_rotation"]})

    myAppearanceMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = __["right_rotation"]})
    myAppearanceMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = __["left_rotation"]})

    myOutfitMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = __["right_rotation"]})
    myOutfitMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = __["left_rotation"]})

    creatorMenu.Closable = false;
    myAppearanceMenu.EnableMouse = true;

    RageUI.Visible(creatorMenu, (not RageUI.Visible(creatorMenu)))
    Utils:CreatePlayerCam()
    Utils:loadPlayerAnime()

    local filter = {
        sex = {index = 1},
        face = {index = 1},
        skin= {index = 1},
    }

    while creatorMenu do
        Wait(0)

        RageUI.IsVisible(creatorMenu, function()
            FreezeEntityPosition(PlayerPedId(), true)
            local Face = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46}
            local Skin = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46}
            RageUI.Line()
            RageUI.List(("%s"..__["sex"]):format(arrow), {
                {Name = "Homme", Value = 0},
                {Name = "Femme", Value = 1},
            }, filter.sex.index, nil, {}, nil, {
                onActive = function() Utils:OnRenderCam() end,
                onListChange = function(Index, Item)
                    filter.sex.index = Index;
                end,
                onSelected = function(Index, Item)
                    TriggerEvent(_Config.events.skinchanger..':change', 'sex', Item.Value)
                end,
            })
            RageUI.List(("%s"..__["face"]):format(arrow), Face, filter.face.index, nil, {}, true, { onActive = function() Utils:OnRenderCam() end, onListChange = function(Index, Item) filter.face.index = Index TriggerEvent(_Config.events.skinchanger..':change', 'face', filter.face.index - 1) end })
            RageUI.List(("%s"..__["skin"]):format(arrow), Skin, filter.skin.index, nil, {}, true, { onActive = function() Utils:OnRenderCam() end, onListChange = function(Index, Item) filter.skin.index = Index TriggerEvent(_Config.events.skinchanger..':change', 'skin', filter.skin.index - 1) end })
            RageUI.Button(("%s"..__["my_appearance"]):format(arrow), nil, {}, true, {onActive = function() Utils:OnRenderCam() end}, myAppearanceMenu)
            RageUI.Button(("%s"..__["my_outfit"]):format(arrow), nil, {}, true, {onActive = function() Utils:OnRenderCam() end}, myOutfitMenu)
            RageUI.Button(__["valid_character"], nil, {RightBadge = RageUI.BadgeStyle.Tick, Color = { HightLightColor = {39, 227, 45, 160}, BackgroundColor = {39, 227, 45, 160} }}, true, {
                onActive = function() Utils:OnRenderCam() end,
                onSelected = function()
                    if _Config.starterPack.enable then
                        TriggerEvent(_Config.events.skinchanger..':getSkin', function(skin)
                            TriggerServerEvent(_Config.events.skin..':save', skin)
                        end)
                        Utils:goKitchen()
                    else
                        TriggerEvent(_Config.events.skinchanger..':getSkin', function(skin)
                            TriggerServerEvent(_Config.events.skin..':save', skin)
                        end)
                        Utils:goLift()
                    end
                end
            })
        end)

        RageUI.IsVisible(myAppearanceMenu, function()
            Render:myAppearanceMenu()
        end)

        RageUI.IsVisible(myOutfitMenu, function()
            Render:myOutfitMenu()
        end)

        if not RageUI.Visible(creatorMenu)
            and not RageUI.Visible(myAppearanceMenu)
            and not RageUI.Visible(myOutfitMenu)
            then
            creatorMenu = RMenu:DeleteType("creatorMenu", true)
            FreezeEntityPosition(PlayerPedId(), false)
            Utils:KillCam()
        end
    end
end
