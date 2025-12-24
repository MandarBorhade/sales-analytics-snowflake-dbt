

-- Define variables (replace with your actual values)



SET role_name = 'dbt_developer'; -- the one you have already created
SET warehouse_name = 'load_wh'; -- the one you have already created
SET database_name = 'sales'; -- the one you have already created
SET schema_name = 'raw'; -- the one you have already created
SET stage_name = 'uploads'; -- please note you have to manually add this below as it cannot be used as a variable
SET file_format = $schema_name || '.' || 'csv_format_iso88591';

-- Use the appropriate role
USE ROLE IDENTIFIER($role_name);
USE WAREHOUSE IDENTIFIER($warehouse_name);
USE DATABASE IDENTIFIER($database_name);
USE SCHEMA IDENTIFIER($schema_name);


CREATE FILE FORMAT IF NOT EXISTS IDENTIFIER($file_format)
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    NULL_IF = ('NULL', '')
    ENCODING = 'ISO8859-1';


SET customers = $schema_name || '.' || 'customers';
SET products = $schema_name || '.' || 'products';
SET sales = $schema_name || '.' || 'sales';
SET returns = $schema_name || '.' || 'returns';


COPY INTO IDENTIFIER($customers)
FROM (
    SELECT t.$1, t.$2, t.$3, t.$4, t.$5, t.$6, t.$7, t.$8, t.$9, t.$10, 
           t.$11, t.$12, t.$13, METADATA$FILENAME, CURRENT_TIMESTAMP()
    FROM @uploads (FILE_FORMAT => IDENTIFIER($file_format), PATTERN => '.*(?i)customer_lookup.*\.csv') t
) ON_ERROR = 'CONTINUE';

COPY INTO IDENTIFIER($products)
FROM (
    SELECT t.$1, t.$2, t.$3, t.$4, t.$5, t.$6, t.$7, t.$8, t.$9, t.$10, 
           t.$11, METADATA$FILENAME, CURRENT_TIMESTAMP()
    FROM @uploads (FILE_FORMAT => IDENTIFIER($file_format), PATTERN => '.*(?i)product_lookup.*\.csv') t
) ON_ERROR = 'CONTINUE';

COPY INTO IDENTIFIER($sales)
FROM (
    SELECT t.$1, t.$2, t.$3, t.$4, t.$5, t.$6, t.$7, t.$8, 
           METADATA$FILENAME, CURRENT_TIMESTAMP()
    FROM @uploads (FILE_FORMAT => IDENTIFIER($file_format), PATTERN => '.*(?i)sales_data.*\.csv') t
) ON_ERROR = 'CONTINUE';

COPY INTO IDENTIFIER($returns)
FROM (
    SELECT t.$1, t.$2, t.$3, t.$4, METADATA$FILENAME, CURRENT_TIMESTAMP()
    FROM @uploads (FILE_FORMAT => IDENTIFIER($file_format), PATTERN => '.*(?i)returns_data.*\.csv') t
) ON_ERROR = 'CONTINUE';

-----------------------------------------------------
-- Verify Data Load
-----------------------------------------------------
-- SELECT * FROM IDENTIFIER($customers);
-- SELECT * FROM IDENTIFIER($products);
-- SELECT * FROM IDENTIFIER($sales);
-- SELECT * FROM IDENTIFIER($returns);