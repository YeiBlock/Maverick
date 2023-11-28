# Install Node.js dependencies
npm install
npm install moment -g

# Navigate to the client directory and install Python dependencies
cd client
pip install -r requirements.txt 

# Navigate to the utils/stream directory and run stream.js
cd ../utils/stream
node stream.js

# Navigate back to the project root directory
cd ../../
