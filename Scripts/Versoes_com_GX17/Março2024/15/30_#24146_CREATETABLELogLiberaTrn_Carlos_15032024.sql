use pronto

CREATE TABLE [LogLiberaTrn] (
  [LogLiberaTrnId]       DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [MovTrnId]             DECIMAL(18)    NOT NULL,
  [LogLiberaTrnDataInc]  DATETIME    NOT NULL,
  [LogLiberaTrnUsuInc]   VARCHAR(100)    NOT NULL,
  [LogLiberaTrnMensagem] VARCHAR(250)    NOT NULL,
     PRIMARY KEY ( [LogLiberaTrnId] ))
CREATE NONCLUSTERED INDEX [ILOGLIBERATRN1] ON [LogLiberaTrn] (
      [MovTrnId])
ALTER TABLE [LogLiberaTrn]
 ADD CONSTRAINT [ILOGLIBERATRN1] FOREIGN KEY ( [MovTrnId] ) REFERENCES [MovTrn01]([MovTrnId])
