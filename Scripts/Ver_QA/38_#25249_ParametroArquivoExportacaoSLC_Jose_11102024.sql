/* TAREFA #25249 - JOS� */

INSERT INTO PARSIS
VALUES ('ARQ_SLC_EXP','Caminho de exporta��o do arquivo SLC','VA',300,NULL,'N','/mnt/home/subadquir�ncia/025/reembolso/SLC/env/','ADMIN',GETDATE(),NULL,NULL,0);

ALTER TABLE [TblBan]
ADD [TblBanSlcCodArranjo] SMALLINT    NULL,
    [TblBanTipo] CHAR(2)    NULL;