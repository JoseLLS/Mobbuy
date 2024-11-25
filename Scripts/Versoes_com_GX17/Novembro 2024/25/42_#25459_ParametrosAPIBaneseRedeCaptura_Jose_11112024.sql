/* TAREFA #25459 - JOSÉ */

INSERT INTO PARSIS
VALUES ('BANESE_REDECAP','Link da API de Rede Captura da Banese','VA',300,NULL,'N','https://api-priv.mulvi.com.br/pppay/contabil/v1/Transacao/SubAdiquirencia/Aprovadas','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO PARSIS
VALUES ('BANESE_TOKEN','Link da API que gera o token da Banese','VA',300,NULL,'N','https://api-priv.mulvi.com.br/pppay/contabil/v1/Token/GerarTokenAsync','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO PARSIS
VALUES ('BANESE_TOKEN_USR','Usuário da API que gera o token da Banese','VA',300,NULL,'N','0000052','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO PARSIS
VALUES ('BANESE_TOKEN_SEN','Senha da API que gera o token da Banese','VA',300,NULL,'N','8k5o5mxRMPgR','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO VAN01
VALUES(7, 'API Banese', '1753-01-01 00:00:00.000');

ALTER TABLE [VAN04]
ADD [VanTrnNumPedInt] VARCHAR(50)    NULL;

--Script de tela nova
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('GatewayConvenios','GatewayConvenios', 'Gateway Convênios', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'GatewayConvenios', 'Gateway Convênios', 301, 'CTR_FIN', '', '/banese/servlet/');

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (12, 'GatewayConvenios');

INSERT INTO sse2_grp_mod
VALUES (12, 'ADM', 'GatewayConvenios');