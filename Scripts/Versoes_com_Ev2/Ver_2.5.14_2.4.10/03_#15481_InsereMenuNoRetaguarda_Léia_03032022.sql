

USE PRONTO


--Rodar primeiro
INSERT INTO  sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wwAviso', 'wwAviso', 'Avisos', '', '', 0, 1, '')


select * from   sse2_mod where MOD2Id = 'wwAviso'


--Rodar segundo

Select * from sse2_mnu02 where  MnuIteIde = 'wwAviso'

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wwAviso', 'Avisos', 103, 'TAB_GER', '', '/pronto/servlet/') --Alterar "/cliente/servlet/"


--Rodar terceiro
select * from sse2_ung_mod where mod2id = 'wwAviso'

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'wwAviso') -- Dar o SELECT de baixo na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente

SELECT * FROM sse2_ung

--Rodar quarto
select * from sse2_grp_mod where MOD2Id = 'wwAviso'

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'wwAviso') --Dar o SELECT de cima na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente



