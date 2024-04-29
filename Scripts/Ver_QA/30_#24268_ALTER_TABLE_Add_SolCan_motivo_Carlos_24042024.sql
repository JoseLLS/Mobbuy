
ALTER TABLE [SolicitacaoCancelamento]
ADD [SolCan_motivo] VARCHAR(MAX)    NOT NULL CONSTRAINT SolCan_motivoSolicitacaoCancelamento_DEFAULT DEFAULT ''

ALTER TABLE [SolicitacaoCancelamento]
DROP CONSTRAINT SolCan_motivoSolicitacaoCancelamento_DEFAULT