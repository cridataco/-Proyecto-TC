CREATE DATABASE [1marchadev];;
GO

CREATE LOGIN pmarcha_bd WITH PASSWORD = 'abc123***';
GO

USE [1marchadev];;
GO
CREATE USER pmarcha_bd FOR LOGIN pmarcha_bd;
GO

USE [1marchadev];;
GO
GRANT EXECUTE TO pmarcha_bd;
GO