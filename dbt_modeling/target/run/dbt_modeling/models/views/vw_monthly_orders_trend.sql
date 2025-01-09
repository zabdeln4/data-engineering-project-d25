

  create or replace view `ready-de-25`.`olist_ziad`.`vw_monthly_orders_trend`
  OPTIONS()
  as SELECT
    DATE_TRUNC(f.order_purchase_timestamp, MONTH) AS month,
    COUNT(f.order_id) AS total_orders
FROM `ready-de-25`.`olist_ziad`.`fact_orders` f
GROUP BY month
ORDER BY month;

