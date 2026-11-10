WITH dedup_query AS (
SELECT 
*,
ROW_NUMBER() OVER (PARTITION BY p_id ORDER BY updated DESC) AS dedup_rank
FROM
{{source('source','items')}}
)
SELECT 
    p_id, p_name, price, updated  
FROM dedup_query
WHERE dedup_rank = 1