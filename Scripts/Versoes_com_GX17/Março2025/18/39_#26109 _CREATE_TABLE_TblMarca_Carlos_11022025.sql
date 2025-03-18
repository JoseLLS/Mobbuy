USE PERMITE

CREATE TABLE [TblMarca] (
  [TblMarcaID]     INT    NOT NULL IDENTITY ( 1 , 1 ),
  [TblMarcaDsc]    CHAR(50)    NOT NULL,
  [TblMarcaSts]    BIT    NOT NULL,
  [TblMarcaDtaInc] DATETIME    NULL,
  [TblMarcaUsuInc] CHAR(20)    NULL,
  [TblMarcaDtaAlt] DATETIME    NULL,
  [TblMarcaUsuAlt] CHAR(20)    NULL,
     PRIMARY KEY ( [TblMarcaID] ))