
WITH cleaned_data AS (
    SELECT
        {{ cast_int('CUSTOMERKEY') }} AS CUSTOMERKEY,
        {{ clean_string('PREFIX') }} AS PREFIX,
        {{ clean_string('FIRSTNAME') }} AS FIRSTNAME,
        {{ clean_string('LASTNAME') }} AS LASTNAME,
        {{ convert_date('BIRTHDATE') }} AS BIRTHDATE,
        {{ clean_string('MARITALSTATUS') }} AS MARITALSTATUS,
        {{ clean_string('GENDER') }} AS GENDER,
        {{ clean_string('EMAILADDRESS') }} AS EMAILADDRESS,
        {{ cast_float('ANNUALINCOME') }} AS ANNUALINCOME,
        {{ cast_int('TOTALCHILDREN') }} AS TOTALCHILDREN,
        {{ clean_string('EDUCATIONLEVEL') }} AS EDUCATIONLEVEL,
        {{ clean_string('OCCUPATION') }} AS OCCUPATION,
        {{ clean_string('HOMEOWNER') }} AS HOMEOWNER,
        FILENAME, FILELOADTIME,
        -- Assign row numbers to handle duplicates
        ROW_NUMBER() OVER (PARTITION BY CUSTOMERKEY ORDER BY FILELOADTIME DESC) AS rn

    FROM {{ source('raw', 'customers') }}
    WHERE {{ cast_int('CUSTOMERKEY') }} IS NOT NULL
)
-- Select only unique and non null CUSTOMERKEY records
SELECT 
CUSTOMERKEY, PREFIX, FIRSTNAME, LASTNAME, BIRTHDATE, MARITALSTATUS, GENDER,
EMAILADDRESS, ANNUALINCOME, TOTALCHILDREN, EDUCATIONLEVEL, OCCUPATION, HOMEOWNER,
FILENAME, FILELOADTIME
FROM cleaned_data
WHERE rn = 1
ORDER BY CUSTOMERKEY