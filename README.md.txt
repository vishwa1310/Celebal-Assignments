# Data Exploration and Cleaning using Pandas

This project shows how to clean and analyze a shopping dataset using Python and Pandas. We will look at the data fix values, remove duplicates pick specific rows and columns and do basic data cleaning.

## Step 1: Import Libraries and Load Dataset

First we import the Pandas library. Load the shopping dataset from a CSV file.

Example:

```python

import pandas as pd

df = pd.read_csv("shopping_trends.csv")

```

## Step 2:. Understand the Dataset

We do some things to understand the dataset. We look at the few rows the last few rows, the shape, the columns and some info.

We do these operations:

- Look at the few rows with `head()`

- Look at the last few rows with `tail()`

- Check the shape

- Check the columns

- Get some info with `info()`

- Get some descriptions with `describe()`

## Step 3: Identify and Handle Missing Values

We find missing values with `isnull().sum()`. Then we clean the dataset.

We use these techniques:

- Check for null values

- Fill missing values

- Remove columns

- Clean inconsistent data

Example:

```python

df.isnull().sum()

```

## Step 4: Perform Basic Data Operations

We do some data manipulation. We pick columns, filter rows and show subsets of data.

We do these operations:

- Pick columns

- Filter rows

- Use indexing

- Use conditional queries

- Use `iloc[]` for indexing

Example:

```python

filtered_df = df[df['rating'] > 4]

```

## Step 5: Remove Duplicate Records

We find duplicates with `duplicated()`. Remove them with `drop_duplicates()`.

Example:

```python

df.drop_duplicates(inplace=True)

```

## Step 6: Create Derived Columns

We make columns from old ones. This helps us analyze things.

Example:

```python

df['discounted_price'] = df['price']. (Df['price'] * df['discount'] / 100)

```

These new columns help with discounts, pricing and customer behavior.

## Step 7: Save the Cleaned Dataset

We save the cleaned dataset as a CSV file.

Example:

```python

df.to_csv("cleaned_dataset.csv" index=False)

```

## Technologies Used

- Python

- Pandas

- Jupyter Notebook

## Learning Outcomes

After this project you will know:

- How to preprocess data with Pandas

- How to handle missing and duplicate values

- How to filter and select data

- Basic data exploration

- How to create new columns

- How to export cleaned datasets

##

This project gives practical experience, with data cleaning and preprocessing. It shows data analysis techniques used in real-world analytics and machine learning.