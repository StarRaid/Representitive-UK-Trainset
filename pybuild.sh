#!/bin/bash

python3 nml_patcher.py -f "rukts.pnml" -o "rukts.nml"
python3 -m nml.main rukts.nml -o rukts.grf -s