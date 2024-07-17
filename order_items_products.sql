WITH product_translated AS (
    SELECT p.product_id, t.product_category_name_english category 
    FROM products p
    LEFT JOIN cat_translation t 
    ON p.product_category_name = t.product_category_name
), 

sales AS (
SELECT i.*, c.category, c.subcategory, o.customer_id, i.price sales
FROM order_items i
LEFT JOIN product_translated p
ON i.product_id = p.product_id
LEFT JOIN orders o
ON o.order_id = i.order_id
LEFT JOIN categories c 
ON p.category = c.subcategory
), 

SalesBySeller AS (
    SELECT
        seller_id,
        SUM(sales) AS total_sales
    FROM
        sales
    GROUP BY
        seller_id
),
RankedSales AS (
    SELECT
        seller_id,
        total_sales,
        SUM(total_sales) OVER (ORDER BY total_sales DESC) AS cumulative_sales,
        SUM(total_sales) OVER () AS total_sales_sum
    FROM
        SalesBySeller
),
PercentileSales AS (
    SELECT
        seller_id,
        total_sales,
        cumulative_sales,
        (cumulative_sales / total_sales_sum) * 100 AS cumulative_sales_percentage
    FROM
        RankedSales
), 
PercentileCategories AS (
SELECT
    seller_id,
    total_sales,
    cumulative_sales,
    cumulative_sales_percentage,
    CASE
        WHEN cumulative_sales_percentage <= 10 THEN 'Top 10%'
        WHEN cumulative_sales_percentage <= 20 THEN 'Top 20%'
        WHEN cumulative_sales_percentage <= 30 THEN 'Top 30%'
        WHEN cumulative_sales_percentage <= 40 THEN 'Top 40%'
        WHEN cumulative_sales_percentage <= 50 THEN 'Top 50%'
        WHEN cumulative_sales_percentage <= 60 THEN 'Top 60%'
        WHEN cumulative_sales_percentage <= 70 THEN 'Top 70%'
        WHEN cumulative_sales_percentage <= 80 THEN 'Top 80%'
        WHEN cumulative_sales_percentage <= 90 THEN 'Top 90%'
        ELSE 'Top 100%'
    END AS percentile
FROM
    PercentileSales
ORDER BY
    cumulative_sales_percentage
)

SELECT s.*, pc.percentile
FROM sales s
LEFT JOIN PercentileCategories pc
ON s.seller_id = pc.seller_id