#!/bin/bash

# Check if Python 3 is installed
if ! command -v python3 &>/dev/null; then
  echo "Error: Python 3 is not installed. Please install Python 3 first."
  exit 1
fi

# Create a virtual environment
echo "Creating virtual environment..."
python3 -m venv venv || { echo "Error: Failed to create virtual environment."; exit 1; }

# Check if the operating system is Windows or Unix-based (Linux/Mac)
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
  # Windows environment: Use the appropriate activation script
  echo "Detected Windows environment. Activating virtual environment..."
  source venv/Scripts/activate || { echo "Error: Failed to activate virtual environment."; exit 1; }
else
  # Unix-based environment: Use the Unix activation script
  echo "Detected Unix-based environment. Activating virtual environment..."
  source venv/bin/activate || { echo "Error: Failed to activate virtual environment."; exit 1; }
fi

# Check if requirements.txt exists
if [ ! -f "requirements.txt" ]; then
  echo "Error: requirements.txt not found."
  deactivate
  exit 1
fi

# Install the required dependencies from requirements.txt
echo "Installing dependencies from requirements.txt..."
pip install -r requirements.txt || { echo "Error: Failed to install dependencies."; deactivate; exit 1; }

# Optional: deactivate the virtual environment if you want to clean up
deactivate || { echo "Error: Failed to deactivate virtual environment."; exit 1; }

# Confirmation message
echo "Environment setup is complete. The virtual environment 'venv' is ready."
