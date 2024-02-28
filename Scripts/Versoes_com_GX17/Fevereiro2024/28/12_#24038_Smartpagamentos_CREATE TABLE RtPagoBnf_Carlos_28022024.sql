USE SmartPagamentos
CREATE TABLE [RtPagoBnf] (
  [RtPagoBnfId]          DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtPagoBnfEstCod]      INT    NULL,
  [RtPagoBnfNsu]         DECIMAL(18)    NULL,
  [RtPagoBnfAutCod]      VARCHAR(10)    NULL,
  [RtPagoBnfDataTrn]     DATETIME    NULL,
  [RtPagoBnfProduto]     VARCHAR(1)    NULL,
  [RtPagoBnfBandeira]    VARCHAR(1)    NULL,
  [RtPagoBnfTrnCod]      VARCHAR(10)    NULL,
  [RtPagoBnfValorTrn]    DECIMAL(17,2)    NULL,
  [RtPagoBnfValorLiqEst] DECIMAL(17,2)    NULL,
  [RtPagoBnfValor]       DECIMAL(17,2)    NULL,
  [RtPagoBnfDataInc]     DATETIME    NULL,
  [RtPagoBnfGuid]        VARCHAR(100)    NULL,
     PRIMARY KEY ( [RtPagoBnfId] ))

CREATE NONCLUSTERED INDEX [URTPAGOBNFEC] ON [RtPagoBnf] (
      [RtPagoBnfEstCod])