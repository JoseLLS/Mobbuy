USE [Pronto]
GO

/****** Object:  View [dbo].[Est08_Aux10]    Script Date: 25/11/2022 10:51:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE View [dbo].[Est08_VlrPag_Aberto] as 

SELECT 
      EstCod, 
	  VlpVlrPag,
	  VlpDtaVct,
	  VlpTipPrd
FROM VLRPAG with(nolock) where VlpStsPag = 1

GO


