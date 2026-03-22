/*
PURPOSE:
Clean and transform all Bronze tables into Silver layer
*/

USE DataWareHouse;
GO

-- =========================
-- DROP OLD SILVER TABLES
-- =========================

IF OBJECT_ID('silver.crm_customer', 'U') IS NOT NULL DROP TABLE silver.crm_customer;
IF OBJECT_ID('silver.crm_product', 'U') IS NOT NULL DROP TABLE silver.crm_product;
IF OBJECT_ID('silver.crm_sales', 'U') IS NOT NULL DROP TABLE silver.crm_sales;
IF OBJECT_ID('silver.erp_customer', 'U') IS NOT NULL DROP TABLE silver.erp_customer;
IF OBJECT_ID('silver.erp_location', 'U') IS NOT NULL DROP TABLE silver.erp_location;
IF OBJECT_ID('silver.erp_category', 'U') IS NOT NULL DROP TABLE silver.erp_category;
GO

-- =========================
-- CUSTOMER CLEANING
-- =========================

SELECT
    TRY_CAST(cst_id AS INT) AS cst_id,
    cst_key,

    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,

    cst_material_status,

    CASE 
        WHEN cst_gndr = 'F' THEN 'Female'
        WHEN cst_gndr = 'M' THEN 'Male'
        ELSE 'Unknown'
    END AS cst_gndr,

    TRY_CONVERT(DATE, cst_create_date) AS cst_create_date

INTO silver.crm_customer

FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY cst_id 
               ORDER BY TRY_CONVERT(DATE, cst_create_date) DESC
           ) AS rn
    FROM bronze.crm_cust_info
) t
WHERE rn = 1;
GO

-- =========================
-- PRODUCT CLEANING
-- =========================

SELECT
    TRY_CAST(prd_id AS INT) AS prd_id,
    prd_key,

    TRIM(prd_nm) AS prd_nm,

    TRY_CAST(prd_cost AS DECIMAL(10,2)) AS prd_cost,

    prd_line,

    TRY_CONVERT(DATE, prd_start_dt) AS prd_start_dt,
    TRY_CONVERT(DATE, prd_end_dt) AS prd_end_dt

INTO silver.crm_product

FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY prd_id 
               ORDER BY prd_start_dt DESC
           ) AS rn
    FROM bronze.crm_prd_info
) t
WHERE rn = 1;
GO

-- =========================
-- SALES CLEANING
-- =========================

SELECT
    sls_ord_num,
    sls_prd_key,

    TRY_CAST(sls_cust_id AS INT) AS sls_cust_id,

    TRY_CONVERT(DATE, sls_order_dt, 112) AS order_dt,
    TRY_CONVERT(DATE, sls_ship_dt, 112) AS ship_dt,
    TRY_CONVERT(DATE, sls_due_dt, 112) AS due_dt,

    TRY_CAST(sls_sales AS DECIMAL(10,2)) AS sales,
    TRY_CAST(sls_quantity AS INT) AS quantity,
    TRY_CAST(sls_price AS DECIMAL(10,2)) AS price

INTO silver.crm_sales

FROM bronze.crm_sales_details;
GO

-- =========================
-- ERP CUSTOMER CLEANING
-- =========================

SELECT
    CID,
    TRY_CONVERT(DATE, BDATE) AS birth_date,

    CASE 
        WHEN GEN = 'Male' THEN 'Male'
        WHEN GEN = 'Female' THEN 'Female'
        ELSE 'Unknown'
    END AS gender

INTO silver.erp_customer

FROM bronze.erp_cust_az12;
GO

-- =========================
-- ERP LOCATION CLEANING
-- =========================

SELECT
    CID,
    TRIM(CNTRY) AS country

INTO silver.erp_location

FROM bronze.erp_loc_a101;
GO

-- =========================
-- ERP CATEGORY CLEANING
-- =========================

SELECT
    ID,
    TRIM(CAT) AS category,
    TRIM(SUBCAT) AS subcategory,

    CASE 
        WHEN MAINTENANCE = 'Yes' THEN 1
        WHEN MAINTENANCE = 'No' THEN 0
        ELSE NULL
    END AS maintenance_flag

INTO silver.erp_category

FROM bronze.erp_px_cat_g1v2;
GO

-- =========================
-- FINAL CUSTOMER (JOINED)
-- =========================

IF OBJECT_ID('silver.dim_customer', 'U') IS NOT NULL DROP TABLE silver.dim_customer;
GO

SELECT
    c.cst_id,
    c.cst_key,
    c.cst_firstname,
    c.cst_lastname,
    c.cst_material_status,
    c.cst_gndr,

    e.birth_date,
    e.gender,
    l.country

INTO silver.dim_customer

FROM silver.crm_customer c
LEFT JOIN silver.erp_customer e
    ON c.cst_key = e.CID
LEFT JOIN silver.erp_location l
    ON c.cst_key = l.CID;
GO

-- =========================
-- VERIFY DATA
-- =========================

SELECT COUNT(*) AS customer_rows FROM silver.dim_customer;
SELECT COUNT(*) AS product_rows FROM silver.crm_product;
SELECT COUNT(*) AS sales_rows FROM silver.crm_sales;

SELECT TOP 10 * FROM silver.dim_customer;
SELECT TOP 10 * FROM silver.crm_sales;
GO