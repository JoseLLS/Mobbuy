USE [Pronto]
GO

/****** Object:  StoredProcedure [dbo].[ConcAdqVendasSint]    Script Date: 26/07/2023 12:10:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConcAdqVendasSint]
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


