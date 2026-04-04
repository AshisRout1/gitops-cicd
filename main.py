from flask import Flask
import os


def create_app():
    app = Flask(__name__)

    @app.get("/")
    def index():
        message = os.getenv(
            "MESSAGE",
            "Hello from Argocd running on Kubernetes 🚀"
        )

        return f"""
        <html>
            <head><title>Secure Python App</title></head>
            <body style="font-family: Arial; text-align:center; margin-top:50px;">
                <h1>{message}</h1>
            </body>
        </html>
        """

    @app.get("/health")
    def health():
        return {"status": "ok"}, 200

    return app


# 👇 IMPORTANT: expose app for Gunicorn
app = create_app()
