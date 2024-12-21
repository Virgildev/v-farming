fx_version 'cerulean'
game 'gta5'

author 'Virgil'
description 'Simple Farming Script'
version '1.0.0'

lua54 'yes' 

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua',
    '@oxmysql/lib/MySQL.lua'
}