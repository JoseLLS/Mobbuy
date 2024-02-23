USE [EstBank]
GO

/****** Object:  Table [dbo].[TRN15]    Script Date: 23/02/2024 16:05:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TRN15](
	[TRN15Id] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[TRN15DataInc] [datetime] NOT NULL,
	[TRN15UsuInc] [varchar](60) NOT NULL,
	[TRN15ValorInicial] [decimal](17, 2) NOT NULL,
	[TRN15CdOpGateway] [decimal](12, 0) NOT NULL,
	[TRN15CdOpGatewayDet] [decimal](12, 0) NOT NULL,
	[TRN15Chave] [varchar](100) NOT NULL,
	[TRN15StatusAprovacao] [smallint] NOT NULL,
	[TRN15DescAprovacao] [varchar](60) NOT NULL,
	[TRN15DataPagamento] [datetime] NOT NULL,
	[TRN15AutCode] [varchar](32) NOT NULL,
	[TRN15AutNumber] [varchar](32) NOT NULL,
	[TRN15Status] [varchar](20) NOT NULL,
	[TRN15Nit] [varchar](20) NOT NULL,
	[TRN15ValorPagamento] [decimal](17, 2) NOT NULL,
	[TRN15ValorParcela] [decimal](17, 2) NOT NULL,
	[TRN15Parcelas] [smallint] NOT NULL,
	[TRN15Cartao] [varchar](40) NOT NULL,
	[TRN15ValorTaxa] [decimal](17, 2) NOT NULL,
	[TRN15ValorCaptura] [decimal](17, 2) NOT NULL,
	[TRN15ValorLiquido] [decimal](17, 2) NOT NULL,
	[TRN15Motivo] [varchar](60) NOT NULL,
	[TRN15QtdCartoes] [int] NOT NULL,
	[VanTrnSeq] [decimal](18, 0) NULL,
	[TRN15Importado] [bit] NOT NULL,
	[TRN15NumCartao] [varchar](20) NOT NULL,
	[TRN15Hora] [int] NOT NULL,
	[TRN15Bandeira] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TRN15Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TRN15]  WITH CHECK ADD  CONSTRAINT [ITRN22] FOREIGN KEY([VanTrnSeq])
REFERENCES [dbo].[VAN04] ([VanTrnSeq])
GO

ALTER TABLE [dbo].[TRN15] CHECK CONSTRAINT [ITRN22]
GO


USE [EstBank]
GO

/****** Object:  Table [dbo].[TRN15b]    Script Date: 23/02/2024 16:05:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TRN15b](
	[TRN15Id] [decimal](18, 0) NOT NULL,
	[TRN15Seq] [smallint] NOT NULL,
	[TRN15bStatusIni] [varchar](60) NOT NULL,
	[TRN15bStatusFinal] [varchar](60) NOT NULL,
	[TRN15bDataInc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TRN15Id] ASC,
	[TRN15Seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TRN15b]  WITH CHECK ADD  CONSTRAINT [ITRN15B1] FOREIGN KEY([TRN15Id])
REFERENCES [dbo].[TRN15] ([TRN15Id])
GO

ALTER TABLE [dbo].[TRN15b] CHECK CONSTRAINT [ITRN15B1]
GO
