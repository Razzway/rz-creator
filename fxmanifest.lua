fx_version ('cerulean')
game ('gta5')
version('1.0')
author('Razzway')
description('rz-creator, an cool character creator in RageUI')

shared_scripts {
    'configs/cConfig.lua',
    'src/translation/*.lua',
}

client_scripts {
    'src/utils.lua',

    'src/libs/RageUI//RMenu.lua',
    'src/libs/RageUI//menu/RageUI.lua',
    'src/libs/RageUI//menu/Menu.lua',
    'src/libs/RageUI//menu/MenuController.lua',
    'src/libs/RageUI//components/*.lua',
    'src/libs/RageUI//menu/elements/*.lua',
    'src/libs/RageUI//menu/items/*.lua',
    'src/libs/RageUI//menu/panels/*.lua',
    'src/libs/RageUI/menu/windows/*.lua',

    'src/client/*.lua',
    'src/client/menu\'s/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'configs/sConfig.lua',
    'src/server/*.lua',
}
