--use pronto
USE Pronto
GO

INSERT INTO sse2_mnu02 VALUES (10, 0, 'CONCILIA_FIN','Conciliação Financeira',130,'','','')

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpMovDia_Grid', 'wpMovDia_Grid', 'Movimento Diária', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpMovDia_Grid', 'Movimento Diária', 131, 'CONCILIA_FIN', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'wpMovDia_Grid')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'wpMovDia_Grid')


USE PRONTO
GO

CREATE TABLE [ConcResultados] (
  [ConcResultadosSeq]       DECIMAL(12)    NOT NULL    IDENTITY ( 1 , 1 ),
  [ConcResultadosData]      DATETIME    NOT NULL,
  [ConcResultadosVendas]    CHAR(3)    NOT NULL,
  [ConcResultadosMDR]       CHAR(3)    NOT NULL,
  [ConcResultadosAntecip]   CHAR(3)    NOT NULL,
  [ConcResultadosAgenda]    CHAR(3)    NOT NULL,
  [ConcResultadosCessao]    CHAR(3)    NOT NULL,
  [ConcResultadosPrestServ] CHAR(3)    NOT NULL,
  [ConcResultadosPIX]       CHAR(3)    NOT NULL,
  [ConcResultadosCerc]      CHAR(3)    NOT NULL,
  [ConcResultadosAntAdq]    CHAR(3)    NOT NULL,
     PRIMARY KEY ( [ConcResultadosSeq] ))

USE Pronto
GO

CREATE TABLE TabvenSegmento (
	TavNum INT,
	Segmento VARCHAR(100)
)

INSERT INTO TabvenSegmento VALUES 
(2, 'Grupo Comolatti'),
(6, 'Oficina'),
(7, 'PitStop'),
(12, 'Varejo')

USE Pronto
GO

CREATE TABLE [ConcAgenda] (
  [ConcAgendaId]          DECIMAL(18)    NOT NULL IDENTITY ( 1 , 1 ),
  [ConcAgendaData]        DATETIME    NOT NULL,
  [ConcAgendaValorRecPrv] DECIMAL(17,2)    NOT NULL,
  [ConcAgendaValorRecRel] DECIMAL(17,2)    NOT NULL,
  [ConcAgendaValorPagPrv] DECIMAL(17,2)    NOT NULL,
  [ConcAgendaValorPagRel] DECIMAL(17,2)    NOT NULL,
  [ConcAgendaResultado]   VARCHAR(10)    NOT NULL,
     PRIMARY KEY ( [ConcAgendaId] ))

	CREATE TABLE [ConcCessao] (
  [ConcCessaoId]          DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [ConcCessaoData]        DATETIME    NOT NULL,
  [ConcCessaoValorPrv]    DECIMAL(17,2)    NOT NULL,
  [ConcCessaoValorRel]    DECIMAL(17,2)    NOT NULL,
  [ConcCessaoValorNFPrv]  DECIMAL(17,2)    NOT NULL,
  [ConcCessaoValorNFRel] DECIMAL(17,2)    NOT NULL,
  [ConcCessaoResultado]   VARCHAR(10)    NOT NULL,
     PRIMARY KEY ( [ConcCessaoId] ))

CREATE TABLE [ConcAnt] (
  [ConcAntId]        DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [ConcAntData]      DATETIME    NOT NULL,
  [ConcAntValorPrv]  DECIMAL(17,2)    NOT NULL,
  [ConcAntValorRel]  DECIMAL(17,2)    NOT NULL,
  [ConcAntResultado] VARCHAR(10)    NOT NULL,
     PRIMARY KEY ( [ConcAntId] ))

CREATE TABLE [ConcPix] (
  [ConcPixId]        DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [ConcPixData]      DATETIME    NOT NULL,
  [ConcPixValorPrv]  DECIMAL(17,2)    NOT NULL,
  [ConcPixValorRel]  DECIMAL(17,2)    NOT NULL,
  [ConcPixResultado] VARCHAR(10)    NOT NULL,
     PRIMARY KEY ( [ConcPixId] ))

CREATE TABLE [ConcPS] (
  [ConcPSId]          DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [ConcPSData]        DATETIME    NOT NULL,
  [ConcPSValorPrv]    DECIMAL(17,2)    NOT NULL,
  [ConcPSValorRel]    DECIMAL(17,2)    NOT NULL,
  [ConcPSValorComPrv] DECIMAL(17,2)    NOT NULL,
  [ConcPSValorComRel] DECIMAL(17,2)    NOT NULL,
  [ConcPSResultado]   VARCHAR(10)    NOT NULL,
     PRIMARY KEY ( [ConcPSId] ))

CREATE TABLE [ConcMdr] (
  [ConcMdrId]          DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [ConcMdrData]        DATETIME    NOT NULL,
  [ConcMdrValorAdqRel] DECIMAL(17,2)    NOT NULL,
  [ConcMdrValorAdqPrv] DECIMAL(17,2)    NOT NULL,
  [ConcMdrValorCliRel] DECIMAL(17,2)    NOT NULL,
  [ConcMdrValorCliPrv] DECIMAL(17,2)    NOT NULL,
  [ConcMdrResultado]   VARCHAR(10)    NOT NULL,
     PRIMARY KEY ( [ConcMdrId] ))

CREATE TABLE [ConcVendas] (
  [ConcVendasId]           DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [ConcVendasValorCaptura] DECIMAL(17,2)    NOT NULL,
  [ConcVendasValorMob]     DECIMAL(17,2)    NOT NULL,
  [ConcVendasValorAdq]     DECIMAL(17,2)    NOT NULL,
  [ConcVendasData]         DATETIME    NOT NULL,
  [ConcVendasResultado]    VARCHAR(10)    NOT NULL,
     PRIMARY KEY ( [ConcVendasId] ))


CREATE TABLE [ConcCerc] (
  [ConcCercId]            DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [ConcCercData]          DATETIME    NOT NULL,
  [ConcCercMovDiaTrn]     DECIMAL(17,2)    NOT NULL,
  [ConcCercMovDiaReg]     DECIMAL(17,2)    NOT NULL,
  [ConcCercLiqNormalBxd]  DECIMAL(17,2)    NOT NULL,
  [ConcCercLiqNormalPago] DECIMAL(17,2)    NOT NULL,
  [ConcCercLiqAntBxd]     DECIMAL(17,2)    NOT NULL,
  [ConcCercLiqAntPago]    DECIMAL(17,2)    NOT NULL,
  [ConcCercEfeReg]        DECIMAL(17,2)    NOT NULL,
  [ConcCercEfePago]       DECIMAL(17,2)    NOT NULL,
  [ConcCercCessaoBxd]     DECIMAL(17,2)    NOT NULL,
  [ConcCercCessaoPago]    DECIMAL(17,2)    NOT NULL,
  [ConcCercResultado]     VARCHAR(10)    NOT NULL,
     PRIMARY KEY ( [ConcCercId] ))


	 
CREATE UNIQUE NONCLUSTERED INDEX [UCONCCERCDATA] ON [ConcCerc] (
      [ConcCercData])

	  
CREATE UNIQUE NONCLUSTERED INDEX [UCONCAGENDADATA] ON [ConcAgenda] (
      [ConcAgendaData])

	  CREATE UNIQUE NONCLUSTERED INDEX [UCONCCESSAODATA] ON [ConcCessao] (
      [ConcCessaoData])

	  
CREATE UNIQUE NONCLUSTERED INDEX [UCONCANTDATA] ON [ConcAnt] (
      [ConcAntData])

	
CREATE UNIQUE NONCLUSTERED INDEX [UCONCPIXDATA] ON [ConcPix] (
      [ConcPixData])

	CREATE UNIQUE NONCLUSTERED INDEX [UCONCPSDATA] ON [ConcPS] (
      [ConcPSData])

	  CREATE UNIQUE NONCLUSTERED INDEX [UCONCMDR] ON [ConcMdr] (
      [ConcMdrData])

	  
CREATE UNIQUE NONCLUSTERED INDEX [UCONCVENDASDATA] ON [ConcVendas] (
      [ConcVendasData])

USE [Pronto]
GO

/****** Object:  View [dbo].[VwAgdRec]    Script Date: 18/08/2023 10:58:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

USE Pronto
GO


CREATE VIEW [dbo].[VwAgdRec]
AS

SELECT NEWID() AS 'VwAgdRecId',
RadDat AS 'VwAgdRecData', 
RadDetVlr AS 'VwAgdRecValor', 
IIF(RadDetTipPrd = 'C', 'Crédito', 'Débito') AS 'VwAgdRecPrd', 
B.TblBanBandeira AS 'VwAgdRecBan', 
C.AdqNom AS 'VwAgdRecAdqCod',
'Realizado' AS 'VwAgdRecOrigem'
FROM RAD0002 A
LEFT JOIN ADQ0001 C
ON A.RadDetAdqCod = C.AdqCod
CROSS APPLY
        (
        SELECT  TOP 1 B.TblBanBandeira
        FROM    TblBan B
        WHERE   B.TblBanSigla = A.RadDetBan
        ) B
UNION ALL
SELECT
NEWID(),
A.VlrDtaPrvLiqAnt, 
SUM(VlrVlrRec),
IIF(b.MovTrnTipPrd IN ('S', 'C'), 'Crédito', 'Débito'),
C.TblBanBandeira,
D.AdqNom,
'Previsto'
FROM VLRREC A
INNER JOIN MovTrn01 B
ON A.VlrMovTrnId = B.MovTrnId
LEFT JOIN TblBan C
ON B.MovTrnBan = C.TblBanSigla
LEFT JOIN ADQ0001 D
ON B.AdqCod = D.AdqCod
WHERE A.VlrMovTrnId > 0
GROUP BY A.VlrDtaPrvLiqAnt, B.MovTrnTipPrd, C.TblBanBandeira,D.AdqNom
GO


USE [Pronto]
GO

/****** Object:  View [dbo].[Trn13_aux]    Script Date: 17/08/2023 14:39:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[Trn13_aux]
as
select Trn13DataTrn, Trn13ValorTrn /100'ValorTrn', iif(Trn13Descricao like '%Pix%', 'PIX', 'PS') 'Descricao'
from Trn13
GO

alter table trn12
add Dt_ref_arquivo date null


alter table trn08ps
add TRN08PSDataRef date null


insert into StatusConciliacao values (1, 'Pendente'), (2, 'Processado'),(3, 'Erro')

USE Pronto
GO


CREATE VIEW VwMovTrnMdrCli
AS
SELECT
NEWID() as 'VwMovTrnMdrCliId',
COALESCE(SUM(MovTrnBfaVlrTxaAdm), 0) 'VwMovTrnMdrCliValorRealizado', 
COALESCE(SUM(MovTrnTxaEstVlrPrv), 0) 'VwMovTrnMdrCliValorPrevisto',
A.EstCod 'VwMovTrnMdrCliEstCod',
A.EstNomFan 'VwMovTrnMdrCliEstNomFan',
A.EstSegmento 'VwMovTrnMdrCliSegCad', 
A.TaxaSegmento 'VwMovTrnMdrCliTaxaSeg',
A.TaxaCadastro 'VwMovTrnMdrCliTaxaCad',
A.DescTaxaCadastro 'VwMovTrnMdrCliTavDsc',
A.MovTrnDta 'VwMovTrnMdrCliDataTrn',
A.MovTrnEstTxaAdmPrv 'VwMovTrnMdrCliPercPrv',
B.EstTaxVlrAdm 'VwMovTrnMdrCliPercRel'
FROM 
( 
	SELECT B.EstSegmento, C.TavNum 'TaxaSegmento', C.Segmento, B.TavNum 'TaxaCadastro',
	IIF(A.MovTrnTipPrd = 'D', 1, MovTrnParQtd) 'Parcela',
	A.MovTrnBan, A.AdqCod, A.MovTrnTipPrd, A.MovTrnEstTxaAdmPrv, 
	A.MovTrnEstTxaAntPrv, A.MovTrnEstTarCredPrv, A.MovTrnEstCusTrnPrv,
	B.EstCod, A.MovTrnDta, A.MovTrnBfaVlrTxaAdm, A.MovTrnTxaEstVlrPrv, B.EstNomFan, D.TavDsc 'DescTaxaCadastro', E.TavDsc 'DescTaxaSegmento'
	FROM MovTrn01 A
	INNER JOIN EST B
	ON A.EstCod = B.EstCod
	INNER JOIN TabvenSegmento C
	ON B.EstSegmento = C.Segmento
	INNER JOIN TABVEN D
	ON B.TavNum = D.TavNum
	INNER JOIN TABVEN E
	ON C.TavNum = E.TavNum
	WHERE MovTrnDta >= '20230101'
	AND MovTrnCod = 'CV'
	AND MovTrnTipPrd <> 'P'
) A
LEFT JOIN 
(
	SELECT 
	EstTaxPlaNum, 
	CASE
		WHEN EstTaxBan = 'Mastercard' THEN 'M'
		WHEN EstTaxBan = 'Visa' THEN 'V'
		WHEN EstTaxBan = 'Amex' THEN 'A'
		WHEN EstTaxBan = 'Cabal' THEN 'C'
		WHEN EstTaxBan = 'Verdecard' THEN 'D'
		WHEN EstTaxBan = 'Elo' THEN 'E'
		WHEN EstTaxBan = 'Hipercard' THEN 'H'
		ELSE 'O'
	END 'Bandeira',
	SUBSTRING(EstTaxTip, 1, 1) 'Produto',
	EstTaxPar,
	EstTaxVlrAdm, 
	EstTaxVlrAnt, 
	EstTaxTarCred, 
	EstTaxCusTrn,
	EstTaxAdq
	FROM TABVEN06
	Where EstTaxTip <> 'PIX'
) B
ON A.TaxaCadastro = B.EstTaxPlaNum AND A.Parcela = B.EstTaxPar 
AND A.AdqCod = B.EstTaxAdq AND A.MovTrnBan = B.Bandeira AND A.MovTrnTipPrd = B.Produto
WHERE A.TaxaCadastro <> A.TaxaSegmento
AND A.TaxaCadastro IN (
2, 6, 7, 12
)
GROUP BY A.EstCod, A.EstSegmento, A.TaxaSegmento, A.TaxaCadastro, A.MovTrnDta, A.Segmento, A.EstNomFan, A.DescTaxaCadastro, A.MovTrnEstTxaAdmPrv, B.EstTaxVlrAdm
GO


USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcResultadosLoop]    Script Date: 26/07/2023 11:34:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*V5 TAMBÉM CONTEM CORRECOES NO SCRIPT DA CESSAO*/

CREATE PROCEDURE [dbo].[ConcResultadosLoop](@DATAINI DATE, @DATAFIM DATE)
AS
BEGIN

/*
PROCEDURE PARA MONTAR O GRID OK - NOK DA TELA MOVIMENTO FINANCEIRO AUDITORIA
UTILIZADO DE TABELAS TEMPORARIAS PARA CADA OPERAÇÃO A SER VALIDADA PARA NO FINAL FAZER JOIN PELA DATA E MONTAR A TABELA
*/

/*
TABELA TEMPORARIA DE DATA PARA EVITAR QUE ALGUMA DATA FIQUE COM INFORMACAO VAZIA DENTRO DO INTERVALO PASSADO
*/

CREATE TABLE #_DataTemporaria 
(
	DataTemp Date
)

DECLARE @DataTemp DATE;
DECLARE @ITERADOR INT;
DECLARE @I INT;

SET @DataTemp = @DATAINI

SET @ITERADOR = DATEDIFF(DAY, @DATAINI, @DATAFIM);
SET @I = 0;

WHILE @I <= @ITERADOR
BEGIN
	
	INSERT INTO #_DataTemporaria VALUES (@DataTemp)
	SET @DataTemp = DATEADD(DAY, 1, @DataTemp)
	SET @I = @I + 1;

END

/*SEMPRE LIMPAR A TABELA DE RESULTADOS ANTES DE INICIAR O PROCESSO*/

DELETE FROM ConcResultados WHERE ConcResultadosData BETWEEN @DATAINI AND @DATAFIM
DELETE FROM CONCAGENDA  WHERE ConcAgendaData BETWEEN @DATAINI AND @DATAFIM
DELETE FROM CONCCESSAO  WHERE ConcCessaoData BETWEEN @DATAINI AND @DATAFIM
DELETE FROM CONCANT	    WHERE ConcAntData BETWEEN @DATAINI AND @DATAFIM
DELETE FROM CONCCERC    WHERE ConcCercData BETWEEN @DATAINI AND @DATAFIM
DELETE FROM CONCPIX	    WHERE ConcPixData BETWEEN @DATAINI AND @DATAFIM
DELETE FROM CONCPS	    WHERE ConcPsData BETWEEN @DATAINI AND @DATAFIM
DELETE FROM CONCVENDAS  WHERE ConcVendasData BETWEEN @DATAINI AND @DATAFIM
DELETE FROM CONCMDR	    WHERE ConcMdrData BETWEEN @DATAINI AND @DATAFIM

/*INICIO CONSULTA PARA MONTAR RESULTADO DE VENDAS*/

INSERT INTO ConcVendas 
(
	ConcVendasData,
	ConcVendasValorCaptura,
	ConcVendasValorMob,
	ConcVendasValorAdq,
	ConcVendasResultado
)

SELECT 
	DT.DataTemp,
	COALESCE(Sitef.ValorSitef, 0),
	COALESCE(Mob.ValorMob, 0),
	COALESCE(ADQ.ValorAdq, 0),
CASE
	WHEN (MOB.ValorMob = ADQ.ValorAdq AND Mob.ValorMob = Sitef.ValorSitef)  THEN 'OK'
	WHEN (MOB.ValorMob IS NULL AND ADQ.ValorAdq IS NULL AND Sitef.ValorSitef IS NULL)  THEN 'OK'
	ELSE 'NOK'
END
FROM
#_DataTemporaria DT
LEFT JOIN
(
	SELECT COALESCE(SUM(MovTrnVlr),0) 'ValorMob', MovTrnDta 
	FROM MovTrn01
	WHERE MovTrnDta BETWEEN @DATAINI AND @DATAFIM
	AND MovTrnCod IN ('CV', 'CC', 'PS')
	AND MovTrnTipPrd <> 'P'
	AND MovTrnVanSeq > 0
	GROUP BY MovTrnDta
) Mob
ON DT.DataTemp = Mob.MovTrnDta
LEFT JOIN 
(
	/*SELECT COALESCE(SUM(ValorTrn),0) 'ValorSitef', VanWbsDat FROM (
		SELECT  
		IIF(VanWbsDsc LIKE '%CANCELAMENTO%', ((CONVERT(NUMERIC(17,2),VanWbsVlr))/100) * -1, ((CONVERT(NUMERIC(17,2),VanWbsVlr))/100)) 'ValorTrn', VanWbsDat
		FROM VAN02 
		WHERE VanWbsDat BETWEEN @DATAINI AND @DATAFIM
		AND VanErrCod = 0
		AND VanWbsSta LIKE '%CONFIRMADA%') A GROUP BY VanWbsDat*/

		SELECT COALESCE(SUM(IIF(VanTrnCod = 'CC', VanTrnVlr *-1, VanTrnVlr)), 0) 'ValorSitef', VanTrnDta
		FROM VAN04 
		WHERE VanTrnDta BETWEEN @DATAINI AND @DATAFIM
		GROUP BY VanTrnDta
) Sitef
ON DT.DataTemp = Sitef.VanTrnDta
LEFT JOIN 
(
	/*SELECT A.TrnBrsOprOriDat, COALESCE(A.ValorTRN05, 0) + COALESCE(B.ValorTrnPagSeg, 0) AS 'ValorAdq' FROM (
	
		SELECT COALESCE(SUM(Valor),0) 'ValorTRN05', TrnBrsOprOriDat FROM (
			SELECT
				   TrnBrsOprOriDat, 
				   CASE 
						WHEN TrnBrsOprBan = '002' THEN 'M'
						WHEN TrnBrsOprBan = '003' THEN 'V'
						WHEN TrnBrsOprBan = '004' THEN 'E'
						WHEN TrnBrsOprBan = '010' THEN 'C'
						WHEN TrnBrsOprBan = '006' THEN 'D'
						ELSE ''
				   END AS Bandeira,
				   SUBSTRING(Trnbrsoprideser, 4, 1) Produto,
				   Trnbrsoprmovnsucrr NSU,
				   IIF(TrnBrsRdeSit < 20, Trnbrsoprvlr, Trnbrsoprvlr *-1) Valor, 
				   trnbrsoprtrm as PosNroSer,
				   concat (trnbrsoprbin,trnbrsoprpan )  as ConTrnNumCar    
			FROM trn05    
			WHERE TrnBrsRdeSit in ('00','01','03','04')
			AND TrnBrsOprOriDat BETWEEN @DATAINI AND @DATAFIM
			group by TrnBrsOprOriDat, Trnbrsoprideser, Trnbrsoprmovnsucrr, 
			trnbrsoprtrm, trnbrsoprbin, trnbrsoprpan, TrnBrsOprBan, Trnbrsoprvlr, TrnBrsRdeSit) TRN05
			GROUP BY TrnBrsOprOriDat) A
	LEFT JOIN (
	
		SELECT COALESCE(SUM(Valor),0) 'ValorTrnPagSeg', DataTrn FROM (
			SELECT 
				   convert(datetime, trnpagsegdatainicial, 121) 'DataTrn',
				   CASE
					WHEN TrnPagSegInstituicao = 'AMEX' THEN 'A'
					WHEN TrnPagSegInstituicao =	'CABAL' THEN 'C'
					WHEN TrnPagSegInstituicao =	'ELO' THEN 'E'
					WHEN TrnPagSegInstituicao =	'HIPERCARD' THEN 'H'
					WHEN TrnPagSegInstituicao =	'MAESTRO' THEN 'M'
					WHEN TrnPagSegInstituicao =	'MASTERCARD' THEN 'M'
					WHEN TrnPagSegInstituicao =	'VISA' THEN 'V'
					WHEN TrnPagSegInstituicao =	'VISA ELECTRON' THEN 'V'
					ELSE ''
					END AS ConTrnBan,
				   iif(TrnPagSegMeioPagamento = 3, 'C', 'D') ConTrnTipPrd,
				   trnpagsegcvcodigo ConTrnNsu,
				   IIF(TrnPagSegTipoEvento = 1, trnpagsegvalororiginal, trnpagsegvalororiginal *-1) Valor,  
				   concat (trnpagsegcartaobin,trnpagsegcartaoholder )  as ConTrnNumCar,
				   TrnPagSegTipoEvento
			FROM TrnPagSeg
			WHERE convert(datetime, trnpagsegdatainicial, 121) BETWEEN @DATAINI AND @DATAFIM
			group by trnpagsegdatainicial, TrnPagSegMeioPagamento, trnpagsegcvcodigo, 
			trnpagsegvalororiginal, trnpagsegcartaobin, trnpagsegcartaoholder, TrnPagSegInstituicao, TrnPagSegTipoEvento) TRNPAGSEG
			GROUP BY DataTrn
			
			
			) B 
	ON A.TrnBrsOprOriDat = B.DataTrn*/

			SELECT COALESCE(a.ValorAdq, 0) + COALESCE(b.ValorConc, 0) 'ValorAdq', 
			A.MovTrnDta FROM 
			(
				SELECT COALESCE(SUM(MovTrnVlr),0) 'ValorAdq', MovTrnDta 
				FROM MovTrn01
				WHERE MovTrnDta BETWEEN @DATAINI AND @DATAFIM
				AND MovTrnCod IN ('CV', 'CC', 'PS')
				AND MovTrnTipPrd <> 'P'
				AND MovTrnVanSeq > 0
				GROUP BY MovTrnDta
			) A
			LEFT JOIN 
			(
				SELECT COALESCE(SUM(IIF(ConTrnOri = 'Van04',ConTrnVlr *-1, ConTrnVlr)), 0) 'ValorConc', ConTrnDta
				FROM CON0001
				WHERE ConTrnDta BETWEEN @DATAINI AND @DATAFIM
				GROUP BY ConTrnDta
			)
			B ON A.MovTrnDta = B.ConTrnDta
) Adq
ON DT.DataTemp = Adq.MovTrnDta

/*FIM CONSULTA PARA MONTAR RESULTADO DE VENDAS*/

/*TABELA TEMPORARIA RESULTADO DAS ANTECIPACOES*/

/*INICIO CONSULTA PARA MONTAR RESULTADO DE ANTECIPACOES*/


INSERT INTO ConcAnt
(
	ConcAntData,
	ConcAntValorPrv,
	ConcAntValorRel,
	ConcAntResultado
)


SELECT DT.DataTemp,
COALESCE(A.Valor, 0),
COALESCE(B.Valor, 0),
COALESCE(CASE
	WHEN (A.Valor = B.Valor)  THEN 'OK'
	WHEN A.Valor IS NULL AND B.Valor IS NULL THEN 'OK'
	ELSE 'NOK'
END, 'OK')
FROM 
#_DataTemporaria DT
LEFT JOIN 
(
	SELECT CONVERT(DATE, AnpDtiApv) 'DataAprov', SUM(B.PaaVlrPagAnt) 'Valor' 
	FROM ANTPAG A
	LEFT JOIN PAGANT B
	ON A.AnpNumAnt = B.AnpNumAnt
	WHERE CONVERT(DATE, AnpDtiApv) BETWEEN @DATAINI AND @DATAFIM
	AND ANPSTSANT = 2
	GROUP BY CONVERT(DATE, AnpDtiApv)) A
ON DT.DataTemp = A.DataAprov
LEFT JOIN (
	SELECT CONVERT(DATE, AnpDtiApv) 'DataAprov', SUM(C.VlpVlrPag) 'Valor' 
	FROM ANTPAG A
	LEFT JOIN LANANT B
	ON A.AnpNumAnt = B.AnpNumAnt
	LEFT JOIN VLRPAG C
	ON B.LaaNumLan = C.VlpNumLan
	LEFT JOIN ARQDET D
	ON C.VlpArbNum = D.ArbNum AND C.VlpArbLotNum = D.ArbLotNum AND C.VlpArbDetSeq = D.ArbDetSeq
	WHERE CONVERT(DATE, AnpDtiApv) BETWEEN @DATAINI AND @DATAFIM
	AND A.ANPSTSANT = 2
	AND C.VlpStspag = 2
	AND D.ArbDetCodSit IN (0, 4)
	GROUP BY CONVERT(DATE, AnpDtiApv)) B
ON A.DataAprov = B.DataAprov

/*FIM CONSULTA PARA MONTAR RESULTADO DE ANTECIPACOES*/

/*INICIO CONSULTA PARA MONTAR RESULTADO DE CESSOES*/


INSERT INTO ConcCessao
(
	ConcCessaoData,
	ConcCessaoValorPrv,
	ConcCessaoValorRel,
	ConcCessaoValorNFPrv,
	ConcCessaoValorNFRel,
	ConcCessaoResultado
)


SELECT DT.DataTemp,
COALESCE(A.ValorCessaoMobPed, 0),
COALESCE(B.ValorCessaoAPIPed, 0),
COALESCE(C.ValorCessaoMobPago, 0),
COALESCE(D.ValorCessaoAPIPago, 0),
COALESCE(CASE
	WHEN (A.ValorCessaoMobPed = B.ValorCessaoAPIPed) AND (C.ValorCessaoMobPago = D.ValorCessaoAPIPago) THEN 'OK'
	WHEN ((A.ValorCessaoMobPed IS NULL AND B.ValorCessaoAPIPed IS NULL) OR (C.ValorCessaoMobPago IS NULL AND D.ValorCessaoAPIPago IS NULL)) THEN 'OK'
ELSE 'NOK'
END, 'OK')
FROM #_DataTemporaria DT
LEFT JOIN (
	SELECT
	CONVERT(DATE, CessaoDtalIQ) 'DataMobPed',
	COALESCE(SUM(CessaoValor), 0) 'ValorCessaoMobPed'	
	FROM Cessao
	WHERE CONVERT(DATE, CessaoDtalIQ) BETWEEN @DATAINI AND @DATAFIM 
	AND CessaoStatusId = 1
	GROUP BY CONVERT(DATE, CessaoDtalIQ)
) A
ON DT.DataTemp = A.DataMobPed
LEFT JOIN (
	SELECT
	CONVERT(DATE, CessaoDtalIQ) 'DataAPIPed',
	COALESCE(SUM(B.CESSAODETVALOR), 0) 'ValorCessaoAPIPed'	
	FROM Cessao A
	INNER JOIN CESSAODETALHE B
	ON A.CessaoId = B.CessaoId
	WHERE CONVERT(DATE, CessaoDtalIQ) BETWEEN @DATAINI AND @DATAFIM 
	AND CessaoStatusId = 1
	GROUP BY CONVERT(DATE, CessaoDtalIQ)
) B
ON DT.DataTemp = B.DataAPIPed
LEFT JOIN (
	SELECT
	CONVERT(DATE, CessaoDtalIQ) 'DataMobPago',
	COALESCE(SUM(CessaoValor), 0) 'ValorCessaoMobPago'	
	FROM Cessao
	WHERE CONVERT(DATE, CessaoDtalIQ) BETWEEN @DATAINI AND @DATAFIM 
	AND CessaoStatusId = 1
	AND CessaoTipoId = 2 --VIP
	GROUP BY CONVERT(DATE, CessaoDtalIQ)
) C
ON DT.DataTemp = C.DataMobPago
LEFT JOIN (
	SELECT
	CONVERT(DATE, CessaoDtalIQ) 'DataAPIPago',
	COALESCE(SUM(CessaoValor), 0) 'ValorCessaoAPIPago'	
	FROM Cessao
	WHERE CONVERT(DATE, CessaoDtalIQ) BETWEEN @DATAINI AND @DATAFIM 
	AND CessaoStatusId = 1
	AND CessaoNFDistribuidora <> ''
	GROUP BY CONVERT(DATE, CessaoDtalIQ)
) D
ON DT.DataTemp = D.DataAPIPago

/*FIM CONSULTA PARA MONTAR RESULTADO DE CESSOES*/

/*INICIO CONSULTA PARA MONTAR RESULTADO DE MDR*/

INSERT INTO ConcMdr
(
	ConcMdrData,
	ConcMdrValorAdqRel,
	ConcMdrValorAdqPrv,
	ConcMdrValorCliRel,
	ConcMdrValorCliPrv,
	ConcMdrResultado
)

SELECT 
	DT.DataTemp,
	COALESCE(A.AdqValorRealizado, 0),
	COALESCE(B.AdqValorPrevisto, 0),
	COALESCE(C.ClienteValorRealizado, 0),
	COALESCE(D.ClienteValorPrevisto, 0),
CASE 
	WHEN A.AdqValorRealizado = B.AdqValorPrevisto AND A.AdqValorRealizado = C.ClienteValorRealizado AND A.AdqValorRealizado = D.ClienteValorPrevisto THEN 'OK'
	WHEN A.AdqValorRealizado IS NULL AND B.AdqValorPrevisto IS NULL AND C.ClienteValorRealizado IS NULL AND D.ClienteValorPrevisto IS NULL THEN 'OK'
	ELSE 'NOK'
END
FROM #_DataTemporaria DT
LEFT JOIN
(
	SELECT COALESCE(SUM(MovTrnGbpVlrTxaInt), 0) 'AdqValorRealizado',
	MovTrnDta
	FROM MovTrn01
	WHERE MovTrnDta BETWEEN @DATAINI AND @DATAFIM
	AND MovTrnCod in ('CV', 'PS')
	GROUP BY MovTrnDta) A
ON DT.DataTemp = A.MovTrnDta
LEFT JOIN (
	SELECT COALESCE(SUM(MovTrnTxaComVlrPrv), 0) 'AdqValorPrevisto',
	MovTrnDta
	FROM MovTrn01
	WHERE MovTrnDta BETWEEN @DATAINI AND @DATAFIM
	AND MovTrnCod in ('CV', 'PS')
	GROUP BY MovTrnDta
) B
ON A.MovTrnDta = B.MovTrnDta
LEFT JOIN (
	SELECT COALESCE(SUM(MovTrnBfaVlrTxaAdm), 0) 'ClienteValorRealizado',
	MovTrnDta
	FROM MovTrn01
	WHERE MovTrnDta BETWEEN @DATAINI AND @DATAFIM
	AND MovTrnCod = 'CV'
	AND MovTrnEstTxaAntPrv = 0
	GROUP BY MovTrnDta
) C
ON A.MovTrnDta = C.MovTrnDta
LEFT JOIN (
	SELECT COALESCE(SUM(MovTrnBfaVlrTxaAdm), 0) 'ClienteValorPrevisto',
	MovTrnDta
	FROM MovTrn01
	WHERE MovTrnDta BETWEEN @DATAINI AND @DATAFIM
	AND MovTrnCod = 'CV'
	AND MovTrnEstTxaAntPrv = 0
	GROUP BY MovTrnDta
) D
ON A.MovTrnDta = D.MovTrnDta

/*FIM CONSULTA PARA MONTAR RESULTADO MDR*/

/*INICIO CONSULTA PARA MONTAR RESULTADOS PRESTACAO DE SERVICO*/
INSERT INTO ConcPS
(
	ConcPSData,
	ConcPSValorPrv,
	ConcPSValorRel,
	ConcPSValorComPrv,
	ConcPSValorComRel,
	ConcPSResultado
)

SELECT 
	DT.DataTemp,
	COALESCE(B.ValorConfMob, 0),
	COALESCE(A.ValorRelMob, 0),
	COALESCE(D.ValorComConfMob, 0),
	COALESCE(C.ValorComRelMob, 0),
CASE 
	WHEN A.ValorRelMob = B.ValorConfMob AND C.ValorComRelMob = D.ValorComConfMob THEN 'OK'
	WHEN A.ValorRelMob IS NULL AND B.ValorConfMob IS NULL AND C.ValorComRelMob IS NULL AND D.ValorComConfMob IS NULL THEN 'OK'
	ELSE 'NOK'
END
FROM #_DataTemporaria DT
LEFT JOIN (
	SELECT A.TRN08PSDataRef 'DataRelMob', SUM(B.TrnVlrTotBru) 'ValorRelMob'
	FROM TRN08PS A
	LEFT JOIN TRN08 B
	ON A.TRN08PSTOKEN = B.TRNTOK AND B.TRN08VanTrnSeq > 0
	LEFT JOIN MovTrn01 C
	ON B.TRN08VanTrnSeq = C.MovTrnVanSeq
	WHERE A.TRN08PSDataRef BETWEEN @DATAINI AND @DATAFIM
	AND A.TRN08PSStatus = 1
	GROUP BY A.TRN08PSDataRef) A
ON DT.DataTemp = A.DataRelMob
LEFT JOIN (
	SELECT Trn13DataTrn 'DataConfMob', COALESCE(SUM(ValorTrn),0) 'ValorConfMob'
	FROM Trn13_aux
	WHERE Trn13DataTrn BETWEEN @DATAINI AND @DATAFIM
	AND Descricao = 'PS'
	GROUP BY Trn13DataTrn) B
ON DT.DataTemp = B.DataConfMob
LEFT JOIN (
	SELECT A.TRN08PSDataRef 'DataComRelMob', SUM(MovTrnVlrLiqEst) 'ValorComRelMob'
	FROM TRN08PS A
	LEFT JOIN TRN08 B
	ON A.TRN08PSTOKEN = B.TRNTOK AND B.TRN08VanTrnSeq > 0
	LEFT JOIN MovTrn01 C
	ON B.TRN08VanTrnSeq = C.MovTrnVanSeq
	WHERE A.TRN08PSDataRef BETWEEN @DATAINI AND @DATAFIM
	AND A.TRN08PSStatus = 1
	GROUP BY A.TRN08PSDataRef) C
ON DT.DataTemp = C.DataComRelMob
LEFT JOIN (
	SELECT A.TRN08PSDataRef 'DataComConfMob', SUM(MovTrnVlrLiqEst) 'ValorComConfMob' 
	FROM TRN08PS A
	LEFT JOIN TRN08 B
	ON A.TRN08PSTOKEN = B.TRNTOK AND B.TRN08VanTrnSeq > 0
	LEFT JOIN MovTrn01 C
	ON B.TRN08VanTrnSeq = C.MovTrnVanSeq
	WHERE A.TRN08PSDataRef BETWEEN @DATAINI AND @DATAFIM
	AND A.TRN08PSStatus = 1
	GROUP BY A.TRN08PSDataRef) D
ON DT.DataTemp = D.DataComConfMob

/*FIM CONSULTA PARA MONTAR RESULTADOS PRESTACAO DE SERVICO*/

/*INICIO CONSULTA PARA MONTAR RESULTADOS PIX*/
INSERT INTO ConcPIX
(
	ConcPixData,
	ConcPixValorPrv,
	ConcPixValorRel,
	ConcPixResultado
)


SELECT 
	DT.DataTemp,
	COALESCE(B.VALORCONFIRM, 0),
	COALESCE(A.VALORREAL, 0),
CASE 
	WHEN A.VALORREAL = B.VALORCONFIRM THEN 'OK'
	WHEN A.VALORREAL IS NULL AND B.VALORCONFIRM IS NULL THEN 'OK'
	ELSE 'NOK'
END
FROM #_DataTemporaria DT
LEFT JOIN (
	SELECT Dt_ref_arquivo 'MOVTRNDTA', COALESCE(SUM(Pay_value), 0) 'VALORREAL' 
	FROM Trn12
	WHERE Dt_ref_arquivo BETWEEN @DATAINI AND @DATAFIM
	AND MovTrnId > 0
	GROUP BY Dt_ref_arquivo) A
ON DT.DATATEMP = A.MOVTRNDTA
LEFT JOIN (
	SELECT Trn13DataTrn, COALESCE(SUM(ValorTrn), 0) 'VALORCONFIRM'
	FROM Trn13_aux
	WHERE Trn13DataTrn BETWEEN @DATAINI AND @DATAFIM
	AND Descricao = 'PIX'
	GROUP BY Trn13DataTrn) B
ON DT.DATATEMP = B.Trn13DataTrn


/*FIM CONSULTA PARA MONTAR RESULTADOS PIX*/

/*INICIO CONSULTA PARA MONTAR RESULTADOS AGENDA*/

INSERT INTO ConcAgenda
(
	ConcAgendaData,
	ConcAgendaValorRecPrv,
	ConcAgendaValorRecRel,
	ConcAgendaValorPagPrv,
	ConcAgendaValorPagRel,
	ConcAgendaResultado
)

SELECT 
	DT.DataTemp,
	COALESCE(C.ValorReceberPrv, 0),
	COALESCE(D.ValorReceberRel, 0),
	COALESCE(A.ValorVlrPag, 0), 
	COALESCE(B.ValorArqDet, 0),
CASE 
	WHEN A.ValorVlrPag = B.ValorArqDet AND C.ValorReceberPrv = D.ValorReceberRel THEN 'OK'
	WHEN A.ValorVlrPag IS NULL AND B.ValorArqDet IS NULL AND C.ValorReceberPrv IS NULL AND D.ValorReceberRel IS NULL THEN 'OK'
	ELSE 'NOK'
END
FROM #_DataTemporaria DT
LEFT JOIN 
(
	SELECT A.ArbDetDtaCre 'DataCredito', COALESCE(SUM(A.ArbDetVlr), 0) 'ValorVlrPag' 	
	FROM ARQDET A
	WHERE A.ArbDetDtaCre BETWEEN @DATAINI AND @DATAFIM
	AND A.ArbDetCodSit IN (0, 4)
	GROUP BY A.ArbDetDtaCre
) A ON DT.DataTemp = A.DataCredito
LEFT JOIN 
(
	SELECT A.ArbDetDtaCre 'DataCredito', COALESCE(SUM(A.ArbDetVlr), 0) 'ValorArqDet' 	
	FROM ARQDET A
	WHERE A.ArbDetDtaCre BETWEEN @DATAINI AND @DATAFIM
	AND A.ArbDetCodSit = 4
	GROUP BY A.ArbDetDtaCre
) B
ON DT.DataTemp = B.DataCredito
LEFT JOIN 
(
	/*SELECT VlrDtaPrvLiqAnt 'DataRec', COALESCE(SUM(VlrVlrRec), 0) 'ValorReceberPrv' 
	FROM VLRREC
	WHERE VlrDtaPrvLiqAnt BETWEEN @DATAINI AND @DATAFIM
	AND VlrStsRec = 2
	GROUP BY VlrDtaPrvLiqAnt*/
	SELECT  RadDat 'DataRec', COALESCE(SUM(RadDetVlr), 0) 'ValorReceberPrv'
	FROM RAD0002 
	WHERE RadDat BETWEEN @DATAINI AND @DATAFIM
	GROUP BY RadDat
) C
ON DT.DataTemp = C.DataRec
LEFT JOIN 
(
	SELECT  RadDat 'DataRec', COALESCE(SUM(RadDetVlr), 0) 'ValorReceberRel'
	FROM RAD0002 
	WHERE RadDat BETWEEN @DATAINI AND @DATAFIM
	GROUP BY RadDat
) D
ON DT.DataTemp = D.DataRec

/*FIM CONSULTA PARA MONTAR RESULTADOS AGENDA*/

/*INICIO CONSULTA PARA MONTAR RESULTADOS PIX*/
INSERT INTO ConcCerc
(
	ConcCercData,
	ConcCercMovDiaTrn,
	ConcCercMovDiaReg,
	ConcCercLiqNormalBxd,
	ConcCercLiqNormalPago,
	ConcCercLiqAntBxd,
	ConcCercLiqAntPago,
	ConcCercEfeReg,
	ConcCercEfePago,
	ConcCercCessaoBxd,
	ConcCercCessaoPago,
	ConcCercResultado
)

SELECT 
	DT.DataTemp,
	COALESCE(D.ValorVlrPag, 0),
	COALESCE(C.ValorRecLiq, 0),
	COALESCE(H.ValorLiqBaixado, 0),
	COALESCE(G.ValorAntPago, 0),
	COALESCE(E.ValorLiqBaixado, 0),
	COALESCE(F.ValorLiqPago, 0),
	COALESCE(A.ValorEfeito, 0), 
	COALESCE(B.ValorPago, 0),
	COALESCE(I.ValorCessao, 0),
	COALESCE(J.ValorCessaoDetalhe, 0),
/*CASE 
	WHEN A.ValorEfeito = B.ValorPago 
	AND C.ValorRecLiq = D.ValorVlrPag 
	AND E.ValorLiqBaixado = F.ValorLiqPago 
	AND H.ValorLiqBaixado = G.ValorAntPago 
	AND I.ValorCessao = J.ValorCessaoDetalhe THEN 'OK'

	WHEN A.ValorEfeito IS NULL AND B.ValorPago IS NULL 
	AND C.ValorRecLiq IS NULL AND D.ValorVlrPag IS NULL 
	AND E.ValorLiqBaixado IS NULL AND F.ValorLiqPago IS NULL 
	AND G.ValorAntPago IS NULL AND I.ValorCessao IS NULL AND J.ValorCessaoDetalhe IS NULL THEN 'OK'
	ELSE 'NOK'
END*/
'OK'
FROM #_DataTemporaria DT
LEFT JOIN 
(
	SELECT COALESCE(SUM(EfeitoContratoVlrRepasse), 0) 'ValorEfeito', EfeitoContratoDtaVenc 'EfeitoData'
	FROM
	EfeitoContrato a
	WHERE a.EfeitoContratoDtaVenc BETWEEN @DATAINI AND @DATAFIM
	AND a.EfeitoContratoArbNum > 0
	AND a.EfeitoContratoVlrRepasse > 0
	GROUP BY EfeitoContratoDtaVenc
) A
ON DT.DATATEMP = A.EfeitoData
LEFT JOIN 
(
	/*
	SELECT COALESCE(SUM(ArbDetVlr), 0) 'ValorPago', ArbDetDtaCre 'DataPgt'
	FROM ARQDET a
	WHERE ArbDetDtaCre BETWEEN @DATAINI AND @DATAFIM
	AND ArbNum IN
	(
	SELECT EfeitoContratoArbNum 
	FROM
	EfeitoContrato a
	WHERE a.EfeitoContratoDtaVenc BETWEEN @DATAINI AND @DATAFIM
	AND a.EfeitoContratoArbNum > 0
	AND a.EfeitoContratoVlrRepasse > 0
	)
	GROUP BY ArbDetDtaCre*/
	SELECT COALESCE(SUM(EfeitoContratoVlrRepasse), 0) 'ValorPago', EfeitoContratoDtaVenc 'DataPgt'
	FROM
	EfeitoContrato a
	WHERE a.EfeitoContratoDtaVenc BETWEEN @DATAINI AND @DATAFIM
	AND a.EfeitoContratoArbNum > 0
	AND a.EfeitoContratoVlrRepasse > 0
	GROUP BY EfeitoContratoDtaVenc
) B
ON DT.DATATEMP = B.DataPgt
LEFT JOIN
(
	SELECT COALESCE(SUM(UnidPagVlrLiq), 0) 'ValorRecLiq', UnidDtaVcto 'DataRecLiq'
	FROM UnidRecPag
	WHERE UnidDtaVcto BETWEEN @DATAINI AND @DATAFIM
	GROUP BY UnidDtaVcto
) C
ON DT.DataTemp = C.DataRecLiq
LEFT JOIN
(	/*
	select sum(coalesce(a.valorvlrpag, 0) + coalesce(b.ValorVlrPag, 0)) 'ValorVlrPag', a.DataVlrPag from (
	SELECT COALESCE(SUM(VlpVlrPag), 0) 'ValorVlrPag', VlpDtaVct 'DataVlrPag' 
	FROM VLRPAG A
	WHERE A.VlpDtaVct BETWEEN @DATAINI AND @DATAFIM
	AND A.VlpIdCreditTransaction = 0
	AND A.VlpIdCreditTransactionPai = 0
	GROUP BY VlpDtaVct) a
	left join (
		SELECT COALESCE(SUM(VlpVlrPag), 0)	'valorvlrpag', VlpDtaVct 'DataVlrPag'
		FROM VLRPAG A
		WHERE A.VlpDtaVct BETWEEN @DATAINI AND @DATAFIM
		AND A.VlpIdCreditTransaction > 0
		GROUP BY VlpDtaVct
	) b on a.DataVlrPag = b.DataVlrPag
	group by a.DataVlrPag*/
	SELECT COALESCE(SUM(UnidPagVlrLiq), 0) 'ValorVlrPag', UnidDtaVcto 'DataVlrPag'
	FROM UnidRecPag
	WHERE UnidDtaVcto BETWEEN @DATAINI AND @DATAFIM
	GROUP BY UnidDtaVcto
) D
ON DT.DataTemp = D.DataVlrPag
LEFT JOIN 
(
	SELECT CONVERT(DATE, AnpDtiApv) 'UnidDtaVcto', SUM(B.PaaVlrPagAnt) 'ValorLiqBaixado' 
	FROM ANTPAG A
	LEFT JOIN PAGANT B
	ON A.AnpNumAnt = B.AnpNumAnt
	WHERE CONVERT(DATE, AnpDtiApv) BETWEEN @DATAINI AND @DATAFIM
	AND ANPSTSANT = 2
	GROUP BY CONVERT(DATE, AnpDtiApv)
) E
ON DT.DataTemp = E.UnidDtaVcto
LEFT JOIN 
(
	/*SELECT VlpDtaVct, SUM(VlpVlrPag) 'ValorLiqPago' 
	FROM VLRPAG
	WHERE VlpDtaVct BETWEEN @DATAINI AND @DATAFIM
	AND VlpStspag = 2
	AND VlpVlrPag > 0
	AND VlpAnpNum = 0
	AND VlpIdCreditTransaction = 0
	AND VlpIdCreditTransactionPai = 0
	GROUP BY VlpDtaVct*/
	SELECT CONVERT(DATE, AnpDtiApv) 'VlpDtaVct', SUM(B.PaaVlrPagAnt) 'ValorLiqPago' 
	FROM ANTPAG A
	LEFT JOIN PAGANT B
	ON A.AnpNumAnt = B.AnpNumAnt
	WHERE CONVERT(DATE, AnpDtiApv) BETWEEN @DATAINI AND @DATAFIM
	AND ANPSTSANT = 2
	GROUP BY CONVERT(DATE, AnpDtiApv)
) F
ON DT.DataTemp = F.VlpDtaVct
LEFT JOIN 
(
	/*SELECT VlpDtaVct, SUM(VlpVlrPag) 'ValorAntPago' 
	FROM VLRPAG
	WHERE VlpDtaVct BETWEEN @DATAINI AND @DATAFIM
	AND VlpStspag = 2
	AND VlpVlrPag > 0
	AND VlpAnpNum > 0
	GROUP BY VlpDtaVct*/
	SELECT UnidDtaVcto 'VlpDtaVct', SUM(UnidPagVlrLiq) 'ValorAntPago' 
	FROM UnidRecPag A
	INNER JOIN LogCERC B
	ON A.UnidRecPagRefCerc = B.LogChave AND B.LogTipo = 2
	WHERE UnidDtaVcto BETWEEN @DATAINI AND @DATAFIM
	AND UnidRecPagTipo = 'C'
	AND B.LogStatus = 'SUCESSO'
	GROUP BY UnidDtaVcto
) G
ON DT.DataTemp = G.VlpDtaVct
LEFT JOIN 
(
	SELECT UnidDtaVcto, SUM(UnidPagVlrLiq) 'ValorLiqBaixado' 
	FROM UnidRecPag A
	INNER JOIN LogCERC B
	ON A.UnidRecPagRefCerc = B.LogChave AND B.LogTipo = 2
	WHERE UnidDtaVcto BETWEEN @DATAINI AND @DATAFIM
	AND UnidRecPagTipo = 'C'
	AND B.LogStatus = 'SUCESSO'
	GROUP BY UnidDtaVcto
) H
ON DT.DataTemp = H.UnidDtaVcto
LEFT JOIN 
(
	SELECT CONVERT(DATE, CessaoDtalIQ) 'DataCessao',
	SUM(CessaoValor) 'ValorCessao' 
	FROM CESSAO
	WHERE CONVERT(DATE, CessaoDtalIQ) BETWEEN @DATAINI AND @DATAFIM 
	AND CessaoStatusId = 1
	AND CessaoTipoId = 2 --VIP
	GROUP BY CONVERT(DATE, CessaoDtalIQ)
) I
ON DT.DataTemp = I.DataCessao
LEFT JOIN 
(
	SELECT CONVERT(DATE, CessaoDtalIQ) 'DataCessaoDetalhe',
	SUM(CessaoValor) 'ValorCessaoDetalhe' 
	FROM CESSAO
	WHERE CONVERT(DATE, CessaoDtalIQ) BETWEEN @DATAINI AND @DATAFIM 
	AND CessaoStatusId = 1
	AND CessaoTipoId = 2 --VIP
	GROUP BY CONVERT(DATE, CessaoDtalIQ)
) J
ON DT.DataTemp = J.DataCessaoDetalhe

/*FIM CONSULTA PARA MONTAR RESULTADOS PIX*/

INSERT INTO ConcResultados 
(
	ConcResultadosData,
	ConcResultadosAgenda,
	ConcResultadosAntAdq,
	ConcResultadosAntecip,
	ConcResultadosCerc,
	ConcResultadosCessao,
	ConcResultadosMDR,
	ConcResultadosPIX,
	ConcResultadosPrestServ,
	ConcResultadosVendas
)


SELECT A.ConcVendasData, G.ConcAgendaResultado, 'OK', B.ConcAntResultado, H.ConcCercResultado, 
C.ConcCessaoResultado, D.ConcMdrResultado, F.ConcPixResultado, E.ConcPsResultado, A.ConcVendasResultado
FROM ConcVendas A
LEFT JOIN ConcAnt B
ON A.ConcVendasData = B.ConcAntData
LEFT JOIN ConcCessao C
ON A.ConcVendasData = C.ConcCessaoData
LEFT JOIN ConcMdr D
ON A.ConcVendasData = D.ConcMdrData
LEFT JOIN ConcPs E
ON A.ConcVendasData = E.ConcPsData
LEFT JOIN ConcPix F
ON A.ConcVendasData = F.ConcPixData
LEFT JOIN ConcAgenda G
ON A.ConcVendasData = G.ConcAgendaData
LEFT JOIN ConcCerc H
ON A.ConcVendasData = H.ConcCercData
WHERE A.ConcVendasData BETWEEN @DATAINI AND @DATAFIM

END

GO