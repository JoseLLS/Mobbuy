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