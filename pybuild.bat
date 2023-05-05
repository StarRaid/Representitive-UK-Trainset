@ECHO OFF
:start
python nml_patcher.py -f "rukts.pnml" -o "rukts.nml"
nmlc rukts.nml -o rukts.grf -s
PAUSE
goto start