# Stage 1: Build Node.js dependencies
FROM node:14 AS node_builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Node.js dependencies
RUN npm install
RUN npm install moment -g

# Stage 2: Build Python dependencies
FROM python:3.9 AS python_builder

# Set the working directory
WORKDIR /app

# Copy the entire project to the working directory
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Stage 3: Final image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy from both Node.js and Python builders
COPY --from=node_builder /app/node_modules /app/node_modules
COPY --from=python_builder /app /app

# Set the environment variables
ENV NODE_ENV production

# Expose the port your app runs on
EXPOSE 3000

# Run your main Python script (replace with your actual Python script name)
CMD ["python", "main.py"]
