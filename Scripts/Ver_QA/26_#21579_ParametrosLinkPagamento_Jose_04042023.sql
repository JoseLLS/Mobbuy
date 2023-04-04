/* TAREFA #21579 - JOSÉ */

USE Pronto

INSERT INTO PARSIS
VALUES ('LINK_ATIVACAO', 'Parametro para ativar a tela de link de ativção no site', 'CA', 1, NULL, 'N', 'S', 'ADMIN', '2023-03-31 00:00:00.000', NULL, NULL, 0);

INSERT INTO PARSIS
VALUES ('LINKPAGAMENTOAPI_HOST', 'Host da API de Link de Pagamento', 'VA', 100, NULL, 'N', 'apigateway-qa.mobbuyapp.com', 'ADMIN', '2023-03-31 00:00:00.000', NULL, NULL, 0);

INSERT INTO PARSIS
VALUES ('LINKPAGAMENTOAPI_URL1', 'Url 1 da API de Link de Pagamento', 'VA', 40, NULL, 'N', 'Cobranca', 'ADMIN', '2023-03-31 00:00:00.000', NULL, NULL, 0);

INSERT INTO PARSIS
VALUES ('LINKPAGAMENTOAPI_URL2', 'Url 2 da API de Link de Pagamento', 'VA', 40, NULL, 'N', 'Autorizar', 'ADMIN', '2023-03-31 00:00:00.000', NULL, NULL, 0);

INSERT INTO PARSIS
VALUES ('MANAGERAPI_HOST', 'Host da API do Manager', 'VA', 100, NULL, 'N', 'https://apigateway-qa.mobbuyapp.com', 'ADMIN', '2023-03-31 00:00:00.000', NULL, NULL, 0);

UPDATE PARSIS
SET ParCon = 'super'
WHERE ParCod = 'APIGATEWAY_USER';

UPDATE PARSIS
SET ParCon = 'MobbuyAdm@2019'
WHERE ParCod = 'APIGATEWAY_PASSWORD';