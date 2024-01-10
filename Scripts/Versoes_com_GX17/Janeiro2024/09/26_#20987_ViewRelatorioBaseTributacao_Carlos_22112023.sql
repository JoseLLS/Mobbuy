
GO

/****** Object:  View [dbo].[RelatorioBaseTributacao]    Script Date: 23/11/2023 12:09:00 ******/
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
	SUM(M.MovTrnVlr - M.MovTrnVlrLiqEst - M.MovTrnGbpVlrTxaInt - M.MovTrnGbpVlrTxaAnt) AS 'RelBaseTribReceitaLiquida',  --ALTERADO EM 23/11/2023 CONF. TAREFA #20987
	SUM(M.MovTrnGbpVlrTxaAnt)  AS 'RelBaseTribTaxaAntAdq',          						    --ALTERADO EM 23/11/2023 CONF. TAREFA #20987
    	SUM(CASE WHEN M.MovTrnTipPrd = 'P' THEN M.MovTrnVlr ELSE 0 END) AS 'RelBaseTribValorPix'--NOVO  06/03/2023

FROM MovTrn01 M
	LEFT JOIN EST E 
	ON E.EstCod = M.EstCod
	
	WHERE MovTrnCod IN ('CV', 'CC')
	
	GROUP BY M.EstCod, E.EstNomFan, E.EstAplPsq, E.EstCpfCnpj, E.EstTip, E.EstSegmento, M.MovTrnDta, M.MovtrnAnt,
	         M.MovTrnVlr, M.MovTrnVlrLiqEst, M.MovTrnGbpVlrTxaInt, M.MovTrnGbpVlrTxaAnt
GO


