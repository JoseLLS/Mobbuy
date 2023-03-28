


/* ALTERAÇÃO DA VERSÃO DO BANCO */

UPDATE PARSIS
   SET ParCon = '2.5.12_2.4.9'
 WHERE ParCod = 'VERSAO_BANCO'

UPDATE PARSIS
   SET ParCon = '24/02/2022'
 WHERE ParCod = 'VERSAO_BANCO_DATA'
 
 /* TAREFA #15481 - LÉIA */
 
 CREATE TABLE [AVISO] ( 
  [AvisoId]             INT NOT NULL IDENTITY ( 1 , 1 ),
  [AvisoTitulo]         VARCHAR(50)    NULL, 
  [AvisoSituacao]       CHAR(1)    NULL, 
  [AvisoDataHora]       DATETIME    NULL, 
  [AvisoInsUsuarioId]   VARCHAR(100)    NULL, 
  [AvisoInsUsuarioNome] VARCHAR(100)    NULL, 
  [AvisoPeriodoInicial] DATETIME    NULL, 
  [AvisoPeriodoFinal]   DATETIME    NULL, 
  [AvisoTexto]          VARCHAR(MAX)    NULL, 
  [AvisoImagem]         VARBINARY(MAX)    NULL, 
  [AvisoImagem_GXI]     VARCHAR(2048)    NULL, 
     PRIMARY KEY ( [AvisoId] ))
	 
	 
CREATE TABLE [AVISOUSUARIO] ( 
  [AvisoId]              INT    NOT NULL, 
  [AvisoUsuarioId]       VARCHAR(100)    NOT NULL, 
  [AvisoUsuarioNome]     VARCHAR(100)    NULL, 
  [AvisoUsuarioDataHora] DATETIME    NULL, 
  [AvisoUsuarioLida]     BIT   NULL, 
     PRIMARY KEY ( [AvisoId],[AvisoUsuarioId] ))
ALTER TABLE [AVISOUSUARIO] 
 ADD CONSTRAINT [IAVISOUSUARIO1] FOREIGN KEY ( [AvisoId] ) REFERENCES [AVISO]([AvisoId])


 /* TAREFA #14590 - CARLOS */
 
 --PRONTO
USE PRONTO
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('HLogAPI_GRID', 'HLogAPI_GRID', 'Consulta Log API', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'HLogAPI_GRID', 'Consulta Log API', 50, 'AUDITORIA', 'Controle Fraude', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'HLogAPI_GRID')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'HLogAPI_GRID')
/********************************************************************************************************************/
--BANESE
USE BANESE
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('HLogAPI_GRID', 'HLogAPI_GRID', 'Consulta Log API', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'HLogAPI_GRID', 'Consulta Log API', 50, 'AUDITORIA', 'Controle Fraude', '/banese/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (12, 'HLogAPI_GRID')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (12, 'ADM', 'HLogAPI_GRID')
/********************************************************************************************************************/
--BEM FACIL
USE BEMFACIL
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('HLogAPI_GRID', 'HLogAPI_GRID', 'Consulta Log API', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'HLogAPI_GRID', 'Consulta Log API', 50, 'AUDITORIA', 'Controle Fraude', '/bemfacil/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (6, 'HLogAPI_GRID')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (6, 'ADM', 'HLogAPI_GRID')
/********************************************************************************************************************/
--CREDINOV
USE CREDINOV
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('HLogAPI_GRID', 'HLogAPI_GRID', 'Consulta Log API', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'HLogAPI_GRID', 'Consulta Log API', 50, 'AUDITORIA', 'Controle Fraude', '/credinov/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (26, 'HLogAPI_GRID')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (26, 'ADM', 'HLogAPI_GRID')
/********************************************************************************************************************/
--CREDPAG
USE CREDPAG
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('HLogAPI_GRID', 'HLogAPI_GRID', 'Consulta Log API', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'HLogAPI_GRID', 'Consulta Log API', 50, 'AUDITORIA', 'Controle Fraude', '/credipag/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (24, 'HLogAPI_GRID')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (24, 'ADM', 'HLogAPI_GRID')
/********************************************************************************************************************/
--SMARTPAGAMENTOS
USE SMARTPAGAMENTOS
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('HLogAPI_GRID', 'HLogAPI_GRID', 'Consulta Log API', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'HLogAPI_GRID', 'Consulta Log API', 50, 'AUDITORIA', 'Controle Fraude', '/smartpagamentos/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (18, 'HLogAPI_GRID')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (18, 'ADM', 'HLogAPI_GRID')
/********************************************************************************************************************/



 /* TAREFA #15445 - WESLEY */

USE PRONTO

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('AgendaConsulta_Cerc', 'AgendaConsulta_Cerc', 'Agenda', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'AgendaConsulta_Cerc', '', 103, 'CERC                ', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'AgendaConsulta_Cerc')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'AgendaConsulta_Cerc')


 INSERT INTO [dbo].[PARSIS]
           ([ParCod]
           ,[ParDsc]
           ,[ParTipPar]
           ,[ParTamPar]
           ,[ParQtdDec]
           ,[ParIndSin]
           ,[ParCon]
           ,[ParUsuInc]
           ,[ParDtiInc]
           ,[ParUsuAlt]
           ,[ParDtiAlt]
           ,[ParFlgInt])
     VALUES
           ('URL_AGENDA_CONSULTAR' 
           ,'Url da CERC V5 agenda consultar.'
           ,'CA'
           ,100
           ,NULL
		   ,'N'
           ,'https://ap.cerc.inf.br/v15/agenda/consultar'
           ,NULL
           ,NULL
           ,'025ADM                           '
           ,'2021-10-05 10:00:36.000'
           ,0)
GO