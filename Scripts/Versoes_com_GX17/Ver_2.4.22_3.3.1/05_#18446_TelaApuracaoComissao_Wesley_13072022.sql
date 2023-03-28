INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('ApuracaoCom_Grid', 'ApuracaoCom_Grid', 'Apuração Comissão', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'ApuracaoCom_Grid', '', 103, 'CRED_ESTAB', '', '/pronto/servlet/')

-- 26 é CREDIPAG, VERIFICAR O UNG2COD DE CADA CLIENTE ANTES DE RODAR
INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (26, 'ApuracaoCom_Grid')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (26, 'ADM', 'ApuracaoCom_Grid')