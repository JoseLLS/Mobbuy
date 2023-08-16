--drop table [Trn12]

CREATE TABLE [Trn12] (
  [Transaction_pix]         DECIMAL(18)    NOT NULL,
  [Dt_hr_trans]             DATETIME    NULL,
  [Cd_company]              DECIMAL(18)    NULL,
  [Cd_partner]              SMALLINT    NULL,
  [Cnpj_terminal]           VARCHAR(14)    NULL,
  [Cd_terminal_physical]    VARCHAR(10)    NULL,
  [Pay_value]               DECIMAL(17,2)    NULL,
  [Pay_liquid]              DECIMAL(17,2)    NULL,
  [Quantity_parcel]         SMALLINT    NULL,
  [Dt_hr_inclusao_cobranca] DATETIME    NULL,
  [Txid_cobranca]           VARCHAR(40)    NULL,
  [Valor_cobranca]          DECIMAL(17,2)    NULL,
  [Valor_tarifa_cobranca]   DECIMAL(17,2)    NULL,
  [Situacao_cobranca]       VARCHAR(20)    NULL,
  [Dt_hr_pagamento]         DATETIME    NULL,
  [Valor_pagamento]         DECIMAL(17,2)    NULL,
  [Nsu_pagamento]           VARCHAR(20)    NULL,
  [Valor_tarifa_pagamento]  DECIMAL(17,2)    NULL,
  [Situacao_pagamento]      VARCHAR(20)    NULL,
  [Json_Entrada]            VARCHAR(MAX)    NULL,
  [Loc_Num_Log]             DECIMAL(18)    NULL,
  [Dt_hr_Importacao]        DATETIME    NULL,
  [Status_Movimento]        VARCHAR(40)    NULL,
  [MovTrnId]                DECIMAL(18)    NULL,
  [Status_Lancamento]       VARCHAR(40)    NULL,
  [VlpNumLan]               DECIMAL(18)    NULL,
    [Dt_hr_Processamento]     DATETIME    NULL,
     PRIMARY KEY ( [Transaction_pix] ))
CREATE NONCLUSTERED INDEX [UTRN12] ON [Trn12] (
      [Transaction_pix],
      [Status_Movimento],
      [Status_Lancamento],
      [Situacao_cobranca])
CREATE NONCLUSTERED INDEX [ITRN13] ON [Trn12] (
      [MovTrnId])
CREATE NONCLUSTERED INDEX [UTRN121] ON [Trn12] (
      [Status_Movimento],
      [Status_Lancamento])
CREATE NONCLUSTERED INDEX [ITRN14] ON [Trn12] (
      [VlpNumLan])
ALTER TABLE [Trn12]
 ADD CONSTRAINT [ITRN13] FOREIGN KEY ( [MovTrnId] ) REFERENCES [MovTrn01]([MovTrnId])
ALTER TABLE [Trn12]
 ADD CONSTRAINT [ITRN14] FOREIGN KEY ( [VlpNumLan] ) REFERENCES [VLRPAG]([VlpNumLan])