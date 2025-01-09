

  create or replace view `ready-de-25`.`olist_ziad`.`stg_products`
  OPTIONS()
  as WITH cleaned_products AS (
    SELECT DISTINCT
        product_id,
        product_category_name,
        product_name_lenght,
        product_description_lenght,
        product_photos_qty,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm
    FROM `ready-de-25`.`olist_ziad`.`products`
)

SELECT * FROM cleaned_products;

