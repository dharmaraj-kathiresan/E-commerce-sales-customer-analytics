-- E-Commerce Payment Analysis
-- Database: PostgreSQL

-- 1. Total payment value by payment method
SELECT payment_type,
ROUND(SUM(payment_value), 2) AS total_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;

-- 2. Number of transactions by payment method
SELECT payment_type,
COUNT(*) AS total_transactions
FROM order_payments
GROUP BY payment_type
ORDER BY total_transactions DESC;

-- 3. Average payment value by payment method
SELECT payment_type,
ROUND(AVG(payment_value), 2) AS average_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY average_payment_value DESC;

-- 4. Average credit card installments
SELECT ROUND(AVG(payment_installments), 2) AS average_installments
FROM order_payments
WHERE payment_type = 'credit_card';

-- 5. Credit card installment distribution
SELECT payment_installments,
COUNT(*) AS total_transactions
FROM order_payments
WHERE payment_type = 'credit_card'
GROUP BY payment_installments
ORDER BY payment_installments;

-- 6. Orders with zero or negative payment values
SELECT order_id, payment_type, payment_value
FROM order_payments
WHERE payment_value <= 0
ORDER BY payment_value;

-- 7. Payment value by order
SELECT order_id,
ROUND(SUM(payment_value), 2) AS order_payment_total
FROM order_payments
GROUP BY order_id
ORDER BY order_payment_total DESC
LIMIT 10;