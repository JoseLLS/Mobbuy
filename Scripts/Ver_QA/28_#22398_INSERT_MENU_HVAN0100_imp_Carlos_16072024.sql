USE CREDPAG

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('HVAN0100_imp', 'HVAN0100_imp', 'Importação de Rede de Captura', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'HVAN0100_imp', 'Importação de Rede de Captura', 11, 'REDE_CAP', '', '/credpag/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (24, 'HVAN0100_imp')

INSERT INTO sse2_grp_mod
VALUES (24, 'FINANCEIRO', 'HVAN0100_imp')
/*********************************************************************************************************************/
