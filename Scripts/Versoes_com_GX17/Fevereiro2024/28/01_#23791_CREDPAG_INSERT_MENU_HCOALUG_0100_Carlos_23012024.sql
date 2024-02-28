USE CREDPAG

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('HCOALUG_0100','HCOALUG_0100', 'Upload - Cobrança de Aluguel', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'HCOALUG_0100', 'Upload - Cobrança de Aluguel', 90, 'SUPRIMENTOS', '', '/credpag/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (24, 'HCOALUG_0100')

INSERT INTO sse2_grp_mod
VALUES (24, 'FINANCEIRO', 'HCOALUG_0100')
