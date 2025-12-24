
-- Define variables (replace with your actual values)
SET role_name = 'dbt_developer'; -- the one you have already created
SET warehouse_name = 'load_wh';  -- the one you have already created
SET database_name = 'sales';  -- the one you have already created
SET schema_name = $database_name || '.' || 'raw';  -- the one you have already created



-- Use the appropriate role
USE ROLE IDENTIFIER($role_name);
USE WAREHOUSE IDENTIFIER($warehouse_name);
USE DATABASE IDENTIFIER($database_name);
USE SCHEMA IDENTIFIER($schema_name);

-----------------------------------------------------
-- 🚀 Step 1: Create Landing Tables
-----------------------------------------------------
SET customers = $schema_name || '.' || 'customers'; -- name of landind customers table
SET products = $schema_name || '.' || 'products'; -- name of landing products table
SET sales = $schema_name || '.' || 'sales'; -- name of landing sales table
SET returns = $schema_name || '.' || 'returns'; -- name of landing returns table



-- Customers Table
CREATE OR REPLACE TABLE IDENTIFIER($customers) (
    CustomerKey STRING, Prefix STRING, FirstName STRING, LastName STRING, 
    BirthDate STRING, MaritalStatus STRING, Gender STRING, EmailAddress STRING, 
    AnnualIncome STRING, TotalChildren STRING, EducationLevel STRING, Occupation STRING, 
    HomeOwner STRING, Filename STRING,       
    Fileloadtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- Products Table
CREATE OR REPLACE TABLE IDENTIFIER($products) (
    ProductKey STRING, ProductSubcategoryKey STRING, ProductSKU STRING, ProductName STRING, 
    ModelName STRING, ProductDescription STRING, ProductColor STRING, ProductSize STRING, 
    ProductStyle STRING, ProductCost STRING, ProductPrice STRING, Filename STRING,       
    Fileloadtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- Sales Table
CREATE OR REPLACE TABLE IDENTIFIER($sales) (
    OrderDate STRING, StockDate STRING, OrderNumber STRING, ProductKey STRING, 
    CustomerKey STRING, TerritoryKey STRING, OrderLineItem STRING, OrderQuantity STRING, 
    Filename STRING, Fileloadtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- Returns Table
CREATE OR REPLACE TABLE IDENTIFIER($returns) (
    ReturnDate STRING, TerritoryKey STRING, ProductKey STRING, ReturnQuantity STRING, 
    Filename STRING, Fileloadtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-----------------------------------------------------
-- 🚀 Step 3: Verify Tables
-----------------------------------------------------
-- DESC TABLE IDENTIFIER($customers);
-- DESC TABLE IDENTIFIER($products);
-- DESC TABLE IDENTIFIER($sales);
-- DESC TABLE IDENTIFIER($returns);