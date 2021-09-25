fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
client_scripts {
	'client/cl_main.lua',
}

server_scripts {
	'config.lua',
	'@mysql-async/lib/MySQL.lua',
	'server/Create_items.lua',
	'server/sv_main.lua',
}
files{
'html/inventory.html',
'html/css/*.ttf',
'html/*.png',
'html/js/*.js',
'html/css/*.css',
'html/css/*.png',
'html/items/*.png',
}

ui_page "html/inventory.html"
