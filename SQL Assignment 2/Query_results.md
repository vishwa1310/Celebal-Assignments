# 📊 Superstore SQL Assignment – Query Results


## Step 2: Explore Table

### Describe Table



```sql

DESCRIBE superstore;

```

The output shows:

| Column Name   | Data Type |
|---------------|-----------|
| Row ID        | INT       |
| Order ID      | VARCHAR   |
| Order Date    | VARCHAR   |
| Ship Date     | VARCHAR   |
| Ship Mode     | VARCHAR   |
| Customer ID   | VARCHAR   |
| Customer Name | VARCHAR   |
| Segment       | VARCHAR   |
| Country       | VARCHAR   |
| City          | VARCHAR   |
| State         | VARCHAR   |
| Postal Code   | INT       |
| Region        | VARCHAR   |
| Product ID    | VARCHAR   |
| Category      | VARCHAR   |
| Sub-Category  | VARCHAR   |
| Product Name  | VARCHAR   |
| Sales         | FLOAT     |
| Quantity      | INT       |
| Discount      | FLOAT     |
| Profit        | FLOAT     |


### First 8 Rows



```sql

SELECT *

FROM superstore

LIMIT 8;

```

The output shows:

| Row ID | Order ID       | Order Date | Ship Date  | Ship Mode      | Customer ID Customer Name   | Segment   | Country       | City            | State      | Postal Code | Region | Product ID      | Category         Sub-Category | Product Name                                                      | Sales   | Quantity | Discount | Profit   |

|--------|----------------|------------|------------|----------------|-------------|-----------------|-----------|---------------|-----------------|------------|-------------|--------|-----------------|-----------------|--------------|-------------------------------------------------------------------|---------|----------|----------|----------|

| 1       CA-2016-152156 | 11/8/2016  | 11/11/2016 | Second Class    CG-12520    | Claire Gute     | Consumer  | United States | Henderson       Kentucky   | 42420       | South  | FUR-BO-10001798 | Furniture       | Bookcases    | Bush Somerset Collection Bookcase                                 | 261.96  | 2        | 0.0      | 41.91    |

| 2      | CA-2016-152156 | 11/8/2016  | 11/11/2016 | Second Class    CG-12520    | Claire Gute     | Consumer  | United States | Henderson       Kentucky   | 42420       | South  | FUR-CH-10000454 | Furniture       | Chairs       | Hon Deluxe Fabric Upholstered Stacking Chairs, Back       | 731.94  | 3        | 0.0      | 219.58   |

3      | CA-2016-138688 | 6/12/2016  | 6/16/2016   Second Class   | DV-13045    | Darrin Van Huff | Corporate | United States | Los Angeles     | California 90036       | West   | OFF-LA-10000240 | Office Supplies | Labels       | Self-Adhesive Address Labels for Typewriters by Universal         | 14.62   | 2        | 0.0      | 6.87     |

| 4      | US-2015-108966 | 10/11/2015 | 10/18/2015 | Standard Class | SO-20335    | Sean O'Donnell  | Consumer   United States | Fort Lauderdale | Florida    | 33311       | South  | FUR-TA-10000577 | Furniture       | Tables       | Bretford CR4500 Series Slim Rectangular Table                     | 957.58  | 5        | 0.45     | -383.03  |

5      | US-2015-108966 | 10/11/2015 | 10/18/2015 | Standard Class | SO-20335    | Sean O'Donnell   Consumer  | United States | Fort Lauderdale | Florida     33311       | South  | OFF-ST-10000760 | Office Supplies | Storage      | Eldon Fold 'N Roll Cart System                                    | 22.37   | 2        | 0.2      | 2.52     |

| 6      | CA-2014-115812 | 6/9/2014   | 6/14/2014   Standard Class | BH-11710    | Brosina Hoffman | Consumer  | United States | Los Angeles     California | 90032       | West   | FUR-FU-10001487 | Furniture       | Furnishings  | Eldon Expressions Wood and Plastic Desk Accessories Cherry Wood  | 48.86   | 7        | 0.0      | 14.17    |

| 7      | CA-2014-115812 | 6/9/2014   | 6/14/2014  | Standard Class | BH-11710    | Brosina Hoffman | Consumer  | United States | Los Angeles     | California | 90032       | West   | OFF-AR-10002833 | Office Supplies | Art          | Newell 322                                                        | 7.28    | 4        | 0.0      | 1.97     |

| 8      | CA-2014-115812 | 6/9/2014   | 6/14/2014  | Standard Class | BH-11710    | Brosina Hoffman | Consumer  | United States | Los Angeles     | California | 90032       | West   | TEC-PH-10002275 | Technology      | Phones        Mitel 5320 IP Phone VoIP phone                                    | 907.15  | 6        | 0.2      | 90.72    |



### Total Rows



```sql

SELECT COUNT(*) AS total_rows

FROM superstore;

```

The output shows:

| total_rows |
|------------|
| 9994       |



## Step 3: Apply WHERE Filters

### Filter by Region = East (Sample. 5 Rows)



```sql

SELECT * FROM superstore WHERE region = 'East';

```

The output ( 5 rows) shows:

| Row ID | Order ID       | Order Date Customer Name   | City          State        | Region | Category        | Sub-Category | Product Name                                                  | Sales   | Quantity | Profit   |

|--------|----------------|------------|-----------------|--------------|--------------|--------|-----------------|--------------|---------------------------------------------------------------|---------|----------|----------|

| 24     | US-2017-156909 | 7/16/2017  | Sandra Flanagan Philadelphia | Pennsylvania East   | Furniture       | Chairs       | Global Deluxe Stacking Chair, Gray                            | 71.37   | 2        | -1.02    |

28     | US-2015-150630 | 9/17/2015  | Tracy Blumstein | Philadelphia | Pennsylvania East   | Furniture       | Bookcases    | Riverside Palais Royal Lawyers Bookcase, Royale Cherry Finish | 3083.43 | 7        | -1665.05 |

29     | US-2015-150630 | 9/17/2015  | Tracy Blumstein Philadelphia | Pennsylvania | East   | Office Supplies | Binders      | Avery Recycled Flexi-View Covers for Binding Systems          | 9.62    | 2        | -7.05    |

| 30     | US-2015-150630 | 9/17/2015  | Tracy Blumstein | Philadelphia | Pennsylvania East   | Furniture       | Furnishings  | Howard Miller 13-3/4" Diameter Brushed Chrome Round Wall Clock| 124.20   3        | 15.53    |

| 31     | US-2015-150630 | 9/17/2015  | Tracy Blumstein | Philadelphia | Pennsylvania East   | Office Supplies | Envelopes    | Poly String Tie Envelopes                                     | 3.26    | 2        | 1.10     |



### Filter by Category = Furniture (Sample. 5 Rows)



```sql

SELECT * FROM superstore WHERE category = 'Furniture';

```

The output ( 5 rows) shows:

| Row ID | Order ID       | Order Date Customer Name   | City            | State      | Region | Sub-Category | Product Name                                                     | Sales   | Quantity Discount | Profit   |

|--------|----------------|------------|-----------------|-----------------|------------|--------|--------------|------------------------------------------------------------------|---------|----------|----------|----------|

| 1      | CA-2016-152156 | 11/8/2016  | Claire Gute     | Henderson       | Kentucky    South  | Bookcases    | Bush Somerset Collection Bookcase                                | 261.96  | 2        | 0.0      | 41.91    |

| 2      | CA-2016-152156 | 11/8/2016  | Claire Gute     | Henderson       | Kentucky    South  | Chairs       | Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back      | 731.94  | 3        | 0.0      | 219.58   |

| 4      | US-2015-108966 | 10/11/2015 | Sean O'Donnell  | Fort Lauderdale | Florida     South  | Tables       | Bretford CR4500 Series Slim Rectangular Table                    | 957.58  | 5        | 0.45     | -383.03  |

| 6      | CA-2014-115812 | 6/9/2014   | Brosina Hoffman | Los Angeles     | California | West   | Furnishings  | Eldon Expressions Wood and Plastic Desk Accessories, Cherry Wood. 48.86   | 7        | 0.0       14.17    |

| 11     | CA-2014-115812 | 6/9/2014   | Brosina Hoffman | Los Angeles     | California | West   | Tables       | Chromcraft Rectangular Conference Tables                         | 1706.18 9        | 0.2      | 85.31    |



### Products with Sales > 450 (Sample. 10 Rows)



```sql

SELECT `Product Name` sales FROM superstore WHERE sales > 450;

```

The output ( 10 rows) shows:

| Product Name                                                | Sales   |

|-------------------------------------------------------------|---------|

| Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back | 731.94  |

| Bretford CR4500 Series Slim Rectangular Table               | 957.58  |

| Mitel 5320 IP Phone VoIP phone                              | 907.15  |

| Chromcraft Rectangular Conference Tables                    | 1706.18 |

| Konftel 250 Conference phone. Charcoal black                | 911.42  |

| Stur-D-Stor Shelving, Vertical 5-Shelf                      | 665.88  |

| Bretford CR4500 Series Slim Rectangular Table               | 1044.63 |

| Riverside Palais Royal Lawyers Bookcase, Royale Cherry Finish| 3083.43 |

| GE 30524EE4                                                 | 1097.54 |

| Atlantic Metals Mobile 3-Shelf Bookcases, Custom Colors     | 532.40  |



```sql

SELECT * FROM superstore WHERE `Order Date` BETWEEN '2015-01-01' AND '2017-12-31';

```

Output ( 5 rows):

| Row ID | Order ID       | Order Date   Customer Name  | City            | State   | Region  | Category        | Product Name                                                              | Sales  | Profit

|--------|----------------|-------------|---------------|-----------------|---------|---------|-----------------|---------------------------------------------------------------------------|--------|----------|

| 1      | CA-2016-152156 | 11/8/2016   | Claire Gute    | Henderson       | Kentucky| South   | Furniture       | Bush Somerset Collection Bookcase                                         | 261.96 | 41.91    |

2      | CA-2016-152156 | 11/8/2016   | Claire Gute    | Henderson       | Kentucky| South   | Furniture       | Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back               | 731.94 | 219.58   |

| 4       US-2015-108966 | 10/11/2015  | Sean O'Donnell | Fort Lauderdale | Florida South   | Furniture       | Bretford CR4500 Series Slim Rectangular Table                             | 957.58 | -383.03  |

| 5      | US-2015-108966 | 10/11/2015  | Sean O'Donnell | Fort Lauderdale Florida | South   | Office Supplies | Eldon Fold 'N Roll Cart System                                            | 22.37  | 2.52     |

| 15     | US-2015-118983 | 11/22/2015  | Harold Pawlan  | Fort Worth      | Texas   | Central Office Supplies | Holmes Replacement Filter for HEPA Air Cleaner, Very Large Room           | 68.81  | -123.86  |



### Orders with Profit > 200 (Sample. 10 Rows)


```sql

SELECT `Order ID` `Product Name` profit FROM superstore WHERE profit > 200;

```

Output ( 10 of many):

| Order ID       | Product Name                                                 Profit  |

|----------------|-------------------------------------------------------------|---------|

| CA-2016-152156 | Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back | 219.58  |

| CA-2015-106320 | Bretford CR4500 Series Slim Rectangular Table               | 240.27  |

| CA-2016-105816 | AT&T CL83451 4-Handset Telephone                            | 298.69  |

| CA-2017-155376 | Sanyo 2.5 Cubic Foot Mid-Size Office Refrigerators          | 218.25  |

| CA-2016-114489 | Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back | 585.55  |

| CA-2016-114104 | Avaya 5420 Digital phone                                    | 236.23  |

| CA-2014-131926 | Global Deluxe High-Back Managers Chair                      | 580.54  |

| CA-2014-131926 | Honeywell Enviracaire Portable HEPA Air Cleaner for 17'x22' | 496.07  |

| CA-2016-145625 | Logitech P710e Mobile Speakerphone                          | 636.00  |

| CA-2017-163979 | Adjustable Depth Letter/Legal Cart                          | 210.49  |



## Step 4: GROUP BY Aggregations

### Total Sales by Region



```sql

SELECT region, SUM(sales) AS total_sales FROM superstore GROUP BY region;

```

Output:

| region  Total_sales |

|---------|-------------|

| Central | 501240.00   |

| East    | 678781.00   |

| South   | 391722.00   |

| West    | 725458.00   |



### Average Sales by Category



```sql

SELECT category, AVG(sales) AS avg_sales FROM superstore GROUP BY category;

```

Output:

Category        | avg_sales |

|-----------------|-----------|

| Furniture       | 349.83    |

| Office Supplies | 119.32    |

| Technology      | 452.71    |



### Total Quantity by Sub-Category



```sql

SELECT `sub- SUM(quantity) AS total_quantity FROM superstore GROUP BY `sub-category` ORDER BY total_quantity DESC;

```

Output:

| sub-category | total_quantity |

|--------------|----------------|

| Binders      | 5974           |

| Paper        | 5178           |

| Furnishings  | 3563           |

| Phones       | 3289           |

| Storage      | 3158           |

| Art          | 3000

| Accessories  | 2976           |

| Chairs       | 2356           |

| Appliances   | 1729           |

| Labels       | 1400           |

| Tables       | 1241           |

| Fasteners    | 914            |

| Envelopes    | 906            |

| Bookcases    | 868            |

| Supplies     | 647            |

| Machines     | 440            |

| Copiers      | 234            |

Binders and Paper are ordered the most.

### Total Profit by Category

The query is used to get total profit by category.

```sql

SELECT category, ROUND(SUM(profit),2) AS total_profit

FROM superstore

GROUP BY category;

```

Output:

| category        | total_profit |

| Furniture       | 18451.27     |

| Office Supplies | 122490.80    |

| Technology      | 145454.95    |



## Step 5: Sort and Limit Results

### Top 10 Products by Total Sales



```sql

SELECT `product name` SUM(sales) AS total_sales

FROM superstore

GROUP BY `product name`

ORDER BY total_sales DESC

LIMIT 10;

```

Output:

| product name                                                                | total_sales |

|-----------------------------------------------------------------------------|-------------|

| Canon imageCLASS 2200 Advanced Copier                                        61599.82    |

| Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind | 27453.38    |

| Cisco TelePresence System EX90 Videoconferencing Unit                       | 22638.48    |

| HON 5400 Series Task Chairs for Big and Tall                                | 21870.58    |

| GBC DocuBind TL300 Electric Binding System                                  | 19823.51    |

| GBC Ibimaster 500 Manual ProClick Binding System                            | 19024.52    |

| Hewlett Packard LaserJet 3310 Copier                                        | 18839.69    |

| HP Designjet T520 Inkjet Large Format Printer. 24" Color                   | 18374.93    |

| GBC DocuBind P400 Electric Binding System                                   | 17965.13    |

| High Speed Automatic Electric Letter Opener                                 | 17030.32    |

The Canon imageCLASS 2200 Copier has the most sales.

### Top 5 Customers by Total Profit

The query is used to get 5 customers by total profit.

```sql

SELECT `customer name` SUM(profit) AS total_profit

FROM superstore

GROUP BY `customer name`

ORDER BY total_profit DESC

LIMIT 5;

```

Output:

| customer name | total_profit |

|---------------|--------------|

Tamara Chand  | 8981.32      |

| Raymond Buch  | 6976.10      |

| Sanjit Chand  | 5757.41      |

| Hunter Lopez  | 5622.43      |

| Adrian Barton | 5444.81      |

Tamara Chand is the most profitable customer.

### Categories Sorted by Profit (Ascending)

The query is used to get categories sorted by profit.

```sql

SELECT category, SUM(profit) AS total_profit

FROM superstore

GROUP BY category

ORDER BY total_profit ASC;

```

Output:

category        | total_profit |

|-----------------|--------------|

| Furniture       | 18451.27     |

| Office Supplies | 122490.80    |

| Technology      | 145454.95    |

Furniture has the lowest profit.

## Step 6: Business Use Cases

### Monthly Sales Trend


```sql

SELECT

YEAR(STR_TO_DATE(`order date` '%m/%d/%Y')) AS year

MONTH(STR_TO_DATE(`order date` '%m/%d/%Y')) AS month

ROUND(SUM(sales),2) AS monthly_sales

FROM superstore

GROUP BY

YEAR(STR_TO_DATE(`order date` '%m/%d/%Y'))

MONTH(STR_TO_DATE(`order date` '%m/%d/%Y'))

ORDER BY year month;

```

Output (selected highlights):

| year | month | monthly_sales |
|------|-------|---------------|
| 2014 | 1     | 14236.90      |
| 2014 | 3     | 55691.00      |
| 2014 | 9     | 81777.40      |
| 2014 | 12    | 53412.80      |
| 2015 | 3     | 38726.20      |
| 2015 | 9     | 64595.90      |
| 2015 | 11    | 43800.30      |
| 2015 | 12    | 49626.60      |
| 2016 | 3     | 51715.90      |
| 2016 | 5     | 56987.70      |
| 2016 | 9     | 73410.00      |
| 2016 | 11    | 60942.50      |
| 2016 | 12    | 63025.00      |
| 2017 | 1     | 43971.40      |
| 2017 | 9     | 87866.60      |
| 2017 | 11    | 79834.20      |
| 2017 | 12    | 47009.70      |

### Top 10 Customers by Revenue

Query:
```sql
SELECT `customer name`, ROUND(SUM(sales),2) AS total_revenue
FROM superstore
GROUP BY `customer name`
ORDER BY total_revenue DESC
LIMIT 10;
```
Output:

| customer name      | total_revenue |
|--------------------|---------------|
| Sean Miller        | 25043.05      |
| Tamara Chand       | 19052.22      |
| Raymond Buch       | 15117.34      |
| Tom Ashbrook       | 14595.62      |
| Adrian Barton      | 14473.57      |
| Ken Lonsdale       | 14175.23      |
| Sanjit Chand       | 14142.34      |
| Hunter Lopez       | 12873.30      |
| Sanjit Engle       | 12209.44      |
| Christopher Conant | 12129.05      |

### Top 10 Most Profitable Products

Query:
```sql
SELECT `product name`, ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY `product name`
ORDER BY total_profit DESC
LIMIT 10;
```
Output:

| product name                                                                | total_profit |
|-----------------------------------------------------------------------------|--------------|
| Canon imageCLASS 2200 Advanced Copier                                       | 25199.93     |
| Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind | 7753.04      |
| Hewlett Packard LaserJet 3310 Copier                                        | 6983.88      |
| Canon PC1060 Personal Laser Copier                                          | 4570.93      |
| HP Designjet T520 Inkjet Large Format Printer - 24" Color                   | 4094.98      |
| Ativa V4110MDD Micro-Cut Shredder                                           | 3772.95      |
| 3D Systems Cube Printer, 2nd Generation, Magenta                            | 3717.97      |
| Plantronics Savi W720 Multi-Device Wireless Headset System                  | 3696.28      |
| Ibico EPK-21 Electric Binding System                                        | 3345.28      |
| Zebra ZM400 Thermal Label Printer                                           | 3343.54      |


### Orders with Duplicate Order IDs

Query:
```sql
SELECT `order id`, COUNT(*) AS duplicate_count
FROM superstore
GROUP BY `order id`
HAVING COUNT(*) > 1;
```
Output (sample — first 10 of 2,471):

| order id       | duplicate_count |
|----------------|-----------------|
| CA-2014-100090 | 2               |
| CA-2014-100363 | 2               |
| CA-2014-100678 | 4               |
| CA-2014-100706 | 2               |
| CA-2014-100762 | 4               |
| CA-2014-100895 | 3               |
| CA-2014-100916 | 3               |
| CA-2014-101560 | 4               |
| CA-2014-101602 | 2               |
| CA-2014-101931 | 5               |


## Step 7: Validate Results and Data Quality

### Total Records Count

Query:
```sql
SELECT COUNT(*) AS total_records
FROM superstore;
```
Output:

| total_records |
|---------------|
| 9994          |


### True Duplicate Records

Query:
```sql
SELECT `order id`, `product id`, COUNT(*) AS duplicates
FROM superstore
GROUP BY `order id`, `product id`
HAVING COUNT(*) > 1;
```
Output:

| order id       | product id      | duplicates |
|----------------|-----------------|------------|
| CA-2015-103135 | OFF-BI-10000069 | 2          |
| CA-2016-129714 | OFF-PA-10001970 | 2          |
| CA-2016-137043 | FUR-FU-10003664 | 2          |
| CA-2016-140571 | OFF-PA-10001954 | 2          |
| CA-2017-118017 | TEC-AC-10002006 | 2          |
| CA-2017-152912 | OFF-ST-10003208 | 2          |
| US-2014-150119 | FUR-CH-10002965 | 2          |
| US-2016-123750 | TEC-AC-10004659 | 2          |
There are only 8 rows with the exact same Order ID + Product ID combination. These are duplicates.


