CREATE TABLE [ADQ0013] (
  [UNG2Cod]               INT         NOT NULL,
  [AdqCod]                SMALLINT    NOT NULL,
  [SeqCod]                DECIMAL(18) NOT NULL,
  [AdqUngTaxAntEveHis]    SMALLMONEY   NULL,
  [AdqUngTaxAntAutHis]    SMALLMONEY   NULL,
  [AdqUngIndImpAjtAutHis] BIT          NULL,
  [AdqUngDtaVigHis]       DATETIME     NULL,
  [AdqUngUsuHis]          VARCHAR(40)  NULL,
     PRIMARY KEY ( [UNG2Cod],[AdqCod],[SeqCod] ))

CREATE NONCLUSTERED INDEX [UADQ0013] ON [ADQ0013] (
      [UNG2Cod],
      [AdqCod],
      [SeqCod] DESC)
ALTER TABLE [ADQ0013]

ADD CONSTRAINT [IADQ0006ADQHIS1] FOREIGN KEY ( [UNG2Cod],[AdqCod] ) REFERENCES [ADQ0006]([UNG2Cod],[AdqCod])