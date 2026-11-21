{{
  config(
    materialized = 'ephemeral'
    )
}}

WITH listings AS (
    SELECT
        listing_id,
        accommodates,
        bedrooms,
        bathrooms,
        price_per_night,
        price_tag,
        room_tag,
        room_type,
        property_type,
        city,
        country,
        listing_created_at
    FROM
    {{ ref('BOOKINGS_OBT_1') }}
)
SELECT * FROM listings