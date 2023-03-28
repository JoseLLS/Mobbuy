/* TAREFA #20322 - JOSÉ */

--Rodar script em todos os bancos
ALTER VIEW [dbo].[RelatorioBaseTributacao]
AS
SELECT 	
	M.EstCod AS 'RelBaseTribCodigo',
	E.EstAplPsq AS 'RelBaseTribEstabelecimento',
	E.EstSegmento AS 'RelBaseTribSegmentos',
	E.EstNomFan AS 'RelBaseTribNomeFantasia',
	E.EstCpfCnpj AS 'RelBaseTribCNPJ',
	E.EstTip AS 'RelBaseTribEstTipo',
	M.MovTrnDta AS 'RelBaseTribData',
	SUM(MovTrnVlr) AS 'RelBaseTribValorVenda', 	  
	SUM(MovTrnVlrLiqEst) AS 'RelBaseTribValorEstabelecimento',		
	SUM(MovTrnBfaVlrTxaAdm) AS 'RelBaseTribTaxaAdministracao',	
	SUM(MovTrnBfaVlrTxaFin) AS 'RelBaseTribReceitaAntecipacao',
	SUM(MovTrnGbpVlrTxaInt) AS 'RelBaseTribTaxaAdquirente',
	SUM(MovTrnVlr - MovTrnVlrLiqEst - MovTrnGbpVlrTxaInt - MovTrnGbpVlrTxaAnt) AS 'RelBaseTribReceitaLiquida',
	SUM(MovTrnGbpVlrTxaAnt) AS 'RelBaseTribTaxaAntAdq'
FROM MovTrn01 M
	LEFT JOIN EST E ON E.EstCod = M.EstCod
	WHERE MovTrnCod IN ('CV', 'CC')
	GROUP BY M.EstCod, E.EstNomFan, E.EstAplPsq, E.EstCpfCnpj, E.EstTip, E.EstSegmento, M.MovTrnDta
GO

/* TAREFA #20357 - JOSÉ */

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('CadastroTela', 'CadastroTela', 'Cadastro de telas', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'CadastroTela', '', 160, 'TAB_GER', '', '/pronto/servlet/') --Mudar onde está 'pronto' conforme cliente

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'CadastroTela') --Verificar a unidade de negócio para modificar de '25' se for diferente da Pronto

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'CadastroTela') --Verificar a unidade de negócio para modificar de '25' se for diferente da Pronto

/* TAREFA #20382 - WESLEY */

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wplogsistema', 'wplogsistema', 'Logs do Sistema', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wplogsistema', '', 103, 'TAB_GER', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'wplogsistema')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'wplogsistema')

INSERT INTO [dbo].[PARSIS]
           ([ParCod]
           ,[ParDsc]
           ,[ParTipPar]
           ,[ParTamPar]
           ,[ParQtdDec]
           ,[ParIndSin]
           ,[ParCon]
           ,[ParUsuInc]
           ,[ParDtiInc]
           ,[ParUsuAlt]
           ,[ParDtiAlt]
           ,[ParFlgInt])
     VALUES
           ('DIRETORIO_LOGSIS' 
           ,'Diretorio onde fica os logs do sistema'
           ,'CA'
           ,10
           ,NULL
		   ,'N'
           ,'/mnt/home1/sistema/logs'
           ,NULL
           ,NULL
           ,NULL
           ,'2022-12-13 15:00:36.000'
           ,0)
GO

/* TAREFA #20399 - WESLEY */

USE [Pronto]
GO

/****** Object:  View [dbo].[Est08]    Script Date: 14/12/2022 12:18:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[Est08] as 

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
	  ISNULL(CASE WHEN ROUND(CASE WHEN CAST(SUM(A.VlpVlrPag) AS numeric(18,2)) = 0 THEN  0 ELSE
		     ROUND(SUM(DATEDIFF(day,GETDATE(),A.VlpDtaVct) * A.VlpVlrPag) / CAST(SUM(A.VlpVlrPag) AS numeric(18,2)),0) END,2) < 0 THEN 0
			 ELSE
			 ROUND(CASE WHEN CAST(SUM(A.VlpVlrPag) AS numeric(18,2)) = 0 THEN  0 ELSE
		     ROUND(SUM(DATEDIFF(day,GETDATE(),A.VlpDtaVct) * A.VlpVlrPag) / CAST(SUM(A.VlpVlrPag) AS numeric(18,2)),0) END,2) END, 0)
                                                                                                                                         AS 'VwSdPrazoMedio'

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

/* TAREFA #20063 - LEONARDO */

CREATE TABLE [CercAgenda] (
  [CercAgendaId]             DECIMAL(10)    NOT NULL    IDENTITY ( 1 , 1 ),
  [CercAgendaTitular]        VARCHAR(14)    NULL,
  [CercAgendaDataVencimento] DATETIME    NULL,
  [CercAgendaArranjo]        VARCHAR(4)    NULL,
  [CercAgendaValor]          DECIMAL(17,2)    NULL,
  [CercAgendaDataInc]        DATETIME    NULL,
  [CercAgendaStatus]         BIT    NULL,
  [CercAgendaReferencia]     VARCHAR(40)    NULL,
     PRIMARY KEY ( [CercAgendaId] ))
CREATE UNIQUE NONCLUSTERED INDEX [UCERCAGENDACHAVE] ON [CercAgenda] (
      [CercAgendaTitular],
      [CercAgendaArranjo],
      [CercAgendaDataVencimento],
      [CercAgendaValor])
CREATE UNIQUE NONCLUSTERED INDEX [UCERCAGENDAREFERENCIA] ON [CercAgenda] (
      [CercAgendaReferencia])
	  
	  
INSERT INTO PARSIS (PARCOD, ParDsc, ParTipPar, ParTamPar, ParCon)
VALUES ('CERC_AGD_METODO', 'METODO CONSULTA AGENDA CERC', 'CA', 300, 'consultar?online=true')

INSERT INTO PARSIS (PARCOD, ParDsc, ParTipPar, ParTamPar, ParCon)
VALUES ('CERC_AGD_BASE_URL', 'BASE URL CONSULTA AGENDA CERC', 'CA', 300, '/v15/agenda/')

INSERT INTO PARSIS (PARCOD, ParDsc, ParTipPar, ParTamPar, ParCon)
VALUES ('CERC_AGD_DTA_INI', 'DATA INICIAL CONSULTA AGENDA', 'CA', 300, '2022-01-01')

INSERT INTO PARSIS (PARCOD, ParDsc, ParTipPar, ParTamPar, ParCon)
VALUES ('CERC_AGD_DTA_FIM', 'DATA FINAL CONSULTA AGENDA', 'CA', 300, '2022-06-20')

INSERT INTO PARSIS (PARCOD, ParDsc, ParTipPar, ParTamPar, ParCon)
VALUES ('CERC_AGD_TIPO_AVALIACAO', 'TIPO DE AVALIACAO AGENDA', 'CA', 300, 'avaliacao_agenda_completa_ap')

INSERT INTO PARSIS (PARCOD, ParDsc, ParTipPar, ParTamPar, ParCon)
VALUES ('CERC_AGD_ARQ_ESTCOD', 'CAMINHO ARQUIVO TXT ESTABELECIMENTOS', 'CA', 300, 'D:\temp\Estabelecimentos.txt')

/* TAREFA #20466 - WESLEY */

ALTER TABLE [EST] ADD [ESTFlagExtratoFin] BIT NULL

/* TAREFA #20478 - LEONARDO */

/****** Object:  View [dbo].[VwEfeArb]    Script Date: 20/12/2022 10:56:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[VwEfeArb] as 
	SELECT 
	NewID()                         AS 'VwEfeArbGuid',
	A.ArbDetEstCod 'VwEfeArbEstCod', 
	A.ArbNum 'VwEfeArbNum',
	A.ArbLotNum 'VwEfeArbLotNum',
	A.ArbDetSeq 'VwEfeArbDetSeq' 
	FROM ARQDET A
	INNER JOIN EfeitoContrato B
	ON A.ArbNum = B.EfeitoContratoArbNum AND A.ArbLotNum = B.EfeitoContratoArbLotNum 
	AND A.ArbDetSeq = B.EfeitoContratoArbDetSeq AND A.ArbDetEstCod = B.EfeitoContratoEstCod
	WHERE A.ArbDetCodSit IN (0,4)
	GROUP BY
	A.ArbDetEstCod, 
	A.ArbNum,
	A.ArbLotNum,
	A.ArbDetSeq
GO


CREATE view [dbo].[VwEfeVlr] as 

	SELECT
	NewID() 'VwEfeVlrGuid',
	EfeitoContratoDtaVenc 'VwEfeVencimento',
	EfeitoContratoEstCod 'VwEfeEstCod',
	REPASSE 'VwEfeValor',
	EstCod 'VwVlrEstCod',
	VlpDtaVct 'VwVlrDtaVct',
	VALOR 'VwVlrValor'
	FROM (
	SELECT EfeitoContratoDtaVenc,
	EfeitoContratoEstCod,
	SUM(EfeitoContratoVlrRepasse) 'REPASSE'
	FROM EfeitoContrato A
	INNER JOIN VWEFEARB B
	ON A.EfeitoContratoEstCod = B.VWEFEARBESTCOD
	AND A.EfeitoContratoArbNum = B.VWEFEARBNUM
	AND A.EfeitoContratoArbLotNum = B.VWEFEARBLOTNUM
	AND A.EfeitoContratoArbDetSeq = B.VWEFEARBDETSEQ
	WHERE  A.EfeitoContratoVlrRepasse <> 0
	GROUP BY EfeitoContratoDtaVenc,
	EfeitoContratoEstCod) A INNER JOIN (
	SELECT EstCod,
	VlpDtaVct,
	SUM(VlpVlrEfeito) 'VALOR'
	FROM VLRPAG A
	WHERE VlpVlrEfeito <> 0
	GROUP BY
	EstCod,
	VlpDtaVct) B
	ON A.EfeitoContratoEstCod = B.EstCod AND A.EfeitoContratoDtaVenc = B.VlpDtaVct

GO

/* TAREFA #20337 - JOSÉ */

--Banco Monitor
--Rodar em todos os bancos de Monitoramento
INSERT INTO Parametro
VALUES ('PERC_VARIACAO_ESTATISTICA', 'Percentual de variação da base estatística para geração de alerta.', '300')

INSERT INTO Parametro
VALUES ('E-MAIL_ESTATISTICA', 'E-mail padrão para alertas da base estatística.', '')

ALTER TABLE [Transacao]
ADD [TransacaoEstSegmento] NVARCHAR(40)    NULL

ALTER TABLE [Ocorrencia]
ADD [OcorrenciaEstSegmento] NVARCHAR(40)    NULL

CREATE NONCLUSTERED INDEX [UMOVIMENTACAOTRANSFERENCIA] ON [MovimentacaoTransferencia] (
      [MovTransferenciaAno] DESC,
      [MovTransferenciaMes] DESC,
      [TipoReferenciaId],
      [MovTransferenciaEstCod])
	  
CREATE NONCLUSTERED INDEX [UTRANSACAO15] ON [Transacao] (
      [TransacaoData] DESC,
      [TransacaoEc])

--Banco Retaguarda
--Rodar em todos os clientes que usa o sistema de Monitoramento, alterando o parâmetro para cada cliente conforme sua respectiva URL
INSERT INTO PARSIS
VALUES ('API_MONITOR_PERC_ESTAT','Url da API de percentual estatística do Monitor','VA',40,NULL,'N','https://app-prd.semprepronto.com.br/MonitoramentoPronto/rest/Alerta_Percentual_Estatistica','ADMIN','2022-12-26 09:59:00.000',NULL,NULL,0)

/* TAREFA #20491 - WESLEY */

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpDeleteLogSistema', 'wpDeleteLogSistema', 'Deletar Logs', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpDeleteLogSistema', '', 103, 'TAB_GER', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'wpDeleteLogSistema')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'wpDeleteLogSistema')

/* SEM TAREFA - JOSÉ */

--Rodar em todos os bancos de clientes
CREATE NONCLUSTERED INDEX [UUSUEST1] ON [USUEST] (
      [UEstCod],
      [UEstEma])

/* TAREFA #20496 - JOSÉ */

--Rodar script em todos os bancos de clientes que irá ser atualizada a versão
ALTER VIEW [dbo].[VwMovTrn] AS
SELECT
A.MovTrnId                             AS 'VwMovTrnId',
A.MovTrnDta                            AS 'VwMovTrnDta',
A.MovTrnNsu                            AS 'VwMovTrnNsu',
A.MovTrnAutCod                         AS 'VwMovTrnAutCod',
A.MovTrnVlr                            AS 'VwMovTrnVlr',
A.MovTrnNsuMovOri                      AS 'VwMovTrnNsuMovOri',
ISNULL(D.TblBanSigla, '0')             AS 'VwMovTrnBan',
ISNULL(D.TblBanBandeira, 'MarketPay')  AS 'VwMovTrnBanDsc',
A.MovTrnTipPrd                         AS 'VwMovTrnTipPrd',
CASE
	WHEN A.MovTrnCod = 'AJ' THEN 'Ajuste'
	WHEN A.MovTrnCod = 'CC' THEN 'Cancelamento'
	WHEN A.MovTrnCod = 'PS' THEN 'Prestação de serviço'
	WHEN A.MovTrnTipPrd = 'D'  THEN 'Débito'
	WHEN A.MovTrnTipPrd = 'V'  THEN 'Voucher'
	WHEN A.MovTrnTipPrd = 'C' AND A.MovTrnParQtd = 1 THEN 'Crédito a vista'
	WHEN A.MovTrnTipPrd = 'C' AND A.MovTrnParQtd > 1 AND A.MovTrnParIndBemFac = 'N' THEN 'Crédito parcelado'
	WHEN A.MovTrnTipPrd = 'C' AND A.MovTrnParQtd > 1 AND A.MovTrnParIndBemFac = 'S' THEN 'Crédito parcelado BF'
END                  AS 'VwMovTrnTipo',
A.MovTrnCod          AS 'VwMovTrnCod',
A.MovTrnParQtd       AS 'VwMovTrnParQtd',
A.MovTrnParVlr		 AS 'VwMovTrnParVlr',		--NOVO  14/03/2022
A.MovTrnParIndBemFac AS 'VwMovTrnParIndBemFac',
A.MovTrnVlrLiqBemFac AS 'VwMovTrnVlrLiqBemFac',
A.MovTrnVlrLiqEst    AS 'VwMovTrnVlrLiqEst',
A.MovTrnBfaVlrTxaAnt AS 'VwMovTrnBfaVlrTxaAnt',
A.EstCod             AS 'VwMovTrnEstCod',
B.EstNomFan          AS 'VwMovTrnEstNomFan',
B.EstPacCod          AS 'VwMovTrnEstPacCod',
B.EstCodMcc          AS 'VwMovTrnEstCodMcc',
B.EstUF              AS 'VwMovTrnEstUF',
B.EstMun             AS 'VwMovTrnEstMun',
B.EstSegmento		 AS 'VwMovTrnEstSegmento',
A.AdqCod             AS 'VwMovTrnAdqCod',
A.MovTrnPacCod       AS 'VwMovTrnPacCod',
C.PacNom             AS 'VwMovTrnPacNom',
A.MovTrnGbpVlrTxaAdm AS 'VwGbpVlrTxaAdm',
A.MovTrnGbpVlrTxaInt AS 'vWGbpVlrTxaInt',
A.MovTrnGbpVlrTxaAnt AS 'VwGbpVlrTxaAnt',
A.MovTrnBfaVlrTarCre AS 'vwMovBfaVlrTarCre',
A.MovTrnBfaVlrTxaFin AS 'VwMovTrnBfaVlrTxaFin',
A.MovTrnBfaVlrTxaAdm AS 'VwMovTrnBfaVlrTxaAdm', --NOVO  14/03/2022
A.MovTrnBfaVlrCusTrn AS 'VwMovTrnBfaVlrCusTrn',
A.MovTrnBfaVlrCusCap AS 'VwMovTrnBfaVlrCusCap',	--NOVO  14/03/2022
E.AdqNom             AS 'VwMovTrnAdqNom',
B.EstBai             AS 'VwMovTrnBaiNom',
A.MovTrnIdeTer       AS 'VwMovTrnIdeTer',	    --NOVO 22/06/2022
F.PosCodTmrSfe		 AS 'VwMovTrnPos',
A.MovtrnAnt			 AS 'VwMovTrnAnt',
B.TavNum			 AS 'VwMovTrnTavNum',
A.MovTrnInsTimStp	 AS 'VwMovTrnInsTimStp'

FROM MovTrn01 A
INNER JOIN EST B
	ON A.EstCod = B.EstCod
INNER JOIN PARCOM C
	ON A.MovTrnPacCod = C.PacCod
LEFT JOIN TblBan D
    ON A.MovTrnBan = D.TblBanSigla AND D.TblBanAtivo = 'S'
LEFT JOIN ADQ0001 E
    ON A.AdqCod = E.AdqCod
LEFT JOIN POS F
	ON A.MovTrnPosNum = F.PosNum

GROUP BY A.MovTrnId, A.MovTrnDta, A.MovTrnNsu, A.MovTrnAutCod, A.MovTrnVlr, A.MovTrnNsuMovOri, D.TblBanSigla, D.TblBanBandeira,
         A.MovTrnTipPrd, A.MovTrnCod, A.MovTrnTipPrd, A.MovTrnParQtd, A.MovTrnParVlr, A.MovTrnParIndBemFac, A.MovTrnCod, A.MovTrnParQtd ,
		 A.MovTrnVlrLiqBemFac, A.MovTrnVlrLiqEst, A.MovTrnBfaVlrTxaAnt, A.EstCod, B.EstNomFan, B.EstPacCod, B.EstCodMcc,
		 B.EstUF, B.EstMun, A.AdqCod, A.MovTrnPacCod, C.PacNom, A.MovTrnGbpVlrTxaAdm, A.MovTrnGbpVlrTxaInt, A.MovTrnGbpVlrTxaAnt,
		 A.MovTrnBfaVlrTarCre, A.MovTrnBfaVlrTxaFin, A.MovTrnBfaVlrTxaAdm, A.MovTrnBfaVlrCusTrn, A.MovTrnBfaVlrCusCap,
		 E.AdqNom, B.EstBai, B.EstSegmento, A.MovTrnIdeTer, F.posCodTmrSfe, A.MovtrnAnt, B.TavNum, A.MovTrnInsTimStp
GO
