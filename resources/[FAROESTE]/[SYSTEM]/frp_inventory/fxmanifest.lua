fx_version "adamant"
games {"rdr3"}
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

client_scripts {
    "@_core/lib/utils.lua",
    "@_core/config/Items.lua",
    "@_core/config/WeaponInfoDatabase.lua",
    "@_core/config/WeaponInfoLookup.lua",
    "client.lua",
    "client_drop.lua"
}

server_scripts {
    "@_core/lib/utils.lua",
    "server.lua"
}

ui_page "nui/index.html"

files {
    "nui/fonts/*",
    "nui/*",
    "nui/images/*",
    "nui/images/items/*"
}

lua54 'yes'