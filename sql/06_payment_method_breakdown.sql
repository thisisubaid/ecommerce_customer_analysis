--What is the most popular payment method for first-time orders?

SELECT
    payment_type, COUNT(*) AS first_time_orders,
FROM
    `top-geography-426410-i8.brazilian_ecommerce.payments`
Group by payment_type
order by first_time_orders desc
