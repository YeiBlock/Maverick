# Stage 1: Build Node.js dependencies
FROM node:14 AS node_builder

WORKDIR /app

COPY package*.json ./

RUN npm install
RUN npm install moment -g

# Stage 2: Build Python dependencies
FROM python:3.9 AS python_builder

WORKDIR /app

COPY . .

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Stage 3: Final image
FROM python:3.9-slim

WORKDIR /app

COPY --from=node_builder /app/node_modules /app/node_modules
COPY --from=python_builder /app /app

ENV NODE_ENV production

EXPOSE 3000

# Update the CMD to point to the correct location of main.py
CMD ["python", "client/main.py"]
