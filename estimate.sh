#!/bin/bash

# Check if parameter is provided
if [ -z "$1" ]; then
  echo "Error: Missing required parameter."
  echo "Usage: ./script.sh \"<description>\""
  exit 1
fi

# Check if the virtual environment exists
if [ ! -d "venv" ]; then
  echo "Error: Virtual environment not found. Please create it first."
  exit 1
fi

# Check if script.py exists
if [ ! -f "script.py" ]; then
  echo "Error: Python script 'script.py' not found."
  exit 1
fi

# Check if model.pkl exists
if [ ! -f "model.pkl" ]; then
  echo "Error: Model file 'model.pkl' not found."
  exit 1
fi

# Activate the virtual environment
source "venv/bin/activate" || { echo "Error: Failed to activate virtual environment."; exit 1; }

# Run the Python script
python script.py estimate model.pkl "$1" || { echo "Error: Python script failed."; deactivate; exit 1; }

# Deactivate the virtual environment
deactivate || { echo "Error: Failed to deactivate virtual environment."; exit 1; }

echo "Estimation completed successfully!"
