USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcMobCessaoPagoSint]    Script Date: 26/07/2023 14:41:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ConcMobCessaoPagoSint](
	@DataCessao DATE, @ValorCessao NUMERIC(17,2) OUTPUT
)
AS
BEGIN
SELECT 
	@ValorCessao = COALESCE(SUM(CessaoValor), 0)	
	FROM Cessao
	WHERE CONVERT(DATE, CessaoDtalIQ) = @DataCessao 
	AND CessaoStatusId = 1
END

GO


