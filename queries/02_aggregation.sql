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
