fx_version 'adamant'

game 'common'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts {
    '@_core/lib/utils.lua',
    'shared.lua',
}

client_script 'client.lua'

server_scripts {
    'server.lua',
    'PrivilegeQueuePriorityHandler.lua',
}

lua54 'yes'