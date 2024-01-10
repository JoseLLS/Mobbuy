CREATE TABLE [VlrPagAna] (
  [VlrPagAnaId]     DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [VlrPagAnaEc]     SMALLINT    NOT NULL,
  [VlrPagAnaAno]    SMALLINT    NOT NULL,
  [VlrPagAnaMes]    SMALLINT    NOT NULL,
  [VlrPagAnaPrd]    VARCHAR(1)    NOT NULL,
  [VlrPagAnaNumLan] DECIMAL(18)    NOT NULL,
  [VlrPagAnaVlr]    DECIMAL(17,2)    NOT NULL,
  [VlrPagAnaBan]    VARCHAR(1)    NULL,
     PRIMARY KEY ( [VlrPagAnaId] ))

CREATE NONCLUSTERED INDEX [UVLRPAGANA] ON [VlrPagAna] (
      [VlrPagAnaEc],
      [VlrPagAnaPrd],
      [VlrPagAnaBan])

CREATE TABLE [VlrPagCon] (
  [VlrPagConId]     DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [VlrPagConEc]     INT    NOT NULL,
  [VlrPagConAno]    SMALLINT    NOT NULL,
  [VlrPagConMes]    SMALLINT    NOT NULL,
  [VlrPagConPrd]    VARCHAR(1)    NOT NULL,
  [VlrPagConVlrLiq] DECIMAL(17,2)    NOT NULL,
  [VlrPagConBan]    VARCHAR(1)    NULL,
     PRIMARY KEY ( [VlrPagConId] ))

CREATE NONCLUSTERED INDEX [UVLRPAGCON] ON [VlrPagCon] (
      [VlrPagConBan])

CREATE NONCLUSTERED INDEX [UVLRPAGCON1] ON [VLRPAGCON] ( 
      [VlrPagConPrd])