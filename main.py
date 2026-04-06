from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def index():
    return os.getenv("MESSAGE", "Hello from Github Action CICD Completed successfully 🚀")

@app.route("/health")
def health():
    return {"status": "ok"}, 200
