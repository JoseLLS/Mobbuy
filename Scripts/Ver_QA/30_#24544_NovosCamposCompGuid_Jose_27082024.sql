/* TAREFA #24544 - JOS� */

INSERT INTO TIPDSP
VALUES (8, 'Ajuste Manual � Cr�dito','S','SISTEMA',GETDATE(),'','1753-01-01 00:00:00.000');

ALTER TABLE [VLRPAG]
ADD [VlpCompGuidPai] VARCHAR(100)    NULL,
    [VlpCompGuid] VARCHAR(100)    NULL;

ALTER TABLE [EST]
ADD [EstTxAntCompDeb] SMALLMONEY    NULL;