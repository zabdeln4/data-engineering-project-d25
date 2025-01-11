-- 12- What is the monthly revenue trend for the business?

SELECT
    DATE_TRUNC(f.order_purchase_timestamp, MONTH) AS month,
    SUM(f.price + f.freight_value) AS total_revenue
FROM `ready-de-25`.`olist_ziad`.`fact_orders` f
GROUP BY month
ORDER BY month