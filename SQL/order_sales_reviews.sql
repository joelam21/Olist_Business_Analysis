WITH reviews AS (
    SELECT 
        order_id, 
        MAX(review_score) AS review_score, 
        MAX(review_comment_title) AS review_comment_title, 
        MAX(review_comment_message) AS review_comment_message, 
        MAX(review_creation_date) AS review_creation_date, 
        MAX(review_answer_timestamp) AS review_answer_timestamp
    FROM 
        order_reviews
    GROUP BY
        order_id
), 

orders_plus AS (
    SELECT 
        o.order_id, o.order_status, o.order_purchase_timestamp, o.order_approved_at, 
        o.order_delivered_carrier_date, o.order_delivered_customer_date, 
        o.order_estimated_delivery_date, 
        SUM(i.price) AS sales, 
        COUNT(i.price) AS units, 
        MAX(c.customer_unique_id) AS cust_id, 
        MAX(c.customer_zip_code_prefix) AS cust_zip, 
        MAX(r.review_comment_message) AS review_message, 
        AVG(r.review_score) AS review_score,
        DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date) AS days_from_est_deliv
    FROM 
        orders o
    LEFT JOIN 
        order_items i ON o.order_id = i.order_id
    LEFT JOIN 
        reviews r ON o.order_id = r.order_id
    LEFT JOIN 
        customers c ON o.customer_id = c.customer_id
    GROUP BY 
        o.order_id
),

order_count AS (
    SELECT
        cust_id, 
        order_id, 
        order_purchase_timestamp,
        ROW_NUMBER() OVER (PARTITION BY cust_id ORDER BY order_purchase_timestamp) AS order_count,
        DATEDIFF(
            LAG(order_purchase_timestamp) OVER (PARTITION BY cust_id ORDER BY order_purchase_timestamp),
            order_purchase_timestamp
        ) * -1 AS days_between_orders
    FROM
        orders_plus
),

orders_final AS (
    SELECT 
        o.*, 
        c.order_count, 
        c.days_between_orders
    FROM 
        orders_plus o
    LEFT JOIN 
        order_count c ON o.cust_id = c.cust_id AND o.order_id = c.order_id
)

SELECT 
    o.*, 
    CASE 
        WHEN days_from_est_deliv <= 0 THEN 'on time'
        WHEN days_from_est_deliv IS NULL THEN 'NA'
        ELSE 'late'
    END AS on_time
FROM 
    orders_final o;
