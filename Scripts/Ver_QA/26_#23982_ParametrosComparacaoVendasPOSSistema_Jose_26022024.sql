/* TAREFA #23982 -  JOS� */

INSERT INTO PARSIS
VALUES ('MANAGER_TRN_CAPTURA','Url da API de transa��es da captura','VA',100,NULL,'N','/InterfaceManagerMobbuy/interface/api/transacoes/captura','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO PARSIS
VALUES ('MANAGER_URL','Url do manager','VA',100,NULL,'N','www.mobbuyapp.com:10443','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO PARSIS
VALUES ('COMPARA_POS_EMAIL','E-mails para envio de alerta de bloqueio de transa��es (separados por ";").','VA',200,NULL,'N',
'compliance@semprepronto.com.br;financeiro@semprepronto.com.br','ADMIN',GETDATE(),NULL,NULL,0);

INSERT INTO PARSIS
VALUES ('COMPARA_POS_EMAIL_MSG','Corpo do e-mail para envio de alerta de bloqueio de transa��es.','VA',200,NULL,'N',
'<p>Realizamos o bloqueio das transa��es do EC [EC] e POS [POS] devido a diverg�ncia de informa��es com o sistema Retaguarda.<br>Favor verificar.</p>','ADMIN',GETDATE(),NULL,NULL,0);