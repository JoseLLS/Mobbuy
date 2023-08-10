USE [Pronto]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ConcAprovadoAntSint]
(
	@DataAnt DATE,
	@ValorAnt NUMERIC(17,2) OUTPUT
)
AS

BEGIN
	SELECT @ValorAnt = COALESCE(SUM(B.PaaVlrPagAnt), 0) 
	FROM ANTPAG A
	LEFT JOIN PAGANT B
	ON A.AnpNumAnt = B.AnpNumAnt
	WHERE CONVERT(DATE, AnpDtiApv) = @DataAnt
	AND ANPSTSANT = 2
END

GO

CREATE PROCEDURE [dbo].[ConcPagoAntSint]
(
	@DataAnt DATE,
	@ValorAnt NUMERIC(17,2) OUTPUT
)
AS

BEGIN
	SELECT @ValorAnt = COALESCE(SUM(C.VlpVlrPag),0) 
	FROM ANTPAG A
	LEFT JOIN LANANT B
	ON A.AnpNumAnt = B.AnpNumAnt
	LEFT JOIN VLRPAG C
	ON B.LaaNumLan = C.VlpNumLan
	LEFT JOIN ARQDET D
	ON C.VlpArbNum = D.ArbNum AND C.VlpArbLotNum = D.ArbLotNum AND C.VlpArbDetSeq = D.ArbDetSeq
	WHERE CONVERT(DATE, AnpDtiApv) = @DataAnt
	AND A.ANPSTSANT = 2
	AND C.VlpStspag = 2
	AND D.ArbDetCodSit IN (0, 4)
END

GO


SELECT *,
CASE
	WHEN (A.Valor = B.Valor)  THEN 'OK'
	ELSE 'NOK'
END
FROM (
SELECT CONVERT(DATE, AnpDtiApv) 'DataAprov', SUM(B.PaaVlrPagAnt) 'Valor' 
FROM ANTPAG A
LEFT JOIN PAGANT B
ON A.AnpNumAnt = B.AnpNumAnt
WHERE CONVERT(DATE, AnpDtiApv) BETWEEN '20230601' AND '20230630'
AND ANPSTSANT = 2
GROUP BY CONVERT(DATE, AnpDtiApv)) A
LEFT JOIN (
SELECT CONVERT(DATE, AnpDtiApv) 'DataAprov', SUM(C.VlpVlrPag) 'Valor' 
FROM ANTPAG A
LEFT JOIN LANANT B
ON A.AnpNumAnt = B.AnpNumAnt
LEFT JOIN VLRPAG C
ON B.LaaNumLan = C.VlpNumLan
LEFT JOIN ARQDET D
ON C.VlpArbNum = D.ArbNum AND C.VlpArbLotNum = D.ArbLotNum AND C.VlpArbDetSeq = D.ArbDetSeq
WHERE CONVERT(DATE, AnpDtiApv) BETWEEN '20230601' AND '20230630'
AND A.ANPSTSANT = 2
AND C.VlpStspag = 2
AND D.ArbDetCodSit IN (0, 4)
GROUP BY CONVERT(DATE, AnpDtiApv)) B
ON A.DataAprov = B.DataAprov
ORDER BY 1

use pronto
go

declare @ValorAnt numeric(17, 2)

exec concpagoantsint @DataAnt = '20230601', @ValorAnt = @ValorAnt
select @ValorAnt
exec concaprovadoantsint @DataAnt = '20230601', @ValorAnt = @ValorAnt
select @ValorAnt