USE [Pronto]
GO

/****** Object:  View [dbo].[VwConTrn]    Script Date: 01/11/2022 17:11:38 ******/
DROP VIEW [dbo].[VwConTrn]
GO

/****** Object:  View [dbo].[VwConTrn]    Script Date: 01/11/2022 17:11:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[VwConTrn] AS
SELECT 


   NewID() VwConTrnId, 
		a.MovTrnDta VwConTrnDta,  
		a.MovTrnBan as VwConTrnBan, 
		a.adqcod as VwConTrnAdqCod,  
		'Van04' VwConTrnOri, 
		sum(a.MovTrnVlr)   VwConTrnVlr,
		count(a.MovTrnVlr) VwConTrnQtd
		FROM MOVTRN01 a
		--where a.movtrnid in (select trnbrsoprmovtrnid from TRN05 where  trnbrsoprmovtrnid  > 0)
		where a.adqcod = 5
		and a.movtrncod in ( 'CV' , 'PS' )
		and MovTrnIdOri = 0 
		and MovTrnIdCan = 0 
		group by a.MovTrnDta,  
		a.MovTrnBan,
		a.adqcod

UNION All


SELECT 
		NEWID(), 
	   trnbrsoproridat, 
	   CASE 
			WHEN TrnBrsOprBan = '002' THEN 'M'
			WHEN TrnBrsOprBan = '003' THEN 'V'
			WHEN TrnBrsOprBan = '004' THEN 'E'
			WHEN TrnBrsOprBan = '010' THEN 'C'
			WHEN TrnBrsOprBan = '006' THEN 'D'
			ELSE ''
	   END,
	   adqcod,
	   'MOVTRN01',
	   sum(TrnBrsOprVlrPar),
	   count(distinct(trnbrsoprmovtrnid)) 
	FROM trn05    
	Where trnbrsoprmovtrnid  > 0
	and TrnBrsRdeSit in ('00','01','03','04')
	group by trnbrsoproridat, TrnBrsOprBan, adqcod

union all

select	NewID() VwConTrnId, 
		a.MovTrnDta VwConTrnDta,  
		a.MovTrnBan as VwConTrnBan, 
		a.adqcod as VwConTrnAdqCod,  
		'Van04' VwConTrnOri, 
		sum(a.MovTrnVlr)   VwConTrnVlr,
		count(a.MovTrnVlr) VwConTrnQtd
		FROM MOVTRN01 a
		--Where a.MovTrnId in ( select TrnPagSegMovTrnId from TrnPagSeg where TrnPagSegMovTrnId > 0)
		where a.adqcod = 8
		and a.movtrncod in ( 'CV' , 'PS' )
		and MovTrnIdOri = 0 
		and MovTrnIdCan = 0 
		group by a.MovTrnDta,  
		a.MovTrnBan,
		a.adqcod

union all

SELECT NEWID(),
DATATRN,
BANDEIRA,
ADQ,
ORIGEM,
ROUND(SUM(VALOR), 2),
COUNT(DISTINCT(MOVTRNID))
FROM (
SELECT convert(datetime, trnpagsegdatainicial, 121) DATATRN, 
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
		END BANDEIRA,
		8 ADQ,
	   'MOVTRN01' ORIGEM,
		IIF(TrnPagSegQuantidadeParcela > 0, TRNPAGSEGVALORTOTAL/TrnPagSegQuantidadeParcela,  TRNPAGSEGVALORTOTAL) VALOR,
		TrnPagSegMovTrnId MOVTRNID
		FROM TrnPagSeg
		Where TrnPagSegMovTrnId  > 0) A
		GROUP BY DATATRN,
				BANDEIRA,
				ADQ,
				ORIGEM

GO


