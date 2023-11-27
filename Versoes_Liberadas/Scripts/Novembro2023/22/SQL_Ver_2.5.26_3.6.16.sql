/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.16','2.5.26',GETDATE());

/* TAREFA #23408 - LEONARDO */

USE [EstBank]
GO

/****** Object:  StoredProcedure [dbo].[InsereRelBaseTrib]    Script Date: 17/11/2023 15:28:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[InsereRelBaseTrib] (@DataIni DATE, @DataFim DATE)
AS
BEGIN

		DELETE FROM RelBaseTrib WHERE RelBaseTribDataRef BETWEEN @DataIni AND @DataFim
		INSERT INTO RELBASETRIB
		(RelBaseTribDataRef, RelBaseTribEstCod, RelBaseTribSegmento,RelBaseTribEstPacCod, RelBaseTribValorTrn, RelBaseTribValorAdq, RelBaseTribValorParcPort, RelBaseTribValorPS, RelBaseTribAdqNom, RelBaseTribQtdTrn)
		SELECT
		Trn.MovTrnDta,
		Trn.EstCod, 
		Trn.EstSegmento,
		Trn.EstPacCod,
		COALESCE(Trn.ValorTrn, 0),
		COALESCE(Adq.ValorLiqAdquirencia, 0),
		COALESCE(ParcPort.ValorPP, 0), 
		COALESCE(PS.ValorPS, 0),
		Trn.AdqNom,
		Trn.QtdTrn
		FROM
		(
	
			SELECT A.EstCod, A.MovTrnDta, C.EstSegmento, C.EstPacCod, A.AdqCod, D.AdqNom, SUM(A.MovTrnVlr) 'ValorTrn', COUNT(A.MovTrnId) 'QtdTrn'
			FROM MovTrn01 A
			INNER JOIN EST C
			ON A.EstCod = C.EstCod
			INNER JOIN ADQ0001 D
			ON A.AdqCod = D.AdqCod
			GROUP BY A.EstCod, A.MovTrnDta, C.EstSegmento, C.EstPacCod, A.AdqCod, D.AdqNom
		) Trn
		LEFT JOIN 
		(
			SELECT A.EstCod, A.MovTrnDta, A.AdqCod,
			SUM(CASE
					WHEN A.MovtrnAnt = 'T' THEN (A.MovTrnVlr - A.MovTrnVlrLiqEst - A.MovTrnGbpVlrTxaInt - A.MovTrnGbpVlrTxaAnt)
					ELSE (A.MovTrnVlr - A.MovTrnVlrLiqEst - A.MovTrnGbpVlrTxaInt - A.MovTrnTxaAntPrv)
				END)
			'ValorPP'
			FROM MovTrn01 A
			INNER JOIN VAN02 B
			ON A.MovTrnVanSeq = B.VanWbsTrnSeq
			WHERE MovTrnCod IN ('PS', 'PP')
			AND B.VanWbsCupFis LIKE '%PP'
			GROUP BY A.EstCod, A.MovTrnDta, A.AdqCod
		) ParcPort
		ON Trn.EstCod = ParcPort.EstCod AND TRN.AdqCod = ParcPort.AdqCod AND Trn.MovTrnDta = ParcPort.MovTrnDta
		LEFT JOIN 
		(
			SELECT A.EstCod, A.MovTrnDta, A.AdqCod,
			SUM(CASE
					WHEN A.MovtrnAnt = 'T' THEN (A.MovTrnVlr - A.MovTrnVlrLiqEst - A.MovTrnGbpVlrTxaInt - A.MovTrnGbpVlrTxaAnt)
					ELSE (A.MovTrnVlr - A.MovTrnVlrLiqEst - A.MovTrnGbpVlrTxaInt - A.MovTrnTxaAntPrv)
				END)
			'ValorLiqAdquirencia'
			FROM MovTrn01 A 
			WHERE MovTrnCod = 'CV'
			GROUP BY A.EstCod, A.MovTrnDta, A.AdqCod
		)Adq
		ON Trn.EstCod = Adq.EstCod AND Trn.MovTrnDta = ADQ.MovTrnDta AND TRN.AdqCod = Adq.AdqCod
		LEFT JOIN 
		(
			SELECT B.EstCod, B.MovTrnDta, B.AdqCod,
			SUM(CASE
					WHEN B.MovtrnAnt = 'T' THEN ((A.TrnVlrTot - A.TrnVlrTotBru) - (B.MovTrnVlr - B.MovTrnVlrLiqBemFac - - B.MovTrnVlrLiqEst) - B.MovTrnGbpVlrTxaAnt)
					ELSE ((A.TrnVlrTot - A.TrnVlrTotBru) - (B.MovTrnVlr - B.MovTrnVlrLiqBemFac - - B.MovTrnVlrLiqEst) - B.MovTrnTxaAntPrv)
				END)
			'ValorPS' 
			FROM TRN08 A
			INNER JOIN MovTrn01 B
			ON A.TRN08VanTrnSeq = B.MovTrnVanSeq
			GROUP BY B.EstCod, B.MovTrnDta, B.AdqCod
		)PS
		ON Trn.EstCod = PS.EstCod AND Trn.MovTrnDta = PS.MovTrnDta AND TRN.AdqCod = PS.AdqCod
		WHERE Trn.MovTrnDta BETWEEN @DataIni AND @DataFim
END
GO