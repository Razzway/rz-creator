---@author Razzway
---@version 3.0
---@type function Render:myOutfitMenu
function Render:myOutfitMenu()
    RageUI.Line()
    for _,outfit in pairs(_Config.outfit) do
        RageUI.Button(outfit.label, nil, {}, true, {
            onActive = function() Utils:OnRenderCam() end,
            onSelected = function()
                Utils:applySkinSpecific(outfit)
                Utils:showNotification(("Vous avez enfilé la tenue : ~b~%s"):format(outfit.label))
            end
        })
    end
end