@ECHO OFF
:start

python nml_patcher.py -f "rukts.pnml" -o "rukts_py.nml"
nmlc rukts_py.nml -o rukts_py.grf
PAUSE
goto start