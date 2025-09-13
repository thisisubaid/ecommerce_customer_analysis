--What are the top 3 product categories in the state with the highest revenue?

SELECT 
    p.product_category_name,
    sum(i.price) as revenue
FROM `top-geography-426410-i8.brazilian_ecommerce.orders_items` i
JOIN `top-geography-426410-i8.brazilian_ecommerce.products` p ON i.product_id = p.product_id
JOIN `top-geography-426410-i8.brazilian_ecommerce.orders` o ON i.order_id = o.order_id
JOIN `top-geography-426410-i8.brazilian_ecommerce.customers` c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
AND  c.customer_state = 'SP'
group by p.product_category_name
order by revenue desc
limit 3