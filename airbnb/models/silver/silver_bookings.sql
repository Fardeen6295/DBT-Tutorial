{{config(
    materialized='incremental',
    unique_key='booking_id' 
)}}

{# The unique key for the incremental model. It ensures UPSERT Operation along with the incremental logic. #}

{% set cols = [
    "booking_id",
    "booking_date",
    "booking_amount",
    "listing_id",
    "nights_booked",
    "cleaning_fee",
    "service_fee",
    "created_at"
] %}


SELECT
{% for col in cols %}
    {{ col }}{% if not loop.last %},{% endif %}
{% endfor %},
    {{ multiply('nights_booked', 'booking_amount', 2) }} AS total_booking_amount,
    UPPER(booking_status) AS booking_status
FROM
    {{ ref("bronze_bookings") }}
{% if is_incremental() %}
    WHERE created_at > ( SELECT MAX(created_at) FROM {{ this }} )
{% endif %}