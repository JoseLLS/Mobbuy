/* SEM TAREFA - JOSÉ */

--Rodar em todos os clientes que será atualizado o sistema
CREATE NONCLUSTERED INDEX [UVLRPAG12] ON [VLRPAG] ( 
      [EstCod], 
      [VlpBnfCod], 
      [VlpNumLanOri]);
	  
CREATE NONCLUSTERED INDEX [UVLRPAG13] ON [VLRPAG] ( 
      [VlpDtaVct] DESC,
	  [EstCod],
      [VlpBnfCod], 
      [VlpAnpNum], 
      [VlpStspag], 
      [VlpNumLanCan], 
      [VlpNumLanOri]);