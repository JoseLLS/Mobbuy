USE Pronto
GO

DROP PROCEDURE [dbo].[ConciCessaoInsere]
GO

CREATE PROCEDURE [dbo].[ConciCessaoInsere](@DataFiltroIni DATE)
AS
BEGIN

	DECLARE @DataFiltroFim DATE
	SET @DataFiltroFim = DATEADD(day, 1, @DataFiltroIni)

	DELETE ConciCessao WHERE ConciCessaoData = @DataFiltroIni

	INSERT INTO ConciCessao
	SELECT a.QuantidadeCessao, a.ValorTotalCessao, b.QuantidadeCessao, b.ValorTotalCessao, @DataFiltroIni, IIF(a.QuantidadeCessao = b.QuantidadeCessao, 'OK', 'NOK')
	FROM (
		SELECT 
		COALESCE(COUNT(CessaoId), 0) 'QuantidadeCessao', 
		COALESCE(SUM(CessaoValor), 0) 'ValorTotalCessao', 
		'Mobbuy' 'Origem', 
		1 'JoinTable'  
		FROM Cessao
		WHERE CessaoDtalIQ BETWEEN @DataFiltroIni AND @DataFiltroFim
		AND CessaoStatusId = 1) a 
	INNER JOIN (
		SELECT 
		COALESCE(COUNT(CessaoId), 0) 'QuantidadeCessao', 
		COALESCE(SUM(CessaoValor), 0) 'ValorTotalCessao', 
		'Nota Fiscal' 'Origem', 
		1 'JoinTable' 
		FROM Cessao 
		WHERE CessaoDtalIQ BETWEEN @DataFiltroIni AND @DataFiltroFim
		AND CessaoStatusId = 1
		AND CessaoNFDistribuidora <> '') b 
	ON a.JoinTable = b.JoinTable

END

GO