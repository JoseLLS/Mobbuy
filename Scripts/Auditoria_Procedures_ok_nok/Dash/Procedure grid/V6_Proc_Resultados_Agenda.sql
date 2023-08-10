USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcResultadosLoop]    Script Date: 26/07/2023 11:34:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*V5 TAMBÉM CONTEM CORRECOES NO SCRIPT DA CESSAO*/

ALTER PROCEDURE [dbo].[ConcResultadosLoop](@DATAINI DATE, @DATAFIM DATE)
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

/*TABELA TEMPORARIA RESULTADO DAS VENDAS*/

CREATE TABLE #_ConcResultadosVendas 
(
	ConcResultadosData Date,
	ConcResultadosVendas VARCHAR(5)
)


/*INICIO CONSULTA PARA MONTAR RESULTADO DE VENDAS*/

INSERT INTO #_ConcResultadosVendas
(
	ConcResultadosData,
	ConcResultadosVendas
)

SELECT DT.DataTemp,
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
	GROUP BY MovTrnDta
) Mob
ON DT.DataTemp = Mob.MovTrnDta
LEFT JOIN 
(
	SELECT COALESCE(SUM(ValorTrn),0) 'ValorSitef', VanWbsDat FROM (
		SELECT  
		IIF(VanWbsDsc LIKE '%CANCELAMENTO%', ((CONVERT(NUMERIC(17,2),VanWbsVlr))/100) * -1, ((CONVERT(NUMERIC(17,2),VanWbsVlr))/100)) 'ValorTrn', VanWbsDat
		FROM VAN02 
		WHERE VanWbsDat BETWEEN @DATAINI AND @DATAFIM
		AND VanErrCod = 0
		AND VanWbsSta LIKE '%CONFIRMADA%') A GROUP BY VanWbsDat
) Sitef
ON Mob.MovTrnDta = Sitef.VanWbsDat
LEFT JOIN 
(
	SELECT A.TrnBrsOprOriDat, COALESCE(A.ValorTRN05, 0) + COALESCE(B.ValorTrnPagSeg, 0) AS 'ValorAdq' FROM (
	
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
			GROUP BY DataTrn) B 
	ON A.TrnBrsOprOriDat = B.DataTrn
) Adq
ON Mob.MovTrnDta = Adq.TrnBrsOprOriDat

/*FIM CONSULTA PARA MONTAR RESULTADO DE VENDAS*/

/*TABELA TEMPORARIA RESULTADO DAS ANTECIPACOES*/

CREATE TABLE #_ConcResultadosAntecip 
(	
	ConcResultadosData Date,
	ConcResultadosAntecip VARCHAR(5)
)

/*INICIO CONSULTA PARA MONTAR RESULTADO DE ANTECIPACOES*/

INSERT INTO #_ConcResultadosAntecip 
(
	ConcResultadosData,
	ConcResultadosAntecip
)

SELECT DT.DataTemp,
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

/*TABELA TEMPORARIA RESULTADO DAS CESSOES*/

CREATE TABLE #_ConcResultadosCessao 
(	
	ConcResultadosData Date,
	ConcResultadosCessao VARCHAR(5)
)

/*INICIO CONSULTA PARA MONTAR RESULTADO DE CESSOES*/

INSERT INTO #_ConcResultadosCessao
SELECT DT.DataTemp,
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

/*TABELA TEMPORARIA RESULTADO MDR*/

CREATE TABLE #_ConcResultadosMDR 
(	
	ConcResultadosData Date,
	ConcResultadosMDR VARCHAR(5)
)

/*INICIO CONSULTA PARA MONTAR RESULTADO DE MDR*/

INSERT INTO #_ConcResultadosMDR
SELECT DT.DataTemp,
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

/*TABELA TEMPORARIA RESULTADO PRESTACAO SERVICO*/

CREATE TABLE #_ConcResultadosPs 
(	
	ConcResultadosData Date,
	ConcResultadosPs VARCHAR(5)
)

/*INICIO CONSULTA PARA MONTAR RESULTADOS PRESTACAO DE SERVICO*/
INSERT INTO #_ConcResultadosPs

SELECT DT.DataTemp,
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

/*TABELA TEMPORARIA RESULTADO PIX*/

CREATE TABLE #_ConcResultadosPix
(	
	ConcResultadosData Date,
	ConcResultadosPix VARCHAR(5)
)

/*INICIO CONSULTA PARA MONTAR RESULTADOS PIX*/
INSERT INTO #_ConcResultadosPix

SELECT DT.DataTemp,
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

/*TABELA TEMPORARIA RESULTADO DA AGENDA*/

CREATE TABLE #_ConcResultadosAgenda 
(
	ConcResultadosData Date,
	ConcResultadosAgenda VARCHAR(5)
)

/*INICIO CONSULTA PARA MONTAR RESULTADOS AGENDA*/

INSERT INTO #_ConcResultadosAgenda

SELECT DT.DataTemp,
CASE 
	WHEN A.ValorVlrPag = B.ValorArqDet THEN 'OK'
	WHEN A.ValorVlrPag IS NULL AND B.ValorArqDet IS NULL THEN 'OK'
	ELSE 'NOK'
END
FROM #_DataTemporaria DT
LEFT JOIN 
(
	SELECT A.ArbDetDtaCre 'DataCredito', COALESCE(SUM(C.VlpVlrPag),0) 'ValorVlrPag'
	FROM ARQDET A
	INNER JOIN ARQDETLAN B
	ON A.ArbNum = B.ArbNum AND A.ArbLotNum = B.ArbLotNum AND A.ArbDetSeq = B.ArbDetSeq
	INNER JOIN VLRPAG C
	ON B.ArbDetVlpNumLan = C.VlpNumLan
	WHERE A.ArbDetDtaCre BETWEEN @DATAINI AND @DATAFIM
	AND C.VlpStspag = 2
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

/*FIM CONSULTA PARA MONTAR RESULTADOS AGENDA*/

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
SELECT A.ConcResultadosData, 'OK', 'OK', B.ConcResultadosAntecip, 'OK', C.ConcResultadosCessao, ConcResultadosMDR, F.ConcResultadosPix, E.ConcResultadosPs, A.ConcResultadosVendas
FROM #_ConcResultadosVendas A
LEFT JOIN #_ConcResultadosAntecip B
ON A.ConcResultadosData = B.ConcResultadosData
LEFT JOIN #_ConcResultadosCessao C
ON A.ConcResultadosData = C.ConcResultadosData
LEFT JOIN #_ConcResultadosMDR D
ON A.ConcResultadosData = D.ConcResultadosData
LEFT JOIN #_ConcResultadosPs E
ON A.ConcResultadosData = E.ConcResultadosData
LEFT JOIN #_ConcResultadosPix F
ON A.ConcResultadosData = F.ConcResultadosData

END

GO