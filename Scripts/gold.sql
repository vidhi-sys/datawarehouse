USE DataWareHouse;
GO

/*
PURPOSE:
Create GOLD layer 
*/

-- dropping old tables not needed if alerady exists

IF OBJECT_ID('gold.dim_customer', 'U') IS NOT NULL DROP TABLE gold.dim_customer;
IF OBJECT_ID('gold.dim_product', 'U') IS NOT NULL DROP TABLE gold.dim_product;
IF OBJECT_ID('gold.fact_sales', 'U') IS NOT NULL DROP TABLE gold.fact_sales;
GO

-- integrating cutomer

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
GO

-- daata integration

SELECT
    ROW_NUMBER() OVER (ORDER BY prd_id) AS product_key,

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

-- FACT SALES


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
    ON s.sls_cust_id = dc.CUSTOMER_ID

LEFT JOIN gold.dim_product dp
    ON s.sls_prd_key = dp.prd_key;
GO


-- VERIFY DATA


SELECT COUNT(*) AS customers FROM gold.dim_customer;
SELECT COUNT(*) AS products FROM gold.dim_product;
SELECT COUNT(*) AS sales FROM gold.fact_sales;

SELECT TOP 10 * FROM gold.dim_customer;
SELECT TOP 10 * FROM gold.fact_sales;
GO
