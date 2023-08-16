--Rodar primeiro
USE Pronto
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('WWCONFIGURACAO', 'WWCONFIGURACAO', 'Configuração do Sistema', '', '', 0, 1, '')

SELECT * FROM sse2_mnu02 ORDER BY MnuIteIdRoot, MnuIteOrd --SELECT para ver a ordenação (MnuIteOrd) que a tela vai ficar no menu no INSERT abaixo
--A ordenação é em ordem crescente

--Rodar segundo
INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'WWCONFIGURACAO', '', 22, 'REDE_CAP', '', '/pronto/servlet/') --Alterar "/cliente/servlet/"

--Rodar terceiro
INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'WWCONFIGURACAO') --Dar o SELECT de baixo na sse2_ung e pegar o UNG2Cod e alterar conforme o valor de cada cliente

SELECT * FROM sse2_ung

--Rodar quarto
INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'WWCONFIGURACAO') --Dar o SELECT de cima na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente