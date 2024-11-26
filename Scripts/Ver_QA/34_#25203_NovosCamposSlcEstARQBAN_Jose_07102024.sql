/* TAREFA #25203 - JOSÉ */

ALTER TABLE [EST]
ADD [EstSlcNuclea] BIT    NULL;

ALTER TABLE [ARQBAN]
ADD [ArbSlcTip] CHAR(2)    NULL;

ALTER TABLE [TblBan]
ADD [TblBanSlcAtivo] CHAR(1)    NULL,
	[TblBanCodArranjo] CHAR(3)    NULL;