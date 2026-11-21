{% macro room_tag(bedrooms) %}
    CASE
        WHEN {{bedrooms}} = 1 THEN "Single"
        WHEN {{bedrooms}} = 2 THEN "Double"
        WHEN {{bedrooms}} = 3 THEN "Triple"
        ELSE "Family"
    END
{% endmacro %}