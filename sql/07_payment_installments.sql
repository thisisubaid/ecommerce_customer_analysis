--What is the distribution of payment installments? (e.g., how many people pay in 1x vs. 4x?).

SELECT
    payment_installments,
    COUNT(*) AS payment_count
FROM
    `top-geography-426410-i8.brazilian_ecommerce.payments`
WHERE 
    payment_installments > 0
GROUP BY
    payment_installments
ORDER BY
    payment_installments;