/* TAREFA #25249 - JOSÉ */

INSERT INTO PARSIS
VALUES ('ARQ_SLC_EXP','Caminho de exportação do arquivo SLC','VA',300,NULL,'N','/mnt/home/subadquirência/025/reembolso/SLC/env/','ADMIN',GETDATE(),NULL,NULL,0);

ALTER TABLE [TblBan]
ADD [TblBanSlcCodArranjo] SMALLINT    NULL,
    [TblBanTipo] CHAR(2)    NULL;