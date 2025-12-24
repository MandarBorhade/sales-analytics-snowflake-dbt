
{% macro cast_float(column) %}
    TRY_CAST(NULLIF(TRIM({{ column }}), '') AS FLOAT)
{% endmacro %}
