fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_script 'config.lua'

client_scripts {
	'@_core/config/Items.lua',
	'client.js',
	'client.lua'
}

server_script 'server.lua'

exports {
	'GET_TASK_FISHING_DATA',
    'SET_TASK_FISHING_DATA',
    'VERTICAL_PROBE'
}