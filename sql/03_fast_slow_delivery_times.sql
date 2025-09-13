-- Which states have the fastest and slowest average delivery times?

SELECT
    c.customer_state,
    round(AVG(TIMESTAMP_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)), 2) AS avg_delivery_days
FROM `top-geography-426410-i8.brazilian_ecommerce.orders` o
JOIN `top-geography-426410-i8.brazilian_ecommerce.customers` c 
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;
