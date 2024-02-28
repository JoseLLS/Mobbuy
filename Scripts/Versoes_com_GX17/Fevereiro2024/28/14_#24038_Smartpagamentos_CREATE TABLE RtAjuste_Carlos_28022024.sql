USE SmartPagamentos
CREATE TABLE [RtAjuste] (
  [RtAjusteId]          DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtAjusteEstCod]      INT    NULL,
  [RtAjusteNsu]         DECIMAL(18)    NULL,
  [RtAjusteAutCod]      VARCHAR(20)    NULL,
  [RtAjusteDataTrn]     DATETIME    NULL,
  [RtAjusteProduto]     VARCHAR(1)    NULL,
  [RtAjusteBandeira]    VARCHAR(1)    NULL,
  [RtAjusteTrnCod]      VARCHAR(10)    NULL,
  [RtAjusteValorTrn]    DECIMAL(17,2)    NULL,
  [RtAjusteValorLiqEst] DECIMAL(17,2)    NULL,
  [RtAjusteValor]       DECIMAL(17,2)    NULL,
  [RtAjusteDataInc]     DATETIME    NULL,
  [RtAjusteGuid]        VARCHAR(100)    NULL,
     PRIMARY KEY ( [RtAjusteId] ))

CREATE NONCLUSTERED INDEX [URTAJUSTEEC] ON [RtAjuste] (
      [RtAjusteEstCod])