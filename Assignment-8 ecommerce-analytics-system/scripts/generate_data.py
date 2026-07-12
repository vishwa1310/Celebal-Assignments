from faker import Faker
import pandas as pd
import random
from datetime import datetime, timedelta
from pathlib import Path

# Initialize Faker
fake = Faker()

# ----------------------------
# Configuration
# ----------------------------
NUM_CUSTOMERS = 500
NUM_PRODUCTS = 500
NUM_ORDERS = 1000
NUM_ORDER_ITEMS = 3000

# Customer Types
CUSTOMER_TYPES = [
    "REGULAR",
    "PREMIUM",
    "VIP"
]
# Product Categories
PRODUCT_CATEGORIES = {
    "Electronics": ["Laptop", "Mobile", "Headphones", "Keyboard", "Mouse"],
    "Clothing": ["Shirt", "Jeans", "Jacket", "T-Shirt", "Shoes"],
    "Home": ["Chair", "Table", "Lamp", "Curtain", "Sofa"],
    "Books": ["Novel", "Biography", "Science", "History", "Programming"]
}

# Order Status
ORDER_STATUS = [
    "PLACED",
    "SHIPPED",
    "DELIVERED",
    "CANCELLED",
    "RETURNED"
]
# Regions
REGIONS = [
    "NORTH",
    "SOUTH",
    "EAST",
    "WEST",
    "CENTRAL"
]

def generate_customers():

    customers = []

    for i in range(1, NUM_CUSTOMERS + 1):

        customer_id = i
        customer_name = fake.name()
        email = fake.email()

        # Make around 2% of emails invalid
        if random.randint(1, 100) <= 2:
           email = email.replace("@", "")
        registration_date = fake.date_between(start_date="-3y", end_date="today")
        customer_type = random.choice(CUSTOMER_TYPES)

        customers.append([
            customer_id,
            customer_name,
            email,
            registration_date,
            customer_type
        ])

    columns = [
        "customer_id",
        "customer_name",
        "email",
        "registration_date",
        "customer_type"
    ]

    df = pd.DataFrame(customers, columns=columns)

    return df

def generate_products():

    products = []

    for i in range(1, NUM_PRODUCTS + 1):

        product_id = i

        category = random.choice(list(PRODUCT_CATEGORIES.keys()))

        product_name = random.choice(PRODUCT_CATEGORIES[category])

        # Add some data issues
        chance = random.randint(1, 100)

        if chance <= 3:
            product_name = " " + product_name + " "

        elif chance <= 6:
            product_name = product_name.upper()

        elif chance <= 9:
            product_name = product_name.lower()

        subcategory = product_name

        cost_price = random.randint(100, 50000)

        products.append([
            product_id,
            product_name,
            category,
            subcategory,
            cost_price
        ])

    columns = [
        "product_id",
        "product_name",
        "category",
        "subcategory",
        "cost_price"
    ]

    df = pd.DataFrame(products, columns=columns)

    return df

def generate_orders():

    orders = []

    for i in range(1, NUM_ORDERS + 1):

        order_id = i

        # 5% orders will have missing customer_id
        if random.randint(1, 100) <= 5:
            customer_id = None
        else:
            customer_id = random.randint(1, NUM_CUSTOMERS)

        order_date = fake.date_time_between(
            start_date="-2y",
            end_date="now"
        )

        # Around 5% dates will have the wrong format
        if random.randint(1, 100) <= 5:
            order_date = order_date.strftime("%d-%m-%Y")
        else:
            order_date = order_date.strftime("%Y-%m-%d %H:%M:%S")

        status = random.choice(ORDER_STATUS)

        region = random.choice(REGIONS)

        orders.append([
            order_id,
            customer_id,
            order_date,
            status,
            region
        ])

    columns = [
        "order_id",
        "customer_id",
        "order_date",
        "status",
        "region_code"
    ]

    df = pd.DataFrame(orders, columns=columns)

    return df

def generate_order_items():

    order_items = []

    for i in range(1, NUM_ORDER_ITEMS + 1):

        item_id = i

        order_id = random.randint(1, NUM_ORDERS)
        # Around 1% invalid order_id
        if random.randint(1, 100) == 1:
            order_id = NUM_ORDERS + random.randint(1, 20)

        product_id = random.randint(1, NUM_PRODUCTS)

        quantity = random.randint(1, 5)
        # Around 3% negative quantity
        if random.randint(1, 100) <= 3:
            quantity = -quantity

        unit_price = random.randint(100, 50000)

        discount_percent = random.randint(0, 50)

        order_items.append([
            item_id,
            order_id,
            product_id,
            quantity,
            unit_price,
            discount_percent
        ])

    columns = [
        "item_id",
        "order_id",
        "product_id",
        "quantity",
        "unit_price",
        "discount_percent"
    ]

    df = pd.DataFrame(order_items, columns=columns)

    return df

if __name__ == "__main__":

    customers_df = generate_customers()
    customers_df.to_csv("data/raw/customers.csv", index=False)

    products_df = generate_products()
    products_df.to_csv("data/raw/products.csv", index=False)

    orders_df = generate_orders()
    orders_df.to_csv("data/raw/orders.csv", index=False)

    order_items_df = generate_order_items()
    order_items_df.to_csv("data/raw/order_items.csv", index=False)

    print(customers_df.head())

    print("\nProducts")
    print(products_df.head())

    print("\nOrders")
    print(orders_df.head())

    print("\nOrder Items")
    print(order_items_df.head())

    print("\nAll CSV files created successfully!")