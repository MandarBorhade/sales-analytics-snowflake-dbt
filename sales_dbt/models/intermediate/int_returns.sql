WITH enriched_returns AS (
SELECT 
    *
FROM {{source('staging','stg_returns')}} r
LEFT JOIN {{source('raw','AW_TERRITORY_LOOKUP')}} t 
    ON r.TERRITORYKEY = t.SALESTERRITORYKEY
)
select * from enriched_returns