/*
PURPOSE:
Create Data Warehouse with Bronze layer and load CSV files safely

NOTE:
- All columns in Bronze are NVARCHAR (to avoid BULK INSERT errors)
- Data type conversion will be done in Silver layer
*/

/*
 CREATE DATABASE
*/

USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWareHouse')
BEGIN
    ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWareHouse;
END
GO

CREATE DATABASE DataWareHouse;
GO

USE DataWareHouse;
GO

/*
 CREATE schema
*/

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO

/*
 CREATE bronze tables
*/

CREATE TABLE bronze.crm_cust_info(
    cst_id NVARCHAR(50),
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date NVARCHAR(50)
);
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id NVARCHAR(50),
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(100),
    prd_cost NVARCHAR(50),
    prd_line NVARCHAR(10),
    prd_start_dt NVARCHAR(50),
    prd_end_dt NVARCHAR(50)
);
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id NVARCHAR(50),
    sls_order_dt NVARCHAR(50),
    sls_ship_dt NVARCHAR(50),
    sls_due_dt NVARCHAR(50),
    sls_sales NVARCHAR(50),
    sls_quantity NVARCHAR(50),
    sls_price NVARCHAR(50)
);
GO

CREATE TABLE bronze.erp_cust_az12 (
    CID NVARCHAR(50),
    BDATE NVARCHAR(50),
    GEN NVARCHAR(50)
);
GO

CREATE TABLE bronze.erp_loc_a101 (
    CID NVARCHAR(50),
    CNTRY NVARCHAR(50)
);
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    ID NVARCHAR(50),
    CAT NVARCHAR(50),
    SUBCAT NVARCHAR(50),
    MAINTENANCE NVARCHAR(50)
);
GO

/*
bulk insert
*/
-- CRM CUSTOMER
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN

-- CRM CUSTOMER
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\VIDHI\OneDrive\Desktop\datawarehouse\Datasets\sources_crm\cust_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

-- CRM PRODUCT
BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\VIDHI\OneDrive\Desktop\datawarehouse\Datasets\sources_crm\prd_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

-- SALES
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\VIDHI\OneDrive\Desktop\datawarehouse\Datasets\sources_crm\sales_details.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    MAXERRORS = 1000,
    TABLOCK
);

-- ERP CUSTOMER
BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\VIDHI\OneDrive\Desktop\datawarehouse\Datasets\sources_erp\CUST_AZ12.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

-- ERP LOCATION
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\VIDHI\OneDrive\Desktop\datawarehouse\Datasets\sources_erp\LOC_A101.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

-- ERP CATEGORY
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'C:\Users\VIDHI\OneDrive\Desktop\datawarehouse\Datasets\sources_erp\PX_CAT_G1V2.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

END;
GO

SELECT TOP 10 * FROM bronze.crm_cust_info;
SELECT TOP 10 * FROM bronze.crm_prd_info;
SELECT TOP 10 * FROM bronze.crm_sales_details;
SELECT TOP 10 * FROM bronze.erp_cust_az12;
SELECT TOP 10 * FROM bronze.erp_loc_a101;
SELECT TOP 10 * FROM bronze.erp_px_cat_g1v2;
GO
