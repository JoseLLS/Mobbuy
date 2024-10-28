/* TAREFA #25228 - JOSÉ */

CREATE TABLE [ArranjoStatus] (
  [ArranjoStatusId]  SMALLINT    NOT NULL,
  [ArranjoStatusDsc] VARCHAR(40)    NULL,
     PRIMARY KEY ( [ArranjoStatusId] ));
	 
CREATE TABLE [ArqSlcArranjo] (
  [ArbNum]          INT    NOT NULL,
  [ArbLotNum]       SMALLINT    NOT NULL,
  [ArbDetSeq]       INT    NOT NULL,
  [ArqSlcId]        INT    NOT NULL,
  [ArqSlcEstCod]    INT    NULL,
  [ArqSlcBan]       CHAR(1)    NULL,
  [ArqSlcValor]     DECIMAL(17,2)    NULL,
  [ArqSlcDtaInc]    DATETIME    NULL,
  [ArranjoStatusId] SMALLINT    NULL,
     PRIMARY KEY ( [ArbNum],[ArbLotNum],[ArbDetSeq],[ArqSlcId] ));
CREATE NONCLUSTERED INDEX [IARQSLCARRANJO2] ON [ArqSlcArranjo] (
      [ArranjoStatusId]);
ALTER TABLE [ArqSlcArranjo]
 ADD CONSTRAINT [IARQSLCARRANJO1] FOREIGN KEY ( [ArbNum],[ArbLotNum],[ArbDetSeq] ) REFERENCES [ARQDET]([ArbNum],[ArbLotNum],[ArbDetSeq]);
ALTER TABLE [ArqSlcArranjo]
 ADD CONSTRAINT [IARQSLCARRANJO2] FOREIGN KEY ( [ArranjoStatusId] ) REFERENCES [ArranjoStatus]([ArranjoStatusId]);