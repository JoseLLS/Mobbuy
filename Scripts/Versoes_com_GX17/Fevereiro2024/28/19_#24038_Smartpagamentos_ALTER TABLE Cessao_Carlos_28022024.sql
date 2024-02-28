USE SMARTPAGAMENTOS

ALTER TABLE [Cessao] ADD
  [CessaoNFDistribuidora] VARCHAR(128)    NULL,
  [CessaoValorNota]       DECIMAL(17,2)    NULL,
  [CessaoDataEmissao]     DATETIME    NULL,
  [CessaoDistribuidor]    VARCHAR(128)    NULL,
  [CessaoFilial]          VARCHAR(128)    NULL
