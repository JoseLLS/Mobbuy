/* TAREFA #18449 - JOSÉ */

--Rodar em todos os clientes
ALTER VIEW TxAntManualVw
AS
SELECT
	A.AnpCodEst AS 'TxAntManualEstCod',
	A.AnpDtiApv AS 'TxAntManualData',
	SUM(L.LaaVlrTxaAnt) AS 'TxAntManualVlr'
FROM LANANT L
INNER JOIN ANTPAG A
ON L.AnpNumAnt = A.AnpNumAnt AND A.AnpStsAnt = 2

GROUP BY A.AnpCodEst, A.AnpDtiApv

-----------------------------------------------------------------------------------------------------

ALTER VIEW RelatorioBaseTributacao
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
	SUM(MovTrnVlr - MovTrnVlrLiqEst - MovTrnGbpVlrTxaInt) AS 'RelBaseTribReceitaLiquida'
FROM MovTrn01 M
	LEFT JOIN EST E ON E.EstCod = M.EstCod
	WHERE MovTrnCod IN ('CV', 'CC')
	GROUP BY M.EstCod, E.EstNomFan, E.EstAplPsq, E.EstCpfCnpj, E.EstTip, E.EstSegmento, M.MovTrnDta