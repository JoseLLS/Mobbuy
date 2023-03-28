
/****** Object:  View [dbo].[RelatorioBaseTributacao]    Script Date: 09/02/2022 09:18:28 ******/

CREATE VIEW [dbo].[RelatorioBaseTributacao] AS
select 	
	[MovTrn01].[EstCod] as RelBaseTribCodigo,
	[EST].[EstAplPsq] as RelBaseTribEstabelecimento,
	[EST].[EstSegmento] as RelBaseTribSegmentos,
	[EST].[EstNomFan] as RelBaseTribNomeFantasia,
	[EST].[EstCpfCnpj] as RelBaseTribCNPJ,
	[EST].[EstTip] as RelBaseTribEstTipo,
	movtrndta as RelBaseTribData,
	sum(MovTrnVlr) as RelBaseTribValorVenda, 	  
	sum(MovTrnVlrLiqEst) as RelBaseTribValorEstabelecimento,		
	sum(MovTrnBfaVlrTxaAdm) as RelBaseTribTaxaAdministracao,	
	sum(MovTrnBfaVlrTxaFin) as RelBaseTribReceitaAntecipacao,
	sum(MovTrnGbpVlrTxaInt) as RelBaseTribTaxaAdquirente,
	sum(MovTrnVlr - MovTrnVlrLiqEst - MovTrnGbpVlrTxaInt) as RelBaseTribReceitaLiquida
from [MovTrn01]
	left join [EST] on [EST].[EstCod] = [MovTrn01].[EstCod]
	Where MovTrnCod in ('CV', 'CC')
	group by [MovTrn01].[EstCod], EstNomFan, EstAplPsq, EstCpfCnpj, EstTip, EstSegmento, movtrndta

GO


