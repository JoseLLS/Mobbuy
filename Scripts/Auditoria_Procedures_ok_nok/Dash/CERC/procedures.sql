use Pronto
go


CREATE PROCEDURE ConcMobCercEfePrv
(
	@DataTrn DATE, 
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS
BEGIN

	SELECT @ValorTrn = COALESCE(SUM(EfeitoContratoVlrRepasse), 0) 
	FROM
	EfeitoContrato a
	WHERE a.EfeitoContratoDtaVenc = @DataTrn
	AND a.EfeitoContratoArbNum > 0
	AND a.EfeitoContratoVlrRepasse > 0

END
GO

CREATE PROCEDURE ConcMobCercEfeRel
(
	@DataTrn DATE, 
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS
BEGIN

	SELECT @ValorTrn = COALESCE(SUM(ArbDetVlr), 0) FROM ARQDET a
	WHERE ArbDetDtaCre = @DataTrn
	AND ArbNum in 
	(
	SELECT EfeitoContratoArbNum 
	FROM
	EfeitoContrato a
	WHERE a.EfeitoContratoDtaVenc = @DataTrn
	AND a.EfeitoContratoArbNum > 0
	AND a.EfeitoContratoVlrRepasse > 0
	)

END
GO

alter PROCEDURE ConcMobCercMovDiaPrv
(
	@DataTrn DATE, 
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS
BEGIN

	SELECT @ValorTrn = COALESCE(SUM(VlpVlrPag), 0) 
	FROM VLRPAG A
	WHERE A.VlpDtaVct = @DataTrn
	AND A.VlpIdCreditTransaction = 0
	AND A.VlpIdCreditTransactionPai = 0
	
	SELECT @ValorTrn += COALESCE(SUM(VlpVlrPag), 0)	
	FROM VLRPAG A
	WHERE A.VlpDtaVct = @DataTrn
	AND A.VlpIdCreditTransaction > 0

END
GO

alter PROCEDURE ConcMobCercMovDiaRel
(
	@DataTrn DATE, 
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS
BEGIN

	SELECT @ValorTrn = COALESCE(SUM(UnidPagVlrLiq), 0)
	FROM UnidRecPag
	WHERE UnidDtaVcto = @DataTrn

END
GO