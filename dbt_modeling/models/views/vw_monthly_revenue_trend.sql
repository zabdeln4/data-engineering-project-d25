-- 12- What is the monthly revenue trend for the business?

SELECT
    DATE_TRUNC(f.order_purchase_timestamp, MONTH) AS month,
    SUM(f.price + f.freight_value) AS total_revenue
FROM {{ ref('fact_orders') }} f
GROUP BY month
ORDER BY month
