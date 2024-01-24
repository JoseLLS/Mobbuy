
CREATE TABLE [tmpEstabSemMov] (
  [tmpEstabSemMovEstab]  CHAR(100)    NOT NULL,
  [tmpEstabSemMovDta]    DATETIME    NOT NULL,
  [tmpEstabSemMovEstCod] INT	     NULL,
  [tmpEstabSemMovParCom] CHAR(100)    NULL,
  [tmpEstabSemMovPacCod] INT	     NULL,
  [tmpEstabSemMovQtdPos] SMALLINT    NULL,
     PRIMARY KEY ( [tmpEstabSemMovEstab],[tmpEstabSemMovDta] ))
