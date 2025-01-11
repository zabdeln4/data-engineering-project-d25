

  create or replace view `ready-de-25`.`olist_ziad`.`vw_top_selling_products`
  OPTIONS()
  as -- 4- What are the top-selling products by quantity?

SELECT
    p.product_id,
    p.product_category_name,
    COUNT(f.product_id) AS quantity_sold
FROM `ready-de-25`.`olist_ziad`.`fact_orders` f
JOIN `ready-de-25`.`olist_ziad`.`dim_products` p ON f.product_id = p.product_id
GROUP BY p.product_id, p.product_category_name
ORDER BY quantity_sold DESC
LIMIT 10;

