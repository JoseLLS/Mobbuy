USE SmartPagamentos
CREATE TABLE [RtCancelado] (
  [RtCanceladoId]          DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtCanceladoEstCod]      INT    NULL,
  [RtCanceladoNsu]         DECIMAL(18)    NULL,
  [RtCanceladoAutCod]      VARCHAR(10)    NULL,
  [RtCanceladoDataTrn]     DATETIME    NULL,
  [RtCanceladoProduto]     VARCHAR(1)    NULL,
  [RtCanceladoBandeira]    VARCHAR(1)    NULL,
  [RtCanceladoTrnCod]      VARCHAR(10)    NULL,
  [RtCanceladoValorTrn]    DECIMAL(17,2)    NULL,
  [RtCanceladoValorLiqEst] DECIMAL(17,2)    NULL,
  [RtCanceladoValor]       DECIMAL(17,2)    NULL,
  [RtCanceladoDataInc]     DATETIME    NULL,
  [RtCanceladoGuid]        VARCHAR(100)    NULL,
     PRIMARY KEY ( [RtCanceladoId] ))

CREATE NONCLUSTERED INDEX [URTCANCELADOEC] ON [RtCancelado] (
      [RtCanceladoEstCod])