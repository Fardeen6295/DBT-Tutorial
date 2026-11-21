{{config(
    materialized='incremental',
    unique_key='listing_id'
    )
}}

{% set cols =[
    'listing_id',
    'host_id',
    'accommodates',
    'bedrooms',
    'bathrooms',
    'price_per_night',
    'created_at'
] %}

SELECT
    {% for col in cols %}
        {{ col }}{% if not loop.last %},{% endif %}
    {% endfor %},
    {{ price_tag('price_per_night') }} As price_tag,
    {{ room_tag('bedrooms') }} AS room_tag,
    UPPER(room_type) AS room_type,
    UPPER(property_type) AS property_type,
    UPPER(city) AS city,
    UPPER(country) AS country
FROM
    {{ ref("bronze_listings") }}
{% if is_incremental() %}
    WHERE created_at > ( SELECT MAX(created_at) FROM {{ this }} )
{% endif %}