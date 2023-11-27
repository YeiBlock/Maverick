#!/bin/bash

# Exit on any error
set -e

# Navigate to the project root directory
cd /render/project

# Navigate to the client directory
cd client

# Run stream.js
node utils/stream/stream.js &

# Navigate back to the project root directory
cd /render/project

# Run your main Python script (replace with your actual Python script name)
python main.py