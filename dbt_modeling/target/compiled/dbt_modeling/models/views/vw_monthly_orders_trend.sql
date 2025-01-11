-- 7- What is the total number of orders placed each month (trend over time)?

SELECT
    DATE_TRUNC(f.order_purchase_timestamp, MONTH) AS month,
    COUNT(f.order_id) AS total_orders
FROM `ready-de-25`.`olist_ziad`.`fact_orders` f
GROUP BY month
ORDER BY month