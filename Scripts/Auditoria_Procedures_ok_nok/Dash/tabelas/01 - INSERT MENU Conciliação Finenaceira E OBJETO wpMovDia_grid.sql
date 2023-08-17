--use pronto

INSERT INTO sse2_mnu02 VALUES (10, 0, 'CONCILIA_FIN','Conciliação Financeira',130,'','','')

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpMovDia_Grid', 'wpMovDia_Grid', 'Movimento Diária', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpMovDia_Grid', 'Movimento Diária', 131, 'CONCILIA_FIN', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'wpMovDia_Grid')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'wpMovDia_Grid')
