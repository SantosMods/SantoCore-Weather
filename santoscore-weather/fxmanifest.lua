-- fxmanifest.lua

fx_version 'cerulean'
game 'gta5'

author 'SantosMods.dev'
description 'SantosCore Project: Weather Control Module with Badger_Discord_API support'
version '1.1.0'

shared_script 'config.lua'
client_script 'client/main.lua'
server_script 'server/main.lua'

dependencies {
    'ox_lib',
    'Badger_Discord_API'
}
