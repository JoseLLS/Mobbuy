/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.43','2.5.40',GETDATE());

/* TAREFA #24395 - CARLOS */

CREATE TABLE [trTipoDocumento] (
  [TipoDocID]     INT    NOT NULL    IDENTITY ( 1 , 1 ),
  [TipoDocDsc]    CHAR(50)    NOT NULL,
  [TipoDocUsuIns] CHAR(20)    NULL,
  [TipoDocDtaIns] DATETIME    NULL,
  [TipoDocUsuAlt] CHAR(20)    NULL,
  [TipoDocDtaAlt] DATETIME    NULL,
  [TipoDocStatus] BIT    NOT NULL,
     PRIMARY KEY ( [TipoDocID] ));

INSERT INTO trTipoDocumento VALUES (
--'CPF','025ADM','2024-05-15 00:00:00.000','','',1
--'RG','025ADM','2024-05-15 00:00:00.000','','',1
--'CNPJ','025ADM','2024-05-15 00:00:00.000','','',1
--'Contrato Social','025ADM','2024-05-15 00:00:00.000','','',1
--'Habilitação','025ADM','2024-05-15 00:00:00.000','','',1
--'Comprovante Endereço','025ADM','2024-05-15 00:00:00.000','','',1
--'Comprovante Bancário','025ADM','2024-05-15 00:00:00.000','','',1
--'Extrato Digital','025ADM','2024-05-15 00:00:00.000','','',1
);

drop view tabven06_Aux01;

CREATE View [dbo].[TabVen06_Aux01] as 
select 
   TavNum,
   TavVigDtaIni,
   TavAdqCod,
   TavBanCod,
   TavDetSeq
from TABVEN05
where TavDetSeq <= 25
group by TavNum,
   TavVigDtaIni,
   TavAdqCod,
   TavBanCod,
   TavDetSeq
GO;