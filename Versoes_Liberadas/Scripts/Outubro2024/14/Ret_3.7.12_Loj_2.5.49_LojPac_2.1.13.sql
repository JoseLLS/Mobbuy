/* Versionamento de scripts */

INSERT INTO SQLHistorico
VALUES ('3.7.12','2.5.49',GETDATE());

/* TAREFA #25067 - CARLOS */

update sse2_mod  set 
MOD2Dsc  = 'Cadastro CNAE'
where MOD2Id = 'hcnae0106_grid'

update sse2_mnu02 set 
MnuIteOrd = 60,
MnuIteIdRoot = 'ADQ',
MnuIteDsc = 'Cadastro CNAE',
MnuItePth = ''
where MnuIteIde = 'hcnae0106_grid'

update sse2_mod  set 
MOD2Dsc  = 'Importar CNAE'
where MOD2Id = 'hcnae0107'

update sse2_mnu02 set 
MnuIteOrd = 45,
MnuIteIdRoot = 'ADQ',
MnuIteDsc = 'Importar CNAE',
MnuItePth = ''
where MnuIteIde = 'hcnae0107'

/* TAREFA #25167 - CARLOS */

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