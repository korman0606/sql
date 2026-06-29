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

-- Task 23. Top 10 cities by number of customers
SELECT 
	customer_city, 
	COUNT(customer_unique_id) AS customers_count
FROM customers
GROUP BY customer_city
ORDER BY customers_count DESC
LIMIT 10;

-- Task 24. Top 10 average product price by seller
SELECT 
	seller_id,
	ROUND(AVG(price),2) as avg_price
FROM order_items
GROUP BY seller_id
ORDER BY avg_price DESC
LIMIT 10;
