
/*
header comment
pourpose->create files if not alerady exists,creating three schemas gold silver and bronze 
for clarity
warning->if db name is same it may be dropped */
USE master;
GO

-- Drop database if it already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWareHouse')
BEGIN
    DROP DATABASE DatawareHouse;
END
GO
--creating a warehouse
CREATE DATABASE DatawareHouse;
USE  DataWareHouse;
--create schemas for each layer according to mendellian architecture
CREATE SCHEMA Bronze;
GO
CREATE SCHEMA Silver;
GO
CREATE SCHEMA Gold;
GO
--go is like a seprator that tells our schema that execute upper ones first then after finishing go fot the other
--develop each layer now

