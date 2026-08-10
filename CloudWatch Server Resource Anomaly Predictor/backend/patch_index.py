import re
import sys

def main():
    path = 'app/templates/index.html'
    try:
        with open(path, 'r') as f:
            content = f.read()
        
        # Replace absolute Vite asset paths with Jinja2 url_for syntax
        content = re.sub(r'src="[./]*assets/(.*?)"', r'''src="{{ url_for('static', filename='assets/\1') }}"''', content)
        content = re.sub(r'href="[./]*assets/(.*?)"', r'''href="{{ url_for('static', filename='assets/\1') }}"''', content)
        
        with open(path, 'w') as f:
            f.write(content)
        print("Successfully patched index.html")
    except Exception as e:
        print(f"Error patching index.html: {e}")
        sys.exit(1)

if __name__ == '__main__':
    main()
