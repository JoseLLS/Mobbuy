﻿/* TAREFA #24544 - JOSÉ */

INSERT INTO TIPDSP
VALUES (8, 'Ajuste Manual á Crédito','S','SISTEMA',GETDATE(),'','1753-01-01 00:00:00.000');

ALTER TABLE [VLRPAG]
ADD [VlpCompGuidPai] VARCHAR(100)    NULL,
    [VlpCompGuid] VARCHAR(100)    NULL;

ALTER TABLE [EST]
ADD [EstTxAntCompDeb] SMALLMONEY    NULL;

CREATE TABLE [RtCompensado] (
  [RtCompensadoId]          DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtCompensadoEstCod]      INT    NULL,
  [RtCompensadoNsu]         DECIMAL(18)    NULL,
  [RtCompensadoAutCod]      VARCHAR(10)    NULL,
  [RtCompensadoDataTrn]     DATETIME    NULL,
  [RtCompensadoProduto]     VARCHAR(1)    NULL,
  [RtCompensadoBandeira]    VARCHAR(1)    NULL,
  [RtCompensadoTrnCod]      VARCHAR(10)    NULL,
  [RtCompensadoValorTrn]    DECIMAL(17,2)    NULL,
  [RtCompensadoValorLiqEst] DECIMAL(17,2)    NULL,
  [RtCompensadoValor]       DECIMAL(17,2)    NULL,
  [RtCompensadoDataInc]     DATETIME    NULL,
  [RtCompensadoGuid]        VARCHAR(100)    NULL,
     PRIMARY KEY ( [RtCompensadoId] ));

USE [Pronto]
GO
/****** Object:  StoredProcedure [dbo].[RELTEMPAUDITORIA]    Script Date: 24/09/2024 16:13:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 ALTER PROCEDURE [dbo].[RELTEMPAUDITORIA](@ESTCOD as integer, @UsrId as Varchar(20), @RELGUID VARCHAR(100), @DATAINC DATETIME)
AS
BEGIN

/*
	VERSAO 8
	ULTIMA MODIFICA플O 11/10/2023
	ALTERACAO PARA INCLUIR AJUSTE CONTABIL
*/

/*
	VERSAO 7
	ULTIMA MODIFICA플O 22/09/2023
	ALTERACAO PARA AGRUPAR A ANTECIPACAO TAMBEM POR ESTABELECIMENTO
*/

/*
	VERSAO 6
	ULTIMA MODIFICA플O 18/09/2023
	ALTERACAO PARA GRAVAR ALUGUEL DE POS NA TABELA RTANALITICO
*/

/*
	VERSAO 5
	ULTIMA MODIFICA플O 24/07/2023
	ALTERACAO PARA GRAVAR O MOVTRNAUTCOD QUANDO A TRANSACAO FOR DO TIPO PIX NA TABELA RTANALITICO
*/

/*
	VERSAO 4
	ULTIMA MODIFICA플O 19/05/2023
	MODIFICADO POR CONTA DOS AJUSTES NAS TROCAS DE MAQUININHA PRONTO
	NSU, AUTORIZACAO E TRNCOD IGUAIS EM EC DIFERENTES NOS AJUSTES ESTAVAM DUPLICANDO OS REGISTROS
	ALTERADO PARA CONSIDERAR O ESTCOD NA MOVTRN QUANDO FOR AJUSTE
*/

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
DECLARE @TOTALDETCESSAOBENAJUSTE NUMERIC(18,2);
DECLARE @TOTALBANCOAJUSTE NUMERIC(18,2);
DECLARE @TOTALARQUIVO NUMERIC(18,2);
DECLARE @TOTALPAGO NUMERIC(18,2);
DECLARE @TOTALPAGOBNF NUMERIC(18,2);
DECLARE @TOTALESTORNO NUMERIC(18,2);
DECLARE @TOTALALUGUEL NUMERIC(18,2);
DECLARE @TOTALAJUSTECONTABIL NUMERIC(18,2);
DECLARE @TOTALAJUSTECESSAO NUMERIC(18,2);
DECLARE @ALUGUELABERTO NUMERIC(18,2);

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
AND VLPTRNCOD <> 'AJ'
GROUP BY VlpNsu, VlpAutCodStr, VlpTrnCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr
AND A.MovTrnCod = B.VlpTrnCod;

/*ANALITICO VALOR PAGO ESTCOD E BENEFICIARIO IGUAIS - FIM*/


/*PARTE NOVA V4 AJUSTE PAGO - INICIO*/
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
AND VLPTRNCOD = 'AJ'
GROUP BY VlpNsu, VlpAutCodStr, VlpTrnCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr
AND A.MovTrnCod = B.VlpTrnCod
AND A.EstCod = @ESTCOD;
/*PARTE NOVA V4 AJUSTE PAGO - FIM*/

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
AND VLPTRNCOD <> 'AJ'
GROUP BY VlpNsu, VlpAutCodStr, VlpTrnCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr
AND A.MovTrnCod = B.VlpTrnCod;
/*ANALITICO VALOR PAGO ESTCOD DIFERENTE E BENEFICIARIO IGUAL - FIM*/

/*PARTE NOVA V4 AJUSTE PAGO BNF ESTCOD DIFERENTE - INICIO*/
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
AND VLPTRNCOD = 'AJ'
GROUP BY VlpNsu, VlpAutCodStr, VlpTrnCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr
AND A.MovTrnCod = B.VlpTrnCod
AND A.EstCod = @ESTCOD;
/*PARTE NOVA V4 AJUSTE PAGO BNF ESTCOD DIFERENTE - FIM*/

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
AND VLPTRNCOD <> 'AJ'
GROUP BY VlpNsu, VlpAutCodStr, VlpTrnCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr
AND A.MovTrnCod = B.VlpTrnCod;
/*ANALITICO VALOR PAGO ABERTO - FIM*/

/*PARTE NOVA V4 AJUSTE ABERTO - INICIO*/
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
AND VLPTRNCOD = 'AJ'
GROUP BY VlpNsu, VlpAutCodStr, VlpTrnCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr
AND A.MovTrnCod = B.VlpTrnCod
AND A.EstCod = @ESTCOD;
/*PARTE NOVA V4 AJUSTE ABERTO - FIM*/

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

/*ANALITICO VALOR COMPENSADO - INICIO*/
INSERT INTO RtCompensado (RtCompensadoEstCod, RtCompensadoNsu, RtCompensadoAutCod, RtCompensadoDataTrn, RtCompensadoProduto,
RtCompensadoBandeira, RtCompensadoTrnCod, RtCompensadoValorTrn, RtCompensadoValorLIQEST, 
RtCompensadoValor, RtCompensadoDataInc, RtCompensadoGuid)
SELECT @ESTCOD, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnDta, 
A.MovTrnTipPrd, A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALORCOMPENSADO, @DATAINC, @RELGUID
FROM MovTrn01 A
INNER JOIN
(SELECT SUM(VlpVlrPag) VALORCOMPENSADO, VlpNsu, VlpAutCodStr, VlpTrnCod FROM VLRPAG
WHERE VLPBNFCOD = @ESTCOD
AND VlpStspag = 15
AND VlpNsu > 0
GROUP BY VlpNsu, VlpAutCodStr, VlpTrnCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr
AND A.MovTrnCod = B.VlpTrnCod;
/*ANALITICO VALOR COMPENSADO - FIM*/

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

/*ANALITICO LAN?MENTO DE CESSAO ORIGEM - INICIO*/

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
/*ANALITICO LAN?MENTO DE CESSAO ORIGEM - FIM*/

/*ANALITICO LAN?MENTO DE CESSAO BENEFICIARIO - INICIO*/
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
/*ANALITICO LAN?MENTO DE CESSAO BENEFICIARIO - FIM*/

/*ANALITICO LAN?MENTO DE ESTORNO - INICIO*/
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
/*ANALITICO LAN?MENTO DE ESTORNO - FIM*/

/*ANALITICO LAN?MENTO DE ANTECIPACAO - INICIO*/
/*ALTERACAO V7 - AGRUPAR ESTCOD*/
INSERT INTO RtAntecipacao (RtAntecipacaoEstCod, RtAntecipacaoNsu, RtAntecipacaoAutCod, RtAntecipacaoDataTrn,
RtAntecipacaoProduto, RtAntecipacaoBandeira, RtAntecipacaoTrnCod, RtAntecipacaoValorTrn, RtAntecipacaoValorLiqEst,
RtAntecipacaoValor, RtAntecipacaoDataInc, RtAntecipacaoGuid)
SELECT @ESTCOD, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnDta, 
A.MovTrnTipPrd, A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.CUSTOANTECIPACAO, @DATAINC, @RELGUID
FROM MovTrn01 A
INNER JOIN (
SELECT SUM(LaaVlrTxaAnt) CUSTOANTECIPACAO, B.VlpNsu, B.VlpAutCodStr, B.VlpTrnCod, B.EstCod
FROM LANANT A
INNER JOIN 
VLRPAG B
ON A.LaaNumLan = B.VlpNumLan
WHERE AnpNumAnt IN (
SELECT AnpNumAnt FROM ANTPAG
WHERE AnpCodEst = @ESTCOD
AND AnpStsAnt = 2)
GROUP BY B.VlpNsu, B.VlpAutCodStr, B.VlpTrnCod, B.EstCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr
AND A.MovTrnCod = B.VlpTrnCod
AND A.EstCod = B.EstCod;
/*ALTERACAO V7 - AGRUPAR ESTCOD*/
/*ANALITICO LAN?MENTO DE ANTECIPACAO - FIM*/

/*ANALITICO LAN?MENTO DE ANTECIPACAO COM ESTORNO - INICIO*/
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
AND B.VlpTrnCod = 'ES'
GROUP BY B.VlpNsu, B.VlpAutCodStr, B.VlpTrnCod) B
ON A.MovTrnNsu = B.VlpNsu
AND A.MovTrnAutCodStr = B.VlpAutCodStr;
/*ANALITICO LAN?MENTO DE ANTECIPACAO COM ESTORNO - FIM*/


/*ANALITICO LAN?MENTO DE ESTORNO SE TIVER PAGO - INICIO*/

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

/*ANALITICO LAN?MENTO DE ESTORNO SE TIVER PAGO - FIM*/


/*ANALITICO LAN?MENTO DE ESTORNO SE TIVER ABERTO - INICIO*/

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

/*ANALITICO LAN?MENTO DE ESTORNO SE TIVER ABERTO - FIM*/

/*
	ALTERA플O 13/03/2023 - LEONARDO VITOR DOS SANTOS
	INCLUIR TRANSACOES PIX
*/


/*ANALITICO LAN?MENTO DE PIX SE TIVER ABERTO - INICIO*/

INSERT INTO RtAberto (RtAbertoEstCod, RtAbertoNsu, RtAbertoAutCod, RtAbertoDataTrn, RtAbertoProduto, RtAbertoBandeira,
RtAbertoTrnCod, RtAbertoValorTrn, RtAbertoValorLIQEST, RtAbertoValor, RtAbertoDataInc, RtAbertoGuid)
SELECT @ESTCOD, A.MovTrnNsu, CONVERT(VARCHAR, A.MovTrnAutCod), A.MovTrnDta, 
A.MovTrnTipPrd, A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALORABERTO, @DATAINC, @RELGUID
FROM MovTrn01 A
INNER JOIN
(SELECT SUM(VlpVlrPag) VALORABERTO, VlpMovTrnId FROM VLRPAG
WHERE VlpTipPrd = 'P' 
AND VLPBNFCOD = @ESTCOD
AND ESTCOD = @ESTCOD
AND VlpStspag = 1
GROUP BY VlpMovTrnId) B
ON A.MovTrnId = B.VlpMovTrnId;

/*ANALITICO LAN?MENTO DE PIX SE TIVER ABERTO - FIM*/

/*ANALITICO LAN?MENTO DE PIX SE TIVER PAGO - INICIO*/

INSERT INTO RtPago (RtPagoEstCod, RtPagoNsu, RtPagoAutCod, RtPagoDataTrn, RtPagoProduto,
RtPagoBandeira, RtPagoTrnCod, RtPagoValorTrn, RtPagoValorLIQEST, RtPagoValor, RtPagoDataInc, RtPagoGuid)
SELECT @ESTCOD, A.MovTrnNsu, CONVERT(VARCHAR, A.MovTrnAutCod), A.MovTrnDta, A.MovTrnTipPrd, 
A.MovTrnBan, A.MovTrnCod, A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALORPAGOESTBNF, @DATAINC, @RELGUID
FROM MovTrn01 A
INNER JOIN
(SELECT SUM(VlpVlrPag) VALORPAGOESTBNF, VlpMovTrnId FROM VLRPAG
WHERE VlpTipPrd = 'P' 
AND VLPBNFCOD = @ESTCOD
AND ESTCOD = @ESTCOD
AND VlpStspag = 2
GROUP BY VlpMovTrnId) B
ON A.MovTrnId = B.VlpMovTrnId;

/*ANALITICO LAN?MENTO DE PIX SE TIVER PAGO - FIM*/

/*V8 - INSERIR AJUSTES CONTABEIS DE TRANSACAO*/

INSERT INTO 
RtAjusteCon (RtAjusteConEstCod, RtAjusteConNsu, RtAjusteConAutCod, RtAjusteConTrnCod, RtAjusteConValor, RtAjusteConData, 
RtAjusteConBan, RtAjusteConPrd, RtAjusteConGuid, RtAjusteConDataInc, RtAjusteConUsrId)
SELECT @ESTCOD, A.MovTrnNsu, A.MovTrnAutCodStr, A.MovTrnCod, B.ValorAjusteContabil, A.MovTrnDta, A.MovTrnBan, A.MovTrnTipPrd, @RELGUID, @DATAINC, @UsrId
FROM MovTrn01 A
INNER JOIN
(SELECT SUM(VlpVlrPag) ValorAjusteContabil, VlpMovTrnId
FROM VLRPAG
WHERE ESTCOD = @ESTCOD 
AND VlpBnfCod = @ESTCOD
AND VlpStspag = 12
AND VlpNsu > 0
AND VLPTRNCOD = 'AC'
GROUP BY VlpMovTrnId) B
ON A.MovTrnId = B.VlpMovTrnId;

/*V8 - INSERIR AJUSTES CONTABEIS DE TRANSACAO*/

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
	VALORESTORNO NUMERIC(18,2),
	VALORAJUSTECONTABIL NUMERIC(18, 2)
)

INSERT INTO @T1 (NSU, AUT, TRNCOD, VALORCESSAOBNF, VALORCESSAO, VALORPAGO, VALORPAGOBNF, VALORABERTO, VALORCANCELADO, CUSTOANT, VALORCONC, VALORESTORNO, VALORAJUSTECONTABIL)
SELECT RtCessaoBenNsu, RtCessaoBenAutCod, RtCessaoBenTipoLan,RTCESSAOBENDETVALOR, 0 CESSAOORI, 0 PAGO, 0 PAGOBNF,0 ABERTO,0 CANCELADO, 0 ANT, 0 CONC, 0 ESTORNO, 0 
FROM RtCessaoBen
WHERE RtCessaoBenEstCod = @ESTCOD
UNION ALL 
SELECT RTCESSAOORINSU, RTCESSAOORIAUTCOD, RtCessaoOriTipoLan, 0, RtCessaoOriDetValor, 0, 0,0,0,0,0,0,0 
FROM RtCessaoOri
WHERE RtCessaoOriEstCod = @ESTCOD
UNION ALL
SELECT RtPagoNsu, RtPagoAutCod, RtPagoTrnCod,0, 0, RtPagoValor, 0,0,0,0,0,0,0 
FROM RtPago
WHERE RtPagoEstCod = @ESTCOD
UNION ALL
SELECT RTPAGOBNFNSU, RTPAGOBNFAUTCOD, RtPagoBnfTrnCod,0,0,0,RTPAGOBNFVALOR,0,0,0,0,0,0 
FROM RtPagoBnf
WHERE RtPagoBnfEstCod = @ESTCOD
UNION ALL
SELECT RTABERTONSU, RTABERTOAUTCOD, RtAbertoTrnCod,0, 0, 0, 0, RTABERTOVALOR,0,0,0,0,0 
FROM RtAberto
WHERE RtAbertoEstCod = @ESTCOD
UNION ALL
SELECT RtCanceladoNsu, RtCanceladoAutCod, RtCanceladoTrnCod,0, 0, 0, 0, 0, RtCanceladoValor,0,0,0,0 
FROM RTCANCELADO
WHERE RtCanceladoEstCod = @ESTCOD
UNION ALL
SELECT RTANTECIPACAONSU, RTANTECIPACAOAUTCOD, RtAntecipacaoTrnCod,0,0,0,0,0,0, RTANTECIPACAOVALOR,0,0,0 
FROM RtAntecipacao
WHERE RtAntecipacaoEstCod = @ESTCOD
UNION ALL
SELECT RtConciliadoNsu, RtConciliadoAutCod, RtConciliadoTrnCod,0,0,0,0,0,0,0,RtConciliadoValor,0,0 
FROM RtConciliado
WHERE RtConciliadoEstCod = @ESTCOD
UNION ALL
SELECT RtEstornoNsu, RtEstornoAutCod, RtEstornoTrnCod,0,0,0,0,0,0,0,0,RtEstornoValor,0
FROM RtEstorno
WHERE RtEstornoEstcod = @ESTCOD
UNION ALL
SELECT RtAjusteConNsu, RtAjusteConAutCod, RtAjusteConTrnCod, 0,0,0,0,0,0,0,0, 0, RtAjusteConValor
FROM RtAjusteCon
WHERE RtAjusteConEstCod = @ESTCOD;

INSERT INTO RtAnalitico (RtAnaliticoEstCod, RtAnaliticoNsu, RtAnaliticoAutcod, RtAnaliticoDataTrn, RtAnaliticoProduto,
RtAnaliticoBandeira, RtAnaliticoTrnCod, RtAnaliticoValorTrn, RtAnaliticoValorLiqEst, RtAnaliticoValorPago,
RtAnaliticoValorAberto, RtAnaliticoValorCancelado, RtAnaliticoCessao, RtAnaliticoValorAnt, RtAnaliticoCessaoBNF,
RtAnaliticoValorPagoBNF, RtAnaliticoValorConc, RtAnaliticoValorEstorno, RtAnaliticoValorAjusteContabil, RtAnaliticoGuid, RtAnaliticoDataInc, RtAnaliticoUsr)
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
SUM(VALORAJUSTECONTABIL) AJUSTECONTABIL,
@RELGUID,
@DATAINC,
@UsrId
FROM @T1 A
INNER JOIN MovTrn01 B
ON A.NSU = B.MovTrnNsu
AND A.AUT = B.MovTrnAutCodStr
AND A.TRNCOD = B.MovTrnCod
WHERE NOT NSU IS NULL AND NOT AUT IS NULL
AND (B.MOVTRNCOD <> 'AJ' OR (B.MOVTRNCOD = 'AJ' AND B.ESTCOD = @ESTCOD))--PARTE NOVA V4 AGRUPAR QUANDO AJUSTE CONSIDERAR EC
GROUP BY NSU, AUT, B.MovTrnDta, B.MovTrnVlr, B.MovTrnTipPrd, B.MovTrnBan, B.MovTrnCod, B.MovTrnVlrLiqEst;

/*INSERT ANALITICO AGRUPADO - FIM*/

/*INSERT ANALITICO AJUSTES - INICIO*/
INSERT INTO RtAnalitico (RtAnaliticoEstCod, RtAnaliticoNsu, RtAnaliticoAutcod, RtAnaliticoDataTrn, RtAnaliticoProduto,
RtAnaliticoBandeira, RtAnaliticoTrnCod, RtAnaliticoValorTrn, RtAnaliticoValorLiqEst, RtAnaliticoValorPago,
RtAnaliticoValorAberto, RtAnaliticoValorCancelado, RtAnaliticoCessao, RtAnaliticoValorAnt, RtAnaliticoCessaoBNF,
RtAnaliticoValorPagoBNF, RtAnaliticoValorConc, RtAnaliticoValorEstorno, RtAnaliticoValorAjusteContabil, RtAnaliticoGuid, RtAnaliticoDataInc, RtAnaliticoUsr)
SELECT A.EstCod, A.MovTrnNsu, IIF(MovTrnTipPrd = 'P', CONVERT(VARCHAR, A.MovTrnAutCod), A.MovTrnAutCodStr), A.MovTrnDta, iif(MovTrnTipPrd = 'P', 'PIX', 'AJUSTE'), A.MovTrnBan, A.MovTrnCod,
A.MovTrnVlr, A.MovTrnVlrLiqEst, B.VALORPAGO, B.VALORABERTO, B.VALORCANCELADO,
B.VALORCESSAOORI, B.CUSTOANT, B.VALORCESSAOBNF, B.PAGOBNF, B.VALORCONCILIADO, B.VALORESTORNO, 0,
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


/*ALTERACAO V6 - INSERIR VALORES DE ALUGUEL DE POS ABERTO*/
INSERT INTO RtAnalitico (RtAnaliticoEstCod, RtAnaliticoNsu, RtAnaliticoAutcod, RtAnaliticoDataTrn, RtAnaliticoProduto,
RtAnaliticoBandeira, RtAnaliticoTrnCod, RtAnaliticoValorTrn, RtAnaliticoValorLiqEst, RtAnaliticoValorPago,
RtAnaliticoValorAberto, RtAnaliticoValorCancelado, RtAnaliticoCessao, RtAnaliticoValorAnt, RtAnaliticoCessaoBNF,
RtAnaliticoValorPagoBNF, RtAnaliticoValorConc, RtAnaliticoValorEstorno, RtAnaliticoValorAjusteContabil, RtAnaliticoGuid, RtAnaliticoDataInc, RtAnaliticoUsr)
SELECT @ESTCOD, 0, '', VlpDtaVct, VlpTipPrd, VlpBan, VlpTrnCod, 
VlpVlrPag, -- VALOR TRN
VlpVlrPag, -- VALOR LIQ EST
0, -- VALOR PAGO
VlpVlrPag, -- VALOR ABERTO
0, -- VALOR CANCELADO
0, -- VALOR CESSAO
0, -- VALOR ANTECIPACAO
0, -- VALOR CESSAO BNF
0, -- VALOR PAGO BNF
0, -- VALOR CONC
0, --VALOR ESTORNO
0, --VALOR AJUSTE CONTABIL
@RELGUID, 
@DATAINC, 
@UsrId
FROM VLRPAG
WHERE EstCod = @ESTCOD
AND VlpBnfCod = @ESTCOD
AND TidCod = 2
AND VlpTrnCod = 'AL'
AND VlpStspag = 1
/*ALTERACAO V6 - INSERIR VALORES DE ALUGUEL DE POS ABERTO*/

/*ALTERACAO V6 - INSERIR VALORES DE ALUGUEL DE POS PAGO*/
INSERT INTO RtAnalitico (RtAnaliticoEstCod, RtAnaliticoNsu, RtAnaliticoAutcod, RtAnaliticoDataTrn, RtAnaliticoProduto,
RtAnaliticoBandeira, RtAnaliticoTrnCod, RtAnaliticoValorTrn, RtAnaliticoValorLiqEst, RtAnaliticoValorPago,
RtAnaliticoValorAberto, RtAnaliticoValorCancelado, RtAnaliticoCessao, RtAnaliticoValorAnt, RtAnaliticoCessaoBNF,
RtAnaliticoValorPagoBNF, RtAnaliticoValorConc, RtAnaliticoValorEstorno, RtAnaliticoValorAjusteContabil, RtAnaliticoGuid, RtAnaliticoDataInc, RtAnaliticoUsr)
SELECT @ESTCOD, 0, '', VlpDtaVct, VlpTipPrd, VlpBan, VlpTrnCod, 
VlpVlrPag, -- VALOR TRN
VlpVlrPag, -- VALOR LIQ EST
VlpVlrPag, -- VALOR PAGO
0, -- VALOR ABERTO
0, -- VALOR CANCELADO
0, -- VALOR CESSAO
0, -- VALOR ANTECIPACAO
0, -- VALOR CESSAO BNF
0, -- VALOR PAGO BNF
0, -- VALOR CONC
0, --VALOR ESTORNO
0, --VALOR AJUSTE CONTABIL
@RELGUID, 
@DATAINC, 
@UsrId
FROM VLRPAG
WHERE EstCod = @ESTCOD
AND VlpBnfCod = @ESTCOD
AND TidCod = 2
AND VlpTrnCod = 'AL'
AND VlpStspag = 2
/*ALTERACAO V6 - INSERIR VALORES DE ALUGUEL DE POS PAGO*/

/*ALTERACAO V8 - INSERIR VALORES AJUSTE CONTABIL*/

INSERT INTO 
RtAjusteCon (RtAjusteConEstCod, RtAjusteConNsu, RtAjusteConAutCod, RtAjusteConTrnCod, RtAjusteConValor, RtAjusteConData, 
RtAjusteConBan, RtAjusteConPrd, RtAjusteConGuid, RtAjusteConDataInc, RtAjusteConUsrId)
SELECT @ESTCOD, 0, '', VlpTrnCod, VlpVlrPag, VlpDtaVct, '', VlpTipPrd, @RELGUID, @DATAINC, @UsrId
FROM VLRPAG
WHERE EstCod = @ESTCOD
AND VlpBnfCod = @ESTCOD
AND TidCod = 1
AND VlpTrnCod = 'CS'
AND VlpStspag = 12

INSERT INTO RtAnalitico (RtAnaliticoEstCod, RtAnaliticoNsu, RtAnaliticoAutcod, RtAnaliticoDataTrn, RtAnaliticoProduto,
RtAnaliticoBandeira, RtAnaliticoTrnCod, RtAnaliticoValorTrn, RtAnaliticoValorLiqEst, RtAnaliticoValorPago,
RtAnaliticoValorAberto, RtAnaliticoValorCancelado, RtAnaliticoCessao, RtAnaliticoValorAnt, RtAnaliticoCessaoBNF,
RtAnaliticoValorPagoBNF, RtAnaliticoValorConc, RtAnaliticoValorEstorno, RtAnaliticoValorAjusteContabil, RtAnaliticoValorAjusteCessao, RtAnaliticoGuid, RtAnaliticoDataInc, RtAnaliticoUsr)
SELECT @ESTCOD, 0, '', VlpDtaVct, VlpTipPrd, VlpBan, VlpTrnCod, 
VlpVlrPag, -- VALOR TRN
VlpVlrPag, -- VALOR LIQ EST
0, -- VALOR PAGO
0, -- VALOR ABERTO
0, -- VALOR CANCELADO
0, -- VALOR CESSAO
0, -- VALOR ANTECIPACAO
0, -- VALOR CESSAO BNF
0, -- VALOR PAGO BNF
0, -- VALOR CONC
0, --VALOR ESTORNO
0, --VALOR AJUSTE CONTABIL
VlpVlrPag, --VALOR AJUSTE CESSAO
@RELGUID, 
@DATAINC, 
@UsrId
FROM VLRPAG
WHERE EstCod = @ESTCOD
AND VlpBnfCod = @ESTCOD
AND TidCod = 1
AND VlpTrnCod = 'CS'
AND VlpStspag = 12


INSERT INTO 
RtAjusteCon (RtAjusteConEstCod, RtAjusteConNsu, RtAjusteConAutCod, RtAjusteConTrnCod, RtAjusteConValor, RtAjusteConData, 
RtAjusteConBan, RtAjusteConPrd, RtAjusteConGuid, RtAjusteConDataInc, RtAjusteConUsrId)
SELECT @ESTCOD, 0, '', 'CS', VwRelAudCessaoDetValor, CONVERT(DATE, VwRelAudCessaoDtaCad), '', '', @RELGUID, @DATAINC, @UsrId
FROM VwRelAudCessao 
WHERE VwRelAudCessaoBenEstCod = @ESTCOD AND VwRelAudVlpTrnCod IS NULL


INSERT INTO RtAnalitico (RtAnaliticoEstCod, RtAnaliticoNsu, RtAnaliticoAutcod, RtAnaliticoDataTrn, RtAnaliticoProduto,
RtAnaliticoBandeira, RtAnaliticoTrnCod, RtAnaliticoValorTrn, RtAnaliticoValorLiqEst, RtAnaliticoValorPago,
RtAnaliticoValorAberto, RtAnaliticoValorCancelado, RtAnaliticoCessao, RtAnaliticoValorAnt, RtAnaliticoCessaoBNF,
RtAnaliticoValorPagoBNF, RtAnaliticoValorConc, RtAnaliticoValorEstorno, RtAnaliticoValorAjusteContabil, RtAnaliticoValorAjusteCessao, RtAnaliticoValorAjusteCessaoBnf, RtAnaliticoGuid, RtAnaliticoDataInc, RtAnaliticoUsr)
SELECT 
@ESTCOD, 0, '', CONVERT(DATE, VwRelAudCessaoDtaCad), 'Cessao', '', 'CS', 
VwRelAudCessaoDetValor, --VALOR TRN
VwRelAudCessaoDetValor, --VALOR LIQ EST
0,--VALOR PAGO
0,--VALOR ABERTO
0,--VALOR CANCELADO
0,--VALOR CESSAO
0,--VALOR ANT
0,--VALOR CESSAO BNF
0,--VALOR PAGO BNF
0,--VALOR CONC
0,--VALOR ESTORNO
0,--VALOR AJUSTE CONTABIL
0,--AJUSTE CESSAO
VwRelAudCessaoDetValor,--AJUSTE CESSAO BNF
@RELGUID, 
@DATAINC, 
@UsrId
FROM VwRelAudCessao 
WHERE VwRelAudCessaoBenEstCod = @ESTCOD AND VwRelAudVlpTrnCod IS NULL


INSERT INTO 
RtAjusteCon (RtAjusteConEstCod, RtAjusteConNsu, RtAjusteConAutCod, RtAjusteConTrnCod, RtAjusteConValor, RtAjusteConData, 
RtAjusteConBan, RtAjusteConPrd, RtAjusteConGuid, RtAjusteConDataInc, RtAjusteConUsrId)
SELECT @ESTCOD, 0, '', VlpTrnCod, VlpVlrPag, VlpDtaVct, '', VlpTipPrd, @RELGUID, @DATAINC, @UsrId
FROM VLRPAG
WHERE EstCod = @ESTCOD
AND VlpBnfCod = @ESTCOD
AND TidCod = 1
AND VlpTrnCod = 'AB'
AND VlpStspag = 12

INSERT INTO RtAnalitico (RtAnaliticoEstCod, RtAnaliticoNsu, RtAnaliticoAutcod, RtAnaliticoDataTrn, RtAnaliticoProduto,
RtAnaliticoBandeira, RtAnaliticoTrnCod, RtAnaliticoValorTrn, RtAnaliticoValorLiqEst, RtAnaliticoValorPago,
RtAnaliticoValorAberto, RtAnaliticoValorCancelado, RtAnaliticoCessao, RtAnaliticoValorAnt, RtAnaliticoCessaoBNF,
RtAnaliticoValorPagoBNF, RtAnaliticoValorConc, RtAnaliticoValorEstorno, RtAnaliticoValorAjusteContabil, RtAnaliticoValorAjusteCessao, RtAnaliticoValorAjusteCessaoBnf, RtAnaliticoValorAjusteBanco, RtAnaliticoGuid, RtAnaliticoDataInc, RtAnaliticoUsr)
SELECT @ESTCOD, 0, '', VlpDtaVct, VlpTipPrd, VlpBan, VlpTrnCod, 
VlpVlrPag, -- VALOR TRN
VlpVlrPag, -- VALOR LIQ EST
0, -- VALOR PAGO
0, -- VALOR ABERTO
0, -- VALOR CANCELADO
0, -- VALOR CESSAO
0, -- VALOR ANTECIPACAO
0, -- VALOR CESSAO BNF
0, -- VALOR PAGO BNF
0, -- VALOR CONC
0, --VALOR ESTORNO
0, --VALOR AJUSTE CONTABIL
0, --VALOR AJUSTE CESSAO
0, --VALOR AJUSTE CESSAO BNF
VlpVlrPag, --VALOR AJUSTE Banco
@RELGUID, 
@DATAINC, 
@UsrId
FROM VLRPAG
WHERE EstCod = @ESTCOD
AND VlpBnfCod = @ESTCOD
AND TidCod = 1
AND VlpTrnCod = 'AB'
AND VlpStspag = 12


INSERT INTO 
RtAjusteCon (RtAjusteConEstCod, RtAjusteConNsu, RtAjusteConAutCod, RtAjusteConTrnCod, RtAjusteConValor, RtAjusteConData, 
RtAjusteConBan, RtAjusteConPrd, RtAjusteConGuid, RtAjusteConDataInc, RtAjusteConUsrId)
SELECT @ESTCOD, 0, '', VlpTrnCod, VlpVlrPag, VlpDtaVct, '', VlpTipPrd, @RELGUID, @DATAINC, @UsrId
FROM VLRPAG
WHERE EstCod = @ESTCOD
AND VlpBnfCod = @ESTCOD
AND TidCod = 1
AND VlpTrnCod = 'AC'
AND VlpStspag = 12
AND VlpNsu = 0

INSERT INTO RtAnalitico (RtAnaliticoEstCod, RtAnaliticoNsu, RtAnaliticoAutcod, RtAnaliticoDataTrn, RtAnaliticoProduto,
RtAnaliticoBandeira, RtAnaliticoTrnCod, RtAnaliticoValorTrn, RtAnaliticoValorLiqEst, RtAnaliticoValorPago,
RtAnaliticoValorAberto, RtAnaliticoValorCancelado, RtAnaliticoCessao, RtAnaliticoValorAnt, RtAnaliticoCessaoBNF,
RtAnaliticoValorPagoBNF, RtAnaliticoValorConc, RtAnaliticoValorEstorno, RtAnaliticoValorAjusteContabil, RtAnaliticoValorAjusteCessao, RtAnaliticoValorAjusteCessaoBnf, RtAnaliticoValorAjusteBanco, RtAnaliticoGuid, RtAnaliticoDataInc, RtAnaliticoUsr)
SELECT @ESTCOD, 0, '', VlpDtaVct, VlpTipPrd, VlpBan, VlpTrnCod, 
VlpVlrPag, -- VALOR TRN
VlpVlrPag, -- VALOR LIQ EST
0, -- VALOR PAGO
0, -- VALOR ABERTO
0, -- VALOR CANCELADO
0, -- VALOR CESSAO
0, -- VALOR ANTECIPACAO
0, -- VALOR CESSAO BNF
0, -- VALOR PAGO BNF
0, -- VALOR CONC
0, --VALOR ESTORNO
VlpVlrPag, --VALOR AJUSTE CONTABIL
0, --VALOR AJUSTE CESSAO
0, --VALOR AJUSTE CESSAO BNF
0, --VALOR AJUSTE Banco
@RELGUID, 
@DATAINC, 
@UsrId
FROM VLRPAG
WHERE EstCod = @ESTCOD
AND VlpBnfCod = @ESTCOD
AND TidCod = 1
AND VlpTrnCod = 'AC'
AND VlpStspag = 12
AND VlpNsu = 0
/*ALTERACAO V8 - INSERIR VALORES AJUSTE CONTABIL*/

/*INSERT CONSOLIDADO - INICIO*/
SELECT @MOVTRNVLRVENDA = COALESCE(SUM(MovTrnVlr), 0), @MOVTRNVLRLIQVENDA = COALESCE(SUM(MovTrnVlrLiqEst),0) 
FROM MovTrn01 WHERE EstCod = @ESTCOD AND MovTrnCod <> 'CC';

SELECT @MOVTRNVLRCANC = COALESCE(SUM(MovTrnVlr),0), @MOVTRNVLRLIQCANC = COALESCE(SUM(MovTrnVlrLiqEst),0) 
FROM MovTrn01 WHERE EstCod = @ESTCOD AND MovTrnCod = 'CC';

SELECT @TOTALANT = COALESCE(SUM(RtAnaliticoValorAnt),0), @TOTALABERTO = COALESCE(SUM(RtAnaliticoValorAberto),0),
@TOTALDETCESSAOORI = COALESCE(SUM(RtAnaliticoCessao),0), @TOTALDETCESSAOBEN = COALESCE(SUM(RtAnaliticoCessaoBnf),0),
@TOTALPAGO = COALESCE(SUM(RtAnaliticoVALORPAGO),0), @TOTALPAGOBNF = COALESCE(SUM(RtAnaliticoVALORPAGOBNF),0),
@TOTALESTORNO = COALESCE(SUM(RtAnaliticoValorEstorno),0), @TOTALAJUSTECONTABIL = COALESCE(SUM(RtAnaliticoValorAjusteContabil),0), 
@TOTALAJUSTECESSAO = COALESCE(SUM(RtAnaliticoValorAjusteCessao),0), @TOTALDETCESSAOBENAJUSTE = COALESCE(SUM(RtAnaliticoValorAjusteCessaoBnf),0), 
@TOTALBANCOAJUSTE = COALESCE(SUM(RtAnaliticoValorAjusteBanco),0)
FROM RtAnalitico
WHERE RtAnaliticoEstCod = @ESTCOD;

SET @TOTALDETCESSAOORI = @TOTALDETCESSAOORI + @TOTALAJUSTECESSAO;
SET @TOTALDETCESSAOBEN = @TOTALDETCESSAOBEN + @TOTALDETCESSAOBENAJUSTE;

/*CONSIDERAR APENAS O ALUGUEL PAGO*/
SELECT @TOTALALUGUEL = COALESCE(SUM(VLPVLRPAG), 0)
FROM VLRPAG
WHERE EstCod = @ESTCOD AND VlpTrnCod = 'AL' AND TidCod = 2
AND VlpStspag = 2;

/*SOMAR ALUGUEL EM ABERTO COM VALOR EM ABERTO */
SELECT @ALUGUELABERTO = COALESCE(SUM(VLPVLRPAG), 0)
FROM VLRPAG
WHERE EstCod = @ESTCOD AND VlpTrnCod = 'AL' AND TidCod = 2
AND VlpStspag = 1;

--SET @TOTALABERTO = @TOTALABERTO + @ALUGUELABERTO; nao precisa mais pq ja compoe no analitico

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
RtConsolidadoAluguelPos, RtConsolidadoEstorno, RtConsolidadoAjusteContabil, RtConsolidadoAjusteCessao, RtConsolidadoAjusteCessaoBnf, RtConsolidadoAjusteBanco, RTCONSOLIDADOGUID)
VALUES (
@ESTCOD, @MOVTRNVLRVENDA, @MOVTRNVLRLIQVENDA, @TOTALABERTO, @MOVTRNVLRLIQCANC, (@MOVTRNVLRLIQVENDA + @MOVTRNVLRLIQCANC), 
@TOTALCESSAOORI, @TOTALDETCESSAOORI, @TOTALCESSAOBEN, @TOTALDETCESSAOBEN, @TOTALARQUIVO, @TOTALANT, (@TOTALPAGO + @TOTALPAGOBNF + @TOTALBANCOAJUSTE),
@TOTALALUGUEL, @TOTALESTORNO, @TOTALAJUSTECONTABIL, @TOTALAJUSTECESSAO, @TOTALDETCESSAOBENAJUSTE, @TOTALBANCOAJUSTE, @RELGUID
)
/*INSERT CONSOLIDADO - FIM*/
END