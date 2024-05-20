--drop view tabven06_Aux01

CREATE View [dbo].[TabVen06_Aux01] as 
select 
   TavNum,
   TavVigDtaIni,
   TavAdqCod,
   TavBanCod,
   TavDetSeq
from TABVEN05
where TavDetSeq <= 25
group by TavNum,
   TavVigDtaIni,
   TavAdqCod,
   TavBanCod,
   TavDetSeq
GO
