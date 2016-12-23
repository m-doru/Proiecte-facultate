CREATE TABLE [dbo].[Images] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [uploader_id] INT           NOT NULL,
    [url]         VARCHAR (255) NOT NULL,
    [upload_date] DATE          NOT NULL,
    [description] VARCHAR (MAX) NULL,
    [city]        VARCHAR (255) NULL,
	[country]     VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([uploader_id]) REFERENCES [dbo].[Users] ([Id])
);

