WITH enriched_data AS (
SELECT 
    CUSTOMERKEY, 
    PREFIX, 
    FIRSTNAME, 
    LASTNAME, 
    BIRTHDATE, 
    FLOOR(DATEDIFF('day', BIRTHDATE, CURRENT_DATE()) / 365) AS age,
    MARITALSTATUS, 
    GENDER, 
    EMAILADDRESS, 
    SPLIT_PART(EMAILADDRESS, '@', 2) AS EMAIL_DOMAIN,
    ANNUALINCOME, 
    CASE 
        WHEN ANNUALINCOME < 30000 THEN 'Low'
        WHEN ANNUALINCOME BETWEEN 30000 AND 80000 THEN 'Medium'
        ELSE 'High' 
    END AS INCOME_GROUP,
    TOTALCHILDREN, 
    EDUCATIONLEVEL, 
    OCCUPATION, 
    HOMEOWNER, 
    CONCAT(FIRSTNAME, ' ', LASTNAME) AS FULL_NAME,
    FILENAME, 
    FILELOADTIME 
FROM {{ source('staging','stg_customers') }}

)
select * from enriched_data


-- Possible enrichment:
-- Age Calculation (from BIRTHDATE)
-- Income Group (e.g., Low, Medium, High)
-- Full Name (CONCAT(FIRSTNAME, ' ', LASTNAME))
-- Email Domain (Extract domain from EMAILADDRESS)