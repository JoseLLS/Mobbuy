/* TAREFA #19343 - JOSÉ */

--Bancos que usarão o script
USE Pronto

INSERT INTO Parsis
VALUES('REPROCLIQUIDACESSAO', 'URL da API de liquidar cessão no reprocessamento', 'VA', 255, NULL, 'N', 
'https://acesso.semprepronto.com.br/prontoev15/rest/LiquidaCessaoWS', '025ADM', '2022-09-22 09:22:00.000', '025ADM', NULL, 0)

-------------------------------------------------------------------------------------------------------------------------------

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('WPREPROCLIQCESSAO', 'WPREPROCLIQCESSAO', 'Reprocessamento liquidação cessão', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'WPREPROCLIQCESSAO', '', 141, 'CTR_FIN', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'WPREPROCLIQCESSAO')

SELECT * FROM sse2_ung

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'WPREPROCLIQCESSAO')

-------------------------------------------------------------------------------------------------------------------------------

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('WPREPROCLAN', 'WPREPROCLAN', 'Reprocessar lançamentos', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'WPREPROCLAN', '', 142, 'CTR_FIN', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'WPREPROCLAN')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'WPREPROCLAN')

-------------------------------------------------------------------------------------------------------------------------------

CREATE NONCLUSTERED INDEX [UMOVTRN015] ON [MovTrn01] (
      [EstCod],
      [MovTrnDta],
      [MovTrnNsu],
      [MovTrnAutCod])

/* TAREFA #20008 - WESLEY */

DROP INDEX [UVLRPAG7] ON [VLRPAG]

CREATE NONCLUSTERED INDEX [UVLRPAG7] ON [VLRPAG] ( 
      [VlpIdCreditTransactionPai], 
      [EstCod])


CREATE NONCLUSTERED INDEX [UVLRPAG11] ON [VLRPAG] ( 
[VlpIdCreditTransaction], 
[EstCod], 
[VlpVlrPag])

/* TAREFA #20024 - JOSÉ */

--Rodar em todos os clientes, um update de cada vez

ALTER TABLE [USUEST]
ADD [GX_AUX] VARCHAR(40)    NULL CONSTRAINT GX_AUXUSUEST_DEFAULT DEFAULT '' WITH VALUES

ALTER TABLE [USUEST]
DROP CONSTRAINT GX_AUXUSUEST_DEFAULT

UPDATE [USUEST]
SET    [GX_AUX] = Rtrim([UEstUsuAlt])

ALTER TABLE [USUEST]
DROP COLUMN [UEstUsuAlt]

EXEC sp_rename '[USUEST].GX_AUX', 'UEstUsuAlt'

ALTER TABLE [USUEST]
ADD [GX_AUX] VARCHAR(40)    NULL CONSTRAINT GX_AUXUSUEST_DEFAULT DEFAULT '' WITH VALUES

ALTER TABLE [USUEST]
DROP CONSTRAINT GX_AUXUSUEST_DEFAULT

UPDATE [USUEST]
SET    [GX_AUX] = Rtrim([UEstUsuInc])

ALTER TABLE [USUEST]
DROP COLUMN [UEstUsuInc]

EXEC sp_rename '[USUEST].GX_AUX', 'UEstUsuInc'

/* TAREFA #20011 - LEONARDO */

ALTER TABLE [RtConsolidado]
ADD [RtConsolidadoAluguelPos] DECIMAL(17,2)    NULL


ALTER TABLE [RtConsolidado]
ADD [RtConsolidadoEstorno] DECIMAL(17,2)    NULL


CREATE TABLE [RtEstorno] (
  [RtEstornoId]          DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtEstornoEstCod]      INT    NULL,
  [RtEstornoNsu]         DECIMAL(18)    NULL,
  [RtEstornoAutCod]      VARCHAR(10)    NULL,
  [RtEstornoDataTrn]     DATETIME    NULL,
  [RtEstornoProduto]     VARCHAR(1)    NULL,
  [RtEstornoBandeira]    VARCHAR(1)    NULL,
  [RtEstornoTrnCod]      VARCHAR(10)    NULL,
  [RtEstornoValorTrn]    DECIMAL(17,2)    NULL,
  [RtEstornoValorLiqEst] DECIMAL(17,2)    NULL,
  [RtEstornoValor]       DECIMAL(17,2)    NULL,
  [RtEstornoDataInc]     DATETIME    NULL,
  [RtEstornoGuid]        VARCHAR(100)    NULL,
     PRIMARY KEY ( [RtEstornoId] ))
	 
	 
	ALTER TABLE [RtAnalitico]
ADD [RtAnaliticoValorEstorno] DECIMAL(17,2)    NULL

-------------------------------------------------------------------------------------------------------------------------------------

USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[RELTEMPAUDITORIA]    Script Date: 21/11/2022 17:54:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*USE Pronto
GO

ALTER TABLE RTCESSAOORI
ADD RtCessaoOriGuid Varchar(100),
	RtCessaoOriDataInc Datetime

ALTER TABLE RTCESSAOBEN
ADD RtCessaoBenGuid Varchar(100),
	RtCessaoBenDataInc Datetime
GO

DROP PROCEDURE RELTEMPAUDITORIA
GO*/

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
DECLARE @TOTALESTORNO NUMERIC(18,2);
DECLARE @TOTALALUGUEL NUMERIC(18,2);

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
	A.MovTrnTipPrd, A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALOR, @DATAINC, @RELGUID
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
           ,[RtCessaoOriDetValor]
		   ,[RtCessaoOriGuid]
		   ,[RtCessaoOriDataInc])
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
	  ,@RELGUID
	  ,@DATAINC
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
           ,[RtCessaoBenDetValor]
		   ,[RtCessaoBenGuid]
		   ,[RtCessaoBenDataInc])
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
	  ,@RELGUID
	  ,@DATAINC
  FROM [dbo].[VwRelAudCessao]
  WHERE VwRelAudCessaoBenEstCod = @ESTCOD
/*ANALITICO LANÇAMENTO DE CESSAO BENEFICIARIO - FIM*/

/*ANALITICO LANÇAMENTO DE ESTORNO - INICIO*/
INSERT INTO [dbo].[RtEstorno]
           ([RtEstornoEstCod]
           ,[RtEstornoNsu]
           ,[RtEstornoAutCod]
           ,[RtEstornoDataTrn]
           ,[RtEstornoProduto]
           ,[RtEstornoBandeira]
           ,[RtEstornoTrnCod]
           ,[RtEstornoValorTrn]
           ,[RtEstornoValorLiqEst]
           ,[RtEstornoValor]
           ,[RtEstornoDataInc]
           ,[RtEstornoGuid])
    SELECT @ESTCOD, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnDta, A.MovTrnTipPrd, 
	A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALORESTORNO, @DATAINC, @RELGUID
	FROM MovTrn01 A
	INNER JOIN
	(SELECT SUM(VlpVlrPag) VALORESTORNO, VlpMovTrnId
	FROM VLRPAG
	WHERE VlpBnfCod = @ESTCOD AND EstCod = @ESTCOD
	AND VlpTrnCod = 'ES'
	GROUP BY VlpMovTrnId) B
	ON A.MovTrnId = B.VlpMovTrnId
/*ANALITICO LANÇAMENTO DE ESTORNO - FIM*/

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


/*ANALITICO LANÇAMENTO DE ESTORNO SE TIVER PAGO - INICIO*/

INSERT INTO RtPago (RtPagoEstCod, RtPagoNsu, RtPagoAutCod, RtPagoDataTrn, RtPagoProduto,
RtPagoBandeira, RtPagoTrnCod, RtPagoValorTrn, RtPagoValorLIQEST, RtPagoValor, RtPagoDataInc, RtPagoGuid)
SELECT @ESTCOD, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnDta, A.MovTrnTipPrd, 
A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALORPAGOESTBNF, @DATAINC, @RELGUID
FROM MovTrn01 A
INNER JOIN
(SELECT SUM(VlpVlrPag) VALORPAGOESTBNF, VlpMovTrnId
FROM VLRPAG
WHERE VlpTrnCod = 'ES'
AND ESTCOD = @ESTCOD 
AND VlpBnfCod = @ESTCOD
AND VlpStspag = 2
GROUP BY VlpMovTrnId) B
ON A.MovTrnId = B.VlpMovTrnId;

/*ANALITICO LANÇAMENTO DE ESTORNO SE TIVER PAGO - FIM*/


/*ANALITICO LANÇAMENTO DE ESTORNO SE TIVER ABERTO - INICIO*/

INSERT INTO RtAberto (RtAbertoEstCod, RtAbertoNsu, RtAbertoAutCod, RtAbertoDataTrn, RtAbertoProduto, RtAbertoBandeira,
RtAbertoTrnCod, RtAbertoValorTrn, RtAbertoValorLIQEST, RtAbertoValor, RtAbertoDataInc, RtAbertoGuid)
SELECT @ESTCOD, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnDta, 
A.MovTrnTipPrd, A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALORABERTO, @DATAINC, @RELGUID
FROM MovTrn01 A
INNER JOIN
(SELECT SUM(VlpVlrPag) VALORABERTO, VlpMovTrnId FROM VLRPAG
WHERE VlpTrnCod = 'ES' 
AND VLPBNFCOD = @ESTCOD
AND ESTCOD = @ESTCOD
AND VlpStspag = 1
GROUP BY VlpMovTrnId) B
ON A.MovTrnId = B.VlpMovTrnId;

/*ANALITICO LANÇAMENTO DE ESTORNO SE TIVER ABERTO - FIM*/

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
	VALORCONC NUMERIC(18,2),
	VALORESTORNO NUMERIC(18,2)
)

INSERT INTO @T1 (NSU, AUT, TRNCOD, VALORCESSAOBNF, VALORCESSAO, VALORPAGO, VALORPAGOBNF, VALORABERTO, VALORCANCELADO, CUSTOANT, VALORCONC, VALORESTORNO)
SELECT RtCessaoBenNsu, RtCessaoBenAutCod, RtCessaoBenTipoLan,RTCESSAOBENDETVALOR, 0 CESSAOORI, 0 PAGO, 0 PAGOBNF,0 ABERTO,0 CANCELADO, 0 ANT, 0 CONC, 0 ESTORNO 
FROM RtCessaoBen
WHERE RtCessaoBenEstCod = @ESTCOD
UNION ALL 
SELECT RTCESSAOORINSU, RTCESSAOORIAUTCOD, RtCessaoOriTipoLan, 0, RtCessaoOriDetValor, 0, 0,0,0,0,0,0 
FROM RtCessaoOri
WHERE RtCessaoOriEstCod = @ESTCOD
UNION ALL
SELECT RtPagoNsu, RtPagoAutCod, RtPagoTrnCod,0, 0, RtPagoValor, 0,0,0,0,0,0 
FROM RtPago
WHERE RtPagoEstCod = @ESTCOD
UNION ALL
SELECT RTPAGOBNFNSU, RTPAGOBNFAUTCOD, RtPagoBnfTrnCod,0,0,0,RTPAGOBNFVALOR,0,0,0,0,0 
FROM RtPagoBnf
WHERE RtPagoBnfEstCod = @ESTCOD
UNION ALL
SELECT RTABERTONSU, RTABERTOAUTCOD, RtAbertoTrnCod,0, 0, 0, 0, RTABERTOVALOR,0,0,0,0 
FROM RtAberto
WHERE RtAbertoEstCod = @ESTCOD
UNION ALL
SELECT RtCanceladoNsu, RtCanceladoAutCod, RtCanceladoTrnCod,0, 0, 0, 0, 0, RtCanceladoValor,0,0,0 
FROM RTCANCELADO
WHERE RtCanceladoEstCod = @ESTCOD
UNION ALL
SELECT RTANTECIPACAONSU, RTANTECIPACAOAUTCOD, RtAntecipacaoTrnCod,0,0,0,0,0,0, RTANTECIPACAOVALOR,0,0 
FROM RtAntecipacao
WHERE RtAntecipacaoEstCod = @ESTCOD
UNION ALL
SELECT RtConciliadoNsu, RtConciliadoAutCod, RtConciliadoTrnCod,0,0,0,0,0,0,0,RtConciliadoValor,0 
FROM RtConciliado
WHERE RtConciliadoEstCod = @ESTCOD
UNION ALL
SELECT RtEstornoNsu, RtEstornoAutCod, RtEstornoTrnCod,0,0,0,0,0,0,0,0,RtEstornoValor
FROM RtEstorno
WHERE RtEstornoEstcod = @ESTCOD;

INSERT INTO RtAnalitico (RtAnaliticoEstCod, RtAnaliticoNsu, RtAnaliticoAutcod, RtAnaliticoDataTrn, RtAnaliticoProduto,
RtAnaliticoBandeira, RtAnaliticoTrnCod, RtAnaliticoValorTrn, RtAnaliticoValorLiqEst, RtAnaliticoValorPago,
RtAnaliticoValorAberto, RtAnaliticoValorCancelado, RtAnaliticoCessao, RtAnaliticoValorAnt, RtAnaliticoCessaoBNF,
RtAnaliticoValorPagoBNF, RtAnaliticoValorConc, RtAnaliticoValorEstorno,RtAnaliticoGuid, RtAnaliticoDataInc, RtAnaliticoUsr)
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
SUM(VALORCONC) CONC,
SUM(VALORESTORNO) ESTORNO,
@RELGUID,
@DATAINC,
@UsrId
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
RtAnaliticoValorPagoBNF, RtAnaliticoValorConc, RtAnaliticoValorEstorno, RtAnaliticoGuid, RtAnaliticoDataInc, RtAnaliticoUsr)
SELECT A.EstCod, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnDta, 'AJUSTE', A.MovTrnBan, A.MovTrnCod,
A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALORPAGO, B.VALORABERTO, B.VALORCANCELADO,
B.VALORCESSAOORI, B.CUSTOANT, B.VALORCESSAOBNF, B.PAGOBNF, B.VALORCONCILIADO, B.VALORESTORNO,
@RELGUID, @DATAINC, @UsrId
FROM MovTrn01 A INNER JOIN (
SELECT VLPMOVTRNID,
IIF(VlpStspag = 2, SUM(VlpVlrPag), 0) VALORPAGO,
IIF(VlpStspag = 1, SUM(VlpVlrPag), 0) VALORABERTO,
IIF(VlpStspag = 3, SUM(VlpVlrPag), IIF(VlpStspag = 9, SUM(VlpVlrPag), 0)) VALORCANCELADO,
IIF(VlpStspag = 6, SUM(VlpVlrPag), 0) VALORCONCILIADO,
IIF(VlpStspag = 6 AND VLPIDCREDITTRANSACTION > 0, SUM(VlpVlrPag), 0) VALORCESSAOORI,
IIF(VlpStspag = 6 AND VLPIDCREDITTRANSACTIONPAI > 0, SUM(VlpVlrPag), 0) VALORCESSAOBNF,
IIF(VlpAnpNum > 0, SUM(VLPVLRORIPAG - VlpVlrPag), 0) CUSTOANT,
0 PAGOBNF,
IIF(VlpTrnCod = 'ES', SUM(VLPVLRPAG), 0) VALORESTORNO
FROM VLRPAG
WHERE EstCod = @ESTCOD AND VlpNsu = 0
GROUP BY VlpMovTrnId, VlpStspag, VlpIdCreditTransaction, VlpIdCreditTransactionPai, VlpAnpNum, VlpTrnCod
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
@TOTALPAGO = COALESCE(SUM(RtAnaliticoVALORPAGO),0), @TOTALPAGOBNF = COALESCE(SUM(RtAnaliticoVALORPAGOBNF),0),
@TOTALESTORNO = COALESCE(SUM(RtAnaliticoValorEstorno),0)
FROM RtAnalitico
WHERE RtAnaliticoEstCod = @ESTCOD;

SELECT @TOTALALUGUEL = COALESCE(SUM(VLPVLRPAG), 0)
FROM VLRPAG
WHERE EstCod = @ESTCOD AND VlpTrnCod = 'AL' AND TidCod = 2

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
RTCONSOLIDADOCESSAOBENVALOR, RtConsolidadoCessaoDETBenValor, RTCONSOLIDADOBANCOVALOR, RTCONSOLIDADOCUSTOANTVALOR, RTCONSOLIDADOPAGO,
RtConsolidadoAluguelPos, RtConsolidadoEstorno, RTCONSOLIDADOGUID)
VALUES (
@ESTCOD, @MOVTRNVLRVENDA, @MOVTRNVLRLIQVENDA, @TOTALABERTO, @MOVTRNVLRLIQCANC, (@MOVTRNVLRLIQVENDA + @MOVTRNVLRLIQCANC), 
@TOTALCESSAOORI, @TOTALDETCESSAOORI, @TOTALCESSAOBEN, @TOTALDETCESSAOBEN, @TOTALARQUIVO, @TOTALANT, (@TOTALPAGO + @TOTALPAGOBNF),
@TOTALALUGUEL, @TOTALESTORNO, @RELGUID
)
/*INSERT CONSOLIDADO - FIM*/
END
GO