USE [KR_DB]
GO
-- Створення імені користувача (логіну) Hanna з паролем "Iamtheowner".
CREATE LOGIN Hanna
    WITH PASSWORD = 'Iamtheowner';
GO
-- Створення користувача БД для логіну, створеного вище.
CREATE USER Hanna FOR LOGIN Hanna;
GO
-- Надання користувачу Hanna відповідної ролі власника БД db_owner.
EXEC sp_addrolemember 'db_owner', 'Hanna'

-- Перевірка створення ролі.
EXEC sp_helpuser



CREATE LOGIN DBAdmin   
    WITH PASSWORD = 'Iamtheadmin';  
GO
CREATE USER DBAdmin FOR LOGIN DBAdmin;  
GO  
EXEC sp_addrolemember 'db_ddladmin', 'DBAdmin'


CREATE ROLE db_datawriter_and_reader
GO
GRANT INSERT, UPDATE, DELETE, SELECT TO db_datawriter_and_reader
GO
CREATE LOGIN DBWriter
    WITH PASSWORD = 'Iamthedatawriter';
GO
CREATE USER DBWriter FOR LOGIN DBWriter;
GO
EXEC sp_addrolemember 'db_datawriter_and_reader', 'DBWriter'



CREATE LOGIN DBReader
    WITH PASSWORD = 'Iamthedatareader';
GO
CREATE USER DBReader FOR LOGIN DBReader;
GO
EXEC sp_addrolemember 'db_datareader', 'DBReader'


-- Кінцева перевірка створення всіх користувачів.
EXEC sp_helpuser

EXECUTE AS DBWriter