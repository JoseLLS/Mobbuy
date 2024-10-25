/* TAREFA #25228 - JOSÉ */

CREATE TABLE [ARQSLCARRANJO] ( 
  [ArbNum]       INT    NOT NULL, 
  [ArbLotNum]    SMALLINT    NOT NULL, 
  [ArbDetSeq]    INT    NOT NULL, 
  [ArqSlcId]     INT    NOT NULL, 
  [ArqSlcEstCod] INT    NULL, 
  [ArqSlcBan]    CHAR(1)    NULL, 
  [ArqSlcValor]  DECIMAL(17,2)    NULL, 
  [ArqSlcDtaInc] DATETIME    NULL, 
     PRIMARY KEY ( [ArbNum],[ArbLotNum],[ArbDetSeq],[ArqSlcId] ));
	 
ALTER TABLE [ARQSLCARRANJO] 
ADD CONSTRAINT [IARQSLCARRANJO1] FOREIGN KEY ( [ArbNum],[ArbLotNum],[ArbDetSeq] ) REFERENCES [ARQDET]([ArbNum],[ArbLotNum],[ArbDetSeq]);