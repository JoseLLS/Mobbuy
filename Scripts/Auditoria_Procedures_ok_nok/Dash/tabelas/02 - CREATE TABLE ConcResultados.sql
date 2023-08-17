USE PRONTO

CREATE TABLE [ConcResultados] (
  [ConcResultadosSeq]       DECIMAL(12)    NOT NULL    IDENTITY ( 1 , 1 ),
  [ConcResultadosData]      DATETIME    NOT NULL,
  [ConcResultadosVendas]    CHAR(3)    NOT NULL,
  [ConcResultadosMDR]       CHAR(3)    NOT NULL,
  [ConcResultadosAntecip]   CHAR(3)    NOT NULL,
  [ConcResultadosAgenda]    CHAR(3)    NOT NULL,
  [ConcResultadosCessao]    CHAR(3)    NOT NULL,
  [ConcResultadosPrestServ] CHAR(3)    NOT NULL,
  [ConcResultadosPIX]       CHAR(3)    NOT NULL,
  [ConcResultadosCerc]      CHAR(3)    NOT NULL,
  [ConcResultadosAntAdq]    CHAR(3)    NOT NULL,
     PRIMARY KEY ( [ConcResultadosSeq] ))