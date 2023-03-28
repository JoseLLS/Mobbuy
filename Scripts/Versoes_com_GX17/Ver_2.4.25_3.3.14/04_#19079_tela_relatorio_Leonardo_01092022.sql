/*Rodar para os clientes: Banese*/

/* TAREFA #19079 - LEONARDO */
USE banese
GO
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('DiferencaPagamento', 'Exporta Pagamentos', 'Exporta Pagamentos', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'DiferencaPagamento', '', 130, 'CTR_FIN', '', '/credinov/servlet/') --Alterar "/cliente/servlet/"

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (12, 'DiferencaPagamento') --Dar o SELECT de baixo na sse2_ung e pegar o UNG2Cod e alterar conforme o valor de cada cliente

SELECT * FROM sse2_ung

--Rodar quarto
INSERT INTO sse2_grp_mod
VALUES (12, 'ADM', 'DiferencaPagamento')