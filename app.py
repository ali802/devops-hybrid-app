import http.server
import socketserver

PORT = 8080

class MyHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        
        html_content = """
        <!DOCTYPE html>
        <html>
        <head>
            <title>DevOps Hybrid App</title>
            <style>
                body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; background-color: #f4f4f9; }
                h1 { color: #2c3e50; }
                p { color: #7f8c8d; font-size: 1.2em; }
                .status { display: inline-block; padding: 10px 20px; background-color: #2ecc71; color: white; border-radius: 5px; font-weight: bold; }
            </style>
        </head>
        <body>
            <h1>🚀 DevOps Hybrid Project</h1>
            <p>This application was built by GitHub-Hosted Runners and deployed via a Self-Hosted EC2 Runner!</p>
            <div class="status">Status: Operational</div>
        </body>
        </html>
        """
        self.wfile.write(bytes(html_content, "utf-8"))

print(f"Starting server on port {PORT}...")
with socketserver.TCPServer(("", PORT), MyHandler) as httpd:
    httpd.serve_forever()
