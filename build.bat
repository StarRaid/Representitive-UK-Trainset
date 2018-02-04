@ECHO OFF
:start
..gcc -C -E -nostdinc -x c-header -o RUKTS.nml RUKTS.pnml
/nmlc.exe rukts.nml -o rukts.grf
PAUSE
goto start