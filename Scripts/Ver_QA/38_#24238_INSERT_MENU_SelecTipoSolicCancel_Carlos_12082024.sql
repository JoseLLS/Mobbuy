use PRONTO

DELETE sse2_grp_mod WHERE MOD2Id = 'MotSolCancel'
DELETE sse2_ung_mod WHERE MOD2Id = 'MotSolCancel'
DELETE sse2_mnu02 WHERE MnuIteIde = 'MotSolCancel'
DELETE sse2_mod WHERE MOD2Id = 'MotSolCancel'

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('SelecTipoSolicCancel','SelecTipoSolicCancel', 'Tipos Sol.Cancelamento', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'SelecTipoSolicCancel', 'Tipos Sol.Cancelamento', 230, 'TAB_GER', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'SelecTipoSolicCancel')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'SelecTipoSolicCancel')