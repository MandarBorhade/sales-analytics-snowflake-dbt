-- Macro to convert date values safely
{% macro convert_date(column) %}
    CASE
        -- Convert DD/MM/YYYY to YYYY-MM-DD
        WHEN TRY_TO_DATE({{ column }}, 'DD/MM/YYYY') IS NOT NULL 
        THEN TRY_TO_DATE({{ column }}, 'DD/MM/YYYY')

        -- Convert MM/DD/YYYY to YYYY-MM-DD (if applicable in your data)
        WHEN TRY_TO_DATE({{ column }}, 'MM/DD/YYYY') IS NOT NULL 
        THEN TRY_TO_DATE({{ column }}, 'MM/DD/YYYY')

        -- Keep YYYY-MM-DD format as is
        ELSE TRY_TO_DATE({{ column }}, 'YYYY-MM-DD')
    END
{% endmacro %}