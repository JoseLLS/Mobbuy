USE SMARTPAGAMENTOS
GO

/****** Object:  View [dbo].[VwRelAudCessao]    Script Date: 28/02/2024 14:32:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 CREATE view [dbo].[VwRelAudCessao] as
	SELECT
	NewID() AS 'VwRelAudCessaoGUID',
	A.CessaoId AS 'VwRelAudCessaoId',
	A.CessaoEstCodOri AS 'VwRelAudCessaoOriEstCod',
	B.EstNomFan AS 'VwRelAudCessaoOriEstNom',
	B.EstSegmento AS 'VwRelAudCessaoOriEstSeg',
	B.EstCpfCnpj AS 'VwRelAudCessaoOriEstCpfCnpj',
	A.CessaoEstCodBen AS 'VwRelAudCessaoBenEstCod',
	C.EstNomFan AS 'VwRelAudCessaoBenEstNom',
	C.EstCpfCnpj AS 'VwRelAudCessaoBenEstCpfCnpj',
	A.CessaoDtaCad AS 'VwRelAudCessaoDtaCad',--DATACESSAO,
	G.CessaoStatusDesc AS 'VwRelAudCessaoStatusDesc',--STATUS,
	E.VlpNumPar AS 'VwRelAudCessaoParcela',
	A.CessaoValor AS 'VwRelAudCessaoValor',--VALORCESSAO,
	F.CessaoTipoDesc AS 'VwRelAudCessaoTipo',--TIPO
	A.CessaoNFDistribuidora AS 'VwRelAudCessaoNF',--NF,
	A.CessaoValorNota AS 'VwRelAudCessaoValorNF',--VALORNOTA,
	A.CessaoDataEmissao AS 'VwRelAudCessaoDataEmi',--DATAEMISSAO,
	A.CessaoDistribuidor AS 'VwRelAudCessaoDistri',--DISTRIBUIDOR,
	A.CessaoFilial AS 'VwRelAudCessaoFilial',--FILIAL,
	H.MovTrnDta AS 'VwRelAudCessaoDtaTrn',--DATATRANSACAO,
	E.VlpDtaVct AS 'VwRelAudCessaoDtaLiqLan',--DATALIQUIDACAO,
	'Parcelado' AS 'VwRelAudCessaoTipoLan',--TIPOTRANSACAO,
	E.VlpAutCodStr AS 'VwRelAudCessaoAutLan',--AUTORIZACAO,
	E.VlpNsu AS 'VwRelAudCessaoNsuLan',--NSU,
	D.CessaoDetValor AS 'VwRelAudCessaoDetValor',
	H.MovTrnCod AS 'VwRelAudVlpTrnCod'
	FROM CESSAO A 
	INNER JOIN EST B
	ON A.CessaoEstCodOri = B.EstCod
	INNER JOIN EST C
	ON A.CessaoEstCodBen = C.EstCod
	LEFT JOIN CESSAODETALHE D
	ON A.CessaoId = D.CessaoId
	LEFT JOIN VLRPAG E
	ON D.CessaoDetNumLan = E.VlpNumLan
	INNER JOIN CESSAOTIPO F
	ON A.CessaoTipoId = F.CessaoTipoId
	INNER JOIN CESSAOSTATUS G
	ON A.CessaoStatusId = G.CessaoStatusId
	LEFT JOIN MovTrn01 H
	ON E.VlpMovTrnId = H.MovTrnId
	WHERE A.CessaoStatusId = 1
GO