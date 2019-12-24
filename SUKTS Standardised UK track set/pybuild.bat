@ECHO OFF
:start
python nml_patcher.py -f "sukts.pnml" -o "sukts.nml"
nmlc sukts.nml -o sukts.grf
PAUSE
goto start