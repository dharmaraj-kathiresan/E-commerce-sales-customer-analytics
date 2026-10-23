-- E-Commerce Data Quality Checks
-- Database: PostgreSQL

-- 1. Check total orders and duplicate order IDs
SELECT COUNT(*) AS total_orders,
COUNT(DISTINCT order_id) AS unique_orders
FROM orders;

-- 2. Check missing customer IDs in orders
SELECT COUNT(*) AS missing_customer_ids
FROM orders
WHERE customer_id IS NULL;

-- 3. Check duplicate customer IDs
SELECT COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_customer_ids
FROM customers;

-- 4. Check order items with missing product IDs
SELECT COUNT(*) AS missing_product_ids
FROM order_items
WHERE product_id IS NULL;

-- 5. Check order items with missing prices
SELECT COUNT(*) AS missing_prices
FROM order_items
WHERE price IS NULL;

-- 6. Check payments with zero or negative values
SELECT COUNT(*) AS invalid_payment_values
FROM order_payments
WHERE payment_value <= 0;

-- 7. Check invalid review scores
SELECT COUNT(*) AS invalid_review_scores
FROM order_reviews
WHERE review_score NOT BETWEEN 1 AND 5;

-- 8. Check orders without matching order items
SELECT COUNT(*) AS orders_without_items
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;

-- 9. Check order items without matching orders
SELECT COUNT(*) AS items_without_orders
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;