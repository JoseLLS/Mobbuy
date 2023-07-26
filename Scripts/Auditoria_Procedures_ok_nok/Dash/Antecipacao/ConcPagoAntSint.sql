USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcPagoAntSint]    Script Date: 26/07/2023 12:14:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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


