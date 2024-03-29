USE SmartPagamentos

CREATE TABLE [RtAnalitico] (
  [RtAnaliticoId]                   DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtAnaliticoEstCod]               INT    NULL,
  [RtAnaliticoNsu]                  DECIMAL(18)    NULL,
  [RtAnaliticoAutcod]               VARCHAR(20)    NULL,
  [RtAnaliticoDataTrn]              DATETIME    NULL,
  [RtAnaliticoProduto]              VARCHAR(10)    NULL,
  [RtAnaliticoBandeira]             VARCHAR(1)    NULL,
  [RtAnaliticoTrnCod]               VARCHAR(10)    NULL,
  [RtAnaliticoValorTrn]             DECIMAL(17,2)    NULL,
  [RtAnaliticoValorLiqEst]          DECIMAL(17,2)    NULL,
  [RtAnaliticoValorAberto]          DECIMAL(17,2)    NULL,
  [RtAnaliticoValorCancelado]       DECIMAL(17,2)    NULL,
  [RtAnaliticoValorAnt]             DECIMAL(17,2)    NULL,
  [RtAnaliticoValorPago]            DECIMAL(17,2)    NULL,
  [RtAnaliticoValorPagoBnf]         DECIMAL(17,2)    NULL,
  [RtAnaliticoCessao]               DECIMAL(17,2)    NULL,
  [RtAnaliticoCessaoBnf]            DECIMAL(17,2)    NULL,
  [RtAnaliticoValorConc]            DECIMAL(17,2)    NULL,
  [RtAnaliticoDataInc]              DATETIME    NULL,
  [RtAnaliticoGuid]                 VARCHAR(100)    NULL,
  [RtAnaliticoUsr]                  CHAR(20)    NULL,
  [RtAnaliticoValorEstorno]         DECIMAL(17,2)    NULL,
  [RtAnaliticoValorAjusteContabil]  DECIMAL(17,2)    NULL,
  [RtAnaliticoValorAjusteCessao]    DECIMAL(17,2)    NULL,
  [RtAnaliticoValorAjusteCessaoBnf] DECIMAL(17,2)    NULL,
  [RtAnaliticoValorAjusteBanco]     DECIMAL(17,2)    NULL,
     PRIMARY KEY ( [RtAnaliticoId] ))

CREATE NONCLUSTERED INDEX [URTANALITICOEC] ON [RtAnalitico] (
      [RtAnaliticoEstCod])