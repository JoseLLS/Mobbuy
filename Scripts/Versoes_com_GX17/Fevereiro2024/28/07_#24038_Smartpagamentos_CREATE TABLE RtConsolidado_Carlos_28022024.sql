use SmartPagamentos
CREATE TABLE [RtConsolidado] (
  [RtConsolidadoId]                DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtConsolidadoEstCod]            INT    NULL,
  [RtConsolidadoVendaValor]        DECIMAL(17,2)    NULL,
  [RtConsolidadoLiqEstValor]       DECIMAL(17,2)    NULL,
  [RtConsolidadoAbertoValor]       DECIMAL(17,2)    NULL,
  [RtConsolidadoCancelamentoValor] DECIMAL(17,2)    NULL,
  [RtConsolidadoReceberValor]      DECIMAL(17,2)    NULL,
  [RtConsolidadoCessaoOriValor]    DECIMAL(17,2)    NULL,
  [RtConsolidadoCessaoDetOriValor] DECIMAL(17,2)    NULL,
  [RtConsolidadoCessaoBenValor]    DECIMAL(17,2)    NULL,
  [RtConsolidadoCessaoDetBenValor] DECIMAL(17,2)    NULL,
  [RtConsolidadoBancoValor]        DECIMAL(17,2)    NULL,
  [RtConsolidadoCustoAntValor]     DECIMAL(17,2)    NULL,
  [RtConsolidadoPago]              DECIMAL(17,2)    NULL,
  [RtConsolidadoGuid]              VARCHAR(100)    NULL,
  [RtConsolidadoAluguelPos]        DECIMAL(17,2)    NULL,
  [RtConsolidadoEstorno]           DECIMAL(17,2)    NULL,
  [RtConsolidadoAjusteContabil]    DECIMAL(17,2)    NULL,
  [RtConsolidadoAjusteCessao]      DECIMAL(17,2)    NULL,
  [RtConsolidadoAjusteCessaoBnf]   DECIMAL(17,2)    NULL,
  [RtConsolidadoAjusteBanco]       DECIMAL(17,2)    NULL,
     PRIMARY KEY ( [RtConsolidadoId] ))

CREATE NONCLUSTERED INDEX [URTCONSOLIDADOEC] ON [RtConsolidado] (
      [RtConsolidadoEstCod])