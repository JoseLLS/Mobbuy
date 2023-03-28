--Deletar parâmetro que não será mais utilizado
DELETE FROM PARSIS
WHERE ParCod = 'APIGATEWAY_LOGIN'

--Adicionar parâmetro de usuário da API de Gateway
INSERT INTO PARSIS
VALUES ('APIGATEWAY_USER', 'Usuário da API de Gateway', 'VA', 40, NULL, 'N', 'bruno.crocco', 'ADMIN', '2022-01-05 12:04:05.000', NULL, NULL, 0)

--Adicionar parâmetro de senha da API de Gateway
INSERT INTO PARSIS
VALUES ('APIGATEWAY_PASSWORD', 'Senha da API de Gateway', 'VA', 40, NULL, 'N', 'Bemfacil@321', 'ADMIN', '2022-01-05 12:04:05.000', NULL, NULL, 0)