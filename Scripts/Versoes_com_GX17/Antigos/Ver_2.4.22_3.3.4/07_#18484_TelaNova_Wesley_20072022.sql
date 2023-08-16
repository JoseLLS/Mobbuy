USE PRONTO

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('LogTaxas_Grid', 'LogTaxas_Grid', 'Log das taxas', '', '', 0, 1, '')
GO

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'LogTaxas_Grid', '', 103, 'AUDITORIA', '', '/pronto/servlet/')
GO

-- 25 é PRONTO, VERIFICAR O UNG2COD DE CADA CLIENTE ANTES DE RODAR
INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'LogTaxas_Grid')
GO

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (25, 'COMPLIANCE', 'LogTaxas_Grid')
GO

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (25, 'FINANCEIRO', 'LogTaxas_Grid')
GO
