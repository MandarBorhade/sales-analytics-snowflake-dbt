with cleaned_data as (
    select 
        {{ cast_int('SALESTERRITORYKEY') }} as SALESTERRITORYKEY,
        {{ clean_string('REGION') }} as REGION,
        {{ clean_string('COUNTRY') }} as COUNTRY,
        {{ clean_string('CONTINENT') }} as CONTINENT
    FROM {{ source('raw', 'AW_TERRITORY_LOOKUP') }}
    WHERE SALESTERRITORYKEY IS NOT NULL
)

SELECT SALESTERRITORYKEY, REGION, COUNTRY, CONTINENT
FROM cleaned_data
ORDER BY SALESTERRITORYKEY 