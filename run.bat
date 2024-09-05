@ECHO OFF
:start
D:
cd "D:\OpenTTD\Representitive-UK-Trainset"
python nml_patcher.py -f "rukts.pnml" -o "rukts.nml"
nmlc rukts.nml -o rukts.grf -s
copy rukts.grf "C:\Games\OpenTTD\Testbed\newgrf\rukts_dev.grf"
C:
cd "C:\Games\OpenTTD"
openttd.exe -c "C:\Games\OpenTTD\Testbed\openttd.cfg"
PAUSE
goto start