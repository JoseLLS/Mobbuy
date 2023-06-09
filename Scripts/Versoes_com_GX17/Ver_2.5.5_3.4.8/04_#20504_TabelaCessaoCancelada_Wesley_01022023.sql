CREATE TABLE [CessaoCanceladaMotivo] (
  [CessaoCanceladaMotivoId]   DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [CessaoCanceladaMotivoDesc] VARCHAR(200)    NOT NULL,
     PRIMARY KEY ( [CessaoCanceladaMotivoId] ))
	 
SET IDENTITY_INSERT [dbo].[CessaoCanceladaMotivo] ON 
INSERT [dbo].[CessaoCanceladaMotivo] ([CessaoCanceladaMotivoId], [CessaoCanceladaMotivoDesc]) VALUES (CAST(1 AS Decimal(18, 0)), N'Motivo teste 1')
INSERT [dbo].[CessaoCanceladaMotivo] ([CessaoCanceladaMotivoId], [CessaoCanceladaMotivoDesc]) VALUES (CAST(2 AS Decimal(18, 0)), N'API cancelamento cess�o PENDENTE')
INSERT [dbo].[CessaoCanceladaMotivo] ([CessaoCanceladaMotivoId], [CessaoCanceladaMotivoDesc]) VALUES (CAST(3 AS Decimal(18, 0)), N'JOB cancelamento data expirada')
INSERT [dbo].[CessaoCanceladaMotivo] ([CessaoCanceladaMotivoId], [CessaoCanceladaMotivoDesc]) VALUES (CAST(4 AS Decimal(18, 0)), N'API cancelamento cess�o PAGA')
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