/* Versionamento de scripts */

INSERT INTO SQLHistorico
VALUES ('3.8.17','2.6.11',GETDATE());

/* TAREFA #26188 - JOS� */

USE Credpag;

INSERT INTO RETBAN
VALUES(566,'00','Cr�dito Efetuado','P','ADMIN','','',GETDATE()), 
(566,'01','Cr�dito N�o Efetuado','E','ADMIN','','',GETDATE());