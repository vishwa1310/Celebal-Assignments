-- step 1. Load dataset into a SQL database 
CREATE DATABASE superstore_data;
USE superstore_data;

-- step 2. Explore Table
Describe superstore;
--
SELECT *
FROM superstore
LIMIT 8;
--
SELECT COUNT(*) AS total_rows
FROM superstore;

-- step 3. Apply WHERE Filters
SELECT * FROM superstore WHERE region = 'East';
--
SELECT * FROM superstore WHERE category = 'Furniture';
--
SELECT `Product Name`, sales FROM superstore  WHERE sales > 450;
--
SELECT * FROM superstore WHERE `Order Date` BETWEEN '2015-01-01' AND '2017-12-31';
--
SELECT `Order ID`,`Product Name`, profit FROM superstore WHERE profit > 200;

-- step 4.GROUP BY Aggregations
SELECT region, SUM(sales) AS total_sales FROM superstore GROUP BY region;
--
SELECT category, AVG(sales) AS avg_sales FROM superstore GROUP BY category;
--
SELECT `sub-category`, SUM(quantity) AS total_quantity FROM superstore GROUP BY `sub-category` ORDER BY total_quantity DESC;
--
SELECT category,  ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY category;

-- step 5. Sort and Limit Results
SELECT `product name`, SUM(sales) AS total_sales
FROM superstore
GROUP BY `product name`
ORDER BY total_sales DESC
LIMIT 10;
--
SELECT `customer name`, SUM(profit) AS total_profit
FROM superstore
GROUP BY `customer name`
ORDER BY total_profit DESC
LIMIT 5;
--
SELECT category, SUM(profit) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit ASC;

-- step 6. Business Use Cases
SELECT
    YEAR(STR_TO_DATE(`order date`, '%m/%d/%Y')) AS year,
    MONTH(STR_TO_DATE(`order date`, '%m/%d/%Y')) AS month,
    ROUND(SUM(sales),2) AS monthly_sales
FROM superstore
GROUP BY
    YEAR(STR_TO_DATE(`order date`, '%m/%d/%Y')),
    MONTH(STR_TO_DATE(`order date`, '%m/%d/%Y'))
ORDER BY year, month;
--
SELECT `customer name`, ROUND(SUM(sales),2) AS total_revenue
FROM superstore
GROUP BY `customer name`
ORDER BY total_revenue DESC
LIMIT 10;
--
SELECT `product name`, ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY `product name`
ORDER BY total_profit DESC
LIMIT 10;
--
SELECT `order id`,  COUNT(*) AS duplicate_count
FROM superstore
GROUP BY `order id`
HAVING COUNT(*) > 1;

-- step 7. Validate Results and Data Quality
SELECT COUNT(*) AS total_records
FROM superstore;
--
SELECT `order id`, `product id`, COUNT(*) AS duplicates
FROM superstore
GROUP BY `order id`, `product id`
HAVING COUNT(*) > 1;