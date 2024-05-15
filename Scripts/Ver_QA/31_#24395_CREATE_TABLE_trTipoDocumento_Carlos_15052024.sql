
CREATE TABLE [trTipoDocumento] (
  [TipoDocID]     INT    NOT NULL    IDENTITY ( 1 , 1 ),
  [TipoDocDsc]    CHAR(50)    NOT NULL,
  [TipoDocUsuIns] CHAR(20)    NULL,
  [TipoDocDtaIns] DATETIME    NULL,
  [TipoDocUsuAlt] CHAR(20)    NULL,
  [TipoDocDtaAlt] DATETIME    NULL,
  [TipoDocStatus] BIT    NOT NULL,
     PRIMARY KEY ( [TipoDocID] ))