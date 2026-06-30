-- Task 36. How many orders has each unique customer placed?
SELECT
	c.customer_unique_id, 
	COUNT(o.order_id) AS orders_count
FROM orders o 
INNER JOIN customers c
ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY orders_count DESC
LIMIT 10;

