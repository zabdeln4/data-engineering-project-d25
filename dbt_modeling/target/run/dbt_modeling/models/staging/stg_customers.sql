

  create or replace view `ready-de-25`.`olist_ziad`.`stg_customers`
  OPTIONS()
  as WITH cleaned_customers AS (
    SELECT DISTINCT
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state
    FROM `ready-de-25`.`olist_ziad`.`customers`
)

SELECT * FROM cleaned_customers;

