use pronto

CREATE TABLE [TrnCan10] (
  [TrnCan10Id]                  DECIMAL(18)     NOT NULL     IDENTITY ( 1 , 1 ),
  [TrnCan10TipoRegistro]        VARCHAR(2)     NOT NULL,
  [TrnCan10DataCancelamento]    DATETIME     NOT NULL,
  [TrnCan10HoraCancelamento]    INT     NOT NULL,
  [TrnCan10NomeSolicitante]     VARCHAR(25)     NOT NULL,
  [TrnCan10TipoSolicitante]     VARCHAR(1)     NOT NULL,
  [TrnCan10Operador]            VARCHAR(6)     NOT NULL,
  [TrnCan10Cnpj]                VARCHAR(14)     NOT NULL,
  [TrnCan10Rede]                VARCHAR(11)     NOT NULL,
  [TrnCan10Estabelecimento]     VARCHAR(15)     NOT NULL,
  [TrnCan10Terminal]            VARCHAR(8)     NOT NULL,
  [TrnCan10DataMovimento]       DATETIME     NOT NULL,
  [TrnCan10NsuMovimento]        INT     NOT NULL,
  [TrnCan10NsuFormatado]        DECIMAL(18)     NOT NULL,
  [TrnCan10Parcela]             SMALLINT     NOT NULL,
  [TrnCan10QtdParcela]          SMALLINT     NOT NULL,
  [TrnCan10HoraMovimento]       INT     NOT NULL,
  [TrnCan10DataOrigem]          DATETIME     NOT NULL,
  [TrnCan10HoraOrigem]          INT     NOT NULL,
  [TrnCan10NsuOrigem]           INT     NOT NULL,
  [TrnCan10CodigoMensagem]      SMALLINT     NOT NULL,
  [TrnCan10CodigoProcessamento] INT     NOT NULL,
  [TrnCan10Servico]             VARCHAR(4)     NOT NULL,
  [TrnCan10Situacao]            VARCHAR(2)     NOT NULL,
  [TrnCan10Valor]               DECIMAL(15)     NOT NULL,
  [TrnCan10ValorParcela]        DECIMAL(15)     NOT NULL,
  [TrnCan10DataCredito]         DATETIME     NOT NULL,
  [TrnCan10TarifaAdmFixa]       INT     NOT NULL,
  [TrnCan10TarifaAdmPerc]       INT     NOT NULL,
  [TrnCan10TarifaAdmCan]        DECIMAL(10)     NOT NULL,
  [TrnCan10SituacaoParcela]     VARCHAR(1)     NOT NULL,
  [TrnCan10IdPedido]            VARCHAR(40)     NOT NULL,
  [TrnCan10CnpjCpf]             VARCHAR(14)     NOT NULL,
  [TrnCan10Bandeira]            VARCHAR(3)     NOT NULL,
  [TrnCan10SequenciaRegistro]   VARCHAR(9)     NOT NULL,
  [TrnCan10NumLog]              DECIMAL(18)     NOT NULL,
  [TrnCan10MovTrnId]            DECIMAL(18)     NULL,
  [TrnCan10StatusId]            SMALLINT     NOT NULL,
  [TrnCan10HeaderId]            DECIMAL(18)     NULL,
  [TrnCan10TrailerId]           DECIMAL(18)     NULL,
      PRIMARY KEY ( [TrnCan10Id] ))


CREATE NONCLUSTERED INDEX [ITRNCAN101] ON [TrnCan10] (
      [TrnCan10MovTrnId])

CREATE NONCLUSTERED INDEX [ITRNCAN102] ON [TrnCan10] (
      [TrnCan10StatusId])

CREATE NONCLUSTERED INDEX [ITRNCAN103] ON [TrnCan10] (
      [TrnCan10HeaderId])

CREATE NONCLUSTERED INDEX [ITRNCAN104] ON [TrnCan10] (
      [TrnCan10TrailerId])

CREATE NONCLUSTERED INDEX [UTRNCAN10] ON [TrnCan10] (
      [TrnCan10NumLog])

ALTER TABLE [TrnCan10]
 ADD CONSTRAINT [ITRNCAN101] FOREIGN KEY ( [TrnCan10MovTrnId] ) REFERENCES [MovTrn01]([MovTrnId])

ALTER TABLE [TrnCan10]
 ADD CONSTRAINT [ITRNCAN102] FOREIGN KEY ( [TrnCan10StatusId] ) REFERENCES [TrnStatus]([TrnStatusId])

ALTER TABLE [TrnCan10]
 ADD CONSTRAINT [ITRNCAN103] FOREIGN KEY ( [TrnCan10HeaderId] ) REFERENCES [Header]([HeaderId])

ALTER TABLE [TrnCan10]
 ADD CONSTRAINT [ITRNCAN104] FOREIGN KEY ( [TrnCan10TrailerId] ) REFERENCES [Trailer]([TrailerId])