/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.27','2.5.31',GETDATE());

/* SEM TAREFA - LEONARDO */

use pronto
go

insert into PARSIS (ParCod, ParCon) values ('Link_Relatorio_Manager2', 'https://apicomolatti-prd.mobbuyapp.com/Consultas/Operacoesgateway')
insert into PARSIS (ParCod, ParCon) values ('MANAGERAPI_HOST2', 'https://apicomolatti-prd.mobbuyapp.com')