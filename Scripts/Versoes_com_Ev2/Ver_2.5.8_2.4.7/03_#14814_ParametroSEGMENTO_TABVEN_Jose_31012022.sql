/* TAREFA #14814 - JOSÉ */

--Quais clientes precisam do script
USE Banese
USE Bemfacil
USE Credinov
USE Credpag
USE Pronto
USE SmartPagamentos

--Parâmetro para alterar o de/para do segmento com a tabela de vendas
INSERT INTO PARSIS
VALUES ('SEGMENTO_TABVEN', 'Parâmetro que associa tabela de vendas com segmento (Segmento;TavNum)', 'VA', 500, NULL, 'N', 
'Grupo Comolatti;2;Oficina;6;PitStop;7;Varejo;12', 'ADMIN', '2022-01-31 00:00:00:000', NULL, NULL, 0)