/* TAREFA #19617 - JOSÉ */

--Rodar script em todos os bancos de clientes

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpConcRecebDataVen', 'wpConcRecebDataVen', 'Conciliação recebimentos por data da venda', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpConcRecebDataVen', '', 35, 'REEMB_SUB_ADQ', '', '/pronto/servlet/') --Alterar "/cliente/servlet/"

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'wpConcRecebDataVen') --Dar o SELECT de baixo na sse2_ung e pegar o UNG2Cod e alterar conforme o valor de cada cliente

SELECT * FROM sse2_ung

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'wpConcRecebDataVen') --Dar o SELECT de cima na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente

-------------------------------------------------------------------------------------------------------------------------------------

CREATE NONCLUSTERED INDEX [UMOVTRN0110] ON [MovTrn01] (
      [MovTrnDta],
      [AdqCod],
      [MovTrnBan])

/* TAREFA #19511 - LEONARDO */

USE [Banese]
GO

/****** Object:  Table [dbo].[RbTransacao]    Script Date: 20/10/2022 17:52:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RbTransacao](
	[RbTransacaoId] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[RbContagem] [smallint] NULL,
	[RbOrigem] [varchar](40) NULL,
	[RbSinal] [varchar](40) NULL,
	[RbAnalise] [varchar](40) NULL,
	[RbMovTrnId] [decimal](18, 0) NULL,
	[RbEstCod] [int] NULL,
	[RbMovTrnCod] [varchar](10) NULL,
	[RbMovTrnNsu] [decimal](18, 0) NULL,
	[RbMovTrnAutCod] [decimal](12, 0) NULL,
	[RbMovTrnNsuOri] [decimal](18, 0) NULL,
	[RbMovTrnDta] [datetime] NULL,
	[RbMovTrnVlr] [decimal](17, 2) NULL,
	[RbVlpVlrPag] [decimal](17, 2) NULL,
	[RbMovTrnParQtd] [smallint] NULL,
	[RbMovTrnParIndBemFac] [char](1) NULL,
	[RbMovTrnTipPrd] [char](1) NULL,
	[RbMovTrnNumReg] [int] NULL,
	[RbMovTrnNumMov] [int] NULL,
	[RbMovTrnPacCod] [int] NULL,
	[RbMovTrnBan] [char](1) NULL,
	[RbMovTrnIdOri] [decimal](18, 0) NULL,
	[RbMovTrnIdCan] [decimal](18, 0) NULL,
	[RbMovTrnVanSeq] [decimal](18, 0) NULL,
	[RbMovTrnInsTimStp] [datetime] NULL,
	[RbMovTrnPosNum] [int] NULL,
	[RbAdqAjtMotCod] [int] NULL,
	[RbMovTrnAutCodStr] [varchar](12) NULL,
	[RbVlpNumLan] [decimal](18, 0) NULL,
	[RbVlpDtaVct] [datetime] NULL,
	[RbVlpVlrPag2] [decimal](17, 2) NULL,
	[RbVlrTxaAdm] [decimal](17, 2) NULL,
	[RbVlpNumMovProv] [int] NULL,
	[RbVlpNumRegPrv] [int] NULL,
	[RbVlpNumMovLiq] [int] NULL,
	[RbVlpNumRegLiq] [int] NULL,
	[RbVlpBan] [smallint] NULL,
	[RbVlpNumTotPar] [smallint] NULL,
	[RbVlpVlrPagLiq] [decimal](17, 2) NULL,
	[RbVlpArbNum] [int] NULL,
	[RbVlpArbLotNum] [smallint] NULL,
	[RbVlpArbDetSeq] [int] NULL,
	[RbEstCodAge] [smallint] NULL,
	[RbVlpStsPag] [smallint] NULL,
	[RbVlpUsuInc] [varchar](40) NULL,
	[RbVlpDtiInc] [datetime] NULL,
	[RbVlpDtiAlt] [datetime] NULL,
	[RbVlpNumLanCan] [decimal](18, 0) NULL,
	[RbVlpMovTrnId] [decimal](18, 0) NULL,
	[RbVlpTipPrd] [char](1) NULL,
	[RbVlpVlrParBru] [decimal](17, 2) NULL,
	[RbVlpBnfTip] [varchar](10) NULL,
	[RbVlpBnfCod] [int] NULL,
	[RbVlpTrnCod] [varchar](10) NULL,
	[RbVlpNumPar] [smallint] NULL,
	[RbVlpNsu] [decimal](12, 0) NULL,
	[RbVlpAutCodStr] [varchar](12) NULL,
	[RbVlpPagRegRec] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[RbTransacaoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('rbtransacao_grid', 'Consolidado', 'Consolidado', '', '', 0, 1, '')

--Rodar segundo
INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'rbtransacao_grid', '', 140, 'CTR_FIN', '', '/banese/servlet/') --Alterar "/cliente/servlet/"

--Rodar terceiro
INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (12, 'rbtransacao_grid') --Dar o SELECT de baixo na sse2_ung e pegar o UNG2Cod e alterar conforme o valor de cada cliente
--Rodar quarto
INSERT INTO sse2_grp_mod
VALUES (12, 'ADM', 'rbtransacao_grid')
--Dar o SELECT de cima na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente

INSERT INTO sse2_grp_mod
VALUES (12, 'SUBADQUIRENCIA', 'rbtransacao_grid')

INSERT INTO sse2_grp_mod
VALUES (12, 'FINANCEIRO', 'rbtransacao_grid')


USE BANESE
GO

Create View VwRb AS

SELECT NEWID() as VwRbGuid,
SUM(VlpVlrPag) VwRbValor, 
VlpStspag VwRbStatus
FROM RbTransacao A
LEFT JOIN VLRPAG B
ON A.RBVLPNUMLAN = B.VLPNUMLAN
WHERE VlpStspag IN (1, 2, 665, 666, 667)
AND RbSinal = 'negativo'
GROUP BY VlpStspag