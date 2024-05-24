/************ IMPORTANTE: RODAR UMA INSTRUÇÃO DE CADA VEZ ************/

ALTER TABLE [SOLICITACAOCANCELAMENTO] 
ADD [SolCan_motivo_solicitacao] VARCHAR(MAX)    NULL

update SOLICITACAOCANCELAMENTO set SolCan_motivo_solicitacao = 'Não informado' 

ALTER TABLE [SOLICITACAOCANCELAMENTO] 
ADD [SolCan_motivo_recusa] VARCHAR(MAX)    NULL

update [SOLICITACAOCANCELAMENTO] set SolCan_motivo_recusa = SolCan_motivo

ALTER TABLE [SOLICITACAOCANCELAMENTO] 
DROP COLUMN [SolCan_motivo]