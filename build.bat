@ECHO OFF
:start
gcc -C -E -nostdinc -x c-header -o rukts.nml rukts.pnml
nmlc rukts.nml -o rukts.grf
PAUSE
goto start