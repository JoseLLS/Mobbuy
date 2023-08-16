USE [Pronto]
GO

/****** Object:  View [dbo].[CON0001]    Script Date: 01/11/2022 16:39:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE View [dbo].[CON0001]
As
Select * From (																								
select   NewID() ConTrnId, 
		'Van04' ConTrnOri, 
		a.MovTrnDta ConTrnDta, 
		a.EstCod  ConTrnEstCod, 
		a.MovTrnBan as ConTrnBan,  
		a.MovTrnTipPrd ConTrnTipPrd, 
		a.MovTrnNsu   ConTrnNsu, 
		a.MovTrnVlr ConTrnVlr , 
		a.MovTrnNumMov ConTrnAdqNumMov , 
		a.MovTrnNumReg ConTrnAdqNumReg , 
		''           as ConTrnPosNroSerInt , 
		''               as ConTrnPosNroSer , 
		a.MovTrnAutCodStr as ConTrnNumAtzStr , 
		a.MovTrnIdeTer as ConTrnAdqIdeTer , 
		a.MovTrnNumCar as ConTrnNumCar , 
		ConTrnAdqCod = a.AdqCod          
		FROM MOVTRN01 a
		left join trn05 b on a.movtrnid =  b.trnbrsoprmovtrnid 
		Where b.trnbrsoprmovtrnid is null
		and a.adqcod = 5
		and a.movtrncod in ( 'CV' , 'PS' )
		and MovTrnIdOri = 0 
		and MovTrnIdCan = 0 

		
UNION All


SELECT 
		NEWID() ConTrnId, 
	   'MOVTRN01'  ConTrnOri, 
	   trnbrsoproridat ConTrnDta, 
	   EstCod = 0,
	   CASE 
			WHEN TrnBrsOprBan = '002' THEN 'M'
			WHEN TrnBrsOprBan = '003' THEN 'V'
			WHEN TrnBrsOprBan = '004' THEN 'E'
			WHEN TrnBrsOprBan = '010' THEN 'C'
			WHEN TrnBrsOprBan = '006' THEN 'D'
			ELSE ''
	   END AS ConTrnBan,
	   SUBSTRING(Trnbrsoprideser, 4, 1) ConTrnTipPrd,
	   Trnbrsoprmovnsucrr ConTrnNsu,
	   Trnbrsoprvlr ConTrnVlr , 
	   ConTrnAdqNumMov = 0, 
	   ConTrnAdqNumReg = 0, 
	   trnbrsoprtrm as ConTrnPosNroSerInt , 
	   trnbrsoprtrm  as ConTrnPosNroSer , 
	   VanTrnNumAtzStr = '' , 
	   ''           as ConTrnAdqIdeTer , 
	   concat (trnbrsoprbin,trnbrsoprpan )  as ConTrnNumCar , 
	   adqcod as ConTrnAdqCod    
FROM trn05    
Where trnbrsoprmovtrnid  = 0
and TrnBrsRdeSit in ('00','01','03','04')
group by trnbrsoproridat, Trnbrsoprideser, Trnbrsoprmovnsucrr, 
trnbrsoprtrm, trnbrsoprbin, trnbrsoprpan, adqcod, TrnBrsOprBan, Trnbrsoprvlr



UNION All

select   NewID() ConTrnId, 
		'Van04' ConTrnOri, 
		a.MovTrnDta ConTrnDta, 
		a.EstCod  ConTrnEstCod, 
		a.MovTrnBan as ConTrnBan,  
		a.MovTrnTipPrd ConTrnTipPrd, 
		a.MovTrnNsu   ConTrnNsu, 
		a.MovTrnVlr ConTrnVlr , 
		a.MovTrnNumMov ConTrnAdqNumMov , 
		a.MovTrnNumReg ConTrnAdqNumReg , 
		''           as ConTrnPosNroSerInt , 
		''               as ConTrnPosNroSer , 
		a.MovTrnAutCodStr as ConTrnNumAtzStr , 
		a.MovTrnIdeTer as ConTrnAdqIdeTer , 
		a.MovTrnNumCar as ConTrnNumCar , 
		ConTrnAdqCod = a.AdqCod        
		FROM MOVTRN01 a
		left join TrnPagSeg b on a.movtrnid =  b.TrnPagSegMovTrnId 
		Where b.TrnPagSegMovTrnId is null
		and a.adqcod = 8
		and a.movtrncod in ( 'CV' , 'PS' )
		and MovTrnIdOri = 0 
		and MovTrnIdCan = 0 
		
UNION All

SELECT NEWID() ConTrnId, 
	   'MOVTRN01'    ConTrnOri, 
	   convert(datetime, trnpagsegdatainicial, 121) ConTrnDta, 
	   EstCod = trnpagsegestabelecimento ,
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
	   TrnPagSegNsu ConTrnNsu,
	   trnpagsegvalororiginal ConTrnVlr , 
	   ''  as ConTrnAdqNumMov , 
	   ''  as ConTrnAdqNumReg , 
	   convert(varchar(40), trnpagsegestabelecimento) as ConTrnPosNroSerInt , 
	   convert(varchar(40), trnpagsegestabelecimento)  as ConTrnPosNroSer , 
	   convert(varchar(40), trnpagsegautorizacaocodigo) as VanTrnNumAtzStr, 
	   ''           as ConTrnAdqIdeTer , 
	   concat (trnpagsegcartaobin,trnpagsegcartaoholder )  as ConTrnNumCar , 
	   8 as ConTrnAdqCod   
FROM TrnPagSeg    
Where TrnPagSegMovTrnId  = 0
or TrnPagSegMovTrnId is null
group by trnpagsegdatainicial, TrnPagSegInstituicao, TrnPagSegMeioPagamento, TrnPagSegNsu, trnpagsegvalororiginal,
trnpagsegestabelecimento, trnpagsegautorizacaocodigo, trnpagsegcartaobin, trnpagsegcartaoholder
) Resultado
GO


