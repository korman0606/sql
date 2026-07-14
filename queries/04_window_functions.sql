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
