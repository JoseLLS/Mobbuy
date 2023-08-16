/* SEM TAREFA - JOSÉ */

CREATE TABLE [SQLHistorico] (
  [SQLHisId]      SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [SQLHisVerRet]  CHAR(20)    NULL,
  [SQLHisVerLoj]  CHAR(20)    NULL,
  [SQLHisDtaExec] DATETIME    NULL,
     PRIMARY KEY ( [SQLHisId] ));