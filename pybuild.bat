@ECHO OFF
:start
python.exe nml_patcher.py -f "rukts.pnml" -o "rukts.nml" -b 1
nmlc rukts.nml -o rukts.grf
PAUSE
goto start