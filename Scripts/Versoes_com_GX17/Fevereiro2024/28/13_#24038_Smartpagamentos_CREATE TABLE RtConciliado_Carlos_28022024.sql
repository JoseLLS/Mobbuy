USE SmartPagamentos
CREATE TABLE [RtConciliado] (
  [RtConciliadoId]          DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtConciliadoEstCod]      INT    NULL,
  [RtConciliadoNsu]         DECIMAL(18)    NULL,
  [RtConciliadoAutCod]      VARCHAR(10)    NULL,
  [RtConciliadoDataTrn]     DATETIME    NULL,
  [RtConciliadoProduto]     VARCHAR(10)    NULL,
  [RtConciliadoBandeira]    VARCHAR(1)    NULL,
  [RtConciliadoTrnCod]      VARCHAR(10)    NULL,
  [RtConciliadoValorTrn]    DECIMAL(17,2)    NULL,
  [RtConciliadoValorLiqEst] DECIMAL(17,2)    NULL,
  [RtConciliadoValor]       DECIMAL(17,2)    NULL,
  [RtConciliadoDataInc]     DATETIME    NULL,
  [RtConciliadoGuid]        VARCHAR(100)    NULL,
     PRIMARY KEY ( [RtConciliadoId] ))

CREATE NONCLUSTERED INDEX [URTCONCILIADOEC] ON [RtConciliado] (
      [RtConciliadoEstCod])