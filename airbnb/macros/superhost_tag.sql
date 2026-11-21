{% macro superhost_tag(is_superhost) %}
     CASE
        WHEN response_rate > 95 THEN "Excellent"
        WHEN response_rate BETWEEN 80 AND 95 THEN "Good"
        ELSE "Needs Improvement"
    END
{% endmacro %}
