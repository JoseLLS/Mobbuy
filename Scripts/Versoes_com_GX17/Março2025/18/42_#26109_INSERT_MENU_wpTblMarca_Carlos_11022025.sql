****** SOMENTE PERMITE ******
USE permite

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpTblMarca','wpTblMarca', 'Tabela de Marcas', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpTblMarca', 'Tabela de Marcas', 240, 'TAB_GER', '', '/permite/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (30, 'wpTblMarca')

INSERT INTO sse2_grp_mod
VALUES (30, 'ADM', 'wpTblMarca')
