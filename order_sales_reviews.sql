WITH orders_plus AS (
SELECT o.*, sum(i.price) sales, max(c.customer_unique_id) cust_id, 
    count(i.price) units, max(r.review_comment_message) review_message, AVG(r.review_score) review_score, 
    DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) days_from_est_deliv
FROM orders o
LEFT JOIN order_items i
ON o.order_id = i.order_id
LEFT JOIN order_reviews r
ON o.order_id = r.order_id
LEFT JOIN customers c 
ON o.customer_id = c.customer_id
GROUP BY o.order_id
)

SELECT o.*, 
    (CASE 
        WHEN days_from_est_deliv <=0 THEN "on time"
        WHEN days_from_est_deliv IS NULL THEN "NA"
        ELSE "late"
    END
    ) on_time
FROM orders_plus o