
  
    

    create or replace table `ready-de-25`.`olist_ziad`.`fact_orders`
      
    
    

    OPTIONS()
    as (
      SELECT
    oi.order_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    oi.shipping_limit_date,
    oi.price,
    oi.freight_value,
    o.order_status,
    o.order_purchase_timestamp,
    p.payment_type,
    p.payment_value
FROM `ready-de-25`.`olist_ziad`.`stg_order_items` oi
JOIN `ready-de-25`.`olist_ziad`.`stg_orders` o ON oi.order_id = o.order_id
JOIN `ready-de-25`.`olist_ziad`.`stg_payments` p ON oi.order_id = p.order_id
    );
  