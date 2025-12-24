WITH enriched_sales AS (
SELECT 
    *
FROM {{source('staging', 'stg_sales')}} s
LEFT JOIN {{source('raw', 'AW_TERRITORY_LOOKUP')}} t 
    ON s.TERRITORYKEY = t.SALESTERRITORYKEY
)
select * from enriched_sales