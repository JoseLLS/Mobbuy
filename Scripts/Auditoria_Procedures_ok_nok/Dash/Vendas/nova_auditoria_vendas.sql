USE Pronto
GO

ALTER PROCEDURE [dbo].[ConcResultadosLoop](@DATAINI DATE, @DATAFIM DATE)
AS
BEGIN

DELETE FROM ConcResultados

INSERT INTO ConcResultados (ConcResultadosData, ConcResultadosVendas, 
									ConcResultadosMDR, ConcResultadosAntecip,
									ConcResultadosAgenda, ConcResultadosCessao,
									ConcResultadosPrestServ, ConcResultadosPIX,
									ConcResultadosCerc, ConcResultadosAntAdq)

SELECT Mob.MovTrnDta,
CASE
	WHEN (MOB.ValorMob = ADQ.ValorAdq AND Mob.ValorMob = Sitef.ValorSitef)  THEN 'OK'
	ELSE 'NOK'
END,  
'OK', 'OK', 'OK', 'OK', 'OK', 'OK', 'OK', 'OK'
FROM 
(
	SELECT COALESCE(SUM(MovTrnVlr),0) 'ValorMob', MovTrnDta 
	FROM MovTrn01
	WHERE MovTrnDta BETWEEN @DATAINI AND @DATAFIM
	AND MovTrnCod IN ('CV', 'CC', 'PS')
	AND MovTrnTipPrd <> 'P'
	GROUP BY MovTrnDta
) Mob
LEFT JOIN 
(
	SELECT COALESCE(SUM(ValorTrn),0) 'ValorSitef', VanWbsDat FROM (
		SELECT  
		IIF(VanWbsDsc LIKE '%CANCELAMENTO%', ((CONVERT(NUMERIC(17,2),VanWbsVlr))/100) * -1, ((CONVERT(NUMERIC(17,2),VanWbsVlr))/100)) 'ValorTrn', VanWbsDat
		FROM VAN02 
		WHERE VanWbsDat BETWEEN @DATAINI AND @DATAFIM
		AND VanErrCod = 0
		AND VanWbsSta LIKE '%CONFIRMADA%') A GROUP BY VanWbsDat
) Sitef
ON Mob.MovTrnDta = Sitef.VanWbsDat
LEFT JOIN 
(
	SELECT A.TrnBrsOprOriDat, A.ValorTRN05 + B.ValorTrnPagSeg AS 'ValorAdq' FROM (
	
		SELECT COALESCE(SUM(Valor),0) 'ValorTRN05', TrnBrsOprOriDat FROM (
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
			AND TrnBrsOprOriDat BETWEEN @DATAINI AND @DATAFIM
			group by TrnBrsOprOriDat, Trnbrsoprideser, Trnbrsoprmovnsucrr, 
			trnbrsoprtrm, trnbrsoprbin, trnbrsoprpan, TrnBrsOprBan, Trnbrsoprvlr, TrnBrsRdeSit) TRN05
			GROUP BY TrnBrsOprOriDat) A
	LEFT JOIN (
	
		SELECT COALESCE(SUM(Valor),0) 'ValorTrnPagSeg', DataTrn FROM (
			SELECT 
				   convert(datetime, trnpagsegdatainicial, 121) 'DataTrn',
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
			WHERE convert(datetime, trnpagsegdatainicial, 121) BETWEEN @DATAINI AND @DATAFIM
			group by trnpagsegdatainicial, TrnPagSegMeioPagamento, trnpagsegcvcodigo, 
			trnpagsegvalororiginal, trnpagsegcartaobin, trnpagsegcartaoholder, TrnPagSegInstituicao, TrnPagSegTipoEvento) TRNPAGSEG
			GROUP BY DataTrn) B 
	ON A.TrnBrsOprOriDat = B.DataTrn
) Adq
ON Mob.MovTrnDta = Adq.TrnBrsOprOriDat

END

GO



/*TESTES*/

DECLARE @DATAINI DATE = '20230601'
DECLARE @DATAFIM DATE = '20230630'

SELECT Mob.MovTrnDta,
CASE
	WHEN (MOB.ValorMob = ADQ.ValorAdq AND Mob.ValorMob = Sitef.ValorSitef)  THEN 'OK'
	ELSE 'NOK'
END,  
'OK', 'OK', 'OK', 'OK', 'OK', 'OK', 'OK', 'OK',ValorAdq, ValorMob, ValorSitef
FROM 
(
	SELECT COALESCE(SUM(MovTrnVlr),0) 'ValorMob', MovTrnDta 
	FROM MovTrn01
	WHERE MovTrnDta BETWEEN @DATAINI AND @DATAFIM
	AND MovTrnCod IN ('CV', 'CC', 'PS')
	AND MovTrnTipPrd <> 'P'
	GROUP BY MovTrnDta
) Mob
LEFT JOIN 
(
	SELECT COALESCE(SUM(ValorTrn),0) 'ValorSitef', VanWbsDat FROM (
		SELECT  
		IIF(VanWbsDsc LIKE '%CANCELAMENTO%', ((CONVERT(NUMERIC(17,2),VanWbsVlr))/100) * -1, ((CONVERT(NUMERIC(17,2),VanWbsVlr))/100)) 'ValorTrn', VanWbsDat
		FROM VAN02 
		WHERE VanWbsDat BETWEEN @DATAINI AND @DATAFIM
		AND VanErrCod = 0
		AND VanWbsSta LIKE '%CONFIRMADA%') A GROUP BY VanWbsDat
) Sitef
ON Mob.MovTrnDta = Sitef.VanWbsDat
LEFT JOIN 
(
	SELECT A.TrnBrsOprOriDat, A.ValorTRN05 + B.ValorTrnPagSeg AS 'ValorAdq' FROM (
	
		SELECT COALESCE(SUM(Valor),0) 'ValorTRN05', TrnBrsOprOriDat FROM (
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
			AND TrnBrsFecDtaRef BETWEEN @DATAINI AND @DATAFIM
			group by TrnBrsOprOriDat, Trnbrsoprideser, Trnbrsoprmovnsucrr, 
			trnbrsoprtrm, trnbrsoprbin, trnbrsoprpan, TrnBrsOprBan, Trnbrsoprvlr, TrnBrsRdeSit) TRN05
			GROUP BY TrnBrsOprOriDat) A
	LEFT JOIN (
	
		SELECT COALESCE(SUM(Valor),0) 'ValorTrnPagSeg', DataTrn FROM (
			SELECT 
				   convert(datetime, trnpagsegdatainicial, 121) 'DataTrn',
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
			WHERE convert(datetime, trnpagsegdatainicial, 121) BETWEEN @DATAINI AND @DATAFIM
			group by trnpagsegdatainicial, TrnPagSegMeioPagamento, trnpagsegcvcodigo, 
			trnpagsegvalororiginal, trnpagsegcartaobin, trnpagsegcartaoholder, TrnPagSegInstituicao, TrnPagSegTipoEvento) TRNPAGSEG
			GROUP BY DataTrn) B 
	ON A.TrnBrsOprOriDat = B.DataTrn
) Adq
ON Mob.MovTrnDta = Adq.TrnBrsOprOriDat


SELECT COALESCE(SUM(Valor),0) FROM (
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
	AND TrnBrsFecDtaRef = '20230604'
	group by TrnBrsOprOriDat, Trnbrsoprideser, Trnbrsoprmovnsucrr, 
	trnbrsoprtrm, trnbrsoprbin, trnbrsoprpan, TrnBrsOprBan, Trnbrsoprvlr, TrnBrsRdeSit) A


	SELECT COALESCE(SUM(Valor),0) FROM (
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
	WHERE convert(datetime, trnpagsegdatainicial, 121) = '20230604'
	group by trnpagsegdatainicial, TrnPagSegMeioPagamento, trnpagsegcvcodigo, 
	trnpagsegvalororiginal, trnpagsegcartaobin, trnpagsegcartaoholder, TrnPagSegInstituicao, TrnPagSegTipoEvento) B

SELECT * FROM MovTrn01 WHERE MovTrnDta = '20230604' AND AdqCod = 5

SELECT * FROM MovTrn01 WHERE MovTrnNsu = 15500632594
SELECT * FROM TRN05 WHERE TrnBrsOprMovNsuCrr = 15500632594