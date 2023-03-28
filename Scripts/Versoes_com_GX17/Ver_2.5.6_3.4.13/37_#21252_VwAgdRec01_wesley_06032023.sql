USE [Pronto]
GO

/****** Object:  View [dbo].[AgdRec01]    Script Date: 06/03/2023 11:17:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[AgdRec01] as
select
AgdRc1Dta = v.VlrDtaPrvLiqAnt ,
AgdRc1VlrDeb = sum( case when isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='D' and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ) ,
AgdRc1VlrCre = sum( case when isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ),
AgdRc1VlrPrc = sum( case when isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') >  1 then VlrVlrRec Else 0 end ),
AgdRc1VlrAju = sum( case when isnull(MovTrnCod,'') = 'AJ'then VlrVlrRec Else 0 end ),
AgdRc1VlrCan = sum( case when isnull(MovTrnCod,'') = 'CC'then VlrVlrRec Else 0 end ),
AgdRc1VlrOut = sum( case when isnull(MovTrnCod,'') = ''  then VlrVlrRec Else 0 end ),
AgdRc1VlrPix = sum( case when MovTrnTipPrd = 'P'  then VlrVlrRec Else 0 end )
from vlrrec v left join movtrn01 m on (m.movtrnid =  v.VlrMovTrnId ) where v.VlrStsRec not in (4,5)
group by v.VlrDtaPrvLiqAnt
GO


