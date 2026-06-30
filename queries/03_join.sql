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


