
  
    

    create or replace table `ready-de-25`.`olist_ziad`.`dim_sellers`
      
    
    

    OPTIONS()
    as (
      SELECT DISTINCT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM `ready-de-25`.`olist_ziad`.`sellers`
    );
  