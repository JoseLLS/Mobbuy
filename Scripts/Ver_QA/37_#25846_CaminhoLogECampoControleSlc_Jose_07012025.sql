/* TAREFA #25846 - JOSÉ */

ALTER TABLE [ARQBAN]
ADD [ArbSlcExportadoRtm] BIT    NULL;

INSERT INTO PARSIS
VALUES ('LOG_CAMINHO','Caminho no servidor onde ficam os logs','VA',300,NULL,'N','/mnt/home1/sistema/logs/','ADMIN',GETDATE(),NULL,NULL,0);