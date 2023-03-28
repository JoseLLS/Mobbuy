/* TAREFA #20504 - WESLEY */

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('CessaoCancMotGrid', 'CessaoCancMotGrid', 'Motivo Cancelamento Cessão', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'CessaoCancMotGrid', '', 103, 'TAB_GER', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'CessaoCancMotGrid')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'CessaoCancMotGrid')

-----------------------------------------------------------------------------------------------------------------------

CREATE TABLE [CessaoCanceladaMotivo] (
  [CessaoCanceladaMotivoId]   DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [CessaoCanceladaMotivoDesc] VARCHAR(200)    NOT NULL,
     PRIMARY KEY ( [CessaoCanceladaMotivoId] ))
	 
SET IDENTITY_INSERT [dbo].[CessaoCanceladaMotivo] ON 
INSERT [dbo].[CessaoCanceladaMotivo] ([CessaoCanceladaMotivoId], [CessaoCanceladaMotivoDesc]) VALUES (CAST(1 AS Decimal(18, 0)), N'Motivo teste 1')
INSERT [dbo].[CessaoCanceladaMotivo] ([CessaoCanceladaMotivoId], [CessaoCanceladaMotivoDesc]) VALUES (CAST(2 AS Decimal(18, 0)), N'API cancelamento cessão PENDENTE')
INSERT [dbo].[CessaoCanceladaMotivo] ([CessaoCanceladaMotivoId], [CessaoCanceladaMotivoDesc]) VALUES (CAST(3 AS Decimal(18, 0)), N'JOB cancelamento data expirada')
INSERT [dbo].[CessaoCanceladaMotivo] ([CessaoCanceladaMotivoId], [CessaoCanceladaMotivoDesc]) VALUES (CAST(4 AS Decimal(18, 0)), N'API cancelamento cessão PAGA')
SET IDENTITY_INSERT [dbo].[CessaoCanceladaMotivo] OFF
GO
-----------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [CessaoCancelada] (
  [CessaoCanceladaId]       DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [CessaoCanceladaCessaoId] DECIMAL(10)    NOT NULL,
  [CessaoCanceladaMotivoId] DECIMAL(18)    NOT NULL,
  [CessaoCanceladaOrigem]   VARCHAR(20)   NOT NULL,
  [CessaoCanceladaUsuario]  VARCHAR(20)   NULL,
  [CessaoCanceladaDataHora] DATETIME    NOT NULL,
     PRIMARY KEY ( [CessaoCanceladaId] ))
CREATE NONCLUSTERED INDEX [ICESSAOCANCELADA1] ON [CessaoCancelada] (
      [CessaoCanceladaCessaoId])
CREATE NONCLUSTERED INDEX [ICESSAOCANCELADA2] ON [CessaoCancelada] (
      [CessaoCanceladaMotivoId])
ALTER TABLE [CessaoCancelada]
 ADD CONSTRAINT [ICESSAOCANCELADA2] FOREIGN KEY ( [CessaoCanceladaMotivoId] ) REFERENCES [CessaoCanceladaMotivo]([CessaoCanceladaMotivoId])
ALTER TABLE [CessaoCancelada]
 ADD CONSTRAINT [ICESSAOCANCELADA1] FOREIGN KEY ( [CessaoCanceladaCessaoId] ) REFERENCES [Cessao]([CessaoId])