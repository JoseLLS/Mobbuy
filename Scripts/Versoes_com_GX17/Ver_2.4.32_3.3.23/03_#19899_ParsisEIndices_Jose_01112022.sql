/* TAREFA #19899 - JOSÉ */

--Rodar em todos os clientes (O ParCon do script da Parsis muda conforme o banco do cliente, Pronto: 7399...
INSERT INTO PARSIS
VALUES ('MCC_PS', 'MCC da prestação de serviço da rotina de recalcular taxa', 'VA', 16, NULL, 'N', 
'7399', 'ADMIN', '2022-11-01 00:00:00', NULL, NULL, 0)

CREATE NONCLUSTERED INDEX [UADQ0011] ON [ADQ0011] (
      [AdqMccCod],
      [AdqCod],
      [AdqMccBanCod],
      [AdqMccPrdTipPln],
      [AdqMccPrdQtdPar],
      [AdqMccPrdSts])

CREATE NONCLUSTERED INDEX [UMOVTRN0111] ON [MovTrn01] (
      [MovTrnDta] DESC,
      [MovTrnCod])