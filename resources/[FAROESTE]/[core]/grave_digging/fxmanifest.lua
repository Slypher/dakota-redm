fx_version 'adamant'

game 'common'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts {
    '@_core/lib/utils.lua',
    'shared/shared.lua',
    'shared/digging_clusters.lua',
}

client_scripts {
    'client/anim_scene.lua',
    'client/volume.lua',
    'client/request.lua',
    'client/main.lua',
}

server_scripts {
    '@_core/lib/utils.lua',
    'server/server.lua',
    'server/loottable.lua',
    'server/loottable_generator.lua',
}

lua54 'yes'

-- exec './data.cfg'