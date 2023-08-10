use Pronto
go

create PROCEDURE ConcMobVendasSint
(
	@DataTrn DATE,
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS

BEGIN
	SELECT @ValorTrn = COALESCE(SUM(MovTrnVlr),0) FROM MovTrn01
	WHERE MovTrnDta = @DataTrn
	AND MovTrnCod IN ('CV', 'CC', 'PS')
	AND MovTrnTipPrd <> 'P'
END

GO

declare @vendas numeric (17,2)

exec ConcMobVendasSint @DataTrn = '20230801', @ValorTrn = @vendas output;

select @vendas

select * from MovTrn01 where MovTrnTipPrd = 'P'

GO

create PROCEDURE ConcSitefVendasSint
(
	@DataTrn DATE,
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS

BEGIN
	SELECT @ValorTrn = COALESCE(SUM(ValorTrn),0) FROM (
	SELECT  
	IIF(VanWbsDsc LIKE '%CANCELAMENTO%', ((CONVERT(NUMERIC(17,2),VanWbsVlr))/100) * -1, ((CONVERT(NUMERIC(17,2),VanWbsVlr))/100)) 'ValorTrn'
	FROM VAN02 
	WHERE VanWbsDat = @DataTrn
	AND VanErrCod = 0
	AND VanWbsSta LIKE '%CONFIRMADA%') A
END

GO


declare @vendas numeric (17,2)

exec ConcSitefVendasSint @DataTrn = '20230801', @ValorTrn = @vendas output;

select @vendas

GO


create PROCEDURE ConcAdqVendasSint
(
	@DataTrn DATE,
	@ValorTrn NUMERIC(17,2) OUTPUT
)
AS

BEGIN

	SET @ValorTrn = 0

	SELECT @ValorTrn += COALESCE(SUM(Valor),0) FROM (
	SELECT
		   TrnBrsOprOriDat, 
		   CASE 
				WHEN TrnBrsOprBan = '002' THEN 'M'
				WHEN TrnBrsOprBan = '003' THEN 'V'
				WHEN TrnBrsOprBan = '004' THEN 'E'
				WHEN TrnBrsOprBan = '010' THEN 'C'
				WHEN TrnBrsOprBan = '006' THEN 'D'
				ELSE ''
		   END AS Bandeira,
		   SUBSTRING(Trnbrsoprideser, 4, 1) Produto,
		   Trnbrsoprmovnsucrr NSU,
		   IIF(TrnBrsRdeSit < 20, Trnbrsoprvlr, Trnbrsoprvlr *-1) Valor, 
		   trnbrsoprtrm as PosNroSer,
		   concat (trnbrsoprbin,trnbrsoprpan )  as ConTrnNumCar    
	FROM trn05    
	WHERE TrnBrsRdeSit in ('00','01','03','04')
	AND TrnBrsOprOriDat = @DataTrn
	group by TrnBrsOprOriDat, Trnbrsoprideser, Trnbrsoprmovnsucrr, 
	trnbrsoprtrm, trnbrsoprbin, trnbrsoprpan, TrnBrsOprBan, Trnbrsoprvlr, TrnBrsRdeSit) A


	SELECT @ValorTrn += COALESCE(SUM(Valor),0) FROM (
	SELECT 
		   convert(datetime, trnpagsegdatainicial, 121) 'Data',
		   CASE
			WHEN TrnPagSegInstituicao = 'AMEX' THEN 'A'
			WHEN TrnPagSegInstituicao =	'CABAL' THEN 'C'
			WHEN TrnPagSegInstituicao =	'ELO' THEN 'E'
			WHEN TrnPagSegInstituicao =	'HIPERCARD' THEN 'H'
			WHEN TrnPagSegInstituicao =	'MAESTRO' THEN 'M'
			WHEN TrnPagSegInstituicao =	'MASTERCARD' THEN 'M'
			WHEN TrnPagSegInstituicao =	'VISA' THEN 'V'
			WHEN TrnPagSegInstituicao =	'VISA ELECTRON' THEN 'V'
			ELSE ''
			END AS ConTrnBan,
		   iif(TrnPagSegMeioPagamento = 3, 'C', 'D') ConTrnTipPrd,
		   trnpagsegcvcodigo ConTrnNsu,
		   IIF(TrnPagSegTipoEvento = 1, trnpagsegvalororiginal, trnpagsegvalororiginal *-1) Valor,  
		   concat (trnpagsegcartaobin,trnpagsegcartaoholder )  as ConTrnNumCar,
		   TrnPagSegTipoEvento
	FROM TrnPagSeg
	WHERE convert(datetime, trnpagsegdatainicial, 121) = @DataTrn
	group by trnpagsegdatainicial, TrnPagSegMeioPagamento, trnpagsegcvcodigo, 
	trnpagsegvalororiginal, trnpagsegcartaobin, trnpagsegcartaoholder, TrnPagSegInstituicao, TrnPagSegTipoEvento) B

END

GO


create PROCEDURE [dbo].[ConcResultadosLoop](@DATAINI DATE, @DATAFIM DATE)
AS
BEGIN

	DELETE FROM ConcResultados

	DECLARE @DATAFILTRO DATE;
	DECLARE @ITERADOR INT;
	DECLARE @I INT;

	DECLARE @ValorMob NUMERIC(17,2);
	DECLARE @ValorAdq NUMERIC(17,2);
	DECLARE @ValorSitef NUMERIC(17,2);
	DECLARE @RESULTADO VARCHAR(3);

	SET @DATAFILTRO = @DATAINI

	SET @ITERADOR = DATEDIFF(DAY, @DATAINI, @DATAFIM);
	SET @I = 0;

	WHILE @I <= @ITERADOR
	BEGIN
		SET @RESULTADO = 'NOK'
		EXEC ConcMobVendasSint @DataTrn = @DATAFILTRO, @ValorTrn = @ValorMob output;
		EXEC ConcSitefVendasSint @DataTrn = @DATAFILTRO, @ValorTrn = @ValorSitef output;
		EXEC ConcAdqVendasSint @DataTrn = @DATAFILTRO, @ValorTrn = @ValorAdq output;

		IF @ValorMob = @ValorAdq AND @ValorMob = @ValorSitef 
			SET @RESULTADO = 'OK'

		INSERT INTO ConcResultados (ConcResultadosData, ConcResultadosVendas, 
									ConcResultadosMDR, ConcResultadosAntecip,
									ConcResultadosAgenda, ConcResultadosCessao,
									ConcResultadosPrestServ, ConcResultadosPIX,
									ConcResultadosCerc, ConcResultadosAntAdq)
		VALUES (@DATAFILTRO, @RESULTADO, 'OK', 'OK', 'OK', 'OK', 'OK', 'OK', 'OK', 'OK')

		SET @DATAFILTRO = DATEADD(DAY, 1, @DATAFILTRO)
		SET @I = @I + 1;

	END

END

GO


EXEC ConcResultadosLoop '20230601', '20230630'

select * from concresultados

USE PRONTO