-- Task 51. Top 10 customers by total spending.
WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
)

SELECT
    customer_unique_id,
    ROUND(total_spent, 2) AS total_spent
FROM customer_revenue
ORDER BY total_spent DESC
LIMIT 10;

-- Task 52. Sellers with revenue above average (top 10).
WITH seller_revenue AS (
    SELECT
        seller_id,
        SUM(price) AS revenue
    FROM order_items
    GROUP BY seller_id
)

SELECT
    seller_id,
    ROUND(revenue, 2) AS revenue
FROM seller_revenue
WHERE revenue > (
    SELECT AVG(revenue)
    FROM seller_revenue
)
ORDER BY revenue DESC
LIMIT 10;
