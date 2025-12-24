WITH final_fact_sales AS (
    SELECT 
        s.* EXCLUDE (FILENAME, FILELOADTIME),  
        s.FILENAME AS sales_filename,  
        s.FILELOADTIME AS sales_fileloadtime,
        p.* EXCLUDE (PRODUCTKEY, FILENAME, FILELOADTIME),  
        p.FILENAME AS product_filename,
        p.FILELOADTIME AS product_fileloadtime,
        c.* EXCLUDE (CUSTOMERKEY, FILENAME, FILELOADTIME),  
        c.FILENAME AS customer_filename,
        c.FILELOADTIME AS customer_fileloadtime
    FROM {{ ref('int_sales') }} s
    LEFT JOIN {{ ref('dim_products') }} p 
        ON s.PRODUCTKEY = p.PRODUCTKEY
    LEFT JOIN {{ ref('dim_customers') }} c 
        ON s.CUSTOMERKEY = c.CUSTOMERKEY
)
SELECT * FROM final_fact_sales