{{config(materialized='view')}}

SELECT 
    * 
FROM 
    {{source('source', 'dim_customer')}}