-- Task 51. Rank sellers by revenue
SELECT 
	seller_id,
	SUM(price) AS revenue,
	RANK() OVER (ORDER BY SUM(price) DESC) AS revenue_rank
FROM order_items
GROUP BY seller_id;
