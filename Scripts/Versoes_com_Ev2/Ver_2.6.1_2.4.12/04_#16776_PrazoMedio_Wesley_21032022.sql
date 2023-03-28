USE [Pronto]
GO

/****** Object:  View [dbo].[tabven06_Aux01]    Script Date: 21/03/2022 16:34:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE View [dbo].[Est08_Aux02] as 

SELECT 
      Estcod,
	  SUM(DIFERENCA)   AS 'SOMA',
	  COUNT(DIFERENCA) AS 'QUANTIDADE', 
	  SUM(DIFERENCA) / CAST(COUNT(DIFERENCA) AS numeric(18,2)) AS 'MEDIA'
	  FROM Est08_Aux01
	  GROUP BY EstCod
GO

