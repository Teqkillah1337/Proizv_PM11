-- Скрипт создания базы данных "Библиотека"
-- Версия: 1.0
-- Дата создания: 20.05.2025

-- Удаление базы данных, если она существует
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'LibraryDB')
BEGIN
  ALTER DATABASE LibraryDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE LibraryDB;
END
GO

-- Создание базы данных
CREATE DATABASE LibraryDB;
GO

-- Переключение на созданную базу данных
USE LibraryDB;
GO

-- Создание схемы
CREATE SCHEMA Library;
GO

-- Создание таблиц

-- Таблица "Авторы"
CREATE TABLE Library.Authors (
  AuthorID INT IDENTITY(1,1) PRIMARY KEY,
  LastName NVARCHAR(100) NOT NULL,
  FirstName NVARCHAR(100) NOT NULL,
  MiddleName NVARCHAR(100),
  BirthDate DATE,
  Country NVARCHAR(100)
);

-- Таблица "Книги"
CREATE TABLE Library.Books (
  BookID INT IDENTITY(1,1) PRIMARY KEY,
  ISBN NVARCHAR(20) UNIQUE,
  Title NVARCHAR(255) NOT NULL,
  PublishYear INT,
  PublishHouse NVARCHAR(255),
  PageCount INT,
  Price DECIMAL(10,2)
);

-- Таблица "Связь Книги-Авторы"
CREATE TABLE Library.BookAuthors (
  BookID INT,
  AuthorID INT,
  PRIMARY KEY (BookID, AuthorID),
  FOREIGN KEY (BookID) REFERENCES Library.Books(BookID),
  FOREIGN KEY (AuthorID) REFERENCES Library.Authors(AuthorID)
);

-- Таблица "Читатели"
CREATE TABLE Library.Readers (
  ReaderID INT IDENTITY(1,1) PRIMARY KEY,
  LastName NVARCHAR(100) NOT NULL,
  FirstName NVARCHAR(100) NOT NULL,
  MiddleName NVARCHAR(100),
  PassportSeries NVARCHAR(10),
  PassportNumber NVARCHAR(10),
  Address NVARCHAR(255),
  Phone NVARCHAR(20),
  Email NVARCHAR(100)
);

-- Таблица "Выдача книг"
CREATE TABLE Library.BookIssues (
  IssueID INT IDENTITY(1,1) PRIMARY KEY,
  BookID INT,
  ReaderID INT,
  IssueDate DATE NOT NULL,
  ReturnDate DATE,
  ActualReturnDate DATE,
  FOREIGN KEY (BookID) REFERENCES Library.Books(BookID),
  FOREIGN KEY (ReaderID) REFERENCES Library.Readers(ReaderID)
);

-- Индексы для оптимизации
CREATE INDEX IX_Books_Title ON Library.Books(Title);
CREATE INDEX IX_Authors_LastName ON Library.Authors(LastName);
CREATE INDEX IX_Readers_LastName ON Library.Readers(LastName);

GO