--Rodar primeiro
USE PRONTO
GO

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('RtConsolidado_GRID', 'Consolidado', 'Consolidado', '', '', 0, 1, '')

--Rodar segundo
INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'RtConsolidado_GRID', '', 150, 'CTR_FIN', '', '/credinov/servlet/') --Alterar "/cliente/servlet/"

--Rodar terceiro
INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'RtConsolidado_GRID') --Dar o SELECT de baixo na sse2_ung e pegar o UNG2Cod e alterar conforme o valor de cada cliente


--Rodar quarto
INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'RtConsolidado_GRID') --Dar o SELECT de cima na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente