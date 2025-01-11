

  create or replace view `ready-de-25`.`olist_ziad`.`stg_payments`
  OPTIONS()
  as SELECT DISTINCT
    order_id,
    payment_type,
    payment_value
FROM `ready-de-25`.`olist_ziad`.`order_payments`;

