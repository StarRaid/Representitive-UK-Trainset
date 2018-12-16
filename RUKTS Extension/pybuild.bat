@ECHO OFF
:start
python nml_patcher.py -f "ruktsna.pnml" -o "ruktsna.nml"
nmlc ruktsna.nml -o ruktsnma.grf
PAUSE
goto start