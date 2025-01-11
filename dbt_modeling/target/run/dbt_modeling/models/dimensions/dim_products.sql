
  
    

    create or replace table `ready-de-25`.`olist_ziad`.`dim_products`
      
    
    

    OPTIONS()
    as (
      SELECT DISTINCT
    product_id,
    product_category_name,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM `ready-de-25`.`olist_ziad`.`stg_products`
    );
  