-- What are the top 10 states by average order value (AOV)?

SELECT 
    c.customer_state, 
    round(AVG(i.price),2) AS avg_order_value
FROM `top-geography-426410-i8.brazilian_ecommerce.orders` o
JOIN `top-geography-426410-i8.brazilian_ecommerce.customers` c ON o.customer_id = c.customer_id
JOIN `top-geography-426410-i8.brazilian_ecommerce.orders_items` i ON o.order_id = i.order_id
WHERE
    o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY avg_order_value DESC
LIMIT 10