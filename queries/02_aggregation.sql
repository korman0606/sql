-- Task 21. How many orders were placed for each order status?
SELECT order_status, COUNT(*) AS orders_count
FROM orders
GROUP BY order_status
ORDER BY orders_count DESC;

