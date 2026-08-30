-- Task 61. Repeat Customer Rate.
WITH customer_orders AS (
	SELECT
		c.customer_unique_id,
		COUNT(o.order_id) AS orders_count
	FROM customers c
		INNER JOIN orders o
		ON c.customer_id = o.customer_id
	GROUP BY c.customer_unique_id)

SELECT
	ROUND(COUNT(*) FILTER (WHERE orders_count > 1) 
	* 100 / COUNT(*),2) AS repeat_customer_rate
FROM customer_orders;

-- Task 62. Average Order Value by Payment Type.
SELECT
	payment_type,
	AVG (payment_value) AS avg_payment
FROM order_payments
GROUP BY payment_type
ORDER BY avg_payment DESC
LIMIT 4;
