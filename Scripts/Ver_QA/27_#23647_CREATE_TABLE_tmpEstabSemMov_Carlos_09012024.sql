
CREATE TABLE [tmpEstabSemMov] (
  [tmpEstabSemMovEstab]  CHAR(50)    NOT NULL,
  [tmpEstabSemMovDta]    DATETIME    NOT NULL,
  [tmpEstabSemMovEstCod] INT		     NULL,
  [tmpEstabSemMovParCom] CHAR(40)    NULL,
  [tmpEstabSemMovPacCod] INT 	       NULL,
  [tmpEstabSemMovQtdPos] SMALLINT    NULL,
     PRIMARY KEY ( [tmpEstabSemMovEstab],[tmpEstabSemMovDta] ))
