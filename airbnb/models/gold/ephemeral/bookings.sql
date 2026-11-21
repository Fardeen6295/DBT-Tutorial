{{
  config(
    materialized = 'ephemeral'
    )
}}

WITH bookings AS (
    SELECT 
        booking_id,
        booking_date,
        booking_status,
        created_at
    FROM
        {{ ref('BOOKINGS_OBT_1') }}
)
SELECT * FROM bookings