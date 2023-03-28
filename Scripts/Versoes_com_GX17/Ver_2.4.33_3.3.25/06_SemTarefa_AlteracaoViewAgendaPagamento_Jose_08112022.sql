/* SEM TAREFA - JOSÉ */

--Rodar script em todos os clientes atualizados com a versão
ALTER view [dbo].[AgdPag01] as
select
AgdPg1Dta = v.VlpDtaVct ,
AgdPg1VlrDeb	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='D' and isnull(MovTrnParQtd,'') <= 1 then VlpVlrPag Else 0 end ) ,
AgdPg1VlrCre	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') <= 1 then VlpVlrPag Else 0 end ),
AgdPg1VlrPrc	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') >  1 then VlpVlrPag Else 0 end ),
AgdPg1VlrAju	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'')='AJ' then VlpVlrPag Else 0 end ),
AgdPg1VlrCan	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'')='CC' then VlpVlrPag Else 0 end ),
AgdPg1VlrOut	= sum( case when v.TidCod>1 or  isnull(MovTrnCod,'')='AL'   then VlpVlrPag Else 0 end ),
AgdPg1VlrRee	= sum( case when v.VlpStspag=2                           then VlpVlrPag Else 0 end ),
AgdPg1VlrTotAbe = sum( case when v.VlpStspag=1                            then VlpVlrPag Else 0 end ),
AgdPg1VlrCom	= sum( case when v.TidCod=1 and isnull(MovTrnTipPrd,'')='S' then VlpVlrPag Else 0 end )
from VlrPag v left join movtrn01 m on (m.movtrnid =  v.VlpMovTrnId ) where v.VlpStspag not in (3,4)
group by v.VlpDtaVct
GO