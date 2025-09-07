from flask import Flask, request, jsonify
import psycopg2
import os
import json

app = Flask(__name__)

def get_db_conn():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=os.getenv("DB_PORT", "5432"),
        database=os.getenv("DB_NAME", "notesdb"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASS", "postgres")
    )

@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"}), 200

@app.route("/notes", methods=["POST"])
def create_note():
    data = request.json
    conn = get_db_conn()
    cur = conn.cursor()
    cur.execute("INSERT INTO notes (title, body) VALUES (%s, %s) RETURNING id;", 
                (data["title"], data["body"]))
    note_id = cur.fetchone()[0]
    conn.commit()
    cur.close()
    conn.close()
    return jsonify({"id": note_id}), 201

@app.route("/notes", methods=["GET"])
def get_notes():
    conn = get_db_conn()
    cur = conn.cursor()
    cur.execute("SELECT id, title, body FROM notes;")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    notes = [{"id": r[0], "title": r[1], "body": r[2]} for r in rows]
    return jsonify(notes), 200

# Lambda entrypoint
def handler(event, context):
    from mangum import Mangum
    asgi_handler = Mangum(app)
    return asgi_handler(event, context)

