{{ config(materialized='incremental') }}

SELECT
*
FROM
{{ source('source', 'fact_returns') }}

{% if is_incremental() %}
    WHERE date_sk > (SELECT COALESCE(MAX(date_sk), '1900-01-01') FROM {{ this }})
{% endif %}