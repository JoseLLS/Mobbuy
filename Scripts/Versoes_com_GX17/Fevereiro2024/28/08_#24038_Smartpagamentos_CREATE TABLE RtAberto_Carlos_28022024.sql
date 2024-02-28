USE SmartPagamentos
CREATE TABLE [RtAberto] (
  [RtAbertoId]          DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtAbertoEstCod]      INT    NULL,
  [RtAbertoNsu]         DECIMAL(18)    NULL,
  [RtAbertoAutCod]      VARCHAR(20)    NULL,
  [RtAbertoDataTrn]     DATETIME    NULL,
  [RtAbertoProduto]     VARCHAR(1)    NULL,
  [RtAbertoBandeira]    VARCHAR(1)    NULL,
  [RtAbertoTrnCod]      VARCHAR(10)    NULL,
  [RtAbertoValorTrn]    DECIMAL(17,2)    NULL,
  [RtAbertoValorLiqEst] DECIMAL(17,2)    NULL,
  [RtAbertoValor]       DECIMAL(17,2)    NULL,
  [RtAbertoDataInc]     DATETIME    NULL,
  [RtAbertoGuid]        VARCHAR(100)    NULL,
     PRIMARY KEY ( [RtAbertoId] ))

CREATE NONCLUSTERED INDEX [URTABERTOEC] ON [RtAberto] (
      [RtAbertoEstCod])