alter VIEW VwPOSHist as
SELECT 
		VwPOSHistId			= NewID(),
		VwPhPosNum 			= POS.PosNum, 
		VwPhPosNumSer		= POS.PosNumSer,
		VwPhPosEstCod		= POS.PosEstCod, 
		dbo.GetEst(PosEstCod) as 'VwPhEstRazSoc',
		VwPhPosStsPos		= POS.PosStsPos, 
		VwPhPosEtqCodItm	= POS.EtqCodItm, 
		VwPhPOSEtqDsc		= ETQ.EtqDscItm, 
		VwPhPosRedOpe		= POS.PosRedOpe,
		VwPhPosDscDst		= POS.PosDscDst,
		VwPhHipNumSeq		= HISPOS.HipNumSeq,
		VwPhHipEstCod		= Est.EstCod,
		VwPhHipEstRazSoc	= Est.EstRazSoc,
		VwPhHipEstSegmento 	= Est.EstSegmento, 
		VwPhHipDtaEnv		= HISPOS.HipDtaEnv,
		VwPhHipDtaRcb		= HISPOS.HipDtaRcb,  
		VwPhHipDtaDev		= HISPOS.HipDtaDev,  
		VwPhHipCodMotDev	= HISPOS.HipCodMotDev,
		VwPhHipDscMotDev	= HISPOS.HipDscMotDev,
		VwPhHipMotDevId		= HISPOS.MotDevId,
		VwPhHipMotDevDesc	= MotDev.MotDevDesc,
		VwPhPosIseAlug		= POS.PosIseAlug,
		VwPhPosIseAlugDtaAlt = POS.PosIseAlugDtaAlt,
		VwPhHipAlugMotivoId = POS.AlugMotivoId,
		VwPhHipAlugMotivoDsc = Alu.AlugMotivoDsc,
		VwPhHipPosOrigem	= Pos.PosOrigem,
		VwPhHipPosMultiEC	= Pos.PosMultiEC,
		VwPhHipPosNumMultiECPai	= Pos.PosNumMultiECPai
FROM POS
LEFT JOIN HISPOS 
ON HISPOS.HipNumPos = POS.PosNum 
LEFT JOIN ETQ 
ON ETQ.EtqCodItm = POS.EtqCodItm
LEFT JOIN EST
ON EST.EstCod = HISPOS.HipCodEst
LEFT JOIN MotDev
on MotDev.MotDevId = HISPOS.MotDevId
LEFT JOIN AlugMotivo Alu
on Alu.AlugMotivoId = POS.AlugMotivoId 
