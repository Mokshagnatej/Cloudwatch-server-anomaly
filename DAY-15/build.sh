#!/usr/bin/env bash
# Exit on error
set -o errexit

echo "Installing backend dependencies..."
cd backend
pip install --target=./pkgs -r requirements.txt

echo "Building frontend..."
cd ../frontend
npm install
npm run build

echo "Updating backend templates with new frontend build..."
cd ../backend

# Ensure directories exist
mkdir -p app/static/assets
mkdir -p app/templates

# The frontend build script already copies assets, but let's be explicit here just in case
rm -rf app/static/assets/*
cp -r ../frontend/dist/assets/* app/static/assets/

# Copy and patch the index.html to use Jinja2 url_for syntax
python3 -c "
import re

try:
    with open('../frontend/dist/index.html', 'r') as f:
        content = f.read()
    
    # Replace absolute paths with Jinja2 url_for syntax
    content = re.sub(r'src=\"/?assets/(.*?)\"', r'src=\"{{ url_for(\'static\', filename=\'assets/\1\') }}\"', content)
    content = re.sub(r'href=\"/?assets/(.*?)\"', r'href=\"{{ url_for(\'static\', filename=\'assets/\1\') }}\"', content)
    
    with open('app/templates/index.html', 'w') as f:
        f.write(content)
        
    print('Successfully patched index.html for Flask')
except Exception as e:
    print(f'Error patching index.html: {e}')
    exit(1)
"

echo "Build complete."
