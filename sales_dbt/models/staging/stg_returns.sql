
WITH cleaned_data AS (
    SELECT
        {{ convert_date('RETURNDATE') }} AS RETURNDATE,
        {{ cast_int('TERRITORYKEY') }} AS TERRITORYKEY,
        {{ cast_int('PRODUCTKEY') }} AS PRODUCTKEY,
        {{ cast_int('RETURNQUANTITY') }} AS RETURNQUANTITY,
        FILENAME,
        FILELOADTIME,
        -- Assign row numbers to handle duplicates
        ROW_NUMBER() OVER (PARTITION BY RETURNDATE, TERRITORYKEY, PRODUCTKEY ORDER BY FILELOADTIME DESC) AS rn
    FROM {{ source('raw', 'returns') }}
    WHERE 
        {{ convert_date('RETURNDATE') }} IS NOT NULL
        AND {{ cast_int('TERRITORYKEY') }} IS NOT NULL
        AND {{ cast_int('PRODUCTKEY') }} IS NOT NULL
        AND {{ cast_int('RETURNQUANTITY') }} IS NOT NULL
)
-- Select only unique and non-null records
SELECT 
    RETURNDATE, TERRITORYKEY, PRODUCTKEY, RETURNQUANTITY,
    FILENAME, FILELOADTIME
FROM cleaned_data
WHERE rn = 1
ORDER BY RETURNDATE, TERRITORYKEY, PRODUCTKEY