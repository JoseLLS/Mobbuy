USE PERMITE

CREATE TABLE [TblFilial] (
  [TblFilialID]     INT    NOT NULL IDENTITY ( 1 , 1 ),
  [TblFilialDsc]    CHAR(50)    NOT NULL,
  [TblFilialSts]    BIT    NOT NULL,
  [TblFilialDtaInc] DATETIME    NULL,
  [TblFilialUsuInc] CHAR(20)    NULL,
  [TblFilialDtaAlt] DATETIME    NULL,
  [TblFilialUsuAlt] CHAR(20)    NULL,
     PRIMARY KEY ( [TblFilialID] ))