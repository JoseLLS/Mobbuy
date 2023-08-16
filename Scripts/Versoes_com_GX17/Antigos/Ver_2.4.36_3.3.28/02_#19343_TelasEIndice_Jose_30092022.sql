/* TAREFA #19343 - JOSÉ */

--Bancos que usarão o script
USE Pronto

INSERT INTO Parsis
VALUES('REPROCLIQUIDACESSAO', 'URL da API de liquidar cessão no reprocessamento', 'VA', 255, NULL, 'N', 
'https://acesso.semprepronto.com.br/prontoev15/rest/LiquidaCessaoWS', '025ADM', '2022-09-22 09:22:00.000', '025ADM', NULL, 0)

-------------------------------------------------------------------------------------------------------------------------------

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('WPREPROCLIQCESSAO', 'WPREPROCLIQCESSAO', 'Reprocessamento liquidação cessão', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'WPREPROCLIQCESSAO', '', 141, 'CTR_FIN', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'WPREPROCLIQCESSAO')

SELECT * FROM sse2_ung

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'WPREPROCLIQCESSAO')

-------------------------------------------------------------------------------------------------------------------------------

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('WPREPROCLAN', 'WPREPROCLAN', 'Reprocessar lançamentos', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'WPREPROCLAN', '', 142, 'CTR_FIN', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'WPREPROCLAN')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'WPREPROCLAN')

-------------------------------------------------------------------------------------------------------------------------------

CREATE NONCLUSTERED INDEX [UMOVTRN015] ON [MovTrn01] (
      [EstCod],
      [MovTrnDta],
      [MovTrnNsu],
      [MovTrnAutCod])