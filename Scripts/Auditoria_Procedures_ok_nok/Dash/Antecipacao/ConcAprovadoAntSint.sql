USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcAprovadoAntSint]    Script Date: 26/07/2023 12:13:41 ******/
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


