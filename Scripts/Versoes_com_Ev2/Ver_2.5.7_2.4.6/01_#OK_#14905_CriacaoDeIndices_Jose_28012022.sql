/* TAREFA #14905 - JOSÉ */

--Clientes que o script precisa ser rodado
USE Banese
USE Bemfacil
USE Credinov
USE Credpag
USE Pronto
USE SmartPagamentos

--Adição de índices nas tabelas para melhor navegação
CREATE NONCLUSTERED INDEX [USOLICITACAOCANCELAMENTO] ON [SolicitacaoCancelamento] (
      [SolCan_DtaCancelTrans] DESC)

CREATE NONCLUSTERED INDEX [UVAN041] ON [VAN04] (
      [VanTrnDta],
      [VanTrnNumAtz],
      [VanTrnPosIde])