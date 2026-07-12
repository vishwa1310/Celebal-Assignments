# 🛒 E-Commerce Analytics System

An end-to-end **Data Analytics** project built using **Python, Pandas, SQLite, SQL, and Faker**. The project simulates an e-commerce business by generating synthetic datasets, cleaning the data, loading it into a SQLite database, performing SQL analysis, and generating business reports through a Command Line Interface (CLI).

---

## 📌 Project Overview

The objective of this project is to demonstrate a complete data analytics workflow.

The project includes:

- Synthetic data generation
- Data quality analysis
- Data cleaning and validation
- SQLite database integration
- SQL analytics
- Command Line Reporting Tool
- Edge case testing

---

## 🚀 Features

- Generate realistic e-commerce datasets
- Clean and validate raw datasets
- Load cleaned data into SQLite
- Perform SQL business analysis
- Generate reports using Python
- Compare report with previous period
- Test common data quality issues

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| Python | Programming Language |
| Pandas | Data Cleaning & Processing |
| SQLite | Database |
| SQL | Data Analysis |
| Faker | Synthetic Data Generation |
| VS Code | Development Environment |

---

## 📂 Project Structure

```text
ecommerce-analytics-system/
│
├── data/
│   ├── raw/
│   │   ├── customers.csv
│   │   ├── products.csv
│   │   ├── orders.csv
│   │   └── order_items.csv
│   │
│   └── cleaned/
│       ├── customers_clean.csv
│       ├── products_clean.csv
│       ├── orders_clean.csv
│       └── order_items_clean.csv
│
├── database/
│   └── ecommerce.db
│
├── output/
│   └── sample-reports/
│       ├── data_quality_report.txt
│       ├── cli_report.txt
│       ├── sql_results.txt
│       └── test_report.txt
│
├── scripts/
│   ├── generate_data.py
│   ├── clean_data.py
│   ├── load_database.py
│   ├── report_cli.py
│   └── tests.py
│
├── sql/
│   ├── schema.sql
│   ├── aggregations.sql
│   ├── window_functions.sql
│   └── cohort_analysis.sql
│
├── README.md
├── requirements.txt
└── .gitignore
```

---

## 🔄 Project Workflow

```text
Generate Synthetic Data
          │
          ▼
Data Quality Analysis
          │
          ▼
Data Cleaning
          │
          ▼
Load into SQLite Database
          │
          ▼
SQL Business Analysis
          │
          ▼
CLI Report Generation
          │
          ▼
Testing & Validation
```

---

## 📊 Dataset Description

The project contains four datasets.

### Customers

| Column |
|--------|
| customer_id |
| customer_name |
| email |
| registration_date |
| customer_type |

---

### Products

| Column |
|--------|
| product_id |
| product_name |
| category |
| subcategory |
| cost_price |

---

### Orders

| Column |
|--------|
| order_id |
| customer_id |
| order_date |
| status |
| region_code |

---

### Order Items

| Column |
|--------|
| item_id |
| order_id |
| product_id |
| quantity |
| unit_price |
| discount_percent |

---

## 🧹 Data Cleaning

The following data quality issues are handled:

- Invalid email addresses
- Missing customer IDs
- Extra spaces in product names
- Incorrect text formatting
- Invalid order references
- Negative quantities
- Discount validation
- Date format standardization

---

## 🗄️ Database

The cleaned data is loaded into a SQLite database.

Database Tables:

- customers
- products
- orders
- order_items

---

## 📈 SQL Analysis

### Basic Queries

- Total revenue per category
- Top 10 customers by total order value
- Month-wise order count

### Intermediate Queries

- Customers with no delivered orders
- Products with more returns than purchases
- Return rate by category

### Advanced Queries

- Running Totals
- DENSE_RANK()
- LAG() / LEAD()
- NTILE()
- Customer Segmentation
- Cohort Analysis
- Year-over-Year Analysis
- Customer Lifetime Value
- Cumulative Revenue Distribution

---

## 🖥️ Command Line Reporting Tool

The CLI generates reports based on a selected date range.

The generated report includes:

- Total Orders
- Total Revenue
- Unique Customers
- Top 3 Products
- Previous Period Comparison

Example Output

```text
============================================================
SUMMARY REPORT
============================================================

Total Orders      : 503
Total Revenue     : 83093401.30
Unique Customers  : 303

Top 3 Products

1. Shoes - 389
2. Curtain - 272
3. Mobile - 258

Comparison With Previous Period

Orders Change  : 30.65%
Revenue Change : 27.45%
```

---

## 🧪 Testing

The project validates the following edge cases:

- Invalid Order IDs
- Discount Greater Than 100%
- Zero Quantity
- Future Order Dates

---

## ▶️ How to Run

### Clone Repository

```bash
git clone https://github.com/yourusername/ecommerce-analytics-system.git

cd ecommerce-analytics-system
```

---

### Create Virtual Environment

```bash
python -m venv .venv
```

---

### Activate Virtual Environment

Windows

```bash
.venv\Scripts\activate
```

---

### Install Dependencies

```bash
pip install -r requirements.txt
```

---

### Generate Raw Data

```bash
python scripts/generate_data.py
```

---

### Clean Data

```bash
python scripts/clean_data.py
```

---

### Load SQLite Database

```bash
python scripts/load_database.py
```

---

### Generate Report

```bash
python scripts/report_cli.py
```

---

### Run Tests

```bash
python scripts/tests.py
```

---

## 📁 Sample Reports

The `output/sample-reports/` folder contains sample outputs generated by the project.

- Data Quality Report
- CLI Report
- SQL Results
- Test Report

---

## 📚 Learning Outcomes

Through this project, I gained practical experience in:

- Python Programming
- Data Cleaning with Pandas
- SQLite Database
- SQL Analytics
- Window Functions
- Common Table Expressions (CTEs)
- Command Line Applications
- Data Validation
- End-to-End Data Analytics Workflow

---

## 🔮 Future Improvements

- Power BI Dashboard
- Streamlit Dashboard
- Automated ETL Pipeline
- REST API Integration
- Cloud Database Support
- Docker Deployment

---

## 👨‍💻 Author

**Vishwa Khandelwal**

B.Tech Student  
Python | SQL | Data Analytics | Data Engineering