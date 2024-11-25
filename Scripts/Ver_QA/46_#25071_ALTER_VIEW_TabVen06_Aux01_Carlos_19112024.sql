USE --TODOS
GO

/****** Object:  View [dbo].[TabVen06_Aux01]    Script Date: 19/11/2024 08:53:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Alter View [dbo].[TabVen06_Aux01] as 
select 
   TavNum,
   TavVigDtaIni,
   TavAdqCod,
   TavBanCod,
   TavDetSeq
from TABVEN05
where TavDetSeq <= 30
group by TavNum,
   TavVigDtaIni,
   TavAdqCod,
   TavBanCod,
   TavDetSeq
GO


