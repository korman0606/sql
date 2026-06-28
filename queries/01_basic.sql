-- Task 1. How many customers are in the database?
SELECT count(distinct customer_unique_id)
FROM customers;
