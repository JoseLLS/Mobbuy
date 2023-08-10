USE PRONTO
GO

ALTER PROCEDURE ConcMobPixSint 
(
	@DataTrn DATE, 
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS
BEGIN
	SELECT @ValorTrn = COALESCE(SUM(Pay_value), 0) FROM Trn12
	WHERE Dt_ref_arquivo = @DataTrn
	AND MovTrnId > 0
END
GO

ALTER PROCEDURE ConcAdqPixSint 
(
	@DataTrn DATE, 
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS
BEGIN
	SELECT @ValorTrn = COALESCE(SUM(ValorTrn),0)	
	FROM Trn13_aux
	WHERE Trn13DataTrn = @DataTrn
	AND Descricao = 'PIX'
END
GO


SELECT COALESCE(SUM(ValorTrn),0)	
	FROM Trn13_aux
	
	where Descricao = 'PIX'