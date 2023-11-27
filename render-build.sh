#!/bin/bash

# This script is used to build your application.
# Place all the necessary build commands here.

# Navigate to the project root directory
cd /path/to/your/project

# Install Node.js dependencies
npm install
npm install moment -g

# Navigate to the client directory and install Python dependencies
cd client
pip install -r requirements.txt ccxt openpyxl

# Navigate to the utils/stream directory and run stream.js
cd ../utils/stream
node stream.js

# Navigate back to the project root directory
cd ../../
