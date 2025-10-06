from flask import Flask, jsonify
import requests
app = Flask(__name__)

USER_URL = "http://user-service:5000/users"
PRODUCT_URL = "http://product-service:5001/products"
ORDER_URL = "http://order-service:5002/orders"

@app.route("/")
def gateway():
    users = requests.get(USER_URL).json()
    products = requests.get(PRODUCT_URL).json()
    orders = requests.get(ORDER_URL).json()
    return jsonify({"users": users, "products": products, "orders": orders})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
