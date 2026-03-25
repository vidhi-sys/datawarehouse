/*
PURPOSE:
 integrated customer view (Silver → Gold base)
*/

SELECT
    ci.cst_id AS CUSTOMER_ID,
    ci.cst_key AS CUSTOMER_NO ,
    ci.cst_firstname AS F_NAME,
    ci.cst_lastname AS SURNAME,
    ci.cst_material_status AS MARITAL_STATUS,
    ci.cst_gndr AS GENDER,
    ci.cst_create_date ,

    -- FINAL GENDER (ERP priority → CRM fallback)
    CASE 
        WHEN ca.gender IS NOT NULL THEN ca.gender
        WHEN ci.cst_gndr IS NOT NULL THEN ci.cst_gndr
        ELSE 'Unknown'
    END AS final_gender,

    -- FINAL BIRTH DATE
    ISNULL(ca.birth_date, '1900-01-01') AS BIRTH_DATE,

    -- FINAL COUNTRY
    ISNULL(la.country, 'Unknown') AS COUNTRY

FROM silver.crm_customer ci

LEFT JOIN silver.erp_customer ca
    ON UPPER(TRIM(ci.cst_key)) = UPPER(TRIM(ca.CID))

LEFT JOIN silver.erp_location la
    ON UPPER(TRIM(ci.cst_key)) = UPPER(TRIM(la.CID));
    IF OBJECT_ID('gold.dim_customer', 'U') IS NOT NULL 
DROP TABLE gold.dim_customer;

SELECT
    ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key,

    ci.cst_id AS CUSTOMER_ID,
    ci.cst_key AS CUSTOMER_NO,
    ci.cst_firstname AS F_NAME,
    ci.cst_lastname AS SURNAME,
    ci.cst_material_status AS MARITAL_STATUS,

    CASE 
        WHEN ca.gender IS NOT NULL THEN ca.gender
        WHEN ci.cst_gndr IS NOT NULL THEN ci.cst_gndr
        ELSE 'Unknown'
    END AS gender,

    ISNULL(ca.birth_date, '1900-01-01') AS BIRTH_DATE,
    ISNULL(la.country, 'Unknown') AS COUNTRY

INTO gold.dim_customer

FROM silver.crm_customer ci

LEFT JOIN silver.erp_customer ca
    ON UPPER(TRIM(ci.cst_key)) = UPPER(TRIM(ca.CID))

LEFT JOIN silver.erp_location la
    ON UPPER(TRIM(ci.cst_key)) = UPPER(TRIM(la.CID));
    -- we have also customized names
    --sorting columns also done
    -- dimensions vs facts 
SELECT
    ROW_NUMBER() OVER (ORDER BY prd_id) AS product_key,  -- surrogate key
    -- surogate key is very similar to an aritfifcal primary key

    prd_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt

INTO gold.dim_product

FROM silver.crm_product;
GO
-- creating facts
--an artificial, system-generated unique identifier assigned to a database table row to identify it uniquely, acting as a primary key
SELECT
    ROW_NUMBER() OVER (ORDER BY s.sls_ord_num) AS sales_key,

    dc.customer_key,
    dp.product_key,

    s.sls_ord_num,
    s.order_dt,
    s.ship_dt,
    s.due_dt,

    s.sales,
    s.quantity,
    s.price

INTO gold.fact_sales

FROM silver.crm_sales s

LEFT JOIN gold.dim_customer dc
    ON s.sls_cust_id = dc.cst_id

LEFT JOIN gold.dim_product dp
    ON s.sls_prd_key = dp.prd_key;
GO

-- =========================
-- VERIFY DATA
-- =========================

SELECT COUNT(*) AS customers FROM gold.dim_customer;
SELECT COUNT(*) AS products FROM gold.dim_product;
SELECT COUNT(*) AS sales FROM gold.fact_sales;

SELECT TOP 10 * FROM gold.dim_customer;
SELECT TOP 10 * FROM gold.fact_sales;
GO