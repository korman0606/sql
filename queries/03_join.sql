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

-- Task 38. Top 10 product categories by quantity sold.
SELECT
    p.product_category_name,
    COUNT(*) AS products_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY products_sold DESC
LIMIT 10;

-- Task 39. Revenue by customer state.
SELECT
	c.customer_state,
	SUM(oi.price) AS total_revenue
FROM order_items oi 
	INNER JOIN orders o
	ON oi.order_id = o.order_id
	INNER JOIN customers c
	ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;

-- Task 40. Average order value by customer state (top 10).
SELECT
    customer_state,
    ROUND(AVG(order_total), 2) AS avg_order_value
FROM (
    SELECT
        c.customer_state,
        o.order_id,
        SUM(oi.price) AS order_total
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_state,
        o.order_id
) t
GROUP BY customer_state
ORDER BY avg_order_value DESC
LIMIT 10;

-- Task 41. Average review score by product category (top 10)
SELECT
	p.product_category_name AS product_category,
	ROUND(AVG(o_rev.review_score),2) AS review_score
FROM order_reviews AS o_rev
	INNER JOIN order_items oi
	ON o_rev.order_id = oi.order_id
	INNER JOIN products p
	ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY review_score DESC
LIMIT 10;

-- Task 42. Average review score by seller (top 10).
SELECT
	oi.seller_id,
	ROUND(AVG(o_rev.review_score),2) AS review_score
FROM order_reviews AS o_rev
	INNER JOIN order_items oi
	ON o_rev.order_id = oi.order_id
GROUP BY oi.seller_id
ORDER BY review_score DESC
LIMIT 10;

-- Task 43. Revenue by seller state (top 10)
SELECT
    s.seller_state,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN sellers s
    ON oi.seller_id = s.seller_id
GROUP BY s.seller_state
ORDER BY total_revenue DESC
LIMIT 10;

-- Task 44. Average delivery time by customer state.
SELECT
    c.customer_city,
    AVG(o.order_delivered_customer_date - o.order_purchase_timestamp) AS avg_delivery_time
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_city
ORDER BY avg_delivery_time
LIMIT 10;

-- Task 45. Most popular payment type by customer state (3 states).
SELECT
    c.customer_state,
    op.payment_type,
    COUNT(*) AS payments_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY
    c.customer_state,
    op.payment_type
ORDER BY
    c.customer_state,
    payments_count DESC;

-- Task 46. Top 10 cities by revenue.
SELECT 
	s.seller_city,
	SUM(oi.price) AS total_price
FROM order_items oi
	INNER JOIN sellers s
	ON oi.seller_id = s.seller_id
GROUP BY s.seller_city
ORDER BY total_price DESC
LIMIT 10;

-- Task 47. Average product price by category.
SELECT 
	p.product_category_name,
	ROUND(AVG(oi.price),2) avg_price
FROM order_items oi 
	INNER JOIN products p
	ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY avg_price DESC;
