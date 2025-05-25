USE [LibraryDB]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 25.05.2025 19:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[Role] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Library].[Authors]    Script Date: 25.05.2025 19:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Library].[Authors](
	[AuthorID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[MiddleName] [nvarchar](100) NULL,
	[BirthDate] [date] NULL,
	[DeathDate] [date] NULL,
	[Country] [nvarchar](100) NULL,
	[Biography] [nvarchar](max) NULL,
	[AwardInfo] [nvarchar](500) NULL,
	[ContactEmail] [nvarchar](100) NULL,
	[Rating] [decimal](4, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Library].[BookAuthors]    Script Date: 25.05.2025 19:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Library].[BookAuthors](
	[BookID] [int] NOT NULL,
	[AuthorID] [int] NOT NULL,
	[ContributionType] [nvarchar](100) NULL,
	[RoyaltyPercentage] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[BookID] ASC,
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Library].[BookIssues]    Script Date: 25.05.2025 19:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Library].[BookIssues](
	[IssueID] [int] IDENTITY(1,1) NOT NULL,
	[BookID] [int] NULL,
	[ReaderID] [int] NULL,
	[IssueDate] [date] NOT NULL,
	[ExpectedReturnDate] [date] NULL,
	[ActualReturnDate] [date] NULL,
	[Status] [nvarchar](50) NULL,
	[OverdueFine] [decimal](10, 2) NULL,
	[Notes] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[IssueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Library].[BookReviews]    Script Date: 25.05.2025 19:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Library].[BookReviews](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[BookID] [int] NULL,
	[ReaderID] [int] NULL,
	[ReviewDate] [date] NULL,
	[Rating] [decimal](3, 1) NULL,
	[ReviewText] [nvarchar](max) NULL,
	[IsRecommended] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Library].[Books]    Script Date: 25.05.2025 19:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Library].[Books](
	[BookID] [int] IDENTITY(1,1) NOT NULL,
	[ISBN] [nvarchar](20) NULL,
	[Title] [nvarchar](255) NOT NULL,
	[OriginalTitle] [nvarchar](255) NULL,
	[PublishYear] [int] NULL,
	[PublishHouse] [nvarchar](255) NULL,
	[Language] [nvarchar](50) NULL,
	[PageCount] [int] NULL,
	[Price] [decimal](10, 2) NULL,
	[GenreID] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[CoverImage] [varbinary](max) NULL,
	[Rating] [decimal](4, 2) NULL,
	[TotalCopies] [int] NULL,
	[AvailableCopies] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Library].[Genres]    Script Date: 25.05.2025 19:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Library].[Genres](
	[GenreID] [int] IDENTITY(1,1) NOT NULL,
	[GenreName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[GenreName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Library].[Readers]    Script Date: 25.05.2025 19:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Library].[Readers](
	[ReaderID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[MiddleName] [nvarchar](100) NULL,
	[PassportSeries] [nvarchar](10) NULL,
	[PassportNumber] [nvarchar](10) NULL,
	[BirthDate] [date] NULL,
	[Address] [nvarchar](255) NULL,
	[Phone] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[RegistrationDate] [date] NULL,
	[MembershipType] [nvarchar](50) NULL,
	[DiscountPercentage] [decimal](5, 2) NULL,
	[TotalBooksRead] [int] NULL,
	[Status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ReaderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Library].[BookAuthors] ADD  DEFAULT ('Основной автор') FOR [ContributionType]
GO
ALTER TABLE [Library].[BookIssues] ADD  DEFAULT (getdate()) FOR [IssueDate]
GO
ALTER TABLE [Library].[BookIssues] ADD  DEFAULT ((0)) FOR [OverdueFine]
GO
ALTER TABLE [Library].[BookReviews] ADD  DEFAULT (getdate()) FOR [ReviewDate]
GO
ALTER TABLE [Library].[Readers] ADD  DEFAULT (getdate()) FOR [RegistrationDate]
GO
ALTER TABLE [Library].[Readers] ADD  DEFAULT ((0)) FOR [DiscountPercentage]
GO
ALTER TABLE [Library].[Readers] ADD  DEFAULT ((0)) FOR [TotalBooksRead]
GO
ALTER TABLE [Library].[BookAuthors]  WITH CHECK ADD FOREIGN KEY([AuthorID])
REFERENCES [Library].[Authors] ([AuthorID])
GO
ALTER TABLE [Library].[BookAuthors]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [Library].[Books] ([BookID])
GO
ALTER TABLE [Library].[BookIssues]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [Library].[Books] ([BookID])
GO
ALTER TABLE [Library].[BookIssues]  WITH CHECK ADD FOREIGN KEY([ReaderID])
REFERENCES [Library].[Readers] ([ReaderID])
GO
ALTER TABLE [Library].[BookReviews]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [Library].[Books] ([BookID])
GO
ALTER TABLE [Library].[BookReviews]  WITH CHECK ADD FOREIGN KEY([ReaderID])
REFERENCES [Library].[Readers] ([ReaderID])
GO
ALTER TABLE [Library].[Books]  WITH CHECK ADD FOREIGN KEY([GenreID])
REFERENCES [Library].[Genres] ([GenreID])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  (([Role]='Admin' OR [Role]='Librarian' OR [Role]='Reader'))
GO
ALTER TABLE [Library].[Authors]  WITH CHECK ADD CHECK  (([Rating]>=(0) AND [Rating]<=(10)))
GO
ALTER TABLE [Library].[BookIssues]  WITH CHECK ADD CHECK  (([Status]='Просрочена' OR [Status]='Возвращена' OR [Status]='Выдана'))
GO
ALTER TABLE [Library].[BookReviews]  WITH CHECK ADD CHECK  (([Rating]>=(0) AND [Rating]<=(5)))
GO
ALTER TABLE [Library].[Books]  WITH CHECK ADD CHECK  (([Rating]>=(0) AND [Rating]<=(10)))
GO
ALTER TABLE [Library].[Readers]  WITH CHECK ADD CHECK  (([MembershipType]='VIP' OR [MembershipType]='Премиум' OR [MembershipType]='Стандарт'))
GO
ALTER TABLE [Library].[Readers]  WITH CHECK ADD CHECK  (([Status]='Неактивен' OR [Status]='Заблокирован' OR [Status]='Активен'))
GO
