-- Task 1. How many customers are in the database?
SELECT count(distinct customer_unique_id)
FROM customers;

-- Task 2. How many orders have been placed?
SELECT count(*)
FROM orders;

-- Task 3. How many sellers are registered?
SELECT COUNT(*) AS sellers_count
FROM sellers;

-- Task 4. How many products are available?
SELECT COUNT(*) AS products_count
FROM products;

-- Task 5. What order statuses exist in the dataset?
SELECT DISTINCT order_status 
FROM orders
ORDER BY order_status;

-- Task 6. Find the earliest order.
SELECT MIN(order_purchase_timestamp) AS first_order
FROM orders;

-- Task 7. Find the latest order.
SELECT MAX(order_purchase_timestamp) AS last_order
FROM orders;
