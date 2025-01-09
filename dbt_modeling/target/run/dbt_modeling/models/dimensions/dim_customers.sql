
  
    

    create or replace table `ready-de-25`.`olist_ziad`.`dim_customers`
      
    
    

    OPTIONS()
    as (
      SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM `ready-de-25`.`olist_ziad`.`stg_customers`
    );
  