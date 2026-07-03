-- Task 51. Rank sellers by revenue (top 10).
SELECT 
	seller_id,
	SUM(price) AS revenue,
	RANK() OVER (ORDER BY SUM(price) DESC) AS revenue_rank
FROM order_items
GROUP BY seller_id
LIMIT 10;
