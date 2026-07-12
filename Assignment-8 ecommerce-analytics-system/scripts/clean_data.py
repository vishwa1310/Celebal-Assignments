import pandas as pd


# Read Raw CSV Files

customers_df = pd.read_csv("data/raw/customers.csv")
products_df = pd.read_csv("data/raw/products.csv")
orders_df = pd.read_csv("data/raw/orders.csv")
order_items_df = pd.read_csv("data/raw/order_items.csv")



# Explore Data

def explore_data(df, name):
    print("\n" + "=" * 60)
    print(name.upper())
    print("=" * 60)
    print("\nFirst 5 Rows")
    print(df.head())
    print("\nDataset Info")
    df.info()
    print("\nMissing Values")
    print(df.isnull().sum())
    print("\nDuplicate Rows :", df.duplicated().sum())
    print("\nShape :", df.shape)



# Data Quality Checks

def check_invalid_emails(df):
    invalid = df[~df["email"].str.contains("@", na=False)]
    print("\nInvalid Emails :", len(invalid))


def check_product_names(df):
    issues = df[
        (df["product_name"] != df["product_name"].str.strip()) |
        (df["product_name"] != df["product_name"].str.title())
    ]
    print("\nProduct Name Issues :", len(issues))


def check_invalid_dates(df):
    invalid = 0
    for value in df["order_date"]:
        try:
            pd.to_datetime(value)
        except Exception:
            invalid += 1
    print("\nWrong Date Format :", invalid)


def check_negative_quantity(df):
    negative = df[df["quantity"] < 0]
    print("\nNegative Quantity :", len(negative))


def check_invalid_order_ids(order_items_df, orders_df):
    invalid = order_items_df[
        ~order_items_df["order_id"].isin(orders_df["order_id"])
    ]
    print("\nInvalid Order IDs :", len(invalid))



# Cleaning Functions


def clean_customers(df):
    df = df.copy()
    df["email"] = df["email"].str.strip()
    df = df[df["email"].str.contains("@", na=False)]
    return df


def clean_products(df):
    df = df.copy()
    df["product_name"] = df["product_name"].str.strip().str.title()
    return df


def clean_orders(df):
    df = df.copy()
    df["customer_id"] = df["customer_id"].fillna(0).astype(int)

    def fix_date(x):
        try:
            return pd.to_datetime(x).strftime("%Y-%m-%d %H:%M:%S")
        except Exception:
            return x

    df["order_date"] = df["order_date"].apply(fix_date)
    return df


def clean_order_items(df, orders):
    df = df.copy()
    df["quantity"] = df["quantity"].abs()
    df = df[df["order_id"].isin(orders["order_id"])]
    df = df[df["discount_percent"] <= 100]
    return df


# Validation


def validate(df, name):
    print("\n" + "-" * 40)
    print(name)
    print("-" * 40)
    print("Missing Values")
    print(df.isnull().sum())
    print("Duplicate Rows :", df.duplicated().sum())



# Main

def main():

    print("=" * 70)
    print("DATA QUALITY REPORT")
    print("=" * 70)

    explore_data(customers_df, "Customers")
    check_invalid_emails(customers_df)

    explore_data(products_df, "Products")
    check_product_names(products_df)

    explore_data(orders_df, "Orders")
    check_invalid_dates(orders_df)

    explore_data(order_items_df, "Order Items")
    check_negative_quantity(order_items_df)
    check_invalid_order_ids(order_items_df, orders_df)

    print("\n" + "=" * 70)
    print("CLEANING DATA")
    print("=" * 70)

    customers_clean = clean_customers(customers_df)
    products_clean = clean_products(products_df)
    orders_clean = clean_orders(orders_df)
    order_items_clean = clean_order_items(order_items_df, orders_clean)

    print("\nVALIDATION AFTER CLEANING")
    validate(customers_clean, "Customers")
    validate(products_clean, "Products")
    validate(orders_clean, "Orders")
    validate(order_items_clean, "Order Items")

    customers_clean.to_csv("data/cleaned/customers_clean.csv", index=False)
    products_clean.to_csv("data/cleaned/products_clean.csv", index=False)
    orders_clean.to_csv("data/cleaned/orders_clean.csv", index=False)
    order_items_clean.to_csv("data/cleaned/order_items_clean.csv", index=False)

    print("\nAll cleaned CSV files saved successfully.")


if __name__ == "__main__":
    main()
