
WITH cleaned_data AS (
    SELECT
        {{ cast_int('PRODUCTKEY') }} AS PRODUCTKEY,
        {{ cast_int('PRODUCTSUBCATEGORYKEY') }} AS PRODUCTSUBCATEGORYKEY,
        {{ clean_string('PRODUCTSKU') }} AS PRODUCTSKU,
        {{ clean_string('PRODUCTNAME') }} AS PRODUCTNAME,
        {{ clean_string('MODELNAME') }} AS MODELNAME,
        {{ clean_string('PRODUCTDESCRIPTION') }} AS PRODUCTDESCRIPTION,
        {{ clean_string('PRODUCTCOLOR') }} AS PRODUCTCOLOR,
        {{ clean_string('PRODUCTSIZE') }} AS PRODUCTSIZE,
        {{ clean_string('PRODUCTSTYLE') }} AS PRODUCTSTYLE,
        {{ cast_float('PRODUCTCOST') }} AS PRODUCTCOST,
        {{ cast_float('PRODUCTPRICE') }} AS PRODUCTPRICE,
        FILENAME, 
        FILELOADTIME,
        -- Assign row numbers to handle duplicates
        ROW_NUMBER() OVER (PARTITION BY PRODUCTKEY ORDER BY FILELOADTIME DESC) AS rn
    FROM {{ source('raw', 'products') }}
    WHERE {{ cast_int('PRODUCTKEY') }} IS NOT NULL
)
-- Select only unique and non-null PRODUCTKEY records
SELECT 
    PRODUCTKEY, PRODUCTSUBCATEGORYKEY, PRODUCTSKU, PRODUCTNAME, MODELNAME,
    PRODUCTDESCRIPTION, PRODUCTCOLOR, PRODUCTSIZE, PRODUCTSTYLE, PRODUCTCOST, PRODUCTPRICE,
    FILENAME, FILELOADTIME
FROM cleaned_data
WHERE rn = 1
ORDER BY PRODUCTKEY