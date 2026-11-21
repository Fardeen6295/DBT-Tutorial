{{
  config(
    materialized = 'ephemeral',
    )
}}

WITH hosts AS (
    SELECT
        host_id,
        host_name,
        host_since,
        response_rate,
        is_superhost,
        superhost_tag,
        host_created_at
    FROM
    {{ ref('BOOKINGS_OBT_1') }}
)
SELECT * FROM hosts