
/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source => Bronze)
===============================================================================
Description:
    This stored procedure is responsible for loading data into the "bronze" schema 
    from external CSV files. It ensures data freshness by following these steps:

      - Truncating the existing bronze tables before ingestion;
      - Using the "BULK INSERT" command to efficiently load data from CSV files.

Parameters: NONE  
    This procedure does not take any input parameters and does not return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/



-- Create or modify procedure 
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
  DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
  BEGIN TRY
    SET @batch_start_time = GETDATE();
    PRINT '===============================================================';
    PRINT 'Starting Bronze Layer Load Process';
    PRINT '===============================================================';

    PRINT '---------------------------------------------------------------';
    PRINT 'Loading CRM Tables';
    PRINT '---------------------------------------------------------------';

    -- Load bronze.crm_cust_info
    SET @start_time = GETDATE();
    PRINT '>>>>> Truncate Table: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;
    CHECKPOINT;

    PRINT 'Inserting Data Into: bronze.crm_cust_info';
    BULK INSERT bronze.crm_cust_info
    FROM 'C:\SQL2022\datasets\source_crm\cust_info.csv'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>>>> Load duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- Load bronze.crm_prd_info
    SET @start_time = GETDATE();
    PRINT '>>>>> Truncate Table: bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;
    CHECKPOINT;

    PRINT 'Inserting Data Into: bronze.crm_prd_info';
    BULK INSERT bronze.crm_prd_info
    FROM 'C:\SQL2022\datasets\source_crm\prd_info.csv'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>>>> Load duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- Load bronze.crm_sales_details
    SET @start_time = GETDATE();
    PRINT '>>>>> Truncate Table: bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;
    CHECKPOINT;

    PRINT 'Inserting Data Into: bronze.crm_sales_details';
    BULK INSERT bronze.crm_sales_details
    FROM 'C:\SQL2022\datasets\source_crm\sales_details.csv'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>>>> Load duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    PRINT '---------------------------------------------------------------';
    PRINT 'Loading ERP Tables';
    PRINT '---------------------------------------------------------------';

    -- Load bronze.erp_cust_az12
    SET @start_time = GETDATE();
    PRINT '>>>>> Truncate Table: bronze.erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;
    CHECKPOINT;

    PRINT 'Inserting Data Into: bronze.erp_cust_az12';
    BULK INSERT bronze.erp_cust_az12
    FROM 'C:\SQL2022\datasets\source_erp\CUST_AZ12.csv'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>>>> Load duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- Load bronze.erp_loc_a101
    SET @start_time = GETDATE();
    PRINT '>>>>> Truncate Table: bronze.erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;
    CHECKPOINT;

    PRINT 'Inserting Data Into: bronze.erp_loc_a101';
    BULK INSERT bronze.erp_loc_a101
    FROM 'C:\SQL2022\datasets\source_erp\LOC_A101.csv'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>>>> Load duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- Load bronze.erp_px_cat_g1v2
    SET @start_time = GETDATE();
    PRINT '>>>>> Truncate Table: bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    CHECKPOINT;

    PRINT 'Inserting Data Into: bronze.erp_px_cat_g1v2';
    BULK INSERT bronze.erp_px_cat_g1v2
    FROM 'C:\SQL2022\datasets\source_erp\PX_CAT_G1V2.csv'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>>>> Load duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
    PRINT '----------------------';


    SET @batch_end_time = GETDATE();
    PRINT '===============================================================';
    PRINT 'Bronze Layer Load Process Completed Successfully';
    PRINT '   ## Total Load Duration: '+ CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
    PRINT '===============================================================';

  END TRY
  BEGIN CATCH
    PRINT '===============================================================';
    PRINT 'ERROR OCCURRED DURING BRONZE LAYER LOAD';
    PRINT 'Error Message: ' + ERROR_MESSAGE();
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
    PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
    PRINT '===============================================================';
  END CATCH
END;
GO
