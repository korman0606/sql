-- Task 51. Rank sellers by revenue (top 10).
SELECT 
	seller_id,
	SUM(price) AS revenue,
	RANK() OVER (ORDER BY SUM(price) DESC) AS revenue_rank
FROM order_items
GROUP BY seller_id
LIMIT 10;

-- Task 52. Dense rank product categories by revenue (top 10).
SELECT
	p.product_category_name,
	SUM(oi.price) AS revenue,
	DENSE_RANK() OVER (ORDER BY SUM(oi.price) DESC) AS revenue_rank
FROM order_items oi
	INNER JOIN products p
	ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue_rank
LIMIT 10;

-- Task 53. The share of each category in total revenue (top 10).
SELECT
	p.product_category_name,
	ROUND(SUM(oi.price)*100/SUM(SUM(oi.price)) OVER()) AS revenue_percentage
FROM order_items oi
	INNER JOIN products p
	ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue_percentage DESC
LIMIT 10;

-- Task 54. Cumulative revenue by month (top 10).
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
        SUM(oi.price) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
)

SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        SUM(revenue) OVER (ORDER BY month),
        2
    ) AS cumulative_revenue
FROM monthly_revenue
ORDER BY month
LIMIT 10;
