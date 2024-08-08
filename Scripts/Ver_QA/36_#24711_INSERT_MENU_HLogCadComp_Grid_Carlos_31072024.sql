use pronto

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('HLogCadComp_Grid','HLogCadComp_Grid', 'Compliance - Manut. Cadastro', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'HLogCadComp_Grid', 'Compliance - Manut. Cadastro', 80, 'AUDITORIA', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'HLogCadComp_Grid')

INSERT INTO sse2_grp_mod
VALUES (25, 'COMPLIANCE', 'HLogCadComp_Grid')

INSERT INTO sse2_grp_mod
VALUES (25, 'COMPLIANCE NOVO', 'HLogCadComp_Grid')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'HLogCadComp_Grid')
