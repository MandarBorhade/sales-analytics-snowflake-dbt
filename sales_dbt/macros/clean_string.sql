-- Macro to clean strings (trim and remove empty values)
{% macro clean_string(column) %}
    NULLIF(TRIM({{ column }}), '')
{% endmacro %}