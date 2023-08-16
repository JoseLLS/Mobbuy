/* TAREFA #18670 - WESLEY */

use MonitorPronto --COLOCAR CLIENTE DO MONITOR

ALTER TABLE [MovimentacaoTransferencia] ADD [MovTransferenciaEstNomFan] NVARCHAR(100)    NULL
GO

--ATUALIZAR MovTransferenciaEstNomFan 
DECLARE
@EstCod    Int,
@EstNomFan VARCHAR(100)

DECLARE C CURSOR FOR
	SELECT EstCod, EstNomFan from Pronto..Est  -- COLOCAR CLIENTE PARA PEGAR O NOME FANTASIA DO EC

OPEN C
FETCH NEXT FROM C INTO @EstCod, @EstNomFan
WHILE @@FETCH_STATUS = 0 

BEGIN

update MovimentacaoTransferencia set MovTransferenciaEstNomFan = @EstNomFan where MovTransferenciaEstCod = @EstCod

FETCH NEXT FROM C INTO @EstCod, @EstNomFan

END
CLOSE C
DEALLOCATE C

/* TAREFA #19031 - WESLEY */

CREATE NONCLUSTERED INDEX [UEST3] ON [EST] ( 
      [EstPacCod])

CREATE NONCLUSTERED INDEX [UMOVTRN016] ON [MOVTRN01] ( 
      [MovTrnPacCod], 
      [EstCod], 
      [MovTrnDta])