

SELECT DISTINCT
    order_id,
    payment_type,
    payment_value
FROM {{ source('olist_ziad', 'order_payments') }}
