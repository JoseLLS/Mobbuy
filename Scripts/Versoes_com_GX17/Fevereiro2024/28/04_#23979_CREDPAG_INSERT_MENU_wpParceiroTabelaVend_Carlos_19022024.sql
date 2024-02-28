USE CREDPAG

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpParceiroTabelaVend','wpParceiroTabelaVend', 'Taxa Venda Representante', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpParceiroTabelaVend', 'Taxa Venda Representante', 130, 'CRED_ESTAB', '', '/credpag/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (24, 'wpParceiroTabelaVend')

INSERT INTO sse2_grp_mod
VALUES (24, 'CADASTROS', 'wpParceiroTabelaVend')