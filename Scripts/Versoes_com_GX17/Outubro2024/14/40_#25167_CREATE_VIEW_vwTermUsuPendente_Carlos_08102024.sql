
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW vwTermUsuPendente AS
SELECT
	NEWID() AS  'vwTermUsuPendID',
	A.EstCod as 'vwTermUsuPendEstCod',
	A.EstDtiInc as 'vwTermUsuPendDtaHr'
	FROM EST A LEFT JOIN TermoUsuario B on A.EstCod = B.TermoUsuarioEstCod
	WHERE B.TermoUsuarioEstCod is null

