#!/bin/bash

# Check if parameter is provided
if [ -z "$1" ]; then
  echo "Error: Missing required parameter."
  echo "Usage: ./script.sh \"<description>\""
  exit 1
fi

# Activate the virtual environment
source "venv/bin/activate"

python script.py estimate model.pkl "$1"

deactivate
