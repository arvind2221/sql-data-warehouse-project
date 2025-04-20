/*
==============================================================================
Purpose of Script
This script is used to make proper tables and schema, drop the table if they already exists.
Run this script to re-define ddl structure of bronze tables
===============================================================================
*/
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
