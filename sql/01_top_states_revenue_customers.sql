--What are the top 10 states by total revenue and total number of customers?

--Only delivered orders are considered for accurate sales data.

SELECT
    c.customer_state,
    round(sum(i.price), 2) as total_revenue,
    count(distinct c.customer_id) as total_customers
FROM
    `top-geography-426410-i8.brazilian_ecommerce.orders` o
JOIN `top-geography-426410-i8.brazilian_ecommerce.customers` c ON o.customer_id = c.customer_id
JOIN `top-geography-426410-i8.brazilian_ecommerce.orders_items` i ON o.order_id = i.order_id
WHERE
    o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_revenue DESC