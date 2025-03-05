#!/bin/bash

# Create a virtual environment
python3 -m venv venv

# Activate the virtual environment
# On Windows, use: venv\Scripts\activate
source venv/bin/activate

# Install the required dependencies from requirements.txt
pip install -r requirements.txt

echo "Environment setup is complete. The virtual environment 'venv' is ready."
