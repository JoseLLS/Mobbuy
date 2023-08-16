/*CRIA A TABELA HierarquiaComercial*/

CREATE TABLE [HierarquiaComercial] (
  [HierarquiaComercialId]     DECIMAL(10)    NOT NULL,
  [PacCod]                    DECIMAL(6)     NOT NULL,
  [HierarquiaTipoId]          DECIMAL(10)    NOT NULL,
  [HierarquiaPai]             DECIMAL(10)    NOT NULL,
  [HierarquiaComercialStatus] BIT    NOT NULL,
     PRIMARY KEY ( [HierarquiaComercialId] ))
CREATE NONCLUSTERED INDEX [IHIERARQUIACOMERCIAL1] ON [HierarquiaComercial] (
      [HierarquiaTipoId])