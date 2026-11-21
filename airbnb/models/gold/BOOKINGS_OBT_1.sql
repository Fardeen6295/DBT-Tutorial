{% set configs = [
    {
        "table_name": "airbnb.silver.silver_bookings",
        "cols": "silver_bookings.*",
        "alias": "silver_bookings"
    },
    {
        "table_name": "airbnb.silver.silver_listings",
        "cols": "silver_listings.accommodates, silver_listings.bedrooms, silver_listings.bathrooms, silver_listings.price_per_night, silver_listings.price_tag, silver_listings.room_tag, silver_listings.room_type, silver_listings.property_type, silver_listings.city, silver_listings.country, silver_listings.created_at AS listing_created_at, silver_listings.host_id",
        "alias": "silver_listings",
        "join_condition": "silver_bookings.listing_id = silver_listings.listing_id"
    },
    {
        "table_name": "airbnb.silver.silver_hosts",
        "cols": "silver_hosts.host_name, silver_hosts.host_since, silver_hosts.response_rate, silver_hosts.is_superhost, silver_hosts.superhost_tag, silver_hosts.created_at AS host_created_at",
        "alias": "silver_hosts",
        "join_condition": "silver_listings.host_id = silver_hosts.host_id"
    }
] %}

SELECT
    {% for config in configs %}
        {{ config.cols }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM
    {% for config in configs %}
        {% if loop.first %}
            {{ config.table_name }} AS {{ config.alias }}
        {% else %}
LEFT JOIN   {{ config.table_name }} AS {{ config.alias }}
ON          {{ config.join_condition }}
        {% endif %}
    {% endfor %}