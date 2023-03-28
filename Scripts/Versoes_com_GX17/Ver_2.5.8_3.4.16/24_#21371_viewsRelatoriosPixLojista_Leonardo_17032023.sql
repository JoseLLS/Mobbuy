USE [Pronto]
GO

/****** Object:  View [dbo].[AgdPag02]    Script Date: 17/03/2023 14:10:19 ******/
DROP VIEW [dbo].[AgdPag02]
GO

/****** Object:  View [dbo].[AgdPag02]    Script Date: 17/03/2023 14:10:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   view [dbo].[AgdPag02] as 
    select 
        AgdPg1Dta    = v.VlpDtaVct ,
        AgdPg2EstCod = v.EstCod ,
        AgdPg2EstNomFanRed = ( select EstNomFan from EST where EstCod = v.EstCod),
		AgdPg2VlrPix	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='P' and isnull(MovTrnParQtd,'') <= 1 then VlpVlrPag Else 0 end ) ,
        AgdPg2VlrDeb	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='D' and isnull(MovTrnParQtd,'') <= 1 then VlpVlrPag Else 0 end ) ,
        AgdPg2VlrCre	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') <= 1 then VlpVlrPag Else 0 end ),
        AgdPg2VlrPrc	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') >  1 then VlpVlrPag Else 0 end ),
        AgdPg2VlrAju	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'')='AJ'then VlpVlrPag Else 0 end ),
        AgdPg2VlrCan	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'')='CC'then VlpVlrPag Else 0 end ),
        AgdPg2VlrOut	= sum( case when v.TidCod>1 or  isnull(MovTrnCod,'')='AL'  then VlpVlrPag Else 0 end ),
        AgdPg2VlrRee	= sum( case when v.VlpStspag=2                           then VlpVlrPag Else 0 end ),
		AgdPg2VlrTotAbe = sum( case when v.VlpStspag=1                            then VlpVlrPag Else 0 end )
    from VlrPag v left join movtrn01 m on (m.movtrnid =  v.VlpMovTrnId ) where v.VlpStspag not in (3,4) 
    group by v.VlpDtaVct , v.estcod    


GO


USE [Pronto]
GO

/****** Object:  View [dbo].[VwAgdPag]    Script Date: 17/03/2023 14:10:45 ******/
DROP VIEW [dbo].[VwAgdPag]
GO

/****** Object:  View [dbo].[VwAgdPag]    Script Date: 17/03/2023 14:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE   View [dbo].[VwAgdPag] as (
Select NewID() AgdSumID,
AgdPg1Dta AdgSumDta,
AgdPg2EstCod EstCod,
Sum(AgdPg2VlrPix) AgpSumVlrPix,
Sum(AgdPg2VlrDeb) AgpSumVlrDeb,
Sum(AgdPg2VlrCre) AgpSumVlrCreVis,
Sum(AgdPg2VlrPrc) AgpSumVlrCrePar,
Sum(AgdPg2VlrAju) + Sum(AgdPg2VlrOut) AgpSumVlrAju,
Sum(AgdPg2VlrCan) AgpSumVlrDes,
Sum(AgdPg2VlrRee) AgpSumVlrTot,
sum(AgdPg2VlrTotAbe) AgpSumVlrTot2
from AgdPag02
Group By AgdPg2EstCod, AgdPg1Dta );
​
GO


USE [Pronto]
GO

/****** Object:  View [dbo].[VlrPag02]    Script Date: 17/03/2023 14:11:05 ******/
DROP VIEW [dbo].[VlrPag02]
GO

/****** Object:  View [dbo].[VlrPag02]    Script Date: 17/03/2023 14:11:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[VlrPag02] as 
	select 
	movtrnid VlpMovTrnId ,
	MovTrnDta VlpMovTrnDta , 
	movtrnvlr VlpMovTrnVlr , 
	MovTrnNsu VlpMovTrnNsu , 
	MovTrnBan VlpMovTrnBan , 
	MovTrnNumCar VlpMovTrnNumCar , 
	MovTrnParIndBemFac VlpMovTrnParIndBemFac , 
	MovTrnParQtd VlpMovTrnParQtd , 
	MovTrnTipPrd VlpMovTrnTipPrd , 
	MovTrnCod VlpMovTrnCod , 
	MovTrnAutCod VlpMovTrnAutCod , 
	MovTrnAutCodStr VlpMovTrnAutCodStr ,
	MovTrnIdeTer    VlpMovTrnIdeTer ,
	MovTrnPosNum    VlpMovTrnPosNum ,
	MovTrnPosApeId  VlpMovTrnPosApeId ,
	AdqCod          VlpMovTrnAdqCod,
	MovTrnTxCobrancaId VlpMovTaxaCobrancaId
	from movtrn01 
	union all
	select
	VlpMovTrnId           =0,
	VlpMovTrnDta          ='01jan1753', 
	VlpMovTrnVlr          =0, 
	VlpMovTrnNsu          =0, 
	VlpMovTrnBan          ='',  
	VlpMovTrnNumCar       ='', 
	VlpMovTrnParIndBemFac ='', 
	VlpMovTrnParQtd       =0, 
	VlpMovTrnTipPrd       ='', 
	VlpMovTrnCod          ='', 
	VlpMovTrnAutCod       =0, 
	VlpMovTrnAutCodStr    ='',
	VlpMovTrnIdeTer       ='',
	VlpMovTrnPosNum       = 0 ,
	VlpMovTrnPosApeId     = 0 ,
	VlpMovTrnAdqCod       = 0 ,
	VlpMovTaxaCobrancaId  = ''

GO




