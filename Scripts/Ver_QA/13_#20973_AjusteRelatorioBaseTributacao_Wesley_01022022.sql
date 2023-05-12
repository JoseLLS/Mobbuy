/****** Object:  View [dbo].[RelatorioBaseTributacao]    Script Date: 01/02/2023 10:51:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[RelatorioBaseTributacao]

AS
SELECT 	
	M.EstCod                  AS 'RelBaseTribCodigo',
	E.EstAplPsq               AS 'RelBaseTribEstabelecimento',
	E.EstSegmento             AS 'RelBaseTribSegmentos',
	E.EstNomFan               AS 'RelBaseTribNomeFantasia',
	E.EstCpfCnpj              AS 'RelBaseTribCNPJ',
	E.EstTip                  AS 'RelBaseTribEstTipo',
	M.MovTrnDta               AS 'RelBaseTribData',
	SUM(M.MovTrnVlr)          AS 'RelBaseTribValorVenda', 	  
	SUM(M.MovTrnVlrLiqEst)    AS 'RelBaseTribValorEstabelecimento',		
	SUM(M.MovTrnBfaVlrTxaAdm) AS 'RelBaseTribTaxaAdministracao',	
	SUM(M.MovTrnBfaVlrTxaFin) AS 'RelBaseTribReceitaAntecipacao',
	SUM(M.MovTrnGbpVlrTxaInt) AS 'RelBaseTribTaxaAdquirente',
	SUM(CASE
	    WHEN M.MovtrnAnt = 'T' THEN (M.MovTrnVlr - M.MovTrnVlrLiqEst - M.MovTrnGbpVlrTxaInt - M.MovTrnGbpVlrTxaAnt)
		ELSE (M.MovTrnVlr - M.MovTrnVlrLiqEst - M.MovTrnGbpVlrTxaInt - M.MovTrnTxaAntPrv)
	END)                      AS 'RelBaseTribReceitaLiquida',  --NOVO 31/01/2023
	CASE
	    WHEN M.MovtrnAnt = 'T' THEN (M.MovTrnVlr - M.MovTrnVlrLiqEst - M.MovTrnGbpVlrTxaInt - M.MovTrnGbpVlrTxaAnt)
		ELSE SUM(M.MovTrnVlr - M.MovTrnVlrLiqEst - M.MovTrnGbpVlrTxaInt - M.MovTrnTxaAntPrv)
	END                       AS 'RelBaseTribTaxaAntAdq'  --NOVO 31/01/2023

	--SUM(MovTrnVlr - MovTrnVlrLiqEst - MovTrnGbpVlrTxaInt - MovTrnGbpVlrTxaAnt) AS 'RelBaseTribReceitaLiquida',
	--SUM(MovTrnGbpVlrTxaAnt) AS 'RelBaseTribTaxaAntAdq'

FROM MovTrn01 M
	LEFT JOIN EST E ON E.EstCod = M.EstCod
	WHERE MovTrnCod IN ('CV', 'CC')
	GROUP BY M.EstCod, E.EstNomFan, E.EstAplPsq, E.EstCpfCnpj, E.EstTip, E.EstSegmento, M.MovTrnDta, M.MovtrnAnt,
	         M.MovTrnVlr, M.MovTrnVlrLiqEst, M.MovTrnGbpVlrTxaInt, M.MovTrnGbpVlrTxaAnt
GO


