resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

server_scripts {
	'@_core/lib/utils.lua',
	'shared.lua'
}

client_scripts {
	'@_core/lib/utils.lua',
	-- 'config.lua',
	'shared.lua'
}

exports {
    "GetRegisteredDoorHashInRadius",
}