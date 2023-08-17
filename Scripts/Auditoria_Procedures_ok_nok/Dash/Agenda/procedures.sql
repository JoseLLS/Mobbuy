USE PRONTO
GO

ALTER PROCEDURE ConcMobAgdPagoPrv 
(
	@DataTrn DATE, 
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS
BEGIN
	SELECT @ValorTrn = COALESCE(SUM(A.ArbDetVlr),0) FROM (
	SELECT DISTINCT A.ArbDetEstCod, A.ArbDetVlr, A.ArbNum, A.ArbDetDtaCre
	FROM ARQDET A
	LEFT JOIN ARQDETLAN B
	ON A.ArbNum = B.ArbNum AND A.ArbLotNum = B.ArbLotNum AND A.ArbDetSeq = B.ArbDetSeq
	LEFT JOIN VLRPAG C
	ON B.ArbDetVlpNumLan = C.VlpNumLan
	WHERE A.ArbDetDtaCre = @DataTrn
	AND A.ArbDetCodSit = 4
	AND (C.VlpStspag = 2 OR C.VlpStspag IS NULL)) A
	--SELECT @ValorTrn = 0
END
GO

ALTER PROCEDURE ConcMobAgdPagoRel 
(
	@DataTrn DATE, 
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS
BEGIN

	SELECT @ValorTrn = COALESCE(SUM(A.ArbDetVlr), 0) 	
	FROM ARQDET A
	WHERE A.ArbDetDtaCre = @DataTrn
	AND A.ArbDetCodSit = 4
	--SELECT @ValorTrn = 0
END
GO

ALTER PROCEDURE ConcMobAgdRecPrv 
(
	@DataTrn DATE, 
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS
BEGIN
	SELECT @ValorTrn = COALESCE(SUM(VlrVlrRec), 0) 
	FROM VLRREC
	WHERE VlrDtaPrvLiqAnt = @DataTrn
	AND VlrStsRec = 2
	--SET @ValorTrn = 1
END
GO

ALTER PROCEDURE ConcMobAgdRecRel
(
	@DataTrn DATE, 
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS
BEGIN
	SELECT @ValorTrn = COALESCE(SUM(RadDetVlr), 0)
	FROM RAD0002 
	WHERE RadDat = @DataTrn
END
GO

	
	select * from (
	SELECT COALESCE(SUM(A.ArbDetVlr), 0) 'valorbanco', ArbDetEstCod
	FROM ARQDET A
	WHERE A.ArbDetDtaCre = '20230719'
	AND A.ArbDetCodSit = 4
	group by ArbDetEstCod
	) a inner join (
	--1791664,85

	SELECT sum(VlpVlrPag) 'valoragenda', EstCod
	FROM VLRPAG A
	WHERE VlpArbNum in 
	(
		SELECT A.ArbNum 	
		FROM ARQDET A
		WHERE A.ArbDetDtaCre = '20230719'
		AND A.ArbDetCodSit = 4
	)
	group by EstCod) b
	on a.ArbDetEstCod = b.EstCod
	where a.valorbanco <> b.valoragenda
	--4.558.122,39

	SELECT SUM(A.ArbDetVlr) FROM (
	SELECT DISTINCT A.ArbDetEstCod, A.ArbDetVlr, A.ArbNum
	FROM ARQDET A
	LEFT JOIN ARQDETLAN B
	ON A.ArbNum = B.ArbNum AND A.ArbLotNum = B.ArbLotNum AND A.ArbDetSeq = B.ArbDetSeq
	LEFT JOIN VLRPAG C
	ON B.ArbDetVlpNumLan = C.VlpNumLan
	WHERE A.ArbDetDtaCre = '20230703'
	AND A.ArbDetCodSit = 4
	AND (C.VlpStspag = 2 OR C.VlpStspag IS NULL)) A

	--1791664,85


	SELECT COALESCE(SUM(A.ArbDetVlr), 0) 	
	FROM ARQDET A
	WHERE A.ArbDetDtaCre = '20230703'
	AND A.ArbDetCodSit = 4
	--1798938.67

	SELECT * FROM VLRPAG WHERE VlpTrnCod = 'AL' AND VlpStspag = 2