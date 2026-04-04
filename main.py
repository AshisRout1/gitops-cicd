from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def index():
    return os.getenv("MESSAGE", "Hello from ArgoCD Kubernetes 🚀")

@app.route("/health")
def health():
    return {"status": "ok"}, 200
