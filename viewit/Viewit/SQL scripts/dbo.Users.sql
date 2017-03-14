CREATE TABLE [dbo].[Users] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [username]  VARCHAR (50)  NOT NULL,
    [first_name] VARCHAR (50)  NOT NULL,
    [last_name]  VARCHAR (50)  NOT NULL,
    [birthday]   DATE          NOT NULL,
    [email]      VARCHAR (50)  NOT NULL,
    [password]   VARCHAR (255) NOT NULL,
    [is_admin]   BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

