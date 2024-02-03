---ex1
WITH a AS
(SELECT MIN(order_date) AS first_date, customer_id FROM Delivery
GROUP BY customer_id)

SELECT ROUND(SUM(CASE WHEN b.customer_pref_delivery_date=first_date THEN 1 ELSE 0 END)
            /COUNT(DISTINCT b.customer_id)*100, 2) AS immediate_percentage
FROM Delivery b
LEFT JOIN a ON b.customer_id=a.customer_id
