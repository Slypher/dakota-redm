fx_version 'adamant'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
client_script "src/c_utils.lua"
client_script "c_config.lua"
client_script "src/c_main.lua"
client_script "src/c_TokoVoip.lua"
client_script "src/nuiProxy.js"

server_script "s_config.lua"
server_script "src/s_main.lua"
server_script "src/s_utils.lua"

ui_page "nui/index.html"

files({
    "nui/index.html",
    "nui/script.js",
})

