WITH sales as (
SELECT 
   sales_id,
   product_sk,
   customer_sk,
   gross_amount,
   {{multiply('unit_price', 'quantity') }} as cal_gross_amount,
   payment_method
FROM
    {{ ref("bronze_sales") }}
),
product as (
SELECT 
    product_sk,
    department
FROM
    {{ref("bronze_product")}}
),
customer as (
SELECT
    customer_sk,
    gender,
    loyalty_tier
FROM
    {{ ref('bronze_customer') }}
),
joined_tables as (
SELECT
    s.sales_id,
    s.gross_amount,
    s.payment_method,
    p.department,
    c.gender
FROM
    sales s
    LEFT JOIN customer c
    on  s.customer_sk = c.customer_sk
    LEFT JOIN product p
    on s.product_sk = p.product_sk
)

SELECT
    gender,
    department,
    SUM(gross_amount) as total_sales
FROM
    joined_tables
GROUP BY
    ALL
ORDER BY
    department asc,
    total_sales desc
