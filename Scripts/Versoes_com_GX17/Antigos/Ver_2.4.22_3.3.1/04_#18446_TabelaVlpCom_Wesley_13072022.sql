CREATE TABLE [VlpCom] (
  [VlpComId]       DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [VlpComPacCod]   INT    NULL,
  [VlpComEstCod]   SMALLINT    NULL,
  [VlpComSts]      SMALLINT    NULL,
  [VlpComMovTrnId] DECIMAL(18)    NULL,
  [VlpComVlr]      DECIMAL(17,2)    NULL,
  [VlpComPerc]     SMALLMONEY    NULL,
  [VlpComVlrFixo]  DECIMAL(17,2)    NULL,
  [VlpComDtainc]   DATETIME    NULL,
     PRIMARY KEY ( [VlpComId] ))

CREATE NONCLUSTERED INDEX [IVLPCOM1] ON [VlpCom] (
      [VlpComMovTrnId])

ALTER TABLE [VlpCom]
 ADD CONSTRAINT [IVLPCOM1] FOREIGN KEY ( [VlpComMovTrnId] ) REFERENCES [MovTrn01]([MovTrnId])