
SELECT
    p.product_id,
    p.product_category_name,
    COUNT(f.product_id) AS quantity_sold
FROM {{ ref('fact_orders') }} f
JOIN {{ ref('dim_products') }} p ON f.product_id = p.product_id
GROUP BY p.product_id, p.product_category_name
ORDER BY quantity_sold DESC
LIMIT 10
