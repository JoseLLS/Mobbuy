use pronto

CREATE FUNCTION GetEst(@InEstCod INT)         
    RETURNS  Varchar(100) 
    BEGIN 
      DECLARE @nome Varchar(100); 
      set @nome = (SELECT EstRazSoc FROM Est WHERE Estcod = @InEstCod); 
    RETURN @nome; 
END 

create view VwPOSHist as
select 
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
		VwPhHipEstRazSoc	= Est.EstRazSoc,
		VwPhHipEstSegmento 	= Est.EstSegmento, 
		VwPhHipDtaEnv		= HISPOS.HipDtaEnv,
		VwPhHipDtaRcb		= HISPOS.HipDtaRcb,  
		VwPhHipDtaDev		= HISPOS.HipDtaDev,  
		VwPhHipCodMotDev	= HISPOS.HipCodMotDev,
		VwPhHipDscMotDev	= HISPOS.HipDscMotDev
from POS
left join HISPOS 
on HISPOS.HipNumPos = POS.PosNum 
left join ETQ 
on ETQ.EtqCodItm = POS.EtqCodItm
left join EST
on EST.EstCod = HISPOS.HipCodEst
