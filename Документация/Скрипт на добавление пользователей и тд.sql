USE LibraryDB;
GO

-- Удаление существующих объектов
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'AddBook' AND schema_id = SCHEMA_ID('Library'))
    DROP PROCEDURE Library.AddBook;
GO

IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'trg_CheckReaderAge')
    DROP TRIGGER Library.trg_CheckReaderAge;
GO

IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_DatabaseDocumentation')
    DROP VIEW Library.vw_DatabaseDocumentation;
GO

-- Создание входящих пользователей
CREATE LOGIN LibraryAdminLogin WITH PASSWORD = 'StrongPass123!';
CREATE LOGIN LibraryOperatorLogin WITH PASSWORD = 'StrongPass456!';
CREATE LOGIN LibraryReaderLogin WITH PASSWORD = 'StrongPass789!';
GO

-- Создание пользователей базы данных
CREATE USER LibraryAdmin FOR LOGIN LibraryAdminLogin;
CREATE USER LibraryOperator FOR LOGIN LibraryOperatorLogin;
CREATE USER LibraryReader FOR LOGIN LibraryReaderLogin;
GO

-- Создание ролей
CREATE ROLE LibraryAdminRole;
CREATE ROLE LibraryOperatorRole;
CREATE ROLE LibraryReaderRole;
GO

-- Добавление пользователей в роли
ALTER ROLE LibraryAdminRole ADD MEMBER LibraryAdmin;
ALTER ROLE LibraryOperatorRole ADD MEMBER LibraryOperator;
ALTER ROLE LibraryReaderRole ADD MEMBER LibraryReader;
GO

-- Хранимая процедура для добавления книг
CREATE PROCEDURE Library.AddBook
    @ISBN NVARCHAR(20),
    @Title NVARCHAR(255),
    @PublishYear INT,
    @GenreID INT
AS
BEGIN
    INSERT INTO Library.Books 
    (ISBN, Title, PublishYear, GenreID)
    VALUES 
    (@ISBN, @Title, @PublishYear, @GenreID)
END
GO

-- Назначение прав для ролей
GRANT SELECT, INSERT ON Library.Books TO LibraryOperatorRole;
GRANT SELECT ON Library.Books TO LibraryReaderRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON Library.Books TO LibraryAdminRole;
GO

-- Триггер для проверки возраста читателя
CREATE TRIGGER trg_CheckReaderAge
ON Library.Readers
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted 
        WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) < 14
    )
    BEGIN
        RAISERROR('Читатель должен быть старше 14 лет', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO

-- Представление для документации
CREATE VIEW Library.vw_DatabaseDocumentation AS
SELECT 
    t.name AS TableName,
    c.name AS ColumnName,
    tp.name AS DataType,
    c.max_length AS MaxLength
FROM 
    sys.tables t
JOIN 
    sys.columns c ON t.object_id = c.object_id
JOIN 
    sys.types tp ON c.system_type_id = tp.system_type_id
WHERE 
    t.schema_id = SCHEMA_ID('Library')
GO
