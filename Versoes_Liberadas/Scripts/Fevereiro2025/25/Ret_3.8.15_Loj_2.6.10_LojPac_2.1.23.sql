/* Versionamento de scripts */

INSERT INTO SQLHistorico
VALUES ('3.8.15','2.6.10',GETDATE());

/* TAREFA #26096 - CARLOS */

INSERT INTO PARSIS VALUES

('APIGATEWAYRECORRENCIA_BASEURL','base url api gateway recorrencia','CA',100,'','N','/Recorrencia/','024ADM','2025-02-18 09:23:43.000','','',0),
('APIGATEWAYRECORRENCIA_HOST','host api gateway recorrencia','CA',100,'','N','apigateway-qa.mobbuyapp.com','024ADM','2025-02-18 09:22:58.000','','',0),
('APIGATEWAY_TOKEN_PASSWORD','password gerar token link pagamento recorrencia','CA',100,'','N','1q2w3e4r','024ADM','2025-02-18 09:19:53.000','','',0),
('APIGATEWAY_TOKEN_USER','usuario gerar token link pagamento','CA',100,'','N','credapi','024ADM','2025-02-18 09:19:08.000','','',0),
('APIGATEWAY_TOKEN_BASEURL','base url gerar token link pagamento','CA',100,'','N','/Account/','024ADM','2025-02-18 09:18:05.000','','',0),
('APIGATEWAY_TOKEN_HOST','host gerar token link pagamento recorrencia','CA',100,'','N','apigateway-qa.mobbuyapp.com','024ADM','2025-02-18 09:16:47.000','','',0),
('LINKPGTORECAPI_URL','url link pagamentos','CA',100,'','N','GerarPlanoViaLink','024ADM','2025-02-18 09:15:51.000','','',0),
('LINKPGTORECAPI_BASEURL','base url link pagamento recorr�ncia','CA',100,'','N','/Recorrencia/','024ADM','2025-02-18 09:14:51.000','','',0),
('LINKPGTORECAPI_HOST','host link pagamentos recorrencia','CA',100,'','N','apigateway-qa.mobbuyapp.com','024ADM','2025-02-18 09:10:02.000','','',0)

/* TAREFA #25513 - JOS� */

--SCRIPT J� EXECUTADO EM PRODU��O EM TODOS OS BANCOS COM SEUS RESPECTIVOS �CONES, N�O PRECISA EXECUTAR

INSERT INTO PARSIS
VALUES('LOGO_INTERNA','Caminho da logo interna do sistema Lojista','VA',200,NULL,'N','Resources/LogoIconeCREDPAG.png','ADMIN',GETDATE(),NULL,NULL,0);
