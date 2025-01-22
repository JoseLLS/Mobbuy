use pronto

ALTER TABLE [SolicitacaoCancelamento]
ADD [SolCan_CancelManual] BIT    NOT NULL CONSTRAINT SolCan_CancelManualSolicitacaoCancelamento_DEFAULT DEFAULT Convert(BIT,0)

ALTER TABLE [SolicitacaoCancelamento]
DROP CONSTRAINT SolCan_CancelManualSolicitacaoCancelamento_DEFAULT
