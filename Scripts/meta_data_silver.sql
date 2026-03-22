
/*DDL COMMANDS ADDING METADATA TO THE SILVER LAYER EXACTLY IDENTICAL TO BRONZE+ONE EXTRA*/
CREATE TABLE silver.crm_cust_info(
    cst_id NVARCHAR(50),
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

CREATE TABLE silver.crm_prd_info (
    prd_id NVARCHAR(50),
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(100),
    prd_cost NVARCHAR(50),
    prd_line NVARCHAR(10),
    prd_start_dt NVARCHAR(50),
    prd_end_dt NVARCHAR(50),
     dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

CREATE TABLE silver.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id NVARCHAR(50),
    sls_order_dt NVARCHAR(50),
    sls_ship_dt NVARCHAR(50),
    sls_due_dt NVARCHAR(50),
    sls_sales NVARCHAR(50),
    sls_quantity NVARCHAR(50),
    sls_price NVARCHAR(50),
        dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

CREATE TABLE silver.erp_cust_az12 (
    CID NVARCHAR(50),
    BDATE NVARCHAR(50),
    GEN NVARCHAR(50),
        dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

CREATE TABLE silver.erp_loc_a101 (
    CID NVARCHAR(50),
    CNTRY NVARCHAR(50),
        dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

CREATE TABLE silver.erp_px_cat_g1v2 (
    ID NVARCHAR(50),
    CAT NVARCHAR(50),
    SUBCAT NVARCHAR(50),
    MAINTENANCE NVARCHAR(50),
        dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
