from flask import Flask, jsonify
app = Flask(__name__)

@app.route("/orders")
def get_orders():
    return jsonify({"orders": [101, 102, 103]})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5002)
