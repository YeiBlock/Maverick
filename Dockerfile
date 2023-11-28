# Use an appropriate Python base image
FROM python:3.8

# Set the working directory
WORKDIR /app

# Copy the entire project to the working directory
COPY . /app

# Install Node.js dependencies
RUN npm install
RUN npm install moment -g

# Navigate to the client directory and install Python dependencies
WORKDIR /app/client
RUN pip install -r requirements.txt 

# Navigate to the utils/stream directory and run stream.js
WORKDIR /app/utils/stream
CMD ["node", "stream.js"]

# Navigate back to the project root directory
WORKDIR /app

# Run your main Python script (replace with your actual Python script name)
CMD ["python", "main.py"]
