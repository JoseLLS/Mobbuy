/*RODAR APENAS PARA PRONTO*/

USE [Pronto]
GO

/****** Object:  Table [dbo].[RelTempVenda]    Script Date: 12/09/2022 10:04:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RelTempVenda](
	[RelTempVendaId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[RelTempVendaMovId] [decimal](18, 0) NULL,
	[RelTempVendaEstCod] [decimal](10, 0) NULL,
	[RelTempVendaData] [datetime] NULL,
	[RelTempVendaNsu] [decimal](18, 0) NULL,
	[RelTempVendaAutCodStr] [varchar](20) NULL,
	[RelTempVendaTrnCod] [varchar](20) NULL,
	[RelTempVendaTrnBan] [varchar](20) NULL,
	[RelTempVendaTrnTipPrd] [varchar](20) NULL,
	[RelTempVendaTrnVlr] [decimal](17, 2) NULL,
	[RelTempVendaTrnVlrLiq] [decimal](17, 2) NULL,
	[RelTempVendaValorBanco] [decimal](17, 2) NULL,
	[RelTempVendaValorCessao] [decimal](17, 2) NULL,
	[RelTempVendaCustoAnt] [decimal](17, 2) NULL,
	[RelTempVendaValorCan] [decimal](17, 2) NULL,
	[RelTempVendaValorAberto] [decimal](17, 2) NULL,
	[RelTempVendaDataGer] [datetime] NULL,
	[RelTempVendaUsr] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RelTempVendaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


