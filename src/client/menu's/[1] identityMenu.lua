---@author Razzway
---@version 3.0
---@type function _Client.open:identityMenu
function _Client.open:identityMenu()
    local identityMenu = RageUI.CreateMenu(__["create_identity"], __["put_your_info"])
    identityMenu.Closable = false;

    RageUI.Visible(identityMenu, (not RageUI.Visible(identityMenu)))
    FreezeEntityPosition(PlayerPedId(), true)

    while identityMenu do
        Wait(0)

        RageUI.IsVisible(identityMenu, function()
            RageUI.Line()
            RageUI.Button(("%s"..__["firstname"]):format(arrow), nil, {RightLabel = playerIdentity.firstname}, true, {
                onSelected = function()
                    local firstname = Utils:input("Veuillez indiquer votre prénom (ex : Lionel) :", "", 20)
                    if firstname ~= nil and firstname ~= "" and firstname ~= __["undefinited"] and not tonumber(firstname) then
                        playerIdentity.firstname = firstname
                    else
                        Utils:showNotification('~r~Il semblerait que vous n\'ayez pas entrer de prénom.')
                    end
                end
            })
            if playerIdentity.firstname ~= __["undefinited"] then
                RageUI.Button(("%s"..__["name"]):format(arrow), nil, {RightLabel = playerIdentity.name}, true, {
                    onSelected = function()
                        local name = Utils:input("Veuillez indiquer votre nom (ex : Messi) :", "", 20)
                        if name ~= nil and name ~= "" and name ~= __["undefinited"] and not tonumber(name) then
                            playerIdentity.name = name
                        else
                            Utils:showNotification('~r~Il semblerait que vous n\'ayez pas entrer de nom.')
                        end
                    end
                })
            else
                RageUI.Button(("%s"..__["name"]):format(arrow), nil, {RightLabel = playerIdentity.name}, false, {})
            end
            if playerIdentity.firstname ~= __["undefinited"] and playerIdentity.name ~= __["undefinited"] then
                RageUI.Button(("%s"..__["height"]):format(arrow), nil, {RightLabel = playerIdentity.height}, true, {
                    onSelected = function()
                        local height = Utils:input("Veuillez indiquer votre taille (ex : 180) :", "", 20)
                        if height ~= nil and height ~= "" and height ~= __["undefinited"] and tonumber(height) ~= nil then
                            playerIdentity.height = height
                        else
                            Utils:showNotification('~r~Il semblerait que vous n\'ayez pas entrer de taille. Assurez vous qu\'il s\'agisse bel et bien d\'un nombre')
                        end
                    end
                })
            else
                RageUI.Button(("%s"..__["height"]):format(arrow), nil, {RightLabel = playerIdentity.height}, false, {})
            end
            if playerIdentity.firstname ~= __["undefinited"] and playerIdentity.name ~= __["undefinited"] and playerIdentity.height ~= __["undefinited"] then
                RageUI.Button(("%s"..__["date_of_birth"]):format(arrow), nil, {RightLabel = playerIdentity.birthday}, true, {
                    onSelected = function()
                        local birthday = Utils:input("Veuillez indiquer votre date de naissance (ex : 01/01/2001) :", "", 20)
                        if Utils:IsDateCorrect(birthday) and birthday ~= __["undefinited"] then
                            playerIdentity.birthday = birthday
                        else
                            Utils:showNotification('~r~Il semblerait que vous n\'ayez pas entrer de date de naissance. Assurez vous qu\'il s\'agisse bel et bien d\'un nombre')
                        end
                    end
                })
            else
                RageUI.Button(("%s"..__["date_of_birth"]):format(arrow), nil, {RightLabel = playerIdentity.birthday}, false, {})
            end
            if playerIdentity.firstname ~= __["undefinited"] and playerIdentity.name ~= __["undefinited"] and playerIdentity.height ~= __["undefinited"] and playerIdentity.birthday ~= __["undefinited"] then
                RageUI.Button(("%s"..__["sex"]):format(arrow), nil, {RightLabel = playerIdentity.sex}, true, {
                    onSelected = function()
                        local sex = Utils:input("Veuillez indiquer votre sexe (ex : m ou f) :", "", 20)
                        if sex == "m" or sex == "f" then
                            playerIdentity.sex = sex
                        else
                            Utils:showNotification('~r~Il semblerait que vous n\'ayez pas entrer votre sexe. Assurez vous que ce soit bel et bien m ou f.')
                            sex = __["undefinited"]
                        end
                    end
                })
            else
                RageUI.Button(("%s"..__["sex"]):format(arrow), nil, {RightLabel = playerIdentity.sex}, false, {})
            end
            if playerIdentity.firstname ~= __["undefinited"] and playerIdentity.name ~= __["undefinited"] and playerIdentity.height ~= __["undefinited"] and playerIdentity.birthday ~= __["undefinited"] and playerIdentity.sex ~= __["undefinited"] then
                RageUI.Button(__["valid_&_continue"], __["advert_continue"], {RightBadge = RageUI.BadgeStyle.Tick, Color = { HightLightColor = {39, 227, 45, 160}, BackgroundColor = {39, 227, 45, 160} }}, true, {
                    onSelected = function()
                        Utils:showNotification(__["identity_success"])
                        TriggerEvent(_Prefix..':saveSkin')
                        TriggerServerEvent(_Prefix..':identity:setIdentity', playerIdentity)
                        Utils:goCloak()
                    end
                })
            else
                RageUI.Button(__["valid_&_continue"], __["not_filled"], {RightBadge = RageUI.BadgeStyle.Tick, Color = { HightLightColor = {209, 31, 46, 160}, BackgroundColor = {209, 31, 46, 160} }}, false, {})
            end
        end)

        if not RageUI.Visible(identityMenu) then
            identityMenu = RMenu:DeleteType("identityMenu", true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end