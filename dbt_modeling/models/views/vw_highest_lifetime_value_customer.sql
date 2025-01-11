-- 3- Which customer has the highest lifetime value?

SELECT
    c.customer_unique_id AS customer_id,
    SUM(f.price + f.freight_value) AS lifetime_value
FROM {{ ref('fact_orders') }} f
JOIN {{ ref('dim_customers') }} c ON f.customer_id = c.customer_id
GROUP BY c.customer_unique_id
ORDER BY lifetime_value DESC
LIMIT 1
