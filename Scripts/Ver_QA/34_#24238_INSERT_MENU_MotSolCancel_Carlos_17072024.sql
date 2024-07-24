use CredPag

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('MotSolCancel','MotSolCancel', 'Motivo - Sol.Cancelamento', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'MotSolCancel', 'Motivo - Sol.Cancelamento', 230, 'TAB_GER', '', '/credpag/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (24, 'MotSolCancel')

INSERT INTO sse2_grp_mod
VALUES (24, 'ADM', 'MotSolCancel')