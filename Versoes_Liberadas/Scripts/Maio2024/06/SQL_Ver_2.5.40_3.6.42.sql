/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.42','2.5.40',GETDATE());

/* TAREFA #24268 - CARLOS */

ALTER TABLE [SolicitacaoCancelamento]
ADD [SolCan_motivo] VARCHAR(MAX)    NOT NULL CONSTRAINT SolCan_motivoSolicitacaoCancelamento_DEFAULT DEFAULT ''

ALTER TABLE [SolicitacaoCancelamento]
DROP CONSTRAINT SolCan_motivoSolicitacaoCancelamento_DEFAULT

/* TAREFA #22803 - CARLOS */

CREATE TABLE [TmpTabVenDuplicada] (
  [TmpTabVenDuplicadaCod]          INT    NOT NULL    IDENTITY ( 1 , 1 ),
  [TmpTabVenDuplicadaTavNum]       SMALLINT    NULL,
  [TmpTabVenDuplicadaTavVigDtaIni] DATETIME    NULL,
  [TmpTabVenDuplicadaAdqCod]       SMALLINT    NULL,
  [TmpTabVenDuplicadaBanCod]       CHAR(1)    NULL,
  [TmpTabVenDuplicadaTavDetSeq]    SMALLINT    NULL,
  [TmpTabVenDuplicadaTavDetTipPln] CHAR(1)    NULL,
  [TmpTabVenDuplicadaTavDetQtdPar] SMALLINT    NULL,
  [TmpTabVenDuplicadaTavDetTxaAdm] SMALLMONEY    NULL,
  [TmpTabVenDuplicadaTavDetTxaFin] SMALLMONEY    NULL,
  [TmpTabVenDuplicadaTavDetTarCre] SMALLMONEY    NULL,
  [TavDetVlrCusTrnTavDetVlrCusTrn] DECIMAL(17,2)    NULL,
  [PrzCodPrz]                      CHAR(10)    NULL,
     PRIMARY KEY ( [TmpTabVenDuplicadaCod] ))
CREATE NONCLUSTERED INDEX [ITMPTABVENDUPLICADA1] ON [TmpTabVenDuplicada] (
      [PrzCodPrz])
ALTER TABLE [TmpTabVenDuplicada]
 ADD CONSTRAINT [ITMPTABVENDUPLICADA1] FOREIGN KEY ( [PrzCodPrz] ) REFERENCES [PRZPAG]([PrzCodPrz])

/* SEM TAREFA - SCRIPT ATRELADO Á VERSÃO */

CREATE TABLE [NOTIFICACAO] ( 
  [NotificacaoId]        INT    NOT NULL    IDENTITY ( 1 , 1 ), 
  [NotificacaoMsg]       VARCHAR(200)    NULL, 
  [NotificacaoEc]        SMALLINT    NULL, 
  [NotificacaoVista]     BIT    NULL, 
  [NotificacaoData]      DATETIME    NULL, 
  [NotificacaoDataVista] DATETIME    NULL, 
  [NotificacaoUsuInc]    VARCHAR(40)    NULL, 
     PRIMARY KEY ( [NotificacaoId] ))