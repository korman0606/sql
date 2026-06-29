-- Task 21. How many orders were placed for each order status?
SELECT 
  order_status, 
  COUNT(*) AS orders_count
FROM orders
GROUP BY order_status
ORDER BY orders_count DESC;

-- Task 22. How many customers are there in each state?
SELECT 
  customer_state, 
  COUNT(customer_unique_id) AS customers_count
FROM customers
GROUP BY customer_state
ORDER BY customers_count DESC;

-- Task 23. Top 10 cities by number of customers.
SELECT 
	customer_city, 
	COUNT(customer_unique_id) AS customers_count
FROM customers
GROUP BY customer_city
ORDER BY customers_count DESC
LIMIT 10;

-- Task 24. Average product price by seller (top 10).
SELECT 
	seller_id,
	ROUND(AVG(price),2) as avg_price
FROM order_items
GROUP BY seller_id
ORDER BY avg_price DESC
LIMIT 10;

-- Task 25. Search for the cheapest seller (based on the average price of the product).
SELECT
    seller_id,
    ROUND(AVG(price), 2) AS avg_price
FROM order_items
GROUP BY seller_id
ORDER BY avg_price 
LIMIT 1;

-- Task 26. What is the average order value?
SELECT ROUND(AVG(order_total),2) as avg_order_value
FROM (
	SELECT SUM(price) as order_total
	FROM order_items
	GROUP BY order_id
	) t;

-- Task 27. Which sellers sold the largest number of products?
SELECT
    seller_id,
    COUNT(*) AS products_sold
FROM order_items
GROUP BY seller_id
ORDER BY products_sold DESC
LIMIT 10;

-- Task 28. Which sellers generated the highest revenue?
SELECT
    seller_id,
    ROUND(SUM(price), 2) AS revenue
FROM order_items
GROUP BY seller_id
ORDER BY revenue DESC
LIMIT 10;

-- Task 29. What is the average freight cost for each seller? (top 10)
SELECT
    seller_id,
    ROUND(AVG(freight_value), 2) AS average_freight
FROM order_items
GROUP BY seller_id
ORDER BY average_freight DESC
LIMIT 10;

-- Task 30. Distribution of review scores.
SELECT
    review_score,
    COUNT(*) AS reviews_count
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;

-- Task 31. Which payment methods are used most often?
SELECT
    payment_type,
    COUNT(*) AS payments_count
FROM order_payments
GROUP BY payment_type
ORDER BY payments_count DESC;

-- Task 32. Average payment amount for each payment method.
SELECT
    payment_type,
    ROUND(AVG(payment_value), 2) AS average_payment
FROM order_payments
GROUP BY payment_type
ORDER BY average_payment DESC;

-- Task 33. Which payment method brings the highest total revenue?
SELECT
    payment_type,
    ROUND(SUM(payment_value), 2) AS revenue
FROM order_payments
GROUP BY payment_type
ORDER BY revenue DESC;
