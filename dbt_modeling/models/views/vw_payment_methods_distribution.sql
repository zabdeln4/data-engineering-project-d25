
SELECT
    f.payment_type,
    COUNT(f.order_id) AS total_orders,
    ROUND(COUNT(f.order_id) * 100.0 / SUM(COUNT(f.order_id)) OVER (), 2) AS percentage
FROM {{ ref('fact_orders') }} f
GROUP BY f.payment_type
ORDER BY total_orders DESC
