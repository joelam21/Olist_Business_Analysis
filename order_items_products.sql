WITH product_translated AS (
    SELECT p.product_id, t.product_category_name_english category 
    FROM products p
    LEFT JOIN cat_translation t 
    ON p.product_category_name = t.product_category_name
)

SELECT i.*, c.category, c.subcategory, o.customer_id
FROM order_items i
LEFT JOIN product_translated p
ON i.product_id = p.product_id
LEFT JOIN orders o
ON o.order_id = i.order_id
LEFT JOIN categories c 
ON p.category = c.subcategory
