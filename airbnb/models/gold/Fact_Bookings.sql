{% set configs = [
    {
        "table_name": "airbnb.gold.bookings_obt_1",
        "columns": "obt.booking_id, obt.booking_date, obt.booking_amount, obt.listing_id, obt.nights_booked, obt.cleaning_fee, obt.service_fee, obt.total_booking_amount, obt.booking_status, obt.accommodates, obt.bedrooms, obt.bathrooms, obt.price_per_night, obt.host_id, obt.response_rate, obt.created_at",
        "alias" : "obt"
    }
] %}

{% set cfg = configs[0] %}

SELECT
    {{ cfg['columns'] }}
FROM
    {{ cfg['table_name'] }} AS {{ cfg['alias'] }} 