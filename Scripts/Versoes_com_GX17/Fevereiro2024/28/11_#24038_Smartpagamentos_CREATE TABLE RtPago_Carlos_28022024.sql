USE SmartPagamentos
CREATE TABLE [RtPago] (
  [RtPagoId]          DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtPagoEstCod]      INT    NULL,
  [RtPagoNsu]         DECIMAL(18)    NULL,
  [RtPagoAutCod]      VARCHAR(10)    NULL,
  [RtPagoDataTrn]     DATETIME    NULL,
  [RtPagoProduto]     VARCHAR(1)    NULL,
  [RtPagoBandeira]    VARCHAR(1)    NULL,
  [RtPagoTrnCod]      VARCHAR(10)    NULL,
  [RtPagoValorTrn]    DECIMAL(17,2)    NULL,
  [RtPagoValorLiqEst] DECIMAL(17,2)    NULL,
  [RtPagoValor]       DECIMAL(17,2)    NULL,
  [RtPagoDataInc]     DATETIME    NULL,
  [RtPagoGuid]        VARCHAR(100)    NULL,
     PRIMARY KEY ( [RtPagoId] ))

CREATE NONCLUSTERED INDEX [URTPAGOEC] ON [RtPago] (
      [RtPagoEstCod])