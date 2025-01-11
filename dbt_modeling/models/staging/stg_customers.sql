WITH cleaned_customers AS (
    SELECT DISTINCT
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state
    FROM {{ source('olist_ziad', 'customers') }}
)

SELECT * FROM cleaned_customers
