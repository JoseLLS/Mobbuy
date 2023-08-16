/* TAREFA #22234 - JOSÉ */

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('TransacoesGateway', 'TransacoesGateway', 'Transações Gateway', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'TransacoesGateway', '', 151, 'CTR_FIN', '', '/pronto/servlet/')

SELECT * FROM sse2_mnu02 ORDER BY 6,5

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'TransacoesGateway')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'TransacoesGateway')