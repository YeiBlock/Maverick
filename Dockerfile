# Stage 1: Build Node.js dependencies
FROM node:14 AS node_builder

WORKDIR /app

COPY package*.json ./

RUN npm install
RUN npm install moment -g

# Stage 2: Build Python dependencies
FROM python:3.9 AS python_builder

WORKDIR /app/client

COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Stage 3: Final image
FROM python:3.9-slim

WORKDIR /app

COPY --from=node_builder /app/node_modules /app/node_modules

WORKDIR /app/client

COPY . .

ENV NODE_ENV production

# Set the working directory to /app/utils/stream
WORKDIR /app/utils/stream

# CMD to run the stream.js file using Node.js
CMD ["node", "stream.js"]

# Switch back to the main working directory
WORKDIR /app/client

# Additional configurations for the Python application
EXPOSE 3000

# Update the CMD to point to the correct location of main.py
CMD ["python", "main.py"]


