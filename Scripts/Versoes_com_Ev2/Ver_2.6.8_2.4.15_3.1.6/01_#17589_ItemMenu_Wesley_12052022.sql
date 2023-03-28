INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('ConPagEdi_Grid', 'ConPagEdi_Grid', 'Conciliação Pagamento EDI', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'ConPagEdi_Grid', '', 103, 'REEMB_SUB_ADQ', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'ConPagEdi_Grid')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'ConPagEdi_Grid')
