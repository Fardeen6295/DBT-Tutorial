{# SELECT 
* 
FROM 
dbt_tut_dev.source.fact_sales #}

SELECT
    *
FROM
    {{ source('source', 'fact_sales') }}