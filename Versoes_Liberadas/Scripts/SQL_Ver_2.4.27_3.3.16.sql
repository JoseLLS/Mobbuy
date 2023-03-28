/* TAREFA #19196 - LEONARDO */

/*RODAR APENAS PARA BANESE*/

--Rodar primeiro
USE BANESE
GO

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('PreviaPagamento', 'Prévia de pagamento', 'Prévia de pagamento', '', '', 0, 1, '')

--Rodar segundo
INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'PreviaPagamento', '', 150, 'CTR_FIN', '', '/banese/servlet/') --Alterar "/cliente/servlet/"

--Rodar terceiro
INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (12, 'PreviaPagamento') --Dar o SELECT de baixo na sse2_ung e pegar o UNG2Cod e alterar conforme o valor de cada cliente

--Rodar quarto
INSERT INTO sse2_grp_mod
VALUES (12, 'ADM', 'PreviaPagamento') --Dar o SELECT de cima na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente