
{% macro cast_int(column) %}
    TRY_CAST(NULLIF(TRIM({{ column }}), '') AS INT)
{% endmacro %}
