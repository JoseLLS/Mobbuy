USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcAPICessaoPedSint]    Script Date: 26/07/2023 14:42:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConcAPICessaoPedSint](
	@DataCessao DATE, @ValorCessao NUMERIC(17,2) OUTPUT
)
AS
BEGIN
SELECT 
	@ValorCessao = COALESCE(SUM(CessaoValor), 0)	
	FROM Cessao
	WHERE CONVERT(DATE, CessaoDtalIQ) = @DataCessao 
	AND CessaoStatusId = 1
	AND CessaoNFDistribuidora <> ''
END
GO


