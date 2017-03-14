CREATE TABLE [dbo].[Comments]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	[user_id] INT NOT NULL REFERENCES Users(Id),
	[image_id] INT NOT NULL REFERENCES Images(Id),
	[content] VARCHAR(MAX) NOT NULL,
	[date] DATE NOT NULL
)
