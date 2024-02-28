USE SMARTPAGAMENTOS

/**** PARTIDAS EM ABERTO ***/

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpPartidasAberto','wpPartidasAberto', 'Partidas em Aberto', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpPartidasAberto', 'Partidas em Aberto', 126, 'CTR_FIN', '', '/smartpagamentos/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (18, 'wpPartidasAberto')

INSERT INTO sse2_grp_mod
VALUES (18, 'ADM', 'wpPartidasAberto')

/**** AUDITORIA ***/

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('auditoriatransacao','auditoriatransacao', 'Auditoria', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'auditoriatransacao', 'Auditoria', 127, 'CTR_FIN', '', '/smartpagamentos/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (18, 'auditoriatransacao')

INSERT INTO sse2_grp_mod
VALUES (18, 'ADM', 'auditoriatransacao')

