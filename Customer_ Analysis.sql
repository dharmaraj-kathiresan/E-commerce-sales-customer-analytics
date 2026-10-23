-- E-Commerce Customer Analysis
-- Database: PostgreSQL

-- 1. Total number of customers
SELECT COUNT(*) AS total_customers
FROM vw_customer_analysis;

-- 2. Customers who placed repeat orders
SELECT COUNT(*) AS repeat_customers
FROM vw_customer_analysis
WHERE order_count > 1;

-- 3. Number of orders per customer
SELECT order_count, COUNT(*) AS total_customers
FROM vw_customer_analysis
GROUP BY order_count
ORDER BY order_count;

-- 4. Top 10 customers by spending
SELECT customer_unique_id,
order_count,
ROUND(total_spent, 2) AS total_spent
FROM vw_customer_analysis
ORDER BY total_spent DESC
LIMIT 10;

-- 5. Average spending per customer
SELECT ROUND(AVG(total_spent), 2) AS average_customer_spending
FROM vw_customer_analysis;

-- 6. Total spending by customer state
SELECT customer_state,
ROUND(SUM(total_sales), 2) AS total_sales
FROM vw_sales_analysis
GROUP BY customer_state
ORDER BY total_sales DESC;

-- 7. Customers who placed more than one order
SELECT customer_unique_id, order_count, total_spent
FROM vw_customer_analysis
WHERE order_count > 1
ORDER BY order_count DESC, total_spent DESC;