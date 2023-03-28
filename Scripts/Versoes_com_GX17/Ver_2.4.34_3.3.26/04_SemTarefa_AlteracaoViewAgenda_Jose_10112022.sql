/* SEM TAREFA - JOSÉ */

ALTER view [dbo].[AgdPag02] as 
    select 
        AgdPg1Dta    = v.VlpDtaVct ,
        AgdPg2EstCod = v.EstCod ,
        AgdPg2EstNomFanRed = ( select EstNomFan from EST where EstCod = v.EstCod),
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

-------------------------------------------------------------------------------------------------------------------------------------------

ALTER View [dbo].[VwAgdPag] as (
Select NewID() AgdSumID,
AgdPg1Dta AdgSumDta,
AgdPg2EstCod EstCod,
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