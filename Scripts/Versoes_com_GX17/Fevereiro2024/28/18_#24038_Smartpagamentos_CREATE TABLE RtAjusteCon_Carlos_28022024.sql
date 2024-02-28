USE SmartPagamentos
CREATE TABLE [RtAjusteCon] (
  [RtAjusteConId]      DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [RtAjusteConEstCod]  INT    NULL,
  [RtAjusteConNsu]     DECIMAL(18)    NULL,
  [RtAjusteConAutCod]  VARCHAR(20)    NULL,
  [RtAjusteConTrnCod]  VARCHAR(10)    NULL,
  [RtAjusteConValor]   DECIMAL(17,2)    NULL,
  [RtAjusteConData]    DATETIME    NULL,
  [RtAjusteConBan]     VARCHAR(1)    NULL,
  [RtAjusteConPrd]     VARCHAR(1)    NULL,
  [RtAjusteConDataInc] DATETIME    NULL,
  [RtAjusteConGuid]    VARCHAR(255)    NULL,
  [RtAjusteConUsrId]   VARCHAR(255)    NULL,
     PRIMARY KEY ( [RtAjusteConId] ))