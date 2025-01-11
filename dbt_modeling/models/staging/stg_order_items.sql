WITH cleaned_order_items AS (
    SELECT DISTINCT
        order_id,
        order_item_id,
        product_id,
        seller_id,
        shipping_limit_date,
        price,
        freight_value
    FROM {{ source('olist_ziad', 'order_items') }}
)

SELECT * FROM cleaned_order_items
