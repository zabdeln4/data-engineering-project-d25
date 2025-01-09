WITH cleaned_orders AS (
    SELECT DISTINCT
        order_id,
        customer_id,
        order_status,
        order_purchase_timestamp,
        order_delivered_customer_date,
        order_estimated_delivery_date
    FROM `ready-de-25`.`olist_ziad`.`orders`
)

SELECT * FROM cleaned_orders