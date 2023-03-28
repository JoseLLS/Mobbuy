--Rodar script em todos os bancos de clientes

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('wpConcRecebDataVen', 'wpConcRecebDataVen', 'Conciliação recebimentos por data da venda', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'wpConcRecebDataVen', '', 35, 'REEMB_SUB_ADQ', '', '/pronto/servlet/') --Alterar "/cliente/servlet/"

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'wpConcRecebDataVen') --Dar o SELECT de baixo na sse2_ung e pegar o UNG2Cod e alterar conforme o valor de cada cliente

SELECT * FROM sse2_ung

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'wpConcRecebDataVen') --Dar o SELECT de cima na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente

-------------------------------------------------------------------------------------------------------------------------------------

CREATE NONCLUSTERED INDEX [UMOVTRN0110] ON [MovTrn01] (
      [MovTrnDta],
      [AdqCod],
      [MovTrnBan])