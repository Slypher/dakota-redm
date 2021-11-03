fx_version 'adamant'

game 'common'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts {
    '@_core/lib/utils.lua',
    'shared.lua',
    'data.lua',
}

client_scripts {
    'anim_scene.lua',
    'volume.lua',
    'request.lua',
    'client.lua',
}

server_script 'server.lua'

lua54 'yes'

exec './data.cfg'