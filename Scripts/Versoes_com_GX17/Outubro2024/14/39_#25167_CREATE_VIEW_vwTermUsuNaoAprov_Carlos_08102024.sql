
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW vwTermUsuNaoAprov AS
SELECT
	NEWID() AS  'vwTermUsuNaoAprovID',
	TermoTipo as 'vwTermUsuNaoAprovTermoTipo',
	TermoUsuarioCod as 'vwTermUsuNaoAprovUsuCod',
	TermoUsuarioAceito as 'vwTermUsuNaoAprovUsuAceito',
	TermoUsuarioAceitoDtaHr as 'vwTermUsuNaoAprovDtaHr',
	TermoUsuarioAceitoIp as 'vwTermUsuNaoAprovIp',
	TermoUsuarioEstCod as 'vwTermUsuNaoAprovEstCod'
	from TermoUsuario where TermoUsuarioAceito = 0
	and TermoUsuarioEstCod not in (select TermoUsuarioEstCod from TermoUsuario where TermoUsuarioAceito = 1)

GO


