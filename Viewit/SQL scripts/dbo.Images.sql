CREATE TABLE [dbo].[Images]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (1,1), 
    [uploader_id] INT NOT NULL REFERENCES Users(Id), 
    [url] VARCHAR(255) NOT NULL, 
    [upload_date] DATE NOT NULL, 
    [description] VARCHAR(MAX) NULL, 
    [city] INT NULL REFERENCES Cities(Id),

	
)
