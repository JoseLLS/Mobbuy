CREATE TABLE [VlpStatusPag] (
  [VlpStatusPagId]   CHAR(20)     NOT NULL,
  [VlpStatusPagDesc] VARCHAR(30)     NOT NULL,
      PRIMARY KEY ( [VlpStatusPagId] ))

/*
EXECUTAR CASO ALGUNS DOS REGISTROS ESTIVEREM FALTANDO

INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (1 , 'Aberto')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (2 , 'Liquidado')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (3 , 'Cancelado')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (4 , 'Cancelado após liquidado')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (5 , 'Em antecipação')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (6 , 'Conciliado')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (7 , 'Em aberto para cessão')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (8 , 'Cessão cancelada')
INSERT INTO VlpStatusPag (VlpStatusPagId,VlpStatusPagDesc) VALUES (9 , 'Cancelamento manual')
*/

select * from VlpStatusPag