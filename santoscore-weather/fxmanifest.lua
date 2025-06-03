-- fxmanifest.lua

fx_version 'cerulean'
lua54 'yes'
game 'gta5'

author 'SantosMods.dev'
description 'SantosCore Project: Weather Control Module with Badger_Discord_API support'
version '1.2.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}
client_script 'client/main.lua'
server_script 'server/main.lua'

dependencies {
    'ox_lib',
    'Badger_Discord_API'
}
