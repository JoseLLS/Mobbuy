USE SmartPagamentos
CREATE TABLE [RtAntecipacao] (
  [RtAntecipacaoId]          DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtAntecipacaoEstCod]      INT    NULL,
  [RtAntecipacaoNsu]         DECIMAL(18)    NULL,
  [RtAntecipacaoAutCod]      VARCHAR(10)    NULL,
  [RtAntecipacaoDataTrn]     DATETIME    NULL,
  [RtAntecipacaoProduto]     VARCHAR(1)    NULL,
  [RtAntecipacaoBandeira]    VARCHAR(1)    NULL,
  [RtAntecipacaoTrnCod]      VARCHAR(10)    NULL,
  [RtAntecipacaoValorTrn]    DECIMAL(17,2)    NULL,
  [RtAntecipacaoValorLiqEst] DECIMAL(17,2)    NULL,
  [RtAntecipacaoValor]       DECIMAL(17,2)    NULL,
  [RtAntecipacaoDataInc]     DATETIME    NULL,
  [RtAntecipacaoGuid]        VARCHAR(100)    NULL,
     PRIMARY KEY ( [RtAntecipacaoId] ))

CREATE NONCLUSTERED INDEX [URTANTECIPACAOEC] ON [RtAntecipacao] (
      [RtAntecipacaoEstCod])