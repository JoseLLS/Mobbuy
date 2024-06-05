/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.44','2.5.41',GETDATE());

/* TAREFA #24268 - CARLOS */

ALTER TABLE [SolicitacaoCancelamento]
ADD [SolCan_motivo] VARCHAR(MAX)    NOT NULL CONSTRAINT SolCan_motivoSolicitacaoCancelamento_DEFAULT DEFAULT ''

ALTER TABLE [SolicitacaoCancelamento]
DROP CONSTRAINT SolCan_motivoSolicitacaoCancelamento_DEFAULT