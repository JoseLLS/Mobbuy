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