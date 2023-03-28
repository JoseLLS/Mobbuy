/* TAREFA #18510 - JOSÉ */

--Rodar em todos os bancos
CREATE NONCLUSTERED INDEX [UARQDET6] ON [ARQDET] (
      [ArbDetDtaCre] DESC,
      [ArbDetEstCod],
      [ArbDetCodSit])
	  
CREATE NONCLUSTERED INDEX [UCESSAO7] ON [Cessao] (
      [CessaoDtaLiq] DESC,
      [CessaoEstCodBen],
      [CessaoStatusId])