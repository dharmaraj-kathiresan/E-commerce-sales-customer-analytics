-- E-Commerce Sales & Customer Analytics
-- Database: PostgreSQL

-- 1. Total sales
SELECT ROUND(SUM(total_sales), 2) AS total_sales
FROM vw_sales_analysis;

-- 2. Total delivered orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM vw_sales_analysis;

-- 3. Average order value
SELECT ROUND(SUM(total_sales) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM vw_sales_analysis;

-- 4. Monthly sales
SELECT DATE_TRUNC('month', order_date)::date AS month,
ROUND(SUM(total_sales), 2) AS monthly_sales
FROM vw_sales_analysis
GROUP BY month
ORDER BY month;

-- 5. Top 10 product categories by sales
SELECT product_category_name,
ROUND(SUM(total_sales), 2) AS total_sales
FROM vw_sales_analysis
GROUP BY product_category_name
ORDER BY total_sales DESC
LIMIT 10;

-- 6. Top 10 states by sales
SELECT customer_state,
ROUND(SUM(total_sales), 2) AS total_sales
FROM vw_sales_analysis
GROUP BY customer_state
ORDER BY total_sales DESC
LIMIT 10;

-- 7. Order status distribution
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- 8. Cancellation rate
SELECT ROUND(
100.0 * COUNT() FILTER (WHERE order_status = 'canceled') / COUNT(),
2
) AS cancellation_rate
FROM orders;

-- 9. Payment method analysis
SELECT payment_type,
COUNT(*) AS total_payments,
ROUND(SUM(payment_value), 2) AS total_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;

-- 10. Top 10 products by sales
SELECT product_id, product_category_name, units_sold, total_sales
FROM vw_product_analysis
ORDER BY total_sales DESC
LIMIT 10;

-- 11. Top 10 sellers by sales
SELECT seller_id, seller_city, seller_state, total_sales
FROM vw_seller_analysis
ORDER BY total_sales DESC
LIMIT 10;

-- 12. Repeat customers
SELECT COUNT(*) AS repeat_customers
FROM vw_customer_analysis
WHERE order_count > 1;

-- 13. Repeat customer rate
SELECT ROUND(
100.0 * COUNT() FILTER (WHERE order_count > 1) / COUNT(),
2
) AS repeat_customer_rate
FROM vw_customer_analysis;

-- 14. Top 10 customers by spending
SELECT customer_unique_id, order_count,
ROUND(total_spent, 2) AS total_spent
FROM vw_customer_analysis
ORDER BY total_spent DESC
LIMIT 10;

-- 15. Average delivery time
SELECT ROUND(AVG(delivery_days), 2) AS average_delivery_days
FROM vw_delivery_analysis;

-- 16. Late delivery rate
SELECT ROUND(
100.0 * COUNT() FILTER (WHERE delivery_status = 'Late') / COUNT(),
2
) AS late_delivery_rate
FROM vw_delivery_analysis;

-- 17. Average delivery time by state
SELECT customer_state,
ROUND(AVG(delivery_days), 2) AS average_delivery_days
FROM vw_delivery_analysis
GROUP BY customer_state
ORDER BY average_delivery_days DESC;

-- 18. Customer review score distribution
SELECT review_score, COUNT(*) AS total_reviews
FROM vw_review_analysis
GROUP BY review_score
ORDER BY review_score;

-- 19. Average review score by delivery status
SELECT delivery_status,
ROUND(AVG(review_score), 2) AS average_review_score
FROM vw_review_analysis
GROUP BY delivery_status
ORDER BY average_review_score DESC;

-- 20. Top 10 product categories by units sold
SELECT product_category_name,
SUM(units_sold) AS total_units_sold
FROM vw_product_analysis
GROUP BY product_category_name
ORDER BY total_units_sold DESC
LIMIT 10;