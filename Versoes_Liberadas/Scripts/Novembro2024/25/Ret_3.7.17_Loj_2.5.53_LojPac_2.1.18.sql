/* Versionamento de scripts */

INSERT INTO SQLHistorico
VALUES ('3.7.17','2.5.53',GETDATE());

/* TAREFA #24556 - CARLOS */

USE EstBank

INSERT INTO PARSIS VALUES 
('API_ENTREPAY_AUT_PWK', 'API_ENTREPAY_AUT_PWK', 'CA', 100, '', 'N', 'QTyKfg7rMMDdoP8KDTCgLo8i0uehbKdDRiH9cPxSSUXAH4SYvwSOpwyqgsI1vN2J', '028ADM', '2024-11-25','','',0),
('API_ENTREPAY_AUT_USR', 'API_ENTREPAY_AUT_USR', 'CA', 100, '', 'N', 'J7GJ7zZJcW2lAVMFGZuR00EPqvqvP35M1LJ02SI0aWbdQXXe', '028ADM', '2024-11-25','','',0),
('API_ENTREPAY_BASEURL', 'API_ENTREPAY_BASEURL', 'CA', 100, '', 'N', '/services-portal/v1/edi/', '028ADM', '2024-11-25','','',0),
('API_ENTREPAY_HOST', 'API_ENTREPAY_HOST', 'CA', 100, '', 'N', 'api.entrepay.com.br', '028ADM', '2024-11-25','','',0)

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