/* TAREFA #23982 -  JOSÉ */

INSERT INTO PARSIS
VALUES ('MANAGER_TRN_CAPTURA','Url da API de transações da captura','VA',100,NULL,'N','/InterfaceManagerMobbuy/interface/api/transacoes/captura','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO PARSIS
VALUES ('MANAGER_URL','Url do manager','VA',100,NULL,'N','www.mobbuyapp.com:10443','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO PARSIS
VALUES ('COMPARA_POS_EMAIL','E-mails para envio de alerta de bloqueio de transações (separados por ";").','VA',200,NULL,'N',
'compliance@semprepronto.com.br;financeiro@semprepronto.com.br','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO PARSIS
VALUES ('COMPARA_POS_EMAIL_MSG','Corpo do e-mail para envio de alerta de bloqueio de transações.','VA',200,NULL,'N',
'<p>Realizamos o bloqueio das transações do EC [EC] e POS [POS] devido a divergência de informações com o sistema Retaguarda.<br>Favor verificar.</p>','ADMIN',GETDATE(),NULL,NULL,0);