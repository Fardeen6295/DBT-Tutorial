{{config(
    materialized='incremental',
    unique_key='host_id'
)}}

{% set cols = [
    "host_id",
    "host_name",
    "host_since",
    "response_rate",
    "created_at"
] %}

SELECT
{% for col in cols %}
    {{ col }}{% if not loop.last %},{% endif %}
{% endfor %},
    UPPER(is_superhost) AS is_superhost,
    {{ superhost_tag('is_superhost') }} AS superhost_tag
FROM
    {{ ref("bronze_hosts") }}
{% if is_incremental() %}
    WHERE created_at > ( SELECT MAX(created_at) FROM {{ this }} )
{% endif %}