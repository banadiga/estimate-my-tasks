#!/bin/bash

# Check if virtual environment directory exists
if [ ! -d "venv" ]; then
  echo "Virtual environment not found! Please set it up first."
  exit 1
fi

# Activate the virtual environment
source "venv/bin/activate" || { echo "Failed to activate virtual environment."; exit 1; }

# Check if Python script and CSV file exist
if [ ! -f "script.py" ]; then
  echo "Python script 'script.py' not found."
  deactivate
  exit 1
fi

if [ ! -f "tasks.csv" ]; then
  echo "CSV file 'tasks.csv' not found."
  deactivate
  exit 1
fi

# Run the Python script with the arguments
python script.py train tasks.csv model.pkl || { echo "Python script failed."; deactivate; exit 1; }

# Deactivate the virtual environment
deactivate || { echo "Failed to deactivate virtual environment."; exit 1; }

echo "Training completed successfully!"
