import sys
import os

# Ensure the backend directory is always on the path so that
# 'config', 'app', etc. can be imported regardless of CWD
sys.path.insert(0, os.path.dirname(__file__))

from app import create_app

app = create_app()

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 8080))
    app.run(host='0.0.0.0', port=port)
