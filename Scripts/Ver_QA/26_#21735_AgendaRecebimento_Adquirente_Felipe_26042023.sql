ALTER view [dbo].[AgdRec01] as
select
AgdRc1Dta = v.VlrDtaPrvLiqAnt,
AgdRc1VlrDeb = sum( case when isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('D','S') and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ) ,
AgdRc1VlrCre = sum( case when isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('C','S') and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ),
AgdRc1VlrPrc = sum( case when isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('C','S') and isnull(MovTrnParQtd,'') >  1 then VlrVlrRec Else 0 end ),
AgdRc1VlrAju = sum( case when isnull(MovTrnCod,'') = 'AJ'then VlrVlrRec Else 0 end ),
AgdRc1VlrCan = sum( case when isnull(MovTrnCod,'') = 'CC'then VlrVlrRec Else 0 end ),
AgdRc1VlrOut = sum( case when isnull(MovTrnCod,'') = ''  then VlrVlrRec Else 0 end ),
AgdRc1VlrPix = sum( case when MovTrnTipPrd = 'P'  then VlrVlrRec Else 0 end )
from vlrrec v left join movtrn01 m on (m.movtrnid =  v.VlrMovTrnId ) where v.VlrStsRec not in (4,5)
group by v.VlrDtaPrvLiqAnt;


ALTER VIEW [dbo].[AgdRec02] as 
	select 
		AgdRc1Dta = v.VlrDtaPrvLiqAnt ,
		EstCod    = v.EstCod,
		AgdRc2VlrDeb = sum( case when isnull(MovTrnCod,'')IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('D','S') and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ) ,
		AgdRc2VlrCre = sum( case when isnull(MovTrnCod,'')IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('C','S') and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ),
		AgdRc2VlrPrc = sum( case when isnull(MovTrnCod,'')IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('C','S') and isnull(MovTrnParQtd,'') >  1 then VlrVlrRec Else 0 end ),
		AgdRc2VlrAju = sum( case when isnull(MovTrnCod,'')='AJ'then VlrVlrRec Else 0 end ),
		AgdRc2VlrCan = sum( case when isnull(MovTrnCod,'')='CC'then VlrVlrRec Else 0 end ),
		AgdRc2VlrOut = sum( case when isnull(MovTrnCod,'')=''  then VlrVlrRec Else 0 end ),
		AgdRc2VlrPix = sum( case when m.MovTrnTipPrd ='P'  then VlrVlrRec Else 0 end)
from vlrrec v left join movtrn01 m on (m.movtrnid =  v.VlrMovTrnId ) where v.VlrStsRec not in (4,5) 
	group by v.VlrDtaPrvLiqAnt , v.estcod;
		
alter view [dbo].[AgdRec03] as 
	select 
		AgdRc1Dta 		= v.VlrDtaPrvLiqAnt ,
		AdqCod	  		= m.AdqCod,
		AgdRc3VlrDeb 	= sum( case when isnull(MovTrnCod,'')IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('D','S') and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ),
		AgdRc3VlrCre 	= sum( case when isnull(MovTrnCod,'')IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('C','S') and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ),
		AgdRc3VlrPrc 	= sum( case when isnull(MovTrnCod,'')IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('C','S') and isnull(MovTrnParQtd,'') >  1 then VlrVlrRec Else 0 end ),
		AgdRc3VlrAju 	= sum( case when isnull(MovTrnCod,'')='AJ'then VlrVlrRec Else 0 end ),
		AgdRc3VlrCan 	= sum( case when isnull(MovTrnCod,'')='CC'then VlrVlrRec Else 0 end ),
		AgdRc3VlrOut 	= sum( case when isnull(MovTrnCod,'')=''  then VlrVlrRec Else 0 end ),
		AgdRc3VlrPix 	= sum( case when m.MovTrnTipPrd ='P'  then VlrVlrRec Else 0 end)
from vlrrec v inner join movtrn01 m on (m.movtrnid =  v.VlrMovTrnId ) 
inner join ADQ0001 a
on (a.AdqCod = m.AdqCod)
where v.VlrStsRec not in (4,5) 
group by v.VlrDtaPrvLiqAnt , m.AdqCod;