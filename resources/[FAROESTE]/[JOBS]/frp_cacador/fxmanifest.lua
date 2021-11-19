game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_script {
    '@_core/lib/utils.lua',
    'config.lua',
    'client/main.lua',
    '@hunting_wagon/rdr3-provision-to-dollars.lua',
}

server_script {
    '@_core/lib/utils.lua',
    'config.lua',
    'server/main.lua'    
}

lua54 'yes'