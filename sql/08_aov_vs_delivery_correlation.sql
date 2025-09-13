--Is there a correlation between a state's average order value and its average delivery time? (Do high-value states suffer from slow delivery?).

SELECT 
    c.customer_state,
    AVG(TIMESTAMP_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)) AS avg_delivery_time,
    round(AVG(i.price),2) AS avg_order_value
FROM `top-geography-426410-i8.brazilian_ecommerce.orders` o
JOIN `top-geography-426410-i8.brazilian_ecommerce.customers` c ON o.customer_id = c.customer_id
JOIN `top-geography-426410-i8.brazilian_ecommerce.orders_items` i ON o.order_id = i.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY avg_delivery_time DESC, avg_order_value DESC;