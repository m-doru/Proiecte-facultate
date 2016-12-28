CREATE TABLE [dbo].[Included_in]
(
	[Id_image] INT NOT NULL REFERENCES Images (Id),
	[Id_album] INT NOT NULL REFERENCES Albums (Id),
	PRIMARY KEY(Id_image, Id_album)
)
