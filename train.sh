#!/bin/bash

# Activate the virtual environment
source "venv/bin/activate"

python script.py train tasks.csv model.pkl

deactivate
