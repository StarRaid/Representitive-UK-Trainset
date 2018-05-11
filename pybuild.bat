@ECHO OFF
:start
python nml_compiler.py -f "example_header.pnml" -o "example.nml"
PAUSE
goto start