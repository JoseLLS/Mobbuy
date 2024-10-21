/* TAREFA #25097 - RUAN */

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('trTipoDocumentosGrid', 'trTipoDocumentosGrid', 'Lista de tipos de documentos', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'trTipoDocumentosGrid', 'Lista de tipos de documentos', 11, 'TAB_GER', '', '/pronto/servlet/')

SELECT * FROM sse2_mnu02 WHERE MnuIteIdRoot = 'TAB_GER' ORDER BY MnuIteOrd

INSERT INTO sse2_ung_mod (ung2Cod, mod2Id)
VALUES (25, 'trTipoDocumentosGrid')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'trTipoDocumentosGrid') -- Sempre será ADM para Lista de tipos de documentos
