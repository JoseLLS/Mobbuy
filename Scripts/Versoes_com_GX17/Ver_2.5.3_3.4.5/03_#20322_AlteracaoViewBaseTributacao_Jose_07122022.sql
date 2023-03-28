/* TAREFA #20322 - JOSÉ */

--Rodar script em todos os bancos
ALTER VIEW [dbo].[RelatorioBaseTributacao]
AS
SELECT 	
	M.EstCod AS 'RelBaseTribCodigo',
	E.EstAplPsq AS 'RelBaseTribEstabelecimento',
	E.EstSegmento AS 'RelBaseTribSegmentos',
	E.EstNomFan AS 'RelBaseTribNomeFantasia',
	E.EstCpfCnpj AS 'RelBaseTribCNPJ',
	E.EstTip AS 'RelBaseTribEstTipo',
	M.MovTrnDta AS 'RelBaseTribData',
	SUM(MovTrnVlr) AS 'RelBaseTribValorVenda', 	  
	SUM(MovTrnVlrLiqEst) AS 'RelBaseTribValorEstabelecimento',		
	SUM(MovTrnBfaVlrTxaAdm) AS 'RelBaseTribTaxaAdministracao',	
	SUM(MovTrnBfaVlrTxaFin) AS 'RelBaseTribReceitaAntecipacao',
	SUM(MovTrnGbpVlrTxaInt) AS 'RelBaseTribTaxaAdquirente',
	SUM(MovTrnVlr - MovTrnVlrLiqEst - MovTrnGbpVlrTxaInt - MovTrnGbpVlrTxaAnt) AS 'RelBaseTribReceitaLiquida',
	SUM(MovTrnGbpVlrTxaAnt) AS 'RelBaseTribTaxaAntAdq'
FROM MovTrn01 M
	LEFT JOIN EST E ON E.EstCod = M.EstCod
	WHERE MovTrnCod IN ('CV', 'CC')
	GROUP BY M.EstCod, E.EstNomFan, E.EstAplPsq, E.EstCpfCnpj, E.EstTip, E.EstSegmento, M.MovTrnDta
GO


