

WITH cleaned_data AS (
    SELECT
        {{ convert_date('ORDERDATE') }} AS ORDERDATE,
        {{ convert_date('STOCKDATE') }} AS STOCKDATE,
        {{ clean_string('ORDERNUMBER') }} AS ORDERNUMBER,
        {{ cast_int('PRODUCTKEY') }} AS PRODUCTKEY,
        {{ cast_int('CUSTOMERKEY') }} AS CUSTOMERKEY,
        {{ cast_int('TERRITORYKEY') }} AS TERRITORYKEY,
        {{ cast_int('ORDERLINEITEM') }} AS ORDERLINEITEM,
        {{ cast_int('ORDERQUANTITY') }} AS ORDERQUANTITY,
        FILENAME, FILELOADTIME,
        -- Assign row number to remove duplicates
        ROW_NUMBER() OVER (PARTITION BY ORDERNUMBER, ORDERLINEITEM ORDER BY FILELOADTIME DESC) AS rn
    FROM {{ source('raw', 'sales') }}
    WHERE 
        ORDERNUMBER IS NOT NULL
        AND ORDERLINEITEM IS NOT NULL
        AND {{ cast_int('PRODUCTKEY') }} IS NOT NULL
        AND {{ cast_int('CUSTOMERKEY') }} IS NOT NULL
)
-- Remove duplicates and ensure unique records
SELECT 
    ORDERDATE, STOCKDATE, ORDERNUMBER, PRODUCTKEY, CUSTOMERKEY, TERRITORYKEY, 
    ORDERLINEITEM, ORDERQUANTITY, FILENAME, FILELOADTIME
FROM cleaned_data
WHERE rn = 1
ORDER BY ORDERNUMBER, ORDERLINEITEM
