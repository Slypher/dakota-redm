fx_version 'adamant'

game 'common'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.' 

shared_scripts {
    '@_core/lib/utils.lua',
}

client_scripts {
    'client/provisions.lua',
    'client/skinned-carcass-to-animal-carcass.lua',
    'client/override-carry-action-prompt.js',
    'client/game-event-handler.lua',
}

server_script 'server.lua'

lua54 'yes'