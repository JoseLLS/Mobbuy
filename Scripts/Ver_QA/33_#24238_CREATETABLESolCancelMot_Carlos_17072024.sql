use Pronto

CREATE TABLE [SolCancelMot] (
  [SolCancelMotId]     SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [SolCancelMotDsc]    VARCHAR(100)    NULL,
  [SolCancelMotSts]    BIT    NULL,
  [SolCancelMotUsuInc] VARCHAR(40)    NULL,
  [SolCancelMotUsuAlt] VARCHAR(40)    NULL,
  [SolCancelMotDtaInc] DATETIME    NULL,
  [SolCancelMotDtaAlt] DATETIME    NULL,
     PRIMARY KEY ( [SolCancelMotId] ))