USE [Pronto]
GO

/****** Object:  View [dbo].[tabven06_Aux01]    Script Date: 21/03/2022 16:34:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE View [dbo].[Est08_Aux01] as 

Select 
      Estcod,
      VlpDtaVct                         as 'VENCIMENTO', 
	  GETDATE()                         as 'HOJE', 
	  DATEDIFF(day,GETDATE(),VlpDtaVct) as 'DIFERENCA' 
from vlrpag where vlpStspag = 1

GO


