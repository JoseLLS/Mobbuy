
CREATE PROCEDURE InsereRelBaseTrib (@DataIni DATE, @DataFim DATE)
AS
BEGIN

	DELETE FROM RelBaseTrib WHERE RelBaseTribDataRef BETWEEN @DataIni AND @DataFim

	INSERT INTO RELBASETRIB
	(RelBaseTribDataRef, RelBaseTribEstCod, RelBaseTribSegmento, RelBaseTribValorTrn, RelBaseTribValorAdq, RelBaseTribValorParcPort, RelBaseTribValorPS, RelBaseTribAdqNom)
	SELECT
	Trn.MovTrnDta,
	Trn.EstCod, 
	Trn.EstSegmento, 
	COALESCE(Trn.ValorTrn, 0),
	COALESCE(Adq.ValorLiqAdquirencia, 0),
	COALESCE(ParcPort.ValorPP, 0), 
	COALESCE(PS.ValorPS, 0),
	Adq.Adquirente
	FROM
	(
	
		SELECT A.EstCod, A.MovTrnDta, C.EstSegmento, SUM(A.MovTrnVlr) 'ValorTrn'
		FROM MovTrn01 A
		INNER JOIN EST C
		ON A.EstCod = C.EstCod
		GROUP BY A.EstCod, A.MovTrnDta, C.EstSegmento
	) Trn
	LEFT JOIN 
	(
		SELECT A.EstCod, A.MovTrnDta, 
		SUM(CASE
				WHEN A.MovtrnAnt = 'T' THEN (A.MovTrnVlr - A.MovTrnVlrLiqEst - A.MovTrnGbpVlrTxaInt - A.MovTrnGbpVlrTxaAnt)
				ELSE (A.MovTrnVlr - A.MovTrnVlrLiqEst - A.MovTrnGbpVlrTxaInt - A.MovTrnTxaAntPrv)
			END)
		'ValorPP'
		FROM MovTrn01 A
		INNER JOIN VAN02 B
		ON A.MovTrnVanSeq = B.VanWbsTrnSeq
		WHERE MovTrnCod = 'PS'
		AND B.VanWbsCupFis LIKE '%PP'
		GROUP BY A.EstCod, A.MovTrnDta
	) ParcPort
	ON Trn.EstCod = ParcPort.EstCod AND Trn.MovTrnDta = ParcPort.MovTrnDta
	LEFT JOIN 
	(
		SELECT A.EstCod, A.MovTrnDta,ADQ0001.AdqNom as 'Adquirente',
		SUM(CASE
				WHEN A.MovtrnAnt = 'T' THEN (A.MovTrnVlr - A.MovTrnVlrLiqEst - A.MovTrnGbpVlrTxaInt - A.MovTrnGbpVlrTxaAnt)
				ELSE (A.MovTrnVlr - A.MovTrnVlrLiqEst - A.MovTrnGbpVlrTxaInt - A.MovTrnTxaAntPrv)
			END)
		'ValorLiqAdquirencia'
		FROM MovTrn01 A
		inner join ADQ0001 
		on ADQ0001.AdqCod = A.AdqCod 
		WHERE MovTrnCod = 'CV'
		GROUP BY A.EstCod, A.MovTrnDta, ADQ0001.AdqNom
	)Adq
	ON Trn.EstCod = Adq.EstCod AND Trn.MovTrnDta = ADQ.MovTrnDta
	LEFT JOIN 
	(
		SELECT B.EstCod, B.MovTrnDta, 
		SUM(CASE
				WHEN B.MovtrnAnt = 'T' THEN ((A.TrnVlrTot - A.TrnVlrTotBru) - (B.MovTrnVlr - B.MovTrnVlrLiqBemFac - - B.MovTrnVlrLiqEst) - B.MovTrnGbpVlrTxaAnt)
				ELSE ((A.TrnVlrTot - A.TrnVlrTotBru) - (B.MovTrnVlr - B.MovTrnVlrLiqBemFac - - B.MovTrnVlrLiqEst) - B.MovTrnTxaAntPrv)
			END)
		'ValorPS' 
		FROM TRN08 A
		INNER JOIN MovTrn01 B
		ON A.TRN08VanTrnSeq = B.MovTrnVanSeq
		GROUP BY B.EstCod, B.MovTrnDta
	)PS
	ON Trn.EstCod = PS.EstCod AND Trn.MovTrnDta = PS.MovTrnDta
	WHERE Trn.MovTrnDta BETWEEN @DataIni AND @DataFim
END
