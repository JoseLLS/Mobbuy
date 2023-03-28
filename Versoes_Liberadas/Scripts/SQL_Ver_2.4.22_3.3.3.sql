/* TAREFA #17833 - LEONARDO */

USE [Banese]
GO

/****** Object:  Table [dbo].[EfeitoContratoLan]    Script Date: 20/07/2022 14:57:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EfeitoContratoLan](
	[EfeitoContratoLanId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[VlpNumLan] [decimal](18, 0) NOT NULL,
	[EfeitoContratoTitular] [varchar](15) NOT NULL,
	[EfeitoContratoArranjo] [varchar](10) NOT NULL,
	[EfeitoContratoDtaVenc] [datetime] NOT NULL,
	[EfeitoContratoTipo] [varchar](1) NOT NULL,
	[EfeitoContratoLanDataInc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EfeitoContratoLanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EfeitoContratoLan]  WITH CHECK ADD  CONSTRAINT [IEFEITOCONTRATOLAN1] FOREIGN KEY([EfeitoContratoTitular], [EfeitoContratoArranjo], [EfeitoContratoDtaVenc], [EfeitoContratoTipo])
REFERENCES [dbo].[EfeitoContrato] ([EfeitoContratoTitular], [EfeitoContratoArranjo], [EfeitoContratoDtaVenc], [EfeitoContratoTipo])
GO

ALTER TABLE [dbo].[EfeitoContratoLan] CHECK CONSTRAINT [IEFEITOCONTRATOLAN1]
GO

ALTER TABLE [dbo].[EfeitoContratoLan]  WITH CHECK ADD  CONSTRAINT [IEFEITOCONTRATOLAN2] FOREIGN KEY([VlpNumLan])
REFERENCES [dbo].[VLRPAG] ([VlpNumLan])
GO

ALTER TABLE [dbo].[EfeitoContratoLan] CHECK CONSTRAINT [IEFEITOCONTRATOLAN2]
GO