/* TAREFA #24221 - JOS� */

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('SaldoNegativo', 'SaldoNegativo', 'Saldos negativos', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'SaldoNegativo', '', 281, 'CTR_FIN', '', '/pronto/servlet/');

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'SaldoNegativo');

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'SaldoNegativo');