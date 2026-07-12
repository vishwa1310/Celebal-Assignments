-- 7. Running Total Revenue By Month


SELECT  strftime('%Y-%m', o.order_date) AS month,
    ROUND( SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)),2 ) AS monthly_revenue,

    ROUND( SUM(
            SUM(
                oi.quantity *
                oi.unit_price *
                (1 - oi.discount_percent / 100.0)
            )
        ) OVER( ORDER BY strftime('%Y-%m', o.order_date)), 2 ) AS running_total
FROM orders o

JOIN order_items oi
ON o.order_id = oi.order_id

GROUP BY month

ORDER BY month;



-- 8. Ranking Customers Using DENSE_RANK()


SELECT  c.customer_id, c.customer_name,
    ROUND(
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)), 2) AS total_revenue,

    DENSE_RANK() OVER(
        ORDER BY
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ) DESC
    ) AS customer_rank

FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

JOIN order_items oi
ON o.order_id = oi.order_id

GROUP BY
    c.customer_id,
    c.customer_name;



-- 9. LAG/LEAD Analysis
-- Days Between Consecutive Orders Per Customer
-- Flags customers with an average gap > 30 days as "At Risk"


WITH customer_orders AS (

    SELECT
        customer_id,
        order_date,
        LAG(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS previous_order_date

    FROM orders

    WHERE customer_id IS NOT NULL
      AND customer_id != 0

),

order_gaps AS (

    SELECT
        customer_id,
        order_date,
        previous_order_date,
        CASE
            WHEN previous_order_date IS NOT NULL
            THEN julianday(order_date) - julianday(previous_order_date)
        END AS days_gap

    FROM customer_orders

),

customer_avg_gap AS (

    SELECT
        customer_id,
        AVG(days_gap) AS avg_gap

    FROM order_gaps

    WHERE days_gap IS NOT NULL

    GROUP BY customer_id

)

SELECT
    g.customer_id,
    g.order_date,
    g.previous_order_date,
    ROUND(g.days_gap, 2) AS days_gap,
    ROUND(a.avg_gap, 2) AS avg_gap_for_customer,
    CASE
        WHEN a.avg_gap IS NULL THEN 'Insufficient Data'
        WHEN a.avg_gap > 30 THEN 'At Risk'
        ELSE 'Active'
    END AS customer_status

FROM order_gaps g

LEFT JOIN customer_avg_gap a
    ON g.customer_id = a.customer_id

ORDER BY g.customer_id, g.order_date;



-- 11. Customer Segmentation Using NTILE(4)


WITH customer_sales AS(
SELECT c.customer_id, c.customer_name,
  SUM(
        oi.quantity *
        oi.unit_price *
        (1 - oi.discount_percent/100.0)
    ) AS revenue

FROM customers c

JOIN orders o
ON c.customer_id=o.customer_id

JOIN order_items oi
ON o.order_id=oi.order_id

GROUP BY c.customer_id, c.customer_name)

SELECT customer_id, customer_name, 
ROUND(revenue,2), 
NTILE(4)
OVER( ORDER BY revenue DESC) AS quartile
FROM customer_sales;



-- 12. Year-over-Year Comparison
-- Compares each month's revenue with the same month in the previous year.
-- Uses a LEFT JOIN (not LAG) because LAG over a plain year/month list would
-- compare against whichever row happens to be previous chronologically --
-- which breaks if a month has no data at all. The self-join on
-- (year - 1, same month) guarantees we're always comparing the correct
-- calendar month, and handles missing previous-year data cleanly (NULL).


WITH monthly_revenue AS (

    SELECT
        CAST(strftime('%Y', order_date) AS INTEGER) AS year,
        CAST(strftime('%m', order_date) AS INTEGER) AS month,
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ) AS revenue

    FROM orders o

    JOIN order_items oi
        ON o.order_id = oi.order_id

    GROUP BY year, month

)

SELECT
    curr.year,
    curr.month,
    ROUND(curr.revenue, 2) AS revenue,
    ROUND(prev.revenue, 2) AS prev_year_revenue,
    CASE
        WHEN prev.revenue IS NULL OR prev.revenue = 0 THEN NULL
        ELSE ROUND(
            100.0 * (curr.revenue - prev.revenue) / prev.revenue,
            2
        )
    END AS yoy_growth_percent

FROM monthly_revenue curr

LEFT JOIN monthly_revenue prev
    ON prev.year = curr.year - 1
    AND prev.month = curr.month

ORDER BY curr.year, curr.month;



-- 13. First Purchased Category & Last Purchased Category


WITH customer_category AS(
SELECT c.customer_id, p.category, o.order_date, ROW_NUMBER()
OVER(
PARTITION BY c.customer_id
ORDER BY o.order_date
) first_order,

ROW_NUMBER()
OVER(
PARTITION BY c.customer_id
ORDER BY o.order_date DESC
) last_order

FROM customers c

JOIN orders o
ON c.customer_id=o.customer_id

JOIN order_items oi
ON o.order_id=oi.order_id

JOIN products p
ON oi.product_id=p.product_id

)

SELECT f.customer_id, f.category AS first_category, l.category AS last_category,
CASE
WHEN f.category=l.category
THEN 'No'
ELSE 'Yes'
END AS category_shift
FROM customer_category f
JOIN customer_category l ON f.customer_id=l.customer_id
WHERE f.first_order=1 AND l.last_order=1;


-- 14. Cumulative Revenue Distribution
-- What % of total revenue comes from the top N% of customers


WITH customer_revenue AS(
SELECT c.customer_id,
SUM(
oi.quantity*
oi.unit_price*
(1-oi.discount_percent/100.0)
) revenue

FROM customers c

JOIN orders o
ON c.customer_id=o.customer_id

JOIN order_items oi
ON o.order_id=oi.order_id

GROUP BY c.customer_id )

SELECT
    customer_id,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        SUM(revenue) OVER (ORDER BY revenue DESC),
        2
    ) AS cumulative_revenue,
    ROUND(
        100.0 * SUM(revenue) OVER (ORDER BY revenue DESC)
        / SUM(revenue) OVER (),
        2
    ) AS cumulative_percent
FROM customer_revenue
ORDER BY revenue DESC;



-- 16. Self-Join: Products Frequently Bought Together
-- Finds product pairs that appear in the same order.
-- oi1.product_id < oi2.product_id excludes self-pairs (A-A)
-- and duplicate mirror pairs (A-B and B-A only counted once).
-- product_id is included because product_name is not unique in this
-- dataset (e.g. several distinct product_ids can all be named "Shoes"),
-- so grouping/display by name alone can look like a false self-pair.


SELECT
    oi1.product_id AS product_a_id,
    p1.product_name AS product_a,
    oi2.product_id AS product_b_id,
    p2.product_name AS product_b,
    COUNT(*) AS times_bought_together

FROM order_items oi1

JOIN order_items oi2
    ON oi1.order_id = oi2.order_id
    AND oi1.product_id < oi2.product_id

JOIN products p1
    ON oi1.product_id = p1.product_id

JOIN products p2
    ON oi2.product_id = p2.product_id

GROUP BY oi1.product_id, p1.product_name, oi2.product_id, p2.product_name

ORDER BY times_bought_together DESC;