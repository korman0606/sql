-- Task 36. How many orders has each unique customer placed? (top 10)
SELECT
	c.customer_unique_id, 
	COUNT(o.order_id) AS orders_count
FROM orders o 
INNER JOIN customers c
ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY orders_count DESC
LIMIT 10;

-- Task 37. Top 10 product categories by revenue.
SELECT
	p.product_category_name,
	SUM(o.price) AS total_revenue
FROM products p
INNER JOIN order_items o
ON p.product_id = o.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Task 38. Top 10 product categories by quantity sold.
SELECT
    p.product_category_name,
    COUNT(*) AS products_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY products_sold DESC
LIMIT 10;

-- Task 39. Revenue by customer state.
SELECT
	c.customer_state,
	SUM(oi.price) AS total_revenue
FROM order_items oi 
	INNER JOIN orders o
	ON oi.order_id = o.order_id
	INNER JOIN customers c
	ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;

-- Task 40. Average order value by customer state (top 10).
SELECT
    customer_state,
    ROUND(AVG(order_total), 2) AS avg_order_value
FROM (
    SELECT
        c.customer_state,
        o.order_id,
        SUM(oi.price) AS order_total
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_state,
        o.order_id
) t
GROUP BY customer_state
ORDER BY avg_order_value DESC
LIMIT 10;
