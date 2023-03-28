CREATE TABLE [Trn05_SitProc] (
  [Trn05_SitProcId]   CHAR(20)     NOT NULL,
  [Trn05_SitProcDesc] VARCHAR(200)     NOT NULL,
      PRIMARY KEY ( [Trn05_SitProcId] ))

Insert into Trn05_SitProc (Trn05_SitProcId, Trn05_SitProcDesc) Values (0,  'Pendente')
Insert into Trn05_SitProc (Trn05_SitProcId, Trn05_SitProcDesc) Values (10, 'Erro na validação (Movimento não encontrado)')
Insert into Trn05_SitProc (Trn05_SitProcId, Trn05_SitProcDesc) Values (20, 'Processado')
Insert into Trn05_SitProc (Trn05_SitProcId, Trn05_SitProcDesc) Values (30, 'Desprezado')

CREATE TABLE [Trn05_SitProcErro] (
  [Trn05_SitProcErroId]   CHAR(20)     NOT NULL,
  [Trn05_SitProcErroDesc] VARCHAR(200)     NOT NULL,
      PRIMARY KEY ( [Trn05_SitProcErroId] ))

Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (0,  'Processamento ok')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (1,  'Operação não encontrada (TrnBrsOprCodPrc diferente de 002000, 003000, 003100, 003800, 962000)')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (2,  'Bandeira não encontrada (TrnBrsOprBan diferente de 002, 003, 004, 006, 010)')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (3,  'Situação marcada como Pendente ou Pré Autorização (TrnBrsRdeSit marcada como 10 ou 13)')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (4,  'Situação marcada cancelamento (TrnBrsRdeSit marcada como 20, 21, 40, 41, 43, ou 44)')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (5,  'Situação não encontrada (TrnBrsOprCodPrc diferente de 00, 01, 03, 04, 10, 13, 20, 21, 40, 41, 43, 44, 50, 54)')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (6,  'Movimento não cancelado (MovTrnIdCan marcada como null, '' pu 0')
Insert into Trn05_SitProcErro (Trn05_SitProcErroId, Trn05_SitProcErroDesc) Values (7,  'Movimento não encontrado na MovTrn01')