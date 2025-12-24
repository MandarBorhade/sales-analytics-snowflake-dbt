
WITH final_fact_returns AS (
    SELECT 
        r.* EXCLUDE (FILENAME, FILELOADTIME),  
        r.FILENAME AS returns_filename,  
        r.FILELOADTIME AS returns_fileloadtime,
        p.* EXCLUDE (PRODUCTKEY, FILENAME, FILELOADTIME),  
        p.FILENAME AS product_filename,
        p.FILELOADTIME AS product_fileloadtime
    FROM {{ ref('int_returns') }} r
    LEFT JOIN {{ ref('dim_products') }} p 
        ON r.PRODUCTKEY = p.PRODUCTKEY
)
SELECT * FROM final_fact_returns
