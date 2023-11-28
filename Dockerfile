# Use an official Node.js runtime as a base image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Node.js dependencies
RUN npm install
RUN npm install moment -g

# Copy the entire project to the working directory
COPY . .

# Navigate to the client directory and install Python dependencies
WORKDIR /app/client
RUN pip install -r requirements.txt ccxt openpyxl

# Navigate to the utils/stream directory and run stream.js
WORKDIR /app/utils/stream
CMD ["node", "stream.js"]

# Expose any necessary ports
# EXPOSE 8080

# Change the working directory back to the project root
WORKDIR /app

# Copy the start script to the working directory
COPY render-start.sh .

# Make the start script executable
RUN chmod +x render-start.sh

# Define the command to run on container start
CMD ["./render-start.sh"]
