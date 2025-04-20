/*
==============================================================================
Purpose of Script
This script is used to make proper tables and schema, drop the table if they already exists.
Run this script to re-define ddl structure of bronze tables.
This script is used for loading Bulk data in tables in bronze layer, It truncates the bronze tables before loading the data.
It also defines a procedure EXEC bronze.load_bronze; for bulk data loading and before that truncating the tables
===============================================================================
*/
use Datawarehouse;
IF OBJECT_ID('bronze.crm_cust_info','U') IS NOT NULL
DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info (
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_marital_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date DATE
);
IF OBJECT_ID('bronze.crm_prd_info','U') IS NOT NULL
DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info (
prd_id INT,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);
IF OBJECT_ID('bronze.crm_sales_details','U') IS NOT NULL
DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details (
sls_ord_num NVARCHAR(50),
sls_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt DATE,
sls_due_dt DATE,
sls_sales INT,
sls_quantity INT,
sls_price INT
);
IF OBJECT_ID('bronze.erp_loc_a101','U') IS NOT NULL
DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101 (
CID NVARCHAR(50),
CNTRY NVARCHAR(50)
);
IF OBJECT_ID('bronze.erp_cust_az12','U') IS NOT NULL
DROP TABLE bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12 (
CID NVARCHAR(50),
BDATE DATE,
GEN NVARCHAR(50)
);
IF OBJECT_ID('bronze.erp_px_cat_g1v2','U') IS NOT NULL
DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2 (
ID			NVARCHAR(50),
CAT			NVARCHAR(50),
SUBCATGEN	NVARCHAR(50),
MAINTENANCE NVARCHAR(50)
);
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME,@end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		print '===========================================';
		print 'Loading Bronze Layer';
		print '===========================================';

		print'--------------------------------------------';
		print 'Loading CRM Tables';
		print'--------------------------------------------';

		SET @start_time = GETDATE();
		print 'Truncating Table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;

		print 'Inserting the Data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		from 'D:\SQL Data Warehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		SET @end_time = GETDATE();
		print '>>Load Duration:  ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		print '-----------------';
		SET @start_time = GETDATE();
		print 'Truncating Table: bronze.crm_prd_info';
		truncate table bronze.crm_prd_info;
		print 'Inserting the Data into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		from 'D:\SQL Data Warehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		SET @end_time = GETDATE();
		print '>>Load Duration:  ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		print '-----------------';
		SET @start_time = GETDATE();
		print 'Truncating Table: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;
		print 'Inserting the Data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		from 'D:\SQL Data Warehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		SET @end_time = GETDATE();
		print '>>Load Duration:  ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		print '-----------------';
		print'--------------------------------------------';
		print 'Loading ERP Tables';
		print'--------------------------------------------';
		SET @start_time = GETDATE();
		print 'Truncating Table: bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;
		print 'Inserting the Data into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		from 'D:\SQL Data Warehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		SET @end_time = GETDATE();
		print '>>Load Duration:  ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		print '-----------------';
		SET @start_time = GETDATE();
		print 'Truncating Table: bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101;
		print 'Inserting the Data into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		from 'D:\SQL Data Warehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		SET @end_time = GETDATE();
		print '>>Load Duration:  ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		print '-----------------';
		SET @start_time = GETDATE();
		print 'Truncating Table: bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2;
		print 'Inserting the Data into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		from 'D:\SQL Data Warehouse project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		SET @end_time = GETDATE();
		print '>>Load Duration:  ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		print '-----------------';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================================';
		print 'Loading Braonze Layer Completed';
		print '- Total load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
		PRINT '=========================================================';
	END TRY
	BEGIN CATCH
		PRINT '=========================================================';
		PRINT 'Error occured during loading bronze layer';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================================';
	END CATCH
END
