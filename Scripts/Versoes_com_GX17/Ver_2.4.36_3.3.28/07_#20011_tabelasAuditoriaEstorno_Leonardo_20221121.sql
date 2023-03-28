
ALTER TABLE [RtConsolidado]
ADD [RtConsolidadoAluguelPos] DECIMAL(17,2)    NULL


ALTER TABLE [RtConsolidado]
ADD [RtConsolidadoEstorno] DECIMAL(17,2)    NULL


CREATE TABLE [RtEstorno] (
  [RtEstornoId]          DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtEstornoEstCod]      INT    NULL,
  [RtEstornoNsu]         DECIMAL(18)    NULL,
  [RtEstornoAutCod]      VARCHAR(10)    NULL,
  [RtEstornoDataTrn]     DATETIME    NULL,
  [RtEstornoProduto]     VARCHAR(1)    NULL,
  [RtEstornoBandeira]    VARCHAR(1)    NULL,
  [RtEstornoTrnCod]      VARCHAR(10)    NULL,
  [RtEstornoValorTrn]    DECIMAL(17,2)    NULL,
  [RtEstornoValorLiqEst] DECIMAL(17,2)    NULL,
  [RtEstornoValor]       DECIMAL(17,2)    NULL,
  [RtEstornoDataInc]     DATETIME    NULL,
  [RtEstornoGuid]        VARCHAR(100)    NULL,
     PRIMARY KEY ( [RtEstornoId] ))
	 
	 
	ALTER TABLE [RtAnalitico]
ADD [RtAnaliticoValorEstorno] DECIMAL(17,2)    NULL