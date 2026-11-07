SELECT 
    *
FROM 
    {{ref("bronze_sales")}}
WHERE 
    gross_amount < 0 or net_amount < 0