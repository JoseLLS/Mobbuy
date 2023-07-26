USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcMobVendasSint]    Script Date: 26/07/2023 12:12:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ConcMobVendasSint]
(
	@DataTrn DATE,
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS

BEGIN
	SELECT @ValorTrn = COALESCE(SUM(MovTrnVlr),0) FROM MovTrn01
	WHERE MovTrnDta = @DataTrn
	AND MovTrnCod IN ('CV', 'CC', 'PS')
	AND MovTrnTipPrd <> 'P'
END

GO


