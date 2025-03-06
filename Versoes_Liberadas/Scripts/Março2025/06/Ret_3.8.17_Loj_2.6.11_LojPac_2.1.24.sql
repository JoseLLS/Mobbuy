/* Versionamento de scripts */

INSERT INTO SQLHistorico
VALUES ('3.8.17','2.6.11',GETDATE());

/* TAREFA #26188 - JOSÉ */

USE Credpag;

INSERT INTO RETBAN
VALUES(566,'00','Crédito Efetuado','P','ADMIN','','',GETDATE()), 
(566,'01','Crédito Não Efetuado','E','ADMIN','','',GETDATE());