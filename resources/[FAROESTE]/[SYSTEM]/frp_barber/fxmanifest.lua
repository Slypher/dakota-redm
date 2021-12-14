fx_version "adamant"
games {"rdr3"}

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_script '@_core/lib/utils.lua'

client_script 'client/client.lua'

server_script 'server.lua'

ui_page('client/html/index.html')

files({
    'data/*.json',
    'client/html/img/*',
    'client/html/fonts/*',
    'client/html/*',
    'client/html/webfonts/*',
    'client/html/css/*'
})