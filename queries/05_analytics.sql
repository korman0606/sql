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

-- Task 63. Sellers with High Revenue but Low Rating.
SELECT 
	oi.seller_id,
	ROUND(SUM(oi.price), 2) AS revenue,
	ROUND(AVG(r.review_score), 2) AS avg_rating
FROM order_items oi
JOIN order_reviews r
    ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING 
	SUM(oi.price) > 50000 
	AND AVG(r.review_score) < 4
ORDER BY revenue DESC
LIMIT 10;

--Task 64. Customer Lifetime Value (top 10).
SELECT
    c.customer_unique_id,
    ROUND(SUM(op.payment_value), 2) AS lifetime_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY lifetime_value DESC
LIMIT 10;
