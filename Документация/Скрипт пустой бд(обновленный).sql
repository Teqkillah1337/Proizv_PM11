-- Скрипт создания расширенной базы данных "Библиотека"
-- Версия: 2.0
-- Дата создания: 20.05.2025

USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'LibraryDB')
BEGIN
ALTER DATABASE LibraryDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE LibraryDB;
END
GO

CREATE DATABASE LibraryDB;
GO

USE LibraryDB;
GO

CREATE SCHEMA Library;
GO

-- Справочник жанров
CREATE TABLE Library.Genres (
GenreID INT IDENTITY(1,1) PRIMARY KEY,
GenreName NVARCHAR(100) NOT NULL UNIQUE,
Description NVARCHAR(500)
);

-- Расширенная таблица Авторов
CREATE TABLE Library.Authors (
AuthorID INT IDENTITY(1,1) PRIMARY KEY,
LastName NVARCHAR(100) NOT NULL,
FirstName NVARCHAR(100) NOT NULL,
MiddleName NVARCHAR(100),
BirthDate DATE,
DeathDate DATE,
Country NVARCHAR(100),
Biography NVARCHAR(MAX),
AwardInfo NVARCHAR(500),
ContactEmail NVARCHAR(100),
Rating DECIMAL(4,2) CHECK (Rating BETWEEN 0 AND 10)
);

-- Расширенная таблица Книг
CREATE TABLE Library.Books (
BookID INT IDENTITY(1,1) PRIMARY KEY,
ISBN NVARCHAR(20) UNIQUE,
Title NVARCHAR(255) NOT NULL,
OriginalTitle NVARCHAR(255),
PublishYear INT,
PublishHouse NVARCHAR(255),
Language NVARCHAR(50),
PageCount INT,
Price DECIMAL(10,2),
GenreID INT,
Description NVARCHAR(MAX),
CoverImage VARBINARY(MAX),
Rating DECIMAL(4,2) CHECK (Rating BETWEEN 0 AND 10),
TotalCopies INT,
AvailableCopies INT,
FOREIGN KEY (GenreID) REFERENCES Library.Genres(GenreID)
);

-- Связь Книги-Авторы с дополнительной информацией
CREATE TABLE Library.BookAuthors (
BookID INT,
AuthorID INT,
ContributionType NVARCHAR(100) DEFAULT 'Основной автор',
RoyaltyPercentage DECIMAL(5,2),
PRIMARY KEY (BookID, AuthorID),
FOREIGN KEY (BookID) REFERENCES Library.Books(BookID),
FOREIGN KEY (AuthorID) REFERENCES Library.Authors(AuthorID)
);

-- Расширенная таблица Читателей
CREATE TABLE Library.Readers (
ReaderID INT IDENTITY(1,1) PRIMARY KEY,
LastName NVARCHAR(100) NOT NULL,
FirstName NVARCHAR(100) NOT NULL,
MiddleName NVARCHAR(100),
PassportSeries NVARCHAR(10),
PassportNumber NVARCHAR(10),
BirthDate DATE,
Address NVARCHAR(255),
Phone NVARCHAR(20),
Email NVARCHAR(100) UNIQUE,
RegistrationDate DATE DEFAULT GETDATE(),
MembershipType NVARCHAR(50) CHECK (MembershipType IN ('Стандарт', 'Премиум', 'VIP')),
DiscountPercentage DECIMAL(5,2) DEFAULT 0,
TotalBooksRead INT DEFAULT 0,
Status NVARCHAR(50) CHECK (Status IN ('Активен', 'Заблокирован', 'Неактивен'))
);

-- Расширенная таблица Выдачи книг
CREATE TABLE Library.BookIssues (
IssueID INT IDENTITY(1,1) PRIMARY KEY,
BookID INT,
ReaderID INT,
IssueDate DATE NOT NULL DEFAULT GETDATE(),
ExpectedReturnDate DATE,
ActualReturnDate DATE,
Status NVARCHAR(50) CHECK (Status IN ('Выдана', 'Возвращена', 'Просрочена')),
OverdueFine DECIMAL(10,2) DEFAULT 0,
Notes NVARCHAR(500),
FOREIGN KEY (BookID) REFERENCES Library.Books(BookID),
FOREIGN KEY (ReaderID) REFERENCES Library.Readers(ReaderID)
);

-- Таблица для отзывов о книгах
CREATE TABLE Library.BookReviews (
ReviewID INT IDENTITY(1,1) PRIMARY KEY,
BookID INT,
ReaderID INT,
ReviewDate DATE DEFAULT GETDATE(),
Rating DECIMAL(3,1) CHECK (Rating BETWEEN 0 AND 5),
ReviewText NVARCHAR(MAX),
IsRecommended BIT,
FOREIGN KEY (BookID) REFERENCES Library.Books(BookID),
FOREIGN KEY (ReaderID) REFERENCES Library.Readers(ReaderID)
);

-- Индексы для оптимизации
CREATE INDEX IX_Books_Title ON Library.Books(Title);
CREATE INDEX IX_Books_Genre ON Library.Books(GenreID);
CREATE INDEX IX_Authors_LastName ON Library.Authors(LastName);
CREATE INDEX IX_Readers_LastName ON Library.Readers(LastName);
CREATE INDEX IX_BookIssues_Status ON Library.BookIssues(Status);

GO