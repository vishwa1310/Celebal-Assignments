
-- 1. Total Revenue Per Category
-- Revenue = quantity × unit_price × (1 - discount_percent / 100)


SELECT p.category,ROUND(SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ),
        2
    ) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;


-- 2. Top 10 Customers By Total Order Value


SELECT c.customer_id,c.customer_name,
    ROUND(
        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100.0)
        ),
        2
    ) AS total_order_value
FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id

GROUP BY c.customer_id, c.customer_name
ORDER BY total_order_value DESC
LIMIT 10;



-- 3. Month-wise Order Count (Last 12 Months)


SELECT strftime('%Y-%m', order_date) AS month, COUNT(order_id) AS total_orders
FROM orders
GROUP BY month
ORDER BY month DESC
LIMIT 12;


-- 4. Customers Who Placed Orders But Never Had Any Item Delivered


SELECT DISTINCT c.customer_id, c.customer_name
FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

WHERE c.customer_id NOT IN
(SELECT customer_id FROM orders WHERE status = 'DELIVERED');




-- 5. Products Having More Returns Than Purchases


SELECT p.product_id, p.product_name,
    SUM( CASE
            WHEN o.status = 'RETURNED'
            THEN 1
            ELSE 0
        END
    ) AS returned,

    SUM(CASE
            WHEN o.status = 'DELIVERED'
            THEN 1
            ELSE 0
        END
    ) AS purchased

FROM products p

JOIN order_items oi
ON p.product_id = oi.product_id

JOIN orders o
ON oi.order_id = o.order_id

GROUP BY p.product_id, p.product_name
HAVING returned > purchased;




-- 6. Return Rate Per Category


SELECT p.category,
   ROUND( 100.0 * SUM( CASE
                WHEN o.status = 'RETURNED'
                THEN oi.quantity
                ELSE 0
            END )/
        SUM(oi.quantity), 2
    ) AS return_rate_percent

FROM products p

JOIN order_items oi
ON p.product_id = oi.product_id

JOIN orders o
ON oi.order_id = o.order_id

GROUP BY p.category
ORDER BY return_rate_percent DESC;