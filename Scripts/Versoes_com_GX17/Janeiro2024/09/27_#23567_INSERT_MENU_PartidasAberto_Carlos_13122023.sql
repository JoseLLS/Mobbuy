USE BANESE

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpPartidasAberto','wpPartidasAberto', 'Partidas em Aberto', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpPartidasAberto', 'Partidas em Aberto', 300, 'CTR_FIN', '', '/banese/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (12, 'wpPartidasAberto')

INSERT INTO sse2_grp_mod
VALUES (12, 'FINANCEIRO', 'wpPartidasAberto')
/*********************************************************************************************************************/

USE SMARTPAGAMENTOS

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpPartidasAberto','wpPartidasAberto', 'Partidas em Aberto', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpPartidasAberto', 'Partidas em Aberto', 300, 'CTR_FIN', '', '/smartpagamentos/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (18, 'wpPartidasAberto')

INSERT INTO sse2_grp_mod
VALUES (18, 'FINANCEIRO', 'wpPartidasAberto')
/*********************************************************************************************************************/
USE CREDINOV

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpPartidasAberto','wpPartidasAberto', 'Partidas em Aberto', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpPartidasAberto', 'Partidas em Aberto', 300, 'CTR_FIN', '', '/credinov/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (26, 'wpPartidasAberto')

INSERT INTO sse2_grp_mod
VALUES (26, 'FINANCEIRO', 'wpPartidasAberto')
/*********************************************************************************************************************/
USE CREDPAG

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpPartidasAberto','wpPartidasAberto', 'Partidas em Aberto', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpPartidasAberto', 'Partidas em Aberto', 300, 'CTR_FIN', '', '/credpag/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (24, 'wpPartidasAberto')

INSERT INTO sse2_grp_mod
VALUES (24, 'FINANCEIRO', 'wpPartidasAberto')
/*********************************************************************************************************************/
