:start
bin\m4.exe -R m4nfo_stations.m4 < src\RUKSS.nfx > src\RUKSS.nfo
copy count.m4 + src\RUKSS.nfo test.tt
bin\m4.exe test.tt > src\RUKSS.nfo
nforenum.exe src\RUKSS.nfo
grfcodec.exe -e RUKSS.grf src
PAUSE
goto start
