/* TAREFA #21092 - JOSÉ */

--Rodar em todos os clientes que serão atualizados
CREATE NONCLUSTERED INDEX [UMOVTRN0112] ON [MovTrn01] (
      [EstCod],
      [MovTrnCod],
      [MovTrnDta] DESC);