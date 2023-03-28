/* TAREFA #17966 - JOSÉ */

--Clientes que irão usar o script
USE Banese
USE BemFacil
USE Credinov
USE CredPag
USE Pronto
USE SmartPagamentos

--Rodar primeiro para apagar a view com o código atual (Comentar a linha para conseguir dar um Create após o Drop)
DROP VIEW RelatorioBaseTributacao

--Rodar em seguida para criar a view reescrita
CREATE VIEW RelatorioBaseTributacao AS
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
	SUM(MovTrnVlr - MovTrnVlrLiqEst - MovTrnGbpVlrTxaInt) AS 'RelBaseTribReceitaLiquida',
	T.TxAntManualVlr AS 'RelBaseTribTaxaAntManual'
FROM MovTrn01 M
	LEFT JOIN EST E ON E.EstCod = M.EstCod
	LEFT JOIN TxAntManualVw T ON M.EstCod = T.TxAntManualEstCod AND M.MovTrnDta = T.TxAntManualData
	WHERE MovTrnCod IN ('CV', 'CC')
	GROUP BY M.EstCod, E.EstNomFan, E.EstAplPsq, E.EstCpfCnpj, E.EstTip, E.EstSegmento, M.MovTrnDta, T.TxAntManualVlr
GO