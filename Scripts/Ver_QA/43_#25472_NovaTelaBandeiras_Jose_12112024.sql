/* TAREFA #25472 - JOS� */

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('TBLBAN_GRID', 'TBLBAN_GRID', 'Bandeiras', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'TBLBAN_GRID', 'Bandeiras', 232, 'TAB_GER', '', '/pronto/servlet/');

INSERT INTO sse2_ung_mod (ung2Cod, mod2Id)
VALUES (25, 'TBLBAN_GRID');

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'TBLBAN_GRID');