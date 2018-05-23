@ECHO OFF
:start
python nml_patcher.py -f "rukts.pnml" -o "rukts_py.nml" -b 1
nmlc rukts.nml -o rukts_py.grf
PAUSE
goto start