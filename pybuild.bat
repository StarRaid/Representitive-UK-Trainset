@ECHO OFF
:start
<<<<<<< HEAD
python.exe nml_patcher.py -f "rukts.pnml" -o "rukts.nml" -b 1
nmlc rukts.nml -o rukts.grf
=======
python nml_patcher.py -f "rukts.pnml" -o "rukts_py.nml" -b 1
nmlc rukts_py.nml -o rukts_py.grf
>>>>>>> 398da1528be1e19e0d8168142c92950a8e523a9c
PAUSE
goto start