
/****** Object:  View [dbo].[vwEstabSemMov]    Script Date: 05/01/2024  ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW vwEstabSemMov AS 
	SELECT NEWID() AS  'vwEstabSemMovID',
	B.EstCod AS 'vwEstabSemMovEstCod',
	A.MovTrnDta AS 'vwEstabSemMovDta'
	FROM movtrn01 A LEFT JOIN EST B
	ON A.EstCod = B.EstCod
	WHERE B.EstSit = 'A'
	GROUP BY B.EstCod, A.MovTrnDta

Go


