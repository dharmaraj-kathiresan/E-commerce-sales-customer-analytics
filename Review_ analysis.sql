-- E-Commerce Customer Review Analysis
-- Database: PostgreSQL

-- 1. Overall review score distribution
SELECT review_score,
COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;

-- 2. Average customer review score
SELECT ROUND(AVG(review_score), 2) AS average_review_score
FROM order_reviews;

-- 3. Review score percentage
SELECT review_score,
COUNT() AS total_reviews,
ROUND(
100.0 * COUNT() / SUM(COUNT(*)) OVER (),
2
) AS review_percentage
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;

-- 4. Average review score by delivery status
SELECT delivery_status,
COUNT(*) AS total_reviews,
ROUND(AVG(review_score), 2) AS average_review_score
FROM vw_review_analysis
GROUP BY delivery_status
ORDER BY average_review_score DESC;

-- 5. Review scores for late deliveries
SELECT review_score,
COUNT(*) AS total_reviews
FROM vw_review_analysis
WHERE delivery_status = 'Late'
GROUP BY review_score
ORDER BY review_score;

-- 6. Review scores for on-time deliveries
SELECT review_score,
COUNT(*) AS total_reviews
FROM vw_review_analysis
WHERE delivery_status = 'On Time'
GROUP BY review_score
ORDER BY review_score;