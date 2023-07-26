USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcResultadosLoop]    Script Date: 26/07/2023 11:34:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ConcResultadosLoop](@DATAINI DATE, @DATAFIM DATE)
AS
BEGIN

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

CREATE TABLE #_ConcResultadosVendas 
(
	ConcResultadosData Date,
	ConcResultadosVendas VARCHAR(5)
)

CREATE TABLE #_ConcResultadosAntecip 
(	
	ConcResultadosData Date,
	ConcResultadosAntecip VARCHAR(5)
)

DELETE FROM ConcResultados

INSERT INTO #_ConcResultadosVendas
(
	ConcResultadosData,
	ConcResultadosVendas
)

SELECT A.DataTemp,
CASE
	WHEN (MOB.ValorMob = ADQ.ValorAdq AND Mob.ValorMob = Sitef.ValorSitef)  THEN 'OK'
	WHEN (MOB.ValorMob IS NULL AND ADQ.ValorAdq IS NULL AND Sitef.ValorSitef IS NULL)  THEN 'OK'
	ELSE 'NOK'
END
FROM
#_DataTemporaria A
LEFT JOIN
(
	SELECT COALESCE(SUM(MovTrnVlr),0) 'ValorMob', MovTrnDta 
	FROM MovTrn01
	WHERE MovTrnDta BETWEEN @DATAINI AND @DATAFIM
	AND MovTrnCod IN ('CV', 'CC', 'PS')
	AND MovTrnTipPrd <> 'P'
	GROUP BY MovTrnDta
) Mob
ON A.DataTemp = Mob.MovTrnDta
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
SELECT A.ConcResultadosData, 'OK', 'OK', B.ConcResultadosAntecip, 'OK', 'OK', 'OK', 'OK', 'OK', A.ConcResultadosVendas
FROM #_ConcResultadosVendas A
LEFT JOIN #_ConcResultadosAntecip B
ON A.ConcResultadosData = B.ConcResultadosData

END

GO


