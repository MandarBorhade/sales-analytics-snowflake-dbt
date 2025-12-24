
WITH dim_products AS (
    SELECT *
    FROM {{ source('staging', 'stg_products') }}
),

subcategories AS (
    SELECT *
    FROM {{ source('raw','AW_PRODUCT_SUBCATEGORIES_LOOKUP') }}
),

categories AS (
    SELECT *
    FROM {{ source('raw','AW_PRODUCT_CATEGORIES_LOOKUP') }}
)

SELECT
    p.*,
    s.* EXCLUDE (PRODUCTSUBCATEGORYKEY),  
    c.* EXCLUDE (PRODUCTCATEGORYKEY)
FROM dim_products p
LEFT JOIN subcategories s ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
LEFT JOIN categories c ON s.ProductCategoryKey = c.ProductCategoryKey
