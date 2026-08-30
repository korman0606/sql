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

-- Task 55. The month with the maximum revenue.
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
    ROUND(revenue, 2) AS revenue
FROM monthly_revenue
ORDER BY revenue DESC
LIMIT 1;

-- Task 56. Top 3 sellers in each state (top 10).
WITH seller_revenue AS (
    SELECT
        s.seller_state,
        s.seller_id,
        SUM(oi.price) AS revenue
    FROM sellers s
    JOIN order_items oi
        ON s.seller_id = oi.seller_id
    GROUP BY
        s.seller_state,
        s.seller_id
),
ranked_sellers AS (
    SELECT
        seller_state,
        seller_id,
        revenue,
        DENSE_RANK() OVER (
            PARTITION BY seller_state
            ORDER BY revenue DESC
        ) AS seller_rank
    FROM seller_revenue
)

SELECT
    seller_state,
    seller_id,
    ROUND(revenue, 2) AS revenue,
    seller_rank
FROM ranked_sellers
WHERE seller_rank <= 3
ORDER BY seller_state, seller_rank
LIMIT 10;

--Task 57. Average order cost and comparison with the overall average (top 10).
WITH seller_stats AS (
    SELECT
        oi.seller_id,
        SUM(oi.price) AS revenue,
        AVG(orv.review_score) AS avg_rating
    FROM order_items oi
    JOIN order_reviews orv
        ON oi.order_id = orv.order_id
    GROUP BY oi.seller_id
)

SELECT
    seller_id,
    ROUND(revenue, 2) AS revenue,
    ROUND(avg_rating, 2) AS avg_rating
FROM seller_stats
WHERE revenue > (
    SELECT AVG(revenue)
    FROM seller_stats
)
AND avg_rating > (
    SELECT AVG(avg_rating)
    FROM seller_stats
)
ORDER BY revenue DESC
LIMIT 10;
