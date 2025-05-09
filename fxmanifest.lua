fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'sleetdevs'
description 'NexusJailing - Staff Jail System'
version '1.0.0'

shared_script 'config/config.lua'

server_scripts {
    'server/server.lua',
}

client_scripts {
    'client/client.lua',
}

shared_script '@ox_lib/init.lua' -- Ox lib is required.
dependencies 'ox_lib'
