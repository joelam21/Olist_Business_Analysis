WITH reviews AS (
SELECT 
    order_id, max(review_score) review_score, max(review_comment_title) review_comment_title, 
    max(review_comment_message) review_comment_message, max(review_creation_date) review_creation_date, 
    max(review_answer_timestamp) review_answer_timestamp
FROM 
    order_reviews
GROUP BY
    order_id
), 

orders_plus AS (
SELECT 
    o.*, sum(i.price) sales, max(c.customer_unique_id) cust_id, max(c.customer_zip_code_prefix) cust_zip, 
    count(i.price) units, max(r.review_comment_message) review_message, AVG(r.review_score) review_score,
    DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) days_from_est_deliv
FROM 
    orders o
LEFT JOIN 
    order_items i
ON 
    o.order_id = i.order_id
LEFT JOIN 
    reviews r
ON 
    o.order_id = r.order_id
LEFT JOIN 
    customers c 
ON 
    o.customer_id = c.customer_id
GROUP BY 
    o.order_id
),

order_count AS (
SELECT
    cust_id, order_id, 
    order_purchase_timestamp,
    ROW_NUMBER() OVER (PARTITION BY cust_id ORDER BY order_purchase_timestamp) AS order_count,
    DATEDIFF(
        LAG(order_purchase_timestamp) OVER (PARTITION BY cust_id ORDER BY order_purchase_timestamp),
        order_purchase_timestamp
    )*-1 AS days_between_orders
FROM
    orders_plus
ORDER BY
    cust_id, order_purchase_timestamp

), 

orders_final AS (
SELECT 
    o.*, c.order_count, c.days_between_orders
FROM 
    orders_plus o
LEFT JOIN 
    order_count c
ON
    o.cust_id = c.cust_id 
AND 
    o.order_id = c.order_id
ORDER BY
    o.cust_id, o.order_purchase_timestamp
)


SELECT o.*, 
    (CASE 
        WHEN days_from_est_deliv <=0 THEN "on time"
        WHEN days_from_est_deliv IS NULL THEN "NA"
        ELSE "late"
    END
    ) on_time
FROM orders_final o

/*

 # check for duplicates

SELECT order_id, count(*)
FROM orders_final
GROUP BY order_id
HAVING COUNT(*) > 1

*/
