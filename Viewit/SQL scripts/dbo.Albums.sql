CREATE TABLE [dbo].[Albums] (
    [Id]      INT           IDENTITY (1, 1) NOT NULL,
    [id_user] INT           NOT NULL REFERENCES Users(Id),
    [name]    VARCHAR (255) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

