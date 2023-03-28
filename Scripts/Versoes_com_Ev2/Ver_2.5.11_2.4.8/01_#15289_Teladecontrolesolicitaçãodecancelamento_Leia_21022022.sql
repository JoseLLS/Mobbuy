

/* TAREFA #15289 - LÉIA */

-- Cria novos campo 
ALTER TABLE [SOLICITACAOCANCELAMENTO] 
ADD [SolCan_TipoSolicitacaoCanc] SMALLINT    NULL, 
    [SolCan_Valor] DECIMAL(17,2)    NULL;

-- Atualiza as informações contidas no banco
update solicitacaoCancelamento
set SolCan_TipoSolicitacaocanc = 1,
	Solcan_Valor               = SolCan_pay_value
where SolCan_TipoSolicitacaocanc is null
and SolCan_pay_value is null;

ALTER TABLE [SOLICITACAOCANCELAMENTO] 
ALTER COLUMN [SolCan_pay_value] DECIMAL(17,2) NULL
