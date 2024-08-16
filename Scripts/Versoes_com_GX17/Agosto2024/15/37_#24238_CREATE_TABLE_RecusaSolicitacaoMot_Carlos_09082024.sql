use pronto

CREATE TABLE [RecusaSolicitacaoMot] (
  [RecSolMotId]     SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [RecSolMotDsc]    VARCHAR(100)    NULL,
  [RecSolMotSts]    BIT    NULL,
  [RecSolMotUsuInc] VARCHAR(40)    NULL,
  [RecSolMotUsuAlt] VARCHAR(40)    NULL,
  [RecSolMotDtaInc] DATETIME    NULL,
  [RecSolMotDtaAlt] DATETIME    NULL,
     PRIMARY KEY ( [RecSolMotId] ))