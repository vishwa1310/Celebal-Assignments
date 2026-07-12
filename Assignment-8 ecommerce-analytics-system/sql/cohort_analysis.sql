-- 10. Monthly Revenue Per Customer

WITH monthly_revenue AS (

    SELECT
        c.customer_id,
        strftime('%Y-%m', o.order_date) AS month,

        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ) AS revenue

    FROM customers c

    JOIN orders o
        ON c.customer_id = o.customer_id

    JOIN order_items oi
        ON o.order_id = oi.order_id

    GROUP BY
        c.customer_id,
        month
)

SELECT
    customer_id,
    month,
    ROUND(revenue, 2) AS revenue,

    CASE
        WHEN revenue > 10000 THEN 'High'
        WHEN revenue >= 5000 THEN 'Medium'
        ELSE 'Low'
    END AS customer_category

FROM monthly_revenue

ORDER BY
    month,
    customer_id;



-- Count Customers In Each Category Per Month


WITH monthly_revenue AS (

    SELECT
        c.customer_id,
        strftime('%Y-%m', o.order_date) AS month,

        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ) AS revenue

    FROM customers c

    JOIN orders o
        ON c.customer_id = o.customer_id

    JOIN order_items oi
        ON o.order_id = oi.order_id

    GROUP BY
        c.customer_id,
        month

),

customer_category AS (

    SELECT
        customer_id,
        month,

        CASE
            WHEN revenue > 10000 THEN 'High'
            WHEN revenue >= 5000 THEN 'Medium'
            ELSE 'Low'
        END AS category

    FROM monthly_revenue
)

SELECT
    month,
    category,
    COUNT(customer_id) AS total_customers

FROM customer_category

GROUP BY
    month,
    category

ORDER BY
    month,
    category;



-- 11. Lifetime Value Quartiles


WITH customer_value AS (

    SELECT
        c.customer_id,

        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ) AS total_value

    FROM customers c

    JOIN orders o
        ON c.customer_id = o.customer_id

    JOIN order_items oi
        ON o.order_id = oi.order_id

    GROUP BY
        c.customer_id
)

SELECT
    customer_id,
    ROUND(total_value, 2) AS total_value,

    NTILE(4) OVER (
        ORDER BY total_value DESC
    ) AS quartile,

    CASE
        WHEN NTILE(4) OVER (ORDER BY total_value DESC) = 1 THEN 'Platinum'
        WHEN NTILE(4) OVER (ORDER BY total_value DESC) = 2 THEN 'Gold'
        WHEN NTILE(4) OVER (ORDER BY total_value DESC) = 3 THEN 'Silver'
        ELSE 'Bronze'
    END AS quartile_label

FROM customer_value;



-- 12. Cohort Analysis

WITH customer_cohort AS (

    SELECT
        customer_id,
        DATE(registration_date, 'start of month') AS cohort_month

    FROM customers

),

customer_orders AS (

    SELECT
        customer_id,
        DATE(order_date, 'start of month') AS order_month

    FROM orders

),

cohort_data AS (

    SELECT
        c.customer_id,
        c.cohort_month,
        o.order_month,

        (
            (
                CAST(strftime('%Y', o.order_month) AS INTEGER) -
                CAST(strftime('%Y', c.cohort_month) AS INTEGER)
            ) * 12
            +
            (
                CAST(strftime('%m', o.order_month) AS INTEGER) -
                CAST(strftime('%m', c.cohort_month) AS INTEGER)
            )
        ) AS month_number

    FROM customer_cohort c

    JOIN customer_orders o
        ON c.customer_id = o.customer_id
)

SELECT
    cohort_month,
    month_number,
    COUNT(DISTINCT customer_id) AS active_customers

FROM cohort_data

WHERE month_number BETWEEN 0 AND 3

GROUP BY
    cohort_month,
    month_number

ORDER BY
    cohort_month,
    month_number;



-- 13. Retention Rate

WITH customer_cohort AS (

    SELECT
        customer_id,
        DATE(registration_date, 'start of month') AS cohort_month

    FROM customers

),

customer_orders AS (

    SELECT
        customer_id,
        DATE(order_date, 'start of month') AS order_month

    FROM orders

),

cohort_data AS (

    SELECT
        c.customer_id,
        c.cohort_month,
        o.order_month,

        (
            (
                CAST(strftime('%Y', o.order_month) AS INTEGER) -
                CAST(strftime('%Y', c.cohort_month) AS INTEGER)
            ) * 12
            +
            (
                CAST(strftime('%m', o.order_month) AS INTEGER) -
                CAST(strftime('%m', c.cohort_month) AS INTEGER)
            )
        ) AS month_number

    FROM customer_cohort c

    JOIN customer_orders o
        ON c.customer_id = o.customer_id

),

cohort_size AS (

    SELECT
        cohort_month,
        COUNT(DISTINCT customer_id) AS total_customers

    FROM customer_cohort

    GROUP BY
        cohort_month
)

SELECT
    d.cohort_month,
    d.month_number,

    COUNT(DISTINCT d.customer_id) AS retained_customers,

    s.total_customers,

    ROUND(
        100.0 *
        COUNT(DISTINCT d.customer_id) /
        s.total_customers,
        2
    ) AS retention_rate

FROM cohort_data d

JOIN cohort_size s
    ON d.cohort_month = s.cohort_month

WHERE d.month_number BETWEEN 0 AND 3

GROUP BY
    d.cohort_month,
    d.month_number,
    s.total_customers

ORDER BY
    d.cohort_month,
    d.month_number;