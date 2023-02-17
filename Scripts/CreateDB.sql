-- =============================================
-- Створення БД
-- =============================================
USE master
GO

IF EXISTS (
  SELECT * 
	FROM sys.databases 
	WHERE name = N'KR_DB'
)
   DROP DATABASE KR_DB
GO

CREATE DATABASE KR_DB
GO