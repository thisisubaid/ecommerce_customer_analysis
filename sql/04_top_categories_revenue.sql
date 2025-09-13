-- What are the top 10 product categories by total revenue?

SELECT
    p.product_category_name as product_categories,
    round(sum(i.price),2) as total_revenue
FROM
    `top-geography-426410-i8.brazilian_ecommerce.products` p
JOIN `top-geography-426410-i8.brazilian_ecommerce.orders_items` i ON p.product_id = i.product_id 
GROUP BY product_categories
ORDER BY total_revenue DESC
LIMIT 10;