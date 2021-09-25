@echo off

echo ===-------------------------------===   
echo     Base DakotaRP
echo     Discord:discord.gg/dakotarp 
echo ===-------------------------------===

start ..\FXServer.exe +exec configs/server.cfg +set onesync on  +set sv_enforceGameBuild 1355 +set gamename rdr3 +set svgui_disable true
exit
