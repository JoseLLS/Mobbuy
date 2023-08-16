/* SEM TAREFA - JOSÉ */

CREATE TABLE [SQLHistorico] (
  [SQLHisId]      SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [SQLHisVerRet]  CHAR(20)    NULL,
  [SQLHisVerLoj]  CHAR(20)    NULL,
  [SQLHisDtaExec] DATETIME    NULL,
     PRIMARY KEY ( [SQLHisId] ));

INSERT INTO SQLHistorico
VALUES ('3.5.13','2.5.21',GETDATE())

/* SEM TAREFA - LEONARDO */

alter table movtrn01
add MovTrnTxaComVlrPrv numeric(12,2) null,
	MovTrnTxaEstVlrPrv NUMERIC(12,2) null,
	MovTrnEstTxaAdmPrv NUMERIC(6,2) null,
	MovTrnEstTxaAntPrv NUMERIC(6,2) null,
	MovTrnEstTarCredPrv NUMERIC(6,2) null,
	MovTrnEstCusTrnPrv NUMERIC(6,2) null,
	MovTrnTxaEstCond BIT NULL 