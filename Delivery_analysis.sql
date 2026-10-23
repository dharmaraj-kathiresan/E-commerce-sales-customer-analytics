-- E-Commerce Delivery Analysis
-- Database: PostgreSQL

-- 1. Average delivery time
SELECT ROUND(AVG(delivery_days), 2) AS average_delivery_days
FROM vw_delivery_analysis;

-- 2. Total late deliveries
SELECT COUNT(*) AS late_orders
FROM vw_delivery_analysis
WHERE delivery_status = 'Late';

-- 3. Late delivery percentage
SELECT ROUND(
100.0 * COUNT() FILTER (WHERE delivery_status = 'Late') / COUNT(),
2
) AS late_delivery_rate
FROM vw_delivery_analysis;

-- 4. On-time and late delivery counts
SELECT delivery_status, COUNT(*) AS total_orders
FROM vw_delivery_analysis
GROUP BY delivery_status
ORDER BY total_orders DESC;

-- 5. Average delivery time by state
SELECT customer_state,
COUNT(*) AS delivered_orders,
ROUND(AVG(delivery_days), 2) AS average_delivery_days
FROM vw_delivery_analysis
GROUP BY customer_state
ORDER BY average_delivery_days DESC;

-- 6. States with the highest late delivery rates
SELECT customer_state,
COUNT() AS delivered_orders,
COUNT() FILTER (
WHERE delivery_status = 'Late'
) AS late_orders,
ROUND(
100.0 * COUNT() FILTER (
WHERE delivery_status = 'Late'
) / COUNT(),
2
) AS late_delivery_rate
FROM vw_delivery_analysis
GROUP BY customer_state
ORDER BY late_delivery_rate DESC;

-- 7. Compare actual and estimated delivery dates
SELECT order_id,
delivery_date,
estimated_delivery_date,
delivery_days,
delivery_status
FROM vw_delivery_analysis
WHERE delivery_status = 'Late'
ORDER BY delivery_days DESC
LIMIT 10;