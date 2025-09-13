--What are the top 10 product categories by average order value (AOV)?

SELECT
    p.product_category_name as product_categories,
    round(AVG(i.price),2) as avg_order_value
FROM
    `top-geography-426410-i8.brazilian_ecommerce.products` p
JOIN `top-geography-426410-i8.brazilian_ecommerce.orders_items` i ON p.product_id = i.product_id 
group by product_categories
order by avg_order_value desc
limit 10;
