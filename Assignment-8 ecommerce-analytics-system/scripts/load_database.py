import sqlite3
import pandas as pd
connection = sqlite3.connect("database/ecommerce.db")

print("Database Connected Successfully")

customers = pd.read_csv("data/cleaned/customers_clean.csv")
products = pd.read_csv("data/cleaned/products_clean.csv")
orders = pd.read_csv("data/cleaned/orders_clean.csv")
order_items = pd.read_csv("data/cleaned/order_items_clean.csv")

customers.to_sql(
    "customers",
    connection,
    if_exists="replace",
    index=False
)

products.to_sql(
    "products",
    connection,
    if_exists="replace",
    index=False
)

orders.to_sql(
    "orders",
    connection,
    if_exists="replace",
    index=False
)

order_items.to_sql(
    "order_items",
    connection,
    if_exists="replace",
    index=False
)
connection.close()

print("Database Loaded Successfully")