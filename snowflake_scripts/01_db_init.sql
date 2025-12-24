USE ROLE ACCOUNTADMIN;

-- Define variables (replace with your actual values)
SET role_name = 'dbt_developer';
SET user_name = 'POOMA';
SET warehouse_name = 'load_wh';
SET database_name = 'sales';
SET schema_name = $database_name || '.' || 'raw';
SET stage_name = $schema_name || '.' || 'uploads';

-- Create role for dbt developers
CREATE ROLE IF NOT EXISTS IDENTIFIER($role_name);

-- Assign role to user
GRANT ROLE IDENTIFIER($role_name) TO USER IDENTIFIER($user_name);
ALTER USER IDENTIFIER($user_name) SET DEFAULT_ROLE = $role_name;

-- Create warehouse
CREATE WAREHOUSE IF NOT EXISTS IDENTIFIER($warehouse_name);

-- Grant access to warehouse
GRANT USAGE ON WAREHOUSE IDENTIFIER($warehouse_name) TO ROLE IDENTIFIER($role_name);

-- Create database
CREATE DATABASE IF NOT EXISTS IDENTIFIER($database_name);

-- Grant access to database
GRANT USAGE ON DATABASE IDENTIFIER($database_name) TO ROLE IDENTIFIER($role_name);
GRANT USAGE, CREATE SCHEMA ON DATABASE IDENTIFIER($database_name) TO ROLE IDENTIFIER($role_name);

-- Create schema
CREATE SCHEMA IF NOT EXISTS IDENTIFIER($schema_name);

-- Grant schema privileges
GRANT USAGE ON SCHEMA IDENTIFIER($schema_name) TO ROLE IDENTIFIER($role_name);
GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE 
ON SCHEMA IDENTIFIER($schema_name) TO ROLE IDENTIFIER($role_name);

-- Grant DML privileges on tables
GRANT SELECT, INSERT, UPDATE, DELETE 
ON ALL TABLES IN SCHEMA IDENTIFIER($schema_name) 
TO ROLE IDENTIFIER($role_name);
GRANT SELECT, INSERT, UPDATE, DELETE 
ON FUTURE TABLES IN SCHEMA IDENTIFIER($schema_name) 
TO ROLE IDENTIFIER($role_name);

-- Grant ownership of objects in the schema
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA IDENTIFIER($schema_name) TO ROLE IDENTIFIER($role_name);

-- Create a stage
CREATE STAGE IF NOT EXISTS IDENTIFIER($stage_name);

-- Give stage permissions
GRANT ALL PRIVILEGES ON STAGE IDENTIFIER($stage_name) TO ROLE IDENTIFIER($role_name);

-- Grant File Format Creation Permission
GRANT CREATE FILE FORMAT ON SCHEMA IDENTIFIER($schema_name) TO ROLE IDENTIFIER($role_name);


