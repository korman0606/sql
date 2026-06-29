-- Task 1. How many customers are in the database?
SELECT count(distinct customer_unique_id)
FROM customers;

-- Task 2. How many orders have been placed?
SELECT count(*)
FROM orders;
