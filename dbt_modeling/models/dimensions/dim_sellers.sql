
SELECT DISTINCT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM {{ source('olist_ziad', 'sellers') }}
