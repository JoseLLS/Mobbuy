/****** Object:  View [dbo].[VwEfeArb]    Script Date: 20/12/2022 10:56:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[VwEfeArb] as 
	SELECT 
	NewID()                         AS 'VwEfeArbGuid',
	A.ArbDetEstCod 'VwEfeArbEstCod', 
	A.ArbNum 'VwEfeArbNum',
	A.ArbLotNum 'VwEfeArbLotNum',
	A.ArbDetSeq 'VwEfeArbDetSeq' 
	FROM ARQDET A
	INNER JOIN EfeitoContrato B
	ON A.ArbNum = B.EfeitoContratoArbNum AND A.ArbLotNum = B.EfeitoContratoArbLotNum 
	AND A.ArbDetSeq = B.EfeitoContratoArbDetSeq AND A.ArbDetEstCod = B.EfeitoContratoEstCod
	WHERE A.ArbDetCodSit IN (0,4)
	GROUP BY
	A.ArbDetEstCod, 
	A.ArbNum,
	A.ArbLotNum,
	A.ArbDetSeq
GO


CREATE view [dbo].[VwEfeVlr] as 

	SELECT
	NewID() 'VwEfeVlrGuid',
	EfeitoContratoDtaVenc 'VwEfeVencimento',
	EfeitoContratoEstCod 'VwEfeEstCod',
	REPASSE 'VwEfeValor',
	EstCod 'VwVlrEstCod',
	VlpDtaVct 'VwVlrDtaVct',
	VALOR 'VwVlrValor'
	FROM (
	SELECT EfeitoContratoDtaVenc,
	EfeitoContratoEstCod,
	SUM(EfeitoContratoVlrRepasse) 'REPASSE'
	FROM EfeitoContrato A
	INNER JOIN VWEFEARB B
	ON A.EfeitoContratoEstCod = B.VWEFEARBESTCOD
	AND A.EfeitoContratoArbNum = B.VWEFEARBNUM
	AND A.EfeitoContratoArbLotNum = B.VWEFEARBLOTNUM
	AND A.EfeitoContratoArbDetSeq = B.VWEFEARBDETSEQ
	WHERE  A.EfeitoContratoVlrRepasse <> 0
	GROUP BY EfeitoContratoDtaVenc,
	EfeitoContratoEstCod) A INNER JOIN (
	SELECT EstCod,
	VlpDtaVct,
	SUM(VlpVlrEfeito) 'VALOR'
	FROM VLRPAG A
	WHERE VlpVlrEfeito <> 0
	GROUP BY
	EstCod,
	VlpDtaVct) B
	ON A.EfeitoContratoEstCod = B.EstCod AND A.EfeitoContratoDtaVenc = B.VlpDtaVct

GO


