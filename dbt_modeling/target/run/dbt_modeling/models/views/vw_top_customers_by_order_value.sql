

  create or replace view `ready-de-25`.`olist_ziad`.`vw_top_customers_by_order_value`
  OPTIONS()
  as -- 1- Who are the top customers by total order value?

SELECT
    c.customer_unique_id AS customer_id,
    SUM(f.price + f.freight_value) AS total_order_value
FROM `ready-de-25`.`olist_ziad`.`fact_orders` f
JOIN `ready-de-25`.`olist_ziad`.`dim_customers` c ON f.customer_id = c.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_order_value DESC
LIMIT 10;

