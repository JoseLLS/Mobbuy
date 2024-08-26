use Pronto

CREATE TABLE [LogCadastroCompliance] (
  [LogCadCompID]        DECIMAL(10)    NOT NULL    IDENTITY ( 1 , 1 ),
  [LogCadCompTabela]    VARCHAR(40)    NULL,
  [LogCadCompCampo]     VARCHAR(40)    NULL,
  [LogCadCompInfoAnt]   VARCHAR(MAX)    NULL,
  [LogCadCompInfoAtual] VARCHAR(MAX)    NULL,
  [LogCadCompOrigem]    VARCHAR(40)    NULL,
  [LogCadCompEstCod]    INT    NULL,
  [LogCadCompUsuReq]    CHAR(20)    NULL,
  [LogCadCompDtaReq]    DATETIME    NULL,
  [LogCadCompUsuObs]    VARCHAR(350)    NULL,
  [LogCadCompStatus]    SMALLINT    NOT NULL,
  [LogCadCompUsuAprov]  CHAR(20)    NULL,
  [LogCadCompDtaAprov]  DATETIME    NULL,
  [LogCadCompMotivo]    VARCHAR(350)    NULL,
  [LogCadCompAtributo]  VARCHAR(40)    NULL,
     PRIMARY KEY ( [LogCadCompID] ))

