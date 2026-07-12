import sqlite3
from datetime import datetime, timedelta


connection = sqlite3.connect("database/ecommerce.db")
cursor = connection.cursor()


# Get Previous Date Range

def previous_period(start_date, end_date):

    start = datetime.strptime(start_date, "%Y-%m-%d")
    end = datetime.strptime(end_date, "%Y-%m-%d")

    days = (end - start).days + 1

    previous_end = start - timedelta(days=1)
    previous_start = previous_end - timedelta(days=days - 1)

    return (
        previous_start.strftime("%Y-%m-%d"),
        previous_end.strftime("%Y-%m-%d")
    )


# Generate Report

def generate_report(start_date, end_date):

    print("\n")
    print("=" * 60)
    print("SUMMARY REPORT")
    print("=" * 60)

    
    # Total Orders
    
    cursor.execute("""
        SELECT COUNT(*)
        FROM orders
        WHERE DATE(order_date)
        BETWEEN ? AND ?
    """, (start_date, end_date))

    total_orders = cursor.fetchone()[0]

    # Total Revenue

    cursor.execute("""
        SELECT
            ROUND(
                SUM(
                    oi.quantity *
                    oi.unit_price *
                    (1 - oi.discount_percent / 100.0)
                ),
                2
            )
        FROM orders o
        JOIN order_items oi
            ON o.order_id = oi.order_id
        WHERE DATE(o.order_date)
        BETWEEN ? AND ?
    """, (start_date, end_date))

    revenue = cursor.fetchone()[0]

    if revenue is None:
        revenue = 0

    
    # Unique Customers
    
    cursor.execute("""
        SELECT COUNT(DISTINCT customer_id)
        FROM orders
        WHERE DATE(order_date)
        BETWEEN ? AND ?
    """, (start_date, end_date))

    customers = cursor.fetchone()[0]

    print(f"Total Orders      : {total_orders}")
    print(f"Total Revenue     : {revenue}")
    print(f"Unique Customers  : {customers}")

   
    # Top 3 Products

    print("\nTop 3 Products")

    cursor.execute("""
        SELECT
            p.product_name,
            SUM(oi.quantity) AS total_quantity
        FROM order_items oi
        JOIN products p
            ON oi.product_id = p.product_id
        JOIN orders o
            ON oi.order_id = o.order_id
        WHERE DATE(o.order_date)
        BETWEEN ? AND ?
        GROUP BY p.product_name
        ORDER BY total_quantity DESC
        LIMIT 3
    """, (start_date, end_date))

    rows = cursor.fetchall()

    if len(rows) == 0:

        print("No products found.")

    else:

        for i, row in enumerate(rows, start=1):
            print(f"{i}. {row[0]} - {row[1]}")

    
    # Previous Period Comparison
    
    previous_start, previous_end = previous_period(
        start_date,
        end_date
    )

    cursor.execute("""
        SELECT COUNT(*)
        FROM orders
        WHERE DATE(order_date)
        BETWEEN ? AND ?
    """, (previous_start, previous_end))

    previous_orders = cursor.fetchone()[0]

    cursor.execute("""
        SELECT
            ROUND(
                SUM(
                    oi.quantity *
                    oi.unit_price *
                    (1 - oi.discount_percent / 100.0)
                ),
                2
            )
        FROM orders o
        JOIN order_items oi
            ON o.order_id = oi.order_id
        WHERE DATE(o.order_date)
        BETWEEN ? AND ?
    """, (previous_start, previous_end))

    previous_revenue = cursor.fetchone()[0]

    if previous_revenue is None:
        previous_revenue = 0

    print("\nComparison With Previous Period")

    if previous_orders == 0:

        print("Orders Change  : No previous data")

    else:

        order_change = (
            (total_orders - previous_orders)
            / previous_orders
        ) * 100

        print(f"Orders Change  : {order_change:.2f}%")

    if previous_revenue == 0:

        print("Revenue Change : No previous data")

    else:

        revenue_change = (
            (revenue - previous_revenue)
            / previous_revenue
        ) * 100

        print(f"Revenue Change : {revenue_change:.2f}%")


# Main Menu

while True:

    print("\n")
    print("=" * 60)
    print("E-Commerce Analytics Reporting Tool")
    print("=" * 60)

    print("1. Daily Report")
    print("2. Weekly Report")
    print("3. Monthly Report")
    print("4. Exit")

    choice = input("\nEnter Choice : ")

    if choice == "4":

        print("\nThank You!")
        break

    elif choice in ["1", "2", "3"]:

        if choice == "1":
            print("\nGenerating Daily Report")

        elif choice == "2":
            print("\nGenerating Weekly Report")

        else:
            print("\nGenerating Monthly Report")

        
        # Date Validation
        
        while True:

            try:

                start_date = input(
                    "\nEnter Start Date (YYYY-MM-DD): "
                )

                end_date = input(
                    "Enter End Date (YYYY-MM-DD): "
                )

                start = datetime.strptime(
                    start_date,
                    "%Y-%m-%d"
                )

                end = datetime.strptime(
                    end_date,
                    "%Y-%m-%d"
                )

                if start > end:

                    print("\nStart date cannot be after End date.\n")
                    continue

                break

            except ValueError:

                print("\nInvalid Date!")
                print("Please enter date in YYYY-MM-DD format.")
                print("Example: 2026-06-30\n")

        generate_report(start_date, end_date)

    else:

        print("\nInvalid Choice. Please select 1 to 4.")




connection.close()