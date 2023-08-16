ALTER TABLE [MovTrn01] ADD [MovTrnExpCom] BIT    NOT NULL CONSTRAINT MovTrnExpComMovTrn01_DEFAULT DEFAULT Convert(BIT,0)

CREATE NONCLUSTERED INDEX [UMOVTRN021] ON [MovTrn01] (
      [EstCod],
      [MovTrnDta],
      [MovTrnCod],
      [MovTrnExpCom])

CREATE NONCLUSTERED INDEX [UTABVEN07] ON [TABVEN07] (
      [TavComNum],
      [TavComVigDtaIni],
      [TavComAdqCod],
      [TavComBanCod],
      [TavComDetTipPln],
      [TavComDetQtdPar])