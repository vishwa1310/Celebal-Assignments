import sqlite3
from datetime import datetime

connection = sqlite3.connect("database/ecommerce.db")
cursor = connection.cursor()


# order_items has order_id not in orders


def test_invalid_order_id():

    print("\nTest 1 : Invalid Order ID")

    cursor.execute("""

        SELECT COUNT(*)

        FROM order_items

        WHERE order_id NOT IN
        (
            SELECT order_id
            FROM orders
        )

    """)

    count = cursor.fetchone()[0]

    if count == 0:
        print("PASS")
    else:
        print("FAIL")
        print("Invalid Order IDs :", count)



# discount_percent > 100


def test_discount():

    print("\nTest 2 : Discount Greater Than 100")

    cursor.execute("""

        SELECT COUNT(*)

        FROM order_items

        WHERE discount_percent > 100

    """)

    count = cursor.fetchone()[0]

    if count == 0:
        print("PASS")
    else:
        print("FAIL")
        print("Invalid Discounts :", count)




# Quantity = 0


def test_quantity():

    print("\nTest 3 : Quantity Equal To Zero")

    cursor.execute("""

        SELECT COUNT(*)

        FROM order_items

        WHERE quantity = 0

    """)

    count = cursor.fetchone()[0]

    if count == 0:
        print("PASS")
    else:
        print("FAIL")
        print("Zero Quantity Rows :", count)




# Future Order Date


def test_future_date():

    print("\nTest 4 : Future Order Date")

    today = datetime.today().strftime("%Y-%m-%d")

    cursor.execute("""

        SELECT COUNT(*)

        FROM orders

        WHERE DATE(order_date) > ?

    """, (today,))

    count = cursor.fetchone()[0]

    if count == 0:
        print("PASS")
    else:
        print("FAIL")
        print("Future Orders :", count)



# Main


print("=" * 60)
print("EDGE CASE TEST REPORT")
print("=" * 60)

test_invalid_order_id()

test_discount()

test_quantity()

test_future_date()

connection.close()

print("\n" + "=" * 60)
print("Testing Completed")
print("=" * 60)