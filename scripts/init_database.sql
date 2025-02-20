/*
=============================================================
Database Creation and Schema Setup
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after verifying its existence.
    If the database already exists, it is dropped and recreated. Additionally, 
    three schemas—'bronze', 'silver', and 'gold'—are set up within the database.

WARNING:
    Executing this script will permanently delete the 'DataWarehouse' database if it exists.
    All stored data will be lost. Proceed with caution and ensure proper backups are in place 
    before running this script.
*/




-- Drop and recreate database 'DataWarehouse'
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE
  DROP DATABASE DataWarehouse
END;
GO



-- Create Database 'DataWarehouse'
USE master;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
