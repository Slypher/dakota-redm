fx_version "adamant"
games {"rdr3"}
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

dependency '_core'

client_script {
	"@_core/lib/utils.lua",
	"@_core/config/Items.lua",
	"_cfg.lua",
	"client.lua"
}

server_script {
	"@_core/lib/utils.lua",
	"_cfg.lua",
	"server.lua"
}

ui_page "nui/index.html"

files {
	"nui/**/*",
}