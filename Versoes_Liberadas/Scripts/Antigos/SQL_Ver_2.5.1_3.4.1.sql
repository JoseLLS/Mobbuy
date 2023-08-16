/* TAREFA #20035- JOSÉ */

--Rodar script em todos os clientes
DROP INDEX [IHIERARQUIACOMERCIAL1] ON [HIERARQUIACOMERCIAL]

CREATE NONCLUSTERED INDEX [UHIERARQUIACOMERCIAL] ON [HIERARQUIACOMERCIAL] ( 
      [PacCod], 
      [HierarquiaPai])

/* TAREFA #20046 - WESLEY */

USE [Pronto]
GO

/****** Object:  View [dbo].[Est08_Aux03]    Script Date: 25/11/2022 10:52:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[Est08_Bloqueio_EfeitoContrato] as 

select 
      E.EstCod                                                           AS 'Estcod',
	  EC.EfeitoContratoTitular                                           AS 'EstcpfCnpj',
      CASE 
	      WHEN EC.Data_Vencimento >= GETDATE() AND NOT EC.EfeitoContratoTitular IS NULL AND EC2.EfeitoContratoSituacao not in ('B','R') THEN 'S' 
		  WHEN E.EstPermiteCessao = 0 THEN 'S' 
		  ELSE 'N' 
	  END                                                                AS 'Bloqueio',
	  CASE 
	      WHEN EC.Data_Vencimento >= GETDATE() AND NOT EC.EfeitoContratoTitular IS NULL AND EC2.EfeitoContratoSituacao not in ('B','R') THEN 'Bloqueio efeito de contrato.' 
		  WHEN E.EstPermiteCessao = 0 THEN 'Estabelecimento não tem permissão para gerar cessão.' 
		  ELSE '' 
	  END                                                                AS 'MotivoBloqueio',
	  EC2.EfeitoContratoDtaVenc                                          AS 'DataVencimento',
	  EC2.EfeitoContratoSituacao                                         AS 'Situacao',
	  CASE 
		  WHEN EC2.EfeitoContratoDtaVenc < GETDATE() OR EC.EfeitoContratoTitular IS NULL OR EC2.EfeitoContratoSituacao in ('B','R') THEN 'OK' ELSE '' 
	  END                                                                AS 'Status'
from Est E

LEFT JOIN (select EfeitoContratoEstCod,
                  EfeitoContratoTitular,
                  max(EfeitoContratoDtaVenc) as 'Data_Vencimento'
		   from EfeitoContrato with(nolock) where EfeitoContratoAprovado = 1 group by EfeitoContratoEstCod,EfeitoContratoTitular) EC
     ON  E.EstCod = EC.EfeitoContratoEstCod 

LEFT JOIN (SELECT EfeitoContratoEstCod,
                  EfeitoContratoTitular,
				  EfeitoContratoDtaVenc,
				  EfeitoContratoSituacao
				  FROM EfeitoContrato
				  GROUP BY EfeitoContratoEstCod, EfeitoContratoTitular, EfeitoContratoDtaVenc, EfeitoContratoSituacao) EC2
ON EC2.EfeitoContratoEstCod  = EC.EfeitoContratoEstCod  AND 
   EC2.EfeitoContratoTitular = EC.EfeitoContratoTitular AND 
   EC2.EfeitoContratoDtaVenc = EC.Data_Vencimento

GO

---------------------------------------------------------------------------------------------------------------------------------

USE [Pronto]
GO

/****** Object:  View [dbo].[Est08_Aux10]    Script Date: 25/11/2022 10:51:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE View [dbo].[Est08_VlrPag_Aberto] as 

SELECT 
      EstCod, 
	  VlpVlrPag,
	  VlpDtaVct,
	  VlpTipPrd
FROM VLRPAG with(nolock) where VlpStsPag = 1

GO

---------------------------------------------------------------------------------------------------------------------------------

USE [Pronto]
GO

/****** Object:  View [dbo].[Est08]    Script Date: 25/11/2022 10:58:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[Est08] as 

SELECT 
	  E.EstCod                                                                                                                           AS 'VwSdEstcod',
      E.EstNomFan                                                                                                                        AS 'VwSdEstNom',
      ISNULL(Convert(Numeric(15),B.EstcpfCnpj),E.EstCpfCnpj)                                                                             AS 'VwSdEstcpfCnpj',
	  E.EstTip                                                                                                                           AS 'VwSdEstTipo',
	  B.Bloqueio                                                                                                                         AS 'VwSdBloqueio',
	  B.MotivoBloqueio                                                                                                                   AS 'VwSdMotivoBloqueio', 
	  ISNULL(SUM(A.VlpVlrPag),0)                                                                                                         AS 'VwSdSaldoTotal',
	  CASE WHEN B.Status = 'OK' THEN SUM(CASE WHEN A.VlpTipPrd = 'C' THEN A.VlpVlrPag ELSE 0 END) ELSE 0 END                             AS 'VwSdSaldoAberto', 
	  CASE WHEN B.Status = 'OK' THEN ISNULL(C.EstVlrCessao, 0) ELSE 0 END                                                                AS 'VwSdSaldoReservado',
	  CASE WHEN B.Status = 'OK' THEN SUM(CASE WHEN A.VlpTipPrd = 'C' THEN A.VlpVlrPag ELSE 0 END) - ISNULL(C.EstVlrCessao, 0) ELSE 0 END AS 'VwSdSaldoDisponivelCessao',
	  B.DataVencimento                                                                                                                   AS 'VwSdDtaVenc',
	  B.Situacao                                                                                                                         AS 'VwEfeitoContratoSituacao',
	  ROUND(CASE WHEN CAST(SUM(A.VlpVlrPag) AS numeric(18,2)) = 0 THEN  0 ELSE
				 ROUND(SUM(DATEDIFF(day,GETDATE(),A.VlpDtaVct) * A.VlpVlrPag) / CAST(SUM(A.VlpVlrPag) AS numeric(18,2)),0) END,2)        AS 'VwSdPrazoMedio'

FROM EST E with(nolock)

--EC BLOQUEIO
LEFT JOIN Est08_Bloqueio_EfeitoContrato B
     ON E.EstCod = B.Estcod

--VLRPAG COM STS = 1
LEFT JOIN (SELECT EstCod, 
	              VlpVlrPag,
	              VlpDtaVct,
	              VlpTipPrd  FROM Est08_VlrPag_Aberto) A
     ON E.EstCod = A.EstCod

--CESSOES
LEFT JOIN Est07 C with(nolock)
     ON E.EstCod = C.EstCodCessao

GROUP BY E.EstCod,
         E.EstNomFan, 
		 E.EstCpfCnpj,
		 E.EstTip,
		 B.Bloqueio,
		 B.MotivoBloqueio,
		 B.EstcpfCnpj,
		 B.Status,
		 B.DataVencimento,
		 B.Situacao,
		 C.EstVlrCessao

GO

/* TAREFA #20070 - JOSÉ */

CREATE NONCLUSTERED INDEX [UHIERARQUIACOMERCIAL1] ON [HIERARQUIACOMERCIAL] ( 
      [HierarquiaPai])

/* SEM TAREFA - JOSÉ */

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpExecutaJobs', 'wpExecutaJobs', 'Executa robôs', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpExecutaJobs', '', 105, 'TAB_GER', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'wpExecutaJobs')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'wpExecutaJobs')

/* TAREFA #20006 - WESLEY */

ALTER TABLE [MovTrn01] ADD [MovTrnExpControleSaldo] BIT    NULL
ALTER TABLE [VLRPAG]   ADD [VlrPagExpControleSaldo] BIT    NULL

update parsis set parcon = '003.00' where parcod = 'VERSAO_LAYOUT'
 --ANTIGO - 001.7e

 /* TAREFA #20170 - LEONARDO */

 USE PRONTO
GO

UPDATE sse2_mnu02 SET MnuIteIdRoot = 'CTR_FIN'
WHERE MnuIteIde = 'AuditoriaTransacao'

USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[RELTEMPAUDITORIA]    Script Date: 29/11/2022 12:05:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE [RELTEMPAUDITORIA]

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
DECLARE @TOTALESTORNO NUMERIC(18,2);
DECLARE @TOTALALUGUEL NUMERIC(18,2);
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

/*ANALITICO LANÇAMENTO DE ALGUEL POS SE TIVER ABERTO - INICIO*/
/*
INSERT INTO RtAberto (RtAbertoEstCod, RtAbertoNsu, RtAbertoAutCod, RtAbertoDataTrn, RtAbertoProduto, RtAbertoBandeira,
RtAbertoTrnCod, RtAbertoValorTrn, RtAbertoValorLIQEST, RtAbertoValor, RtAbertoDataInc, RtAbertoGuid)
SELECT @ESTCOD, 0, '', B.VlpDtaVct, 
'L', '', 'AL', 0, 0, B.VALORABERTO, @DATAINC, @RELGUID
FROM 
(SELECT SUM(VlpVlrPag) VALORABERTO, VlpDtaVct 
FROM VLRPAG
WHERE VlpTrnCod = 'AL' 
AND VLPBNFCOD = @ESTCOD
AND ESTCOD = @ESTCOD
AND VlpStspag = 1
AND TidCod = 2
GROUP BY VlpDtaVct) B;
*/
/*ANALITICO LANÇAMENTO DE ALUGUEL POS SE TIVER ABERTO - FIM*/

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

SET @TOTALABERTO = @TOTALABERTO + @ALUGUELABERTO;

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