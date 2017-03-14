CREATE TABLE [dbo].[Belongs_to]
(
	[id_image] INT NOT NULL REFERENCES Images(Id),
	[id_category] INT NOT NULL REFERENCES Categories(Id),
	PRIMARY KEY(id_image, id_category)
)
