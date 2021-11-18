fx_version 'adamant'

game 'common'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.' 

shared_script '@_core/lib/utils.lua'

client_scripts {
    '@_core/lib/enum.lua',
    'eGoldPanningState.lua',
    'client.lua'
}

server_script 'server.lua'

lua54 'yes'