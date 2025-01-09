
  
    

    create or replace table `ready-de-25`.`olist_ziad`.`fact_reviews`
      
    
    

    OPTIONS()
    as (
      SELECT
    r.review_id,
    r.order_id,
    r.review_score
FROM `ready-de-25`.`olist_ziad`.`order_reviews` r
    );
  