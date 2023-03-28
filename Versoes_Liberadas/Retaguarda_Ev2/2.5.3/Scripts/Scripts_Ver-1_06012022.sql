--01_#14561_ADD-COLUMN_UEstCodGru_TABELA_USUEST _Wesley_04012022
ALTER TABLE USUEST ADD  [UEstCodGru] INT NULL

--03_#14705_ParametrosAPIGateway _Jose_05012022
--Deletar parâmetro que não será mais utilizado
DELETE FROM PARSIS
WHERE ParCod = 'APIGATEWAY_LOGIN'

--Adicionar parâmetro de usuário da API de Gateway
INSERT INTO PARSIS
VALUES ('APIGATEWAY_USER', 'Usuário da API de Gateway', 'VA', 40, NULL, 'N', 'bruno.crocco', 'ADMIN', '2022-01-05 12:04:05.000', NULL, NULL, 0)

--Adicionar parâmetro de senha da API de Gateway
INSERT INTO PARSIS
VALUES ('APIGATEWAY_PASSWORD', 'Senha da API de Gateway', 'VA', 40, NULL, 'N', 'Bemfacil@321', 'ADMIN', '2022-01-05 12:04:05.000', NULL, NULL, 0)

--Alteração de versão do banco
UPDATE PARSIS
SET ParCon = '1'
WHERE ParCod = 'VERSAO_BANCO'

UPDATE PARSIS
SET ParCon = '06/01/2022'
WHERE ParCod = 'VERSAO_BANCO_DATA'