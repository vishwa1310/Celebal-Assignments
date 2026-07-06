# Delta Lake MERGE Implementation

## Overview

This project demonstrates how to perform incremental data loading using **Delta Lake** with **PySpark** in **Databricks**. The objective is to load an initial dataset into a Delta table, perform basic data cleaning, and merge new incoming records into the existing table using Delta Lake's `MERGE` operation.

The project uses the **Sample Superstore** dataset as the main dataset and a separate incremental dataset containing new records.

---

## Objectives

- Load a CSV file into a Spark DataFrame.
- Clean the data by removing duplicate records and checking for null values.
- Convert the data into a Delta table.
- Create an incremental dataset.
- Merge the incremental data into the existing Delta table.
- Validate the final output after the merge.

---

## Technologies Used

- Databricks
- Apache Spark (PySpark)
- Delta Lake
- Python
- CSV Dataset

---

## Dataset

### Initial Dataset
- Sample Superstore Dataset
- Total Records: **9,994**

### Incremental Dataset
- Custom dataset created for this project
- Total Records: **25**

The incremental dataset contains only new records, which are inserted into the existing Delta table during the merge process.

---

## Steps Performed

### 1. Load Dataset

The Sample Superstore CSV file was loaded into a Spark DataFrame.

### 2. Data Cleaning

The following preprocessing steps were performed:

- Standardized column names
- Removed duplicate records
- Checked for null values

### 3. Create Delta Table

The cleaned DataFrame was stored as a Delta table.

### 4. Create Incremental Dataset

A separate CSV file containing 25 new records was created to simulate incoming data.

### 5. MERGE Operation

The incremental data was merged into the Delta table using Delta Lake's `MERGE` command.

- Existing records are updated if a match is found.
- New records are inserted if no match exists.

### 6. Validation

After the merge, the final table was validated by:

- Checking the total number of records
- Displaying the merged dataset

---

## Results

- Initial Dataset Records: **9,994**
- Incremental Records: **25**
- Final Records After MERGE: **10,019**

The merge operation successfully inserted all new records into the Delta table.

---

## Learning Outcomes

During this assignment, I learned how to:

- Work with Spark DataFrames in Databricks.
- Create and manage Delta tables.
- Perform basic data cleaning using PySpark.
- Validate datasets before processing.
- Use Delta Lake's `MERGE` operation for incremental data loading.
- Build a simple ETL workflow using PySpark and Delta Lake.

---

