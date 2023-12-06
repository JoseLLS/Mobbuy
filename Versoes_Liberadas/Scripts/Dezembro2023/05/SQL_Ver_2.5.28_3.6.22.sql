/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.22','2.5.28',GETDATE());

/* TAREFA #23465 - LEONARDO */

USE [Pronto]
GO

/****** Object:  Table [dbo].[LOG_WH]    Script Date: 05/12/2023 10:25:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LOG_WH](
	[LOG_WH_Cod] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[LOG_WH_Programa] [varchar](200) NOT NULL,
	[LOG_WH_DataHora] [datetime] NOT NULL,
	[LOG_WH_ApiKey] [varchar](128) NULL,
	[LOG_WH_Usuario] [varchar](128) NULL,
	[LOG_WH_Estabelecimento] [int] NULL,
	[LOG_WH_DadosEntrada] [varchar](max) NOT NULL,
	[LOG_WH_DadosSaida] [varchar](max) NOT NULL,
	[LOG_WH_CessaoId] [decimal](10, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[LOG_WH_Cod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO