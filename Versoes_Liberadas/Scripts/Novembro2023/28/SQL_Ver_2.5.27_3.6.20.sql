/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.20','2.5.27',GETDATE());

/* TAREFA #23426 - LEONARDO */

use smartpagamentos
go

update PARSIS set ParCon = 'N' where ParCod = 'BANCO_V2'