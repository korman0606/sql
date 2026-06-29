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

-- Task 8. How many delivered orders are there?
SELECT COUNT(order_status) AS delivered_orders
FROM orders
WHERE order_status = 'delivered';

-- Task 9. How many canceled orders are there?
SELECT COUNT(*) AS delivered_orders
FROM orders
WHERE order_status = 'canceled';

-- Task 10. What is the average product price?
SELECT ROUND(AVG(price), 2) AS average_price
FROM order_items;

-- Task 11. What is the most expensive product ever sold?
SELECT MAX(price) AS max_price
FROM order_items;

-- Task 12. What is the cheapest product ever sold?
SELECT MIN(price) AS min_price
FROM order_items;

-- Task 13. How many unique cities are represented by customers?
SELECT COUNT(DISTINCT customer_city) AS cities
FROM customers;

-- Task 14. How many unique product categories are there?
SELECT COUNT(DISTINCT product_category_name) AS categories
FROM products;

-- Task 15. What is the average review score?
SELECT ROUND(AVG(review_score), 2) AS average_review
FROM order_reviews;

-- Task 16. What is the highest review score?
SELECT MAX(review_score)
FROM order_reviews;

-- Task 17. What is the lowest review score?
SELECT MIN(review_score)
FROM order_reviews;

-- Task 18. How many different payment methods are used?
SELECT COUNT(DISTINCT payment_type)
FROM order_payments;

-- Task 19. List all payment methods.
SELECT DISTINCT payment_type
FROM order_payments
ORDER BY payment_type;

-- Task 20. What is the average payment amount?
SELECT ROUND(AVG(payment_value),2)
FROM order_payments;
