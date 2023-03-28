USE [Pronto]
GO

/****** Object:  View [dbo].[VwRelAudCessao]    Script Date: 26/09/2022 14:44:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[VwRelAudCessao] as
	SELECT
	NewID() AS 'VwRelAudCessaoGUID',
	A.CessaoId AS 'VwRelAudCessaoId',
	A.CessaoEstCodOri AS 'VwRelAudCessaoOriEstCod',
	B.EstNomFan AS 'VwRelAudCessaoOriEstNom',
	B.EstSegmento AS 'VwRelAudCessaoOriEstSeg',
	B.EstCpfCnpj AS 'VwRelAudCessaoOriEstCpfCnpj',
	A.CessaoEstCodBen AS 'VwRelAudCessaoBenEstCod',
	C.EstNomFan AS 'VwRelAudCessaoBenEstNom',
	C.EstCpfCnpj AS 'VwRelAudCessaoBenEstCpfCnpj',
	A.CessaoDtaCad AS 'VwRelAudCessaoDtaCad',--DATACESSAO,
	G.CessaoStatusDesc AS 'VwRelAudCessaoStatusDesc',--STATUS,
	E.VlpNumPar AS 'VwRelAudCessaoParcela',
	A.CessaoValor AS 'VwRelAudCessaoValor',--VALORCESSAO,
	F.CessaoTipoDesc AS 'VwRelAudCessaoTipo',--TIPO
	A.CessaoNFDistribuidora AS 'VwRelAudCessaoNF',--NF,
	A.CessaoValorNota AS 'VwRelAudCessaoValorNF',--VALORNOTA,
	A.CessaoDataEmissao AS 'VwRelAudCessaoDataEmi',--DATAEMISSAO,
	A.CessaoDistribuidor AS 'VwRelAudCessaoDistri',--DISTRIBUIDOR,
	A.CessaoFilial AS 'VwRelAudCessaoFilial',--FILIAL,
	H.MovTrnDta AS 'VwRelAudCessaoDtaTrn',--DATATRANSACAO,
	E.VlpDtaVct AS 'VwRelAudCessaoDtaLiqLan',--DATALIQUIDACAO,
	'Parcelado' AS 'VwRelAudCessaoTipoLan',--TIPOTRANSACAO,
	E.VlpAutCodStr AS 'VwRelAudCessaoAutLan',--AUTORIZACAO,
	E.VlpNsu AS 'VwRelAudCessaoNsuLan',--NSU,
	D.CessaoDetValor AS 'VwRelAudCessaoDetValor',
	E.VlpTrnCod AS 'VwRelAudVlpTrnCod'
	FROM CESSAO A 
	INNER JOIN EST B
	ON A.CessaoEstCodOri = B.EstCod
	INNER JOIN EST C
	ON A.CessaoEstCodBen = C.EstCod
	LEFT JOIN CESSAODETALHE D
	ON A.CessaoId = D.CessaoId
	LEFT JOIN VLRPAG E
	ON D.CessaoDetNumLan = E.VlpNumLan
	INNER JOIN CESSAOTIPO F
	ON A.CessaoTipoId = F.CessaoTipoId
	INNER JOIN CESSAOSTATUS G
	ON A.CessaoStatusId = G.CessaoStatusId
	LEFT JOIN MovTrn01 H
	ON E.VlpMovTrnId = H.MovTrnId
	WHERE A.CessaoStatusId = 1
GO


USE [Pronto]
GO

/****** Object:  Table [dbo].[RtPagoBnf]    Script Date: 26/09/2022 14:43:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RtPagoBnf](
	[RtPagoBnfId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[RtPagoBnfEstCod] [int] NULL,
	[RtPagoBnfNsu] [decimal](18, 0) NULL,
	[RtPagoBnfAutCod] [varchar](10) NULL,
	[RtPagoBnfDataTrn] [datetime] NULL,
	[RtPagoBnfProduto] [varchar](1) NULL,
	[RtPagoBnfBandeira] [varchar](1) NULL,
	[RtPagoBnfTrnCod] [varchar](10) NULL,
	[RtPagoBnfValorTrn] [decimal](17, 2) NULL,
	[RtPagoBnfValorLiqEst] [decimal](17, 2) NULL,
	[RtPagoBnfValor] [decimal](17, 2) NULL,
	[RtPagoBnfDataInc] [datetime] NULL,
	[RtPagoBnfGuid] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RtPagoBnfId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Pronto]
GO

/****** Object:  Table [dbo].[RtPago]    Script Date: 26/09/2022 14:43:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RtPago](
	[RtPagoId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[RtPagoEstCod] [int] NULL,
	[RtPagoNsu] [decimal](18, 0) NULL,
	[RtPagoAutCod] [varchar](10) NULL,
	[RtPagoDataTrn] [datetime] NULL,
	[RtPagoProduto] [varchar](1) NULL,
	[RtPagoBandeira] [varchar](1) NULL,
	[RtPagoTrnCod] [varchar](10) NULL,
	[RtPagoValorTrn] [decimal](17, 2) NULL,
	[RtPagoValor] [decimal](17, 2) NULL,
	[RtPagoDataInc] [datetime] NULL,
	[RtPagoGuid] [varchar](100) NULL,
	[RtPagoValorLiqEst] [decimal](17, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[RtPagoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Pronto]
GO

/****** Object:  Table [dbo].[RtConsolidado]    Script Date: 30/09/2022 16:33:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RtConsolidado](
	[RtConsolidadoId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[RtConsolidadoEstCod] [int] NULL,
	[RtConsolidadoVendaValor] [decimal](17, 2) NULL,
	[RtConsolidadoLiqEstValor] [decimal](17, 2) NULL,
	[RtConsolidadoAbertoValor] [decimal](17, 2) NULL,
	[RtConsolidadoCancelamentoValor] [decimal](17, 2) NULL,
	[RtConsolidadoReceberValor] [decimal](17, 2) NULL,
	[RtConsolidadoCessaoOriValor] [decimal](17, 2) NULL,
	[RtConsolidadoCessaoBenValor] [decimal](17, 2) NULL,
	[RtConsolidadoBancoValor] [decimal](17, 2) NULL,
	[RtConsolidadoCustoAntValor] [decimal](17, 2) NULL,
	[RtConsolidadoGuid] [varchar](100) NULL,
	[RtConsolidadoCessaoDetBenValor] [decimal](17, 2) NULL,
	[RtConsolidadoCessaoDetOriValor] [decimal](17, 2) NULL,
	[RtConsolidadoPago] [numeric](17, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[RtConsolidadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Pronto]
GO

/****** Object:  Table [dbo].[RtConciliado]    Script Date: 26/09/2022 14:42:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RtConciliado](
	[RtConciliadoId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[RtConciliadoEstCod] [int] NULL,
	[RtConciliadoNsu] [decimal](18, 0) NULL,
	[RtConciliadoAutCod] [varchar](10) NULL,
	[RtConciliadoDataTrn] [datetime] NULL,
	[RtConciliadoProduto] [varchar](10) NULL,
	[RtConciliadoBandeira] [varchar](1) NULL,
	[RtConciliadoTrnCod] [varchar](10) NULL,
	[RtConciliadoValorTrn] [decimal](17, 2) NULL,
	[RtConciliadoValorLiqEst] [decimal](17, 2) NULL,
	[RtConciliadoValor] [decimal](17, 2) NULL,
	[RtConciliadoDataInc] [datetime] NULL,
	[RtConciliadoGuid] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RtConciliadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Pronto]
GO

/****** Object:  Table [dbo].[RtCessaoOri]    Script Date: 26/09/2022 14:42:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RtCessaoOri](
	[RtCessaoOriId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[RtCessaoOriCessaoId] [decimal](10, 0) NULL,
	[RtCessaoOriEstCod] [int] NULL,
	[RtCessaoOriEstNome] [varchar](100) NULL,
	[RtCessaoOriEstSeg] [varchar](40) NULL,
	[RtCessaoOriEstCpfCnpj] [varchar](15) NULL,
	[RtCessaoOriBenEstCod] [int] NULL,
	[RtCessaoOriBenEstNome] [varchar](100) NULL,
	[RtCessaoOriBenEstCpfCnpj] [varchar](15) NULL,
	[RtCessaoOriDataCad] [datetime] NULL,
	[RtCessaoOriStatusDesc] [varchar](20) NULL,
	[RtCessaoOriParcela] [smallint] NULL,
	[RtCessaoOriValor] [decimal](17, 2) NULL,
	[RtCessaoOriTipo] [varchar](40) NULL,
	[RtCessaoOriNF] [varchar](128) NULL,
	[RtCessaoOriValorNF] [decimal](17, 2) NULL,
	[RtCessaoOriDataEmi] [datetime] NULL,
	[RtCessaoOriDistri] [varchar](128) NULL,
	[RtCessaoOriFilial] [varchar](128) NULL,
	[RtCessaoOriDataTrn] [datetime] NULL,
	[RtCessaoOriDataLiqLan] [datetime] NULL,
	[RtCessaoOriTipoLan] [varchar](40) NULL,
	[RtCessaoOriAutCod] [varchar](10) NULL,
	[RtCessaoOriNsu] [decimal](18, 0) NULL,
	[RtCessaoOriDetValor] [decimal](17, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[RtCessaoOriId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Pronto]
GO

/****** Object:  Table [dbo].[RtCessaoBen]    Script Date: 26/09/2022 14:42:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RtCessaoBen](
	[RtCessaoBenId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[RtCessaoBenCessaoId] [decimal](10, 0) NULL,
	[RtCessaoBenEstCod] [int] NULL,
	[RtCessaoBenEstNome] [varchar](100) NULL,
	[RtCessaoBenEstSeg] [varchar](40) NULL,
	[RtCessaoBenEstCpfCnpj] [varchar](15) NULL,
	[RtCessaoBenOriEstCod] [int] NULL,
	[RtCessaoBenOriEstNome] [varchar](100) NULL,
	[RtCessaoBenOriEstCpfCnpj] [varchar](15) NULL,
	[RtCessaoBenDataCad] [datetime] NULL,
	[RtCessaoBenStatusDesc] [varchar](20) NULL,
	[RtCessaoBenParcela] [smallint] NULL,
	[RtCessaoBenValor] [decimal](17, 2) NULL,
	[RtCessaoBenTipo] [varchar](40) NULL,
	[RtCessaoBenNF] [varchar](128) NULL,
	[RtCessaoBenValorNF] [decimal](17, 2) NULL,
	[RtCessaoBenDataEmi] [datetime] NULL,
	[RtCessaoBenDistri] [varchar](128) NULL,
	[RtCessaoBenFilial] [varchar](128) NULL,
	[RtCessaoBenDataTrn] [datetime] NULL,
	[RtCessaoBenDataLiqLan] [datetime] NULL,
	[RtCessaoBenAutCod] [varchar](10) NULL,
	[RtCessaoBenNsu] [decimal](18, 0) NULL,
	[RtCessaoBenDetValor] [decimal](17, 2) NULL,
	[RtCessaoBenTipoLan] [varchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[RtCessaoBenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Pronto]
GO

/****** Object:  Table [dbo].[RtCancelado]    Script Date: 26/09/2022 14:41:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RtCancelado](
	[RtCanceladoId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[RtCanceladoEstCod] [int] NULL,
	[RtCanceladoNsu] [decimal](18, 0) NULL,
	[RtCanceladoAutCod] [varchar](10) NULL,
	[RtCanceladoDataTrn] [datetime] NULL,
	[RtCanceladoProduto] [varchar](1) NULL,
	[RtCanceladoBandeira] [varchar](1) NULL,
	[RtCanceladoTrnCod] [varchar](10) NULL,
	[RtCanceladoValorTrn] [decimal](17, 2) NULL,
	[RtCanceladoValor] [decimal](17, 2) NULL,
	[RtCanceladoDataInc] [datetime] NULL,
	[RtCanceladoGuid] [varchar](100) NULL,
	[RtCanceladoValorLiqEst] [decimal](17, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[RtCanceladoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Pronto]
GO

/****** Object:  Table [dbo].[RtAntecipacao]    Script Date: 26/09/2022 14:41:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RtAntecipacao](
	[RtAntecipacaoId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[RtAntecipacaoEstCod] [int] NULL,
	[RtAntecipacaoNsu] [decimal](18, 0) NULL,
	[RtAntecipacaoAutCod] [varchar](10) NULL,
	[RtAntecipacaoDataTrn] [datetime] NULL,
	[RtAntecipacaoProduto] [varchar](1) NULL,
	[RtAntecipacaoBandeira] [varchar](1) NULL,
	[RtAntecipacaoTrnCod] [varchar](10) NULL,
	[RtAntecipacaoValorTrn] [decimal](17, 2) NULL,
	[RtAntecipacaoValor] [decimal](17, 2) NULL,
	[RtAntecipacaoDataInc] [datetime] NULL,
	[RtAntecipacaoGuid] [varchar](100) NULL,
	[RtAntecipacaoValorLiqEst] [decimal](17, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[RtAntecipacaoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Pronto]
GO

/****** Object:  Table [dbo].[RtAnalitico]    Script Date: 26/09/2022 14:40:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RtAnalitico](
	[RtAnaliticoId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[RtAnaliticoEstCod] [int] NULL,
	[RtAnaliticoNsu] [decimal](18, 0) NULL,
	[RtAnaliticoAutcod] [varchar](20) NULL,
	[RtAnaliticoDataTrn] [datetime] NULL,
	[RtAnaliticoProduto] [varchar](10) NULL,
	[RtAnaliticoBandeira] [varchar](1) NULL,
	[RtAnaliticoTrnCod] [varchar](10) NULL,
	[RtAnaliticoValorAberto] [decimal](17, 2) NULL,
	[RtAnaliticoDataInc] [datetime] NULL,
	[RtAnaliticoValorCancelado] [decimal](17, 2) NULL,
	[RtAnaliticoValorAnt] [decimal](17, 2) NULL,
	[RtAnaliticoValorPago] [decimal](17, 2) NULL,
	[RtAnaliticoCessao] [decimal](17, 2) NULL,
	[RtAnaliticoValorTrn] [decimal](17, 2) NULL,
	[RtAnaliticoGuid] [varchar](100) NULL,
	[RtAnaliticoUsr] [char](20) NULL,
	[RtAnaliticoValorLiqEst] [decimal](17, 2) NULL,
	[RtAnaliticoCessaoBnf] [decimal](17, 2) NULL,
	[RtAnaliticoValorPagoBnf] [decimal](17, 2) NULL,
	[RtAnaliticoValorConc] [decimal](17, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[RtAnaliticoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Pronto]
GO

/****** Object:  Table [dbo].[RtAberto]    Script Date: 26/09/2022 14:40:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RtAberto](
	[RtAbertoId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[RtAbertoEstCod] [int] NULL,
	[RtAbertoNsu] [decimal](18, 0) NULL,
	[RtAbertoAutCod] [varchar](20) NULL,
	[RtAbertoDataTrn] [datetime] NULL,
	[RtAbertoProduto] [varchar](1) NULL,
	[RtAbertoBandeira] [varchar](1) NULL,
	[RtAbertoTrnCod] [varchar](10) NULL,
	[RtAbertoValor] [decimal](17, 2) NULL,
	[RtAbertoDataInc] [datetime] NULL,
	[RtAbertoGuid] [varchar](100) NULL,
	[RtAbertoValorTrn] [decimal](17, 2) NULL,
	[RtAbertoValorLiqEst] [decimal](17, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[RtAbertoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[RELTEMPAUDITORIA]    Script Date: 27/09/2022 15:32:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[RELTEMPAUDITORIA]    Script Date: 06/10/2022 09:52:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[RELTEMPAUDITORIA](@ESTCOD as integer, @UsrId as Varchar(20), @RELGUID VARCHAR(100), @DATAINC DATETIME)
AS
BEGIN

DECLARE @MOVTRNVLRVENDA NUMERIC(18,2);
DECLARE @MOVTRNVLRLIQVENDA NUMERIC(18,2);
DECLARE @MOVTRNVLRCANC NUMERIC(18,2);
DECLARE @MOVTRNVLRLIQCANC NUMERIC(18,2);

DECLARE @TOTALANT NUMERIC(18,2);
DECLARE @TOTALABERTO NUMERIC(18,2);
DECLARE @TOTALCESSAOORI NUMERIC(18,2);
DECLARE @TOTALCESSAOBEN NUMERIC(18,2);
DECLARE @TOTALDETCESSAOORI NUMERIC(18,2);
DECLARE @TOTALDETCESSAOBEN NUMERIC(18,2);
DECLARE @TOTALARQUIVO NUMERIC(18,2);
DECLARE @TOTALPAGO NUMERIC(18,2);
DECLARE @TOTALPAGOBNF NUMERIC(18,2);

/*ANALITICO VALOR PAGO ESTCOD E BENEFICIARIO IGUAIS - INICIO*/
INSERT INTO RtPago (RtPagoEstCod, RtPagoNsu, RtPagoAutCod, RtPagoDataTrn, RtPagoProduto,
RtPagoBandeira, RtPagoTrnCod, RtPagoValorTrn, RtPagoValorLIQEST, RtPagoValor, RtPagoDataInc, RtPagoGuid)
SELECT @ESTCOD, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnDta, A.MovTrnTipPrd, 
A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALORPAGOESTBNF, @DATAINC, @RELGUID
FROM MovTrn01 A
INNER JOIN
(SELECT SUM(VlpVlrPag) VALORPAGOESTBNF, VlpNsu, VlpAutCodStr, VlpTrnCod 
FROM VLRPAG
WHERE ESTCOD = @ESTCOD 
AND VlpBnfCod = @ESTCOD
AND VlpStspag = 2
AND VlpNsu > 0
GROUP BY VlpNsu, VlpAutCodStr, VlpTrnCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr
AND A.MovTrnCod = B.VlpTrnCod;
/*ANALITICO VALOR PAGO ESTCOD E BENEFICIARIO IGUAIS - FIM*/

/*ANALITICO VALOR PAGO ESTCOD DIFERENTE E BENEFICIARIO IGUAL - INICIO*/
INSERT INTO RTPAGOBNF (RtPagoBNFEstCod, RtPagoBNFNsu, RtPagoBNFAutCod, RtPagoBNFDataTrn, RtPagoBNFProduto,
RtPagoBNFBandeira, RtPagoBNFTrnCod, RtPagoBNFValorTrn, RtPagoBNFValorLIQEST, RtPagoBNFValor, RtPagoBNFDataInc, RtPagoBNFGuid)
SELECT @ESTCOD, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnDta, A.MovTrnTipPrd, 
A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALORPAGOBNF, @DATAINC, @RELGUID
FROM MovTrn01 A
INNER JOIN
(SELECT SUM(VlpVlrPag) VALORPAGOBNF, VlpNsu, VlpAutCodStr, VlpTrnCod
FROM VLRPAG
WHERE VlpBnfCod = @ESTCOD AND EstCod <> @ESTCOD
AND VlpStspag = 2
AND VlpNsu > 0
GROUP BY VlpNsu, VlpAutCodStr, VlpTrnCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr
AND A.MovTrnCod = B.VlpTrnCod;
/*ANALITICO VALOR PAGO ESTCOD DIFERENTE E BENEFICIARIO IGUAL - FIM*/

/*ANALITICO VALOR PAGO ABERTO - INICIO*/
INSERT INTO RtAberto (RtAbertoEstCod, RtAbertoNsu, RtAbertoAutCod, RtAbertoDataTrn, RtAbertoProduto, RtAbertoBandeira,
RtAbertoTrnCod, RtAbertoValorTrn, RtAbertoValorLIQEST, RtAbertoValor, RtAbertoDataInc, RtAbertoGuid)
SELECT @ESTCOD, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnDta, 
A.MovTrnTipPrd, A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALORABERTO, @DATAINC, @RELGUID
FROM MovTrn01 A
INNER JOIN
(SELECT SUM(VlpVlrPag) VALORABERTO, VlpNsu, VlpAutCodStr, VlpTrnCod FROM VLRPAG
WHERE VLPBNFCOD = @ESTCOD
AND VlpStspag = 1
AND VlpNsu > 0
GROUP BY VlpNsu, VlpAutCodStr, VlpTrnCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr
AND A.MovTrnCod = B.VlpTrnCod;
/*ANALITICO VALOR PAGO ABERTO - FIM*/

/*ANALITICO VALOR CANCELADO - INICIO*/
INSERT INTO RtCancelado (RtCanceladoEstCod, RtCanceladoNsu, RtCanceladoAutCod, RtCanceladoDataTrn, RtCanceladoProduto,
RtCanceladoBandeira, RtCanceladoTrnCod, RtCanceladoValorTrn, RtCanceladoValorLIQEST, 
RtCanceladoValor, RtCanceladoDataInc, RtCanceladoGuid)
SELECT @ESTCOD, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnDta, 
A.MovTrnTipPrd, A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALORCANCELADO, @DATAINC, @RELGUID
FROM MovTrn01 A
INNER JOIN
(SELECT SUM(VlpVlrPag) VALORCANCELADO, VlpNsu, VlpAutCodStr, VlpTrnCod FROM VLRPAG
WHERE VLPBNFCOD = @ESTCOD
AND VlpStspag IN (3, 9)
AND VlpNsu > 0
GROUP BY VlpNsu, VlpAutCodStr, VlpTrnCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr
AND A.MovTrnCod = B.VlpTrnCod;
/*ANALITICO VALOR CANCELADO - FIM*/

/*ANALITICO VALOR CONCILIADO - INICIO*/
INSERT INTO [dbo].[RtConciliado]
	([RtConciliadoEstCod]
	,[RtConciliadoNsu]
	,[RtConciliadoAutCod]
	,[RtConciliadoDataTrn]
	,[RtConciliadoProduto]
	,[RtConciliadoBandeira]
	,[RtConciliadoTrnCod]
	,[RtConciliadoValorTrn]
	,[RtConciliadoValorLiqEst]
	,[RtConciliadoValor]
	,[RtConciliadoDataInc]
	,[RtConciliadoGuid])
	SELECT @ESTCOD, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnDta, 
	A.MovTrnTipPrd, A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALOR, GETDATE(), ''
	FROM MovTrn01 A
	INNER JOIN
	(SELECT SUM(VlpVlrPag) VALOR, VlpNsu, VlpAutCodStr, VlpTrnCod FROM VLRPAG
	WHERE VLPBNFCOD = @ESTCOD
	AND VlpStspag = 6
	AND VlpNsu > 0
	AND (VlpIdCreditTransaction = 0 OR VlpIdCreditTransaction IS NULL)
	AND (VlpIdCreditTransactionPai = 0 OR VlpIdCreditTransactionPai IS NULL)
	GROUP BY VlpNsu, VlpAutCodStr, VlpTrnCod) B
	ON A.MovTrnNsu = B.VlpNsu
	AND A.MovTrnAutCodStr = B.VlpAutCodStr
	AND A.MovTrnCod = B.VlpTrnCod;
/*ANALITICO VALOR CONCILIADO - FIM*/

/*ANALITICO LANÇAMENTO DE CESSAO ORIGEM - INICIO*/

INSERT INTO [dbo].[RtCessaoOri]
           ([RtCessaoOriCessaoId]
           ,[RtCessaoOriEstCod]
           ,[RtCessaoOriEstNome]
           ,[RtCessaoOriEstSeg]
           ,[RtCessaoOriEstCpfCnpj]
           ,[RtCessaoOriBenEstCod]
           ,[RtCessaoOriBenEstNome]
           ,[RtCessaoOriBenEstCpfCnpj]
           ,[RtCessaoOriDataCad]
           ,[RtCessaoOriStatusDesc]
           ,[RtCessaoOriParcela]
           ,[RtCessaoOriValor]
           ,[RtCessaoOriTipo]
           ,[RtCessaoOriNF]
           ,[RtCessaoOriValorNF]
           ,[RtCessaoOriDataEmi]
           ,[RtCessaoOriDistri]
           ,[RtCessaoOriFilial]
           ,[RtCessaoOriDataTrn]
           ,[RtCessaoOriDataLiqLan]
           ,[RtCessaoOriTipoLan]
           ,[RtCessaoOriAutCod]
           ,[RtCessaoOriNsu]
           ,[RtCessaoOriDetValor])
   SELECT [VwRelAudCessaoId]
      ,[VwRelAudCessaoOriEstCod]
      ,[VwRelAudCessaoOriEstNom]
      ,[VwRelAudCessaoOriEstSeg]
      ,[VwRelAudCessaoOriEstCpfCnpj]
      ,[VwRelAudCessaoBenEstCod]
      ,[VwRelAudCessaoBenEstNom]
      ,[VwRelAudCessaoBenEstCpfCnpj]
      ,[VwRelAudCessaoDtaCad]
      ,[VwRelAudCessaoStatusDesc]
      ,[VwRelAudCessaoParcela]
      ,[VwRelAudCessaoValor]
      ,[VwRelAudCessaoTipo]
      ,[VwRelAudCessaoNF]
      ,[VwRelAudCessaoValorNF]
      ,[VwRelAudCessaoDataEmi]
      ,[VwRelAudCessaoDistri]
      ,[VwRelAudCessaoFilial]
      ,[VwRelAudCessaoDtaTrn]
      ,[VwRelAudCessaoDtaLiqLan]
      ,[VwRelAudVlpTrnCod]
      ,[VwRelAudCessaoAutLan]
      ,[VwRelAudCessaoNsuLan]
      ,[VwRelAudCessaoDetValor]
  FROM [dbo].[VwRelAudCessao]
  WHERE VwRelAudCessaoOriEstCod = @ESTCOD
/*ANALITICO LANÇAMENTO DE CESSAO ORIGEM - FIM*/

/*ANALITICO LANÇAMENTO DE CESSAO BENEFICIARIO - INICIO*/
INSERT INTO [dbo].[RtCessaoBen]
           ([RtCessaoBenCessaoId]
           ,[RtCessaoBenEstCod]
           ,[RtCessaoBenEstNome]
           ,[RtCessaoBenEstCpfCnpj]
           ,[RtCessaoBenOriEstCod]
           ,[RtCessaoBenOriEstNome]
		   ,[RtCessaoBenEstSeg]
           ,[RtCessaoBenOriEstCpfCnpj]
           ,[RtCessaoBenDataCad]
           ,[RtCessaoBenStatusDesc]
           ,[RtCessaoBenParcela]
           ,[RtCessaoBenValor]
           ,[RtCessaoBenTipo]
           ,[RtCessaoBenNF]
           ,[RtCessaoBenValorNF]
           ,[RtCessaoBenDataEmi]
           ,[RtCessaoBenDistri]
           ,[RtCessaoBenFilial]
           ,[RtCessaoBenDataTrn]
           ,[RtCessaoBenDataLiqLan]
		   ,[RtCessaoBenTipoLan]
           ,[RtCessaoBenAutCod]
           ,[RtCessaoBenNsu]
           ,[RtCessaoBenDetValor])
   SELECT [VwRelAudCessaoId]
      ,[VwRelAudCessaoBenEstCod]
      ,[VwRelAudCessaoBenEstNom]
      ,[VwRelAudCessaoBenEstCpfCnpj]
	  ,[VwRelAudCessaoOriEstCod]
      ,[VwRelAudCessaoOriEstNom]
      ,[VwRelAudCessaoOriEstSeg]
      ,[VwRelAudCessaoOriEstCpfCnpj]
      ,[VwRelAudCessaoDtaCad]
      ,[VwRelAudCessaoStatusDesc]
      ,[VwRelAudCessaoParcela]
      ,[VwRelAudCessaoValor]
      ,[VwRelAudCessaoTipo]
      ,[VwRelAudCessaoNF]
      ,[VwRelAudCessaoValorNF]
      ,[VwRelAudCessaoDataEmi]
      ,[VwRelAudCessaoDistri]
      ,[VwRelAudCessaoFilial]
      ,[VwRelAudCessaoDtaTrn]
      ,[VwRelAudCessaoDtaLiqLan]
      ,[VwRelAudVlpTrnCod]
      ,[VwRelAudCessaoAutLan]
      ,[VwRelAudCessaoNsuLan]
      ,[VwRelAudCessaoDetValor]
  FROM [dbo].[VwRelAudCessao]
  WHERE VwRelAudCessaoBenEstCod = @ESTCOD
/*ANALITICO LANÇAMENTO DE CESSAO BENEFICIARIO - FIM*/

/*ANALITICO LANÇAMENTO DE ANTECIPACAO - INICIO*/
INSERT INTO RtAntecipacao (RtAntecipacaoEstCod, RtAntecipacaoNsu, RtAntecipacaoAutCod, RtAntecipacaoDataTrn,
RtAntecipacaoProduto, RtAntecipacaoBandeira, RtAntecipacaoTrnCod, RtAntecipacaoValorTrn, RtAntecipacaoValorLiqEst,
RtAntecipacaoValor, RtAntecipacaoDataInc, RtAntecipacaoGuid)
SELECT @ESTCOD, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnDta, 
A.MovTrnTipPrd, A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.CUSTOANTECIPACAO, @DATAINC, @RELGUID
FROM MovTrn01 A
INNER JOIN (
SELECT SUM(LaaVlrTxaAnt) CUSTOANTECIPACAO, B.VlpNsu, B.VlpAutCodStr, B.VlpTrnCod
FROM LANANT A
INNER JOIN 
VLRPAG B
ON A.LaaNumLan = B.VlpNumLan
WHERE AnpNumAnt IN (
SELECT AnpNumAnt FROM ANTPAG
WHERE AnpCodEst = @ESTCOD
AND AnpStsAnt = 2)
GROUP BY B.VlpNsu, B.VlpAutCodStr, B.VlpTrnCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr
AND A.MovTrnCod = B.VlpTrnCod;
/*ANALITICO LANÇAMENTO DE ANTECIPACAO - FIM*/

/*INSERT ANALITICO AGRUPADO - INICIO*/

DECLARE @T1 TABLE (
	NSU NUMERIC(18,0),
	AUT VARCHAR(20),
	TRNCOD VARCHAR(10),
	VALORABERTO NUMERIC(18,2),
	VALORPAGO NUMERIC(18,2),
	VALORCESSAO NUMERIC(18,2),
	VALORCESSAOBNF NUMERIC(18,2),
	CUSTOANT NUMERIC(18,2),
	VALORCANCELADO NUMERIC(18,2),
	VALORPAGOBNF NUMERIC(18,2),
	VALORCONC NUMERIC(18,2)
)

INSERT INTO @T1 (NSU, AUT, TRNCOD, VALORCESSAOBNF, VALORCESSAO, VALORPAGO, VALORPAGOBNF, VALORABERTO, VALORCANCELADO, CUSTOANT, VALORCONC)
SELECT RtCessaoBenNsu, RtCessaoBenAutCod, RtCessaoBenTipoLan,RTCESSAOBENDETVALOR, 0 CESSAOORI, 0 PAGO, 0 PAGOBNF,0 ABERTO,0 CANCELADO, 0 ANT, 0 CONC 
FROM RtCessaoBen
WHERE RtCessaoBenEstCod = @ESTCOD
UNION ALL 
SELECT RTCESSAOORINSU, RTCESSAOORIAUTCOD, RtCessaoOriTipoLan, 0, RtCessaoOriDetValor, 0, 0,0,0,0,0 
FROM RtCessaoOri
WHERE RtCessaoOriEstCod = @ESTCOD
UNION ALL
SELECT RtPagoNsu, RtPagoAutCod, RtPagoTrnCod,0, 0, RtPagoValor, 0,0,0,0,0 
FROM RtPago
WHERE RtPagoEstCod = @ESTCOD
UNION ALL
SELECT RTPAGOBNFNSU, RTPAGOBNFAUTCOD, RtPagoBnfTrnCod,0,0,0,RTPAGOBNFVALOR,0,0,0,0 
FROM RtPagoBnf
WHERE RtPagoBnfEstCod = @ESTCOD
UNION ALL
SELECT RTABERTONSU, RTABERTOAUTCOD, RtAbertoTrnCod,0, 0, 0, 0, RTABERTOVALOR,0,0,0 
FROM RtAberto
WHERE RtAbertoEstCod = @ESTCOD
UNION ALL
SELECT RtCanceladoNsu, RtCanceladoAutCod, RtCanceladoTrnCod,0, 0, 0, 0, 0, RtCanceladoValor,0,0 
FROM RTCANCELADO
WHERE RtCanceladoEstCod = @ESTCOD
UNION ALL
SELECT RTANTECIPACAONSU, RTANTECIPACAOAUTCOD, RtAntecipacaoTrnCod,0,0,0,0,0,0, RTANTECIPACAOVALOR,0 
FROM RtAntecipacao
WHERE RtAntecipacaoEstCod = @ESTCOD
UNION ALL
SELECT RtConciliadoNsu, RtConciliadoAutCod, RtConciliadoTrnCod,0,0,0,0,0,0,0,RtConciliadoValor 
FROM RtConciliado
WHERE RtConciliadoEstCod = @ESTCOD;

INSERT INTO RtAnalitico (RtAnaliticoEstCod, RtAnaliticoNsu, RtAnaliticoAutcod, RtAnaliticoDataTrn, RtAnaliticoProduto,
RtAnaliticoBandeira, RtAnaliticoTrnCod, RtAnaliticoValorTrn, RtAnaliticoValorLiqEst, RtAnaliticoValorPago,
RtAnaliticoValorAberto, RtAnaliticoValorCancelado, RtAnaliticoCessao, RtAnaliticoValorAnt, RtAnaliticoCessaoBNF,
RtAnaliticoValorPagoBNF, RtAnaliticoValorConc)
SELECT 
@ESTCOD, NSU, AUT, B.MovTrnDta, 
IIF(SUM(VALORCESSAOBNF) > 0, 'Cessao', B.MovTrnTipPrd) PRODUTO, 
B.MovTrnBan, B.MovTrnCod, B.MovTrnVlr, 
IIF(SUM(VALORCESSAOBNF) > 0, SUM(VALORCESSAOBNF), B.MovTrnVlrLiqEst) LIQEST,
SUM(VALORPAGO) PAGO,
SUM(VALORABERTO) ABERTO,
SUM(VALORCANCELADO) CANCELADO,
SUM(VALORCESSAO) CESSAOORI,
SUM(CUSTOANT) CUSTOANT,
SUM(VALORCESSAOBNF) CESSAOBNF,
SUM(VALORPAGOBNF) PAGOBNF,
SUM(VALORCONC) CONC
FROM @T1 A
INNER JOIN MovTrn01 B
ON A.NSU = B.MovTrnNsu
AND A.AUT = B.MovTrnAutCodStr
AND A.TRNCOD = B.MovTrnCod
WHERE NOT NSU IS NULL AND NOT AUT IS NULL
GROUP BY NSU, AUT, B.MovTrnDta, B.MovTrnVlr, B.MovTrnTipPrd, B.MovTrnBan, B.MovTrnCod, B.MovTrnVlrLiqEst;

/*INSERT ANALITICO AGRUPADO - FIM*/

/*INSERT ANALITICO AJUSTES - INICIO*/
INSERT INTO RtAnalitico (RtAnaliticoEstCod, RtAnaliticoNsu, RtAnaliticoAutcod, RtAnaliticoDataTrn, RtAnaliticoProduto,
RtAnaliticoBandeira, RtAnaliticoTrnCod, RtAnaliticoValorTrn, RtAnaliticoValorLiqEst, RtAnaliticoValorPago,
RtAnaliticoValorAberto, RtAnaliticoValorCancelado, RtAnaliticoCessao, RtAnaliticoValorAnt, RtAnaliticoCessaoBNF,
RtAnaliticoValorPagoBNF, RtAnaliticoValorConc)
SELECT A.EstCod, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnDta, 'AJUSTE', A.MovTrnBan, A.MovTrnCod,
A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALORPAGO, B.VALORABERTO, B.VALORCANCELADO,
B.VALORCESSAOORI, B.CUSTOANT, B.VALORCESSAOBNF, B.PAGOBNF, B.VALORCONCILIADO
FROM MovTrn01 A INNER JOIN (
SELECT VLPMOVTRNID,
IIF(VlpStspag = 2, SUM(VlpVlrPag), 0) VALORPAGO,
IIF(VlpStspag = 1, SUM(VlpVlrPag), 0) VALORABERTO,
IIF(VlpStspag = 3, SUM(VlpVlrPag), IIF(VlpStspag = 9, SUM(VlpVlrPag), 0)) VALORCANCELADO,
IIF(VlpStspag = 6, SUM(VlpVlrPag), 0) VALORCONCILIADO,
IIF(VlpStspag = 6 AND VLPIDCREDITTRANSACTION > 0, SUM(VlpVlrPag), 0) VALORCESSAOORI,
IIF(VlpStspag = 6 AND VLPIDCREDITTRANSACTIONPAI > 0, SUM(VlpVlrPag), 0) VALORCESSAOBNF,
IIF(VlpAnpNum > 0, SUM(VLPVLRORIPAG - VlpVlrPag), 0) CUSTOANT,
0 PAGOBNF
FROM VLRPAG
WHERE EstCod = @ESTCOD AND VlpNsu = 0
GROUP BY VlpMovTrnId, VlpStspag, VlpIdCreditTransaction, VlpIdCreditTransactionPai, VlpAnpNum
) B
ON A.MovTrnId = B.VlpMovTrnId
WHERE A.EstCod = @ESTCOD AND MovTrnNsu = 0
/*INSERT ANALITICO AJUSTES - FIM*/

/*INSERT CONSOLIDADO - INICIO*/
SELECT @MOVTRNVLRVENDA = COALESCE(SUM(MovTrnVlr), 0), @MOVTRNVLRLIQVENDA = COALESCE(SUM(MovTrnVlrLiqEst),0) 
FROM MovTrn01 WHERE EstCod = @ESTCOD AND MovTrnCod <> 'CC';

SELECT @MOVTRNVLRCANC = COALESCE(SUM(MovTrnVlr),0), @MOVTRNVLRLIQCANC = COALESCE(SUM(MovTrnVlrLiqEst),0) 
FROM MovTrn01 WHERE EstCod = @ESTCOD AND MovTrnCod = 'CC';

SELECT @TOTALANT = COALESCE(SUM(RtAnaliticoValorAnt),0), @TOTALABERTO = COALESCE(SUM(RtAnaliticoValorAberto),0),
@TOTALDETCESSAOORI = COALESCE(SUM(RtAnaliticoCessao),0), @TOTALDETCESSAOBEN = COALESCE(SUM(RtAnaliticoCessaoBnf),0),
@TOTALPAGO = COALESCE(SUM(RtAnaliticoVALORPAGO),0), @TOTALPAGOBNF = COALESCE(SUM(RtAnaliticoVALORPAGOBNF),0)
FROM RtAnalitico
WHERE RtAnaliticoEstCod = @ESTCOD;

SELECT @TOTALCESSAOORI = COALESCE(SUM(CessaoValor),0) 
FROM CESSAO
WHERE CessaoStatusId = 1
AND CessaoEstCodOri = @ESTCOD;

SELECT @TOTALCESSAOBEN = COALESCE(SUM(CessaoValor),0) 
FROM CESSAO
WHERE CessaoStatusId = 1
AND CessaoEstCodBen = @ESTCOD;

SELECT @TOTALARQUIVO = COALESCE(SUM(ArbDetVlr),0) 
FROM ARQDET
WHERE ArbDetCodSit IN (0, 4)
AND ArbDetEstCod = @ESTCOD;

INSERT INTO RtConsolidado (RTCONSOLIDADOESTCOD, RTCONSOLIDADOVENDAVALOR, RTCONSOLIDADOLIQESTVALOR, RTCONSOLIDADOABERTOVALOR,
RTCONSOLIDADOCANCELAMENTOVALOR, RTCONSOLIDADORECEBERVALOR, RTCONSOLIDADOCESSAOORIVALOR, RtConsolidadoCessaoDETOriValor,
RTCONSOLIDADOCESSAOBENVALOR, RtConsolidadoCessaoDETBenValor, RTCONSOLIDADOBANCOVALOR, RTCONSOLIDADOCUSTOANTVALOR, RTCONSOLIDADOPAGO,RTCONSOLIDADOGUID)
VALUES (
@ESTCOD, @MOVTRNVLRVENDA, @MOVTRNVLRLIQVENDA, @TOTALABERTO, @MOVTRNVLRLIQCANC, (@MOVTRNVLRLIQVENDA + @MOVTRNVLRLIQCANC), 
@TOTALCESSAOORI, @TOTALDETCESSAOORI, @TOTALCESSAOBEN, @TOTALDETCESSAOBEN, @TOTALARQUIVO, @TOTALANT, (@TOTALPAGO + @TOTALPAGOBNF),
@RELGUID
)
/*INSERT CONSOLIDADO - FIM*/
END
GO


