/* TAREFA #20982 - JOSÉ */

--Rodar script em todos os clientes que serão atualizados
INSERT INTO PARSIS
VALUES ('TRANSACAO_POS_DATA', 'Limite de intervalo de data para filtragem no relatório', 'NU', 1, NULL, 'N', '3', 'ADMIN', '2023-02-03 09:37:36.000', NULL, NULL, 0)

/* TAREFA #21490 - FELIPE */

ALTER TABLE [POS]
ADD [PosEqBlue] CHAR(1)    NULL

/* TAREFA #21650 - FELIPE */

insert into van07 
(UNG2Cod,VanCod,VanUngWbsUrl,VanUngWbsPor,VanUngWbsTimOut,VanUngWbsUsr,VanUngWbsPwd,VanUngBasUrl,VanUngTkn,VanUngPcbEstCod,VanUngPcbStfIde)
values(24,8,'api.gsurfnet.com',443,120,'6090300e-2c9f-4b5a-92d0-a15c626f72ec','pR6A3vAIPoymlfDiIJsFMxfRgsE2JpHK','/transactions-v2/','NjA5MDMwMGUtMmM5Zi00YjVhLTkyZDAtYTE1YzYyNmY3MmVjOnBSNkEzdkFJUG95bWxmRGlJSnNGTXhmUmdzRTJKcEhL',56,'00000064')

insert into PARSIS
(parcod,ParDsc,ParTipPar,ParTamPar,ParCon)
values
('API_AUT_GSURF','Gerar autenticação token','CA',300,'/gmac-v1/oauth2/')

/* TAREFA #19342 - WESLEY */

ALTER TABLE [EST] ADD [EstFlagExtratoFin] BIT    NULL


CREATE TABLE [ControleSaldoEvento] (
  [ControleSaldoEventoId]   SMALLINT    NOT NULL,
  [ControleSaldoEventoDesc] VARCHAR(40)    NOT NULL,
     PRIMARY KEY ( [ControleSaldoEventoId] ))

INSERT INTO [dbo].[ControleSaldoEvento] ([ControleSaldoEventoId],[ControleSaldoEventoDesc]) VALUES (1, 'Vendas Realizadas') 
INSERT INTO [dbo].[ControleSaldoEvento] ([ControleSaldoEventoId],[ControleSaldoEventoDesc]) VALUES (2, 'Cancelamentos') 
INSERT INTO [dbo].[ControleSaldoEvento] ([ControleSaldoEventoId],[ControleSaldoEventoDesc]) VALUES (3, 'Bancos') 
INSERT INTO [dbo].[ControleSaldoEvento] ([ControleSaldoEventoId],[ControleSaldoEventoDesc]) VALUES (4, 'Antecipações') 
INSERT INTO [dbo].[ControleSaldoEvento] ([ControleSaldoEventoId],[ControleSaldoEventoDesc]) VALUES (5, 'Cessão Realizada') 
INSERT INTO [dbo].[ControleSaldoEvento] ([ControleSaldoEventoId],[ControleSaldoEventoDesc]) VALUES (6, 'Recusa de Banco') 
INSERT INTO [dbo].[ControleSaldoEvento] ([ControleSaldoEventoId],[ControleSaldoEventoDesc]) VALUES (7, 'Lançamento Manual') 
INSERT INTO [dbo].[ControleSaldoEvento] ([ControleSaldoEventoId],[ControleSaldoEventoDesc]) VALUES (8, 'Aluguel POS') 
INSERT INTO [dbo].[ControleSaldoEvento] ([ControleSaldoEventoId],[ControleSaldoEventoDesc]) VALUES (9, 'Prestação de Serviço')
INSERT INTO [dbo].[ControleSaldoEvento] ([ControleSaldoEventoId],[ControleSaldoEventoDesc]) VALUES (10, 'Cessão Recebida') 

CREATE TABLE [ControleSaldo] (
  [ControleSaldoId]               DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [ControleSaldoEstCod]           INT    NOT NULL,
  [ControleSaldoData]             DATETIME    NOT NULL,
  [ControleSaldoEventoId]         SMALLINT    NOT NULL,
  [ControleSaldoReferencia]       VARCHAR(200)    NULL,
  [ControleSaldoValor]            DECIMAL(17,2)    NOT NULL,
  [ControleSaldoAnterior]         DECIMAL(17,2)    NOT NULL,
  [ControleSaldoAtual]            DECIMAL(17,2)    NOT NULL,
  [ControleSaldoDataHoraExecucao] DATETIME    NOT NULL,
     PRIMARY KEY ( [ControleSaldoId] ))
CREATE NONCLUSTERED INDEX [UCONTROLEVENDAEC] ON [ControleSaldo] (
      [ControleSaldoEstCod],
      [ControleSaldoId] DESC)
CREATE NONCLUSTERED INDEX [UCONTROLEVENDAEC1] ON [ControleSaldo] (
      [ControleSaldoEventoId],
      [ControleSaldoReferencia])
ALTER TABLE [ControleSaldo]
 ADD CONSTRAINT [ICONTROLEVENDAEC1] FOREIGN KEY ( [ControleSaldoEventoId] ) REFERENCES [ControleSaldoEvento]([ControleSaldoEventoId])
ALTER TABLE [ControleSaldo]
 ADD CONSTRAINT [ICONTROLEVENDAEC2] FOREIGN KEY ( [ControleSaldoEstCod] ) REFERENCES [EST]([EstCod])
