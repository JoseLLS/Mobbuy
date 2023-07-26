USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcSitefVendasSint]    Script Date: 26/07/2023 12:12:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ConcSitefVendasSint]
(
	@DataTrn DATE,
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS

BEGIN
	SELECT @ValorTrn = COALESCE(SUM(ValorTrn),0) FROM (
	SELECT  
	IIF(VanWbsDsc LIKE '%CANCELAMENTO%', ((CONVERT(NUMERIC(17,2),VanWbsVlr))/100) * -1, ((CONVERT(NUMERIC(17,2),VanWbsVlr))/100)) 'ValorTrn'
	FROM VAN02 
	WHERE VanWbsDat = @DataTrn
	AND VanErrCod = 0
	AND VanWbsSta LIKE '%CONFIRMADA%') A
END

GO


