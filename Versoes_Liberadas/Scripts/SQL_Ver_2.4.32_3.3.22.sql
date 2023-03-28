/* TAREFA #19611 - JOSÉ */

--Rodar em todos os clientes

UPDATE EST
SET EstDtaDcr = EstDtiAlt
WHERE EstSit = 'I'

/* TAREFA #19863 - JOSÉ */

--Rodar script em todos os bancos de clientes

ALTER view [dbo].[AGPTRN] as 
    select 
        AgpDtaPag    = v.VlpDtaVct ,
        AgpEstCod	 = v.EstCod ,
		AgpDtaTrn    = m.MovTrnDta ,
		AptNumSeq	 = ROW_NUMBER() over (partition by v.VlpDtaVct, v.EstCod, m.MovTrnDta order by v.VlpDtaVct, v.EstCod, m.MovTrnDta) ,
		AptNumMov	 = m.MovTrnNumMov ,
		AptNumReg	 = m.MovTrnNumReg ,
		AptTipLanAgd = v.VlpTipPrd ,
		AptVlpNumTotPar = v.VlpNumTotPar,
		AptNsuTrn	 = m.MovTrnNsu ,
		AptVlrBru	 = case 
			when v.TidCod=1 and isnull(MovTrnCod,'')='AJ' then v.VlpVlrParBru
			when v.TidCod=1 and isnull(MovTrnCod,'')='CV' and isnull(MovTrnTipPrd,'')='D' and isnull(MovTrnParQtd,'') <= 1 and v.VlpVlrParBru = 0 then m.MovTrnVlr
			when v.TidCod=1 and isnull(MovTrnCod,'')='CV' and isnull(MovTrnTipPrd,'')='D' and isnull(MovTrnParQtd,'') <= 1 and v.VlpVlrParBru <> 0 then  v.VlpVlrParBru
			when v.TidCod=1 and isnull(MovTrnCod,'')='CV' and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') <= 1 and v.VlpVlrParBru = 0 then m.MovTrnVlr
			when v.TidCod=1 and isnull(MovTrnCod,'')='CV' and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') <= 1 and v.VlpVlrParBru <> 0 then v.VlpVlrParBru
			when v.TidCod=1 and isnull(MovTrnCod,'')='CV' and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') >  1 and m.MovTrnParIndBemFac = 'N' and v.VlpVlrParBru = 0 then m.MovTrnParVlr 
			when v.TidCod=1 and isnull(MovTrnCod,'')='CV' and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') >  1 and m.MovTrnParIndBemFac = 'N' and v.VlpVlrParBru <> 0 then v.VlpVlrParBru
			when v.TidCod=1 and isnull(MovTrnCod,'')='CV' and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') >  1 and m.MovTrnParIndBemFac = 'S' then m.MovTrnVlr
		else 0 end ,
		AptVlrDsc	 = case when v.VlpStspag = 2 and VlpVlrPagLiq < 0 and ((VlpVlrTaxAdm  + VlpVlrCstTrnPln  +  VlpVlrCstTrnEst + VlpVlrTaxFinBF + VlpVlrTarCreBF) > 0) then (VlpVlrTaxAdm  + VlpVlrCstTrnPln  +  VlpVlrCstTrnEst + VlpVlrTaxFinBF + VlpVlrTarCreBF) * -1
							when v.VlpStspag = 2 and VlpVlrOriPag <> 0 and VlpVlrPagLiq <> 0 then (VlpVlrOriPag - VlpVlrPagLiq) + VlpVlrTaxAdm  + VlpVlrCstTrnPln  +  VlpVlrCstTrnEst + VlpVlrTaxFinBF + VlpVlrTarCreBF
							when v.VlpStspag = 2 and VlpVlrOriPag <> 0 and VlpVlrPagLiq = 0 then (VlpVlrOriPag - VlpVlrPag) + VlpVlrTaxAdm  + VlpVlrCstTrnPln  +  VlpVlrCstTrnEst + VlpVlrTaxFinBF + VlpVlrTarCreBF
							when v.VlpStspag = 1 and VlpVlrOriPag <> 0 then (VlpVlrOriPag - VlpVlrPag) + VlpVlrTaxAdm  + VlpVlrCstTrnPln  +  VlpVlrCstTrnEst + VlpVlrTaxFinBF + VlpVlrTarCreBF
							when VlpVlrOriPag = 0 then VlpVlrTaxAdm  + VlpVlrCstTrnPln  +  VlpVlrCstTrnEst + VlpVlrTaxFinBF + VlpVlrTarCreBF 
					   else 0 end ,
		AptVlrLiq	 = case  when v.VlpVlrPagLiq = 0 then VlpVlrPag 
							 when v.VlpStspag = 2 then VlpVlrPagLiq 
							 when v.VlpStspag = 5 then VlpVlrPag 
					   else 0 end ,
		AptDtaLiq	 = v.VlpDtaLiq ,
		AptVlrPag	 = v.VlpVlrPag ,
		AptNumPar	 = v.VlpNumPar ,
		AptTotPar    = m.MovTrnParQtd ,
		AptNumVlr	 = v.VlpNumLan ,
        AptDtiInc	 = getdate() ,
		AptUsuInc	 = '',
		AptVlpDtiInc = v.VlpDtiInc,
		AptVlpArbNum = v.VlpArbNum,
		AptArbDtaMov = a.ArbDtaMov
    from VlrPag v inner join movtrn01 m on ( m.movtrnid = v.VlpMovTrnId ) left join ARQBAN a on a.ArbNum = v.VlpArbNum
	where v.VlpStspag not in (3,4) and MovTrnCod <> 'CC' and MovTrnIdCan = 0

/* SEM TAREFA - JOSÉ */

INSERT INTO PARSIS
VALUES ('SUDO_ATIVADO', 'Verifica se o sudo está habilitado no ambiente ou não para rodar robôs', 'VA', 1, NULL, 'N', 
'S', 'ADMIN', '2022-10-31 00:00:00', NULL, NULL, 0)

/* TAREFA #19867 - LEONARDO */

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

-------------------------------------------------------------------------------------------------

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