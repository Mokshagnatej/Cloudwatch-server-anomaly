# Stage 1: Build the frontend (Node 20)
FROM node:20-slim AS frontend-build
WORKDIR /app/frontend

# Copy frontend source and install dependencies
COPY DAY-15/frontend/package*.json ./
RUN npm install

# Copy all frontend files and build
COPY DAY-15/frontend/ ./
RUN npm run build

# Stage 2: Build the backend and assemble the final image (Python 3.11)
FROM python:3.11-slim
WORKDIR /app/backend

# Install system dependencies (just in case they are needed by some pip packages)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install python dependencies
COPY DAY-15/backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy backend code
COPY DAY-15/backend/ .

# Ensure frontend assets directories exist
RUN mkdir -p app/static/assets app/templates

# Copy built frontend from Stage 1
COPY --from=frontend-build /app/frontend/dist/assets/ app/static/assets/
COPY --from=frontend-build /app/frontend/dist/index.html app/templates/index.html

# Patch index.html for Flask
COPY DAY-15/backend/patch_index.py .
RUN python3 patch_index.py

# Set environment variables for runtime
ENV PYTHONPATH=/app/backend
ENV PORT=8080

# Start Gunicorn server
CMD ["sh", "-c", "gunicorn --workers 1 --threads 2 --bind 0.0.0.0:${PORT} main:app"]
