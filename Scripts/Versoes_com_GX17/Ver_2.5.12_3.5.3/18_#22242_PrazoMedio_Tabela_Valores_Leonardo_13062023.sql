CREATE TABLE [PrazoMedio] (
  [PrazoMedioId]      SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [PrazoMedioParcela] SMALLINT    NOT NULL,
  [PrazoMedioValor]   DECIMAL(10)    NOT NULL,
     PRIMARY KEY ( [PrazoMedioId] ))

INSERT INTO PrazoMedio (PrazoMedioValor, PrazoMedioParcela) VALUES
(1 ,   0	),
(30,   1	),
(45,   2	),
(60,   3	),
(75,   4	),
(90,   5	),
(105,  6	),
(120,  7	),
(135,  8	),
(150,  9	),
(165,  10	),
(180,  11	),
(195,  12	),
(210,  13	),
(225,  14	),
(240,  15	),
(255,  16	),
(270,  17	),
(285,  18	),
(300,  19	),
(315,  20	),
(330,  21	),
(345,  22	),
(360,  23	),
(375,  24   )