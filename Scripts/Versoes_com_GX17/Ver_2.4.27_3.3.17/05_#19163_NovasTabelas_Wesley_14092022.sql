CREATE TABLE [Trn_Processamento] (
  [Trn_ProcessamentoCod]  VARCHAR(6)    NOT NULL,
  [Trn_ProcessamentoDesc] VARCHAR(100)    NOT NULL,
     PRIMARY KEY ( [Trn_ProcessamentoCod] ))

INSERT INTO [dbo].[Trn_Processamento] ([Trn_ProcessamentoCod],[Trn_ProcessamentoDesc]) VALUES ('002000','pagamento com cartão de débito à vista ')
INSERT INTO [dbo].[Trn_Processamento] ([Trn_ProcessamentoCod],[Trn_ProcessamentoDesc]) VALUES ('003000','pagamento com cartão de crédito à vista ')
INSERT INTO [dbo].[Trn_Processamento] ([Trn_ProcessamentoCod],[Trn_ProcessamentoDesc]) VALUES ('003100','pagamento com cartão de crédito à vista ')
INSERT INTO [dbo].[Trn_Processamento] ([Trn_ProcessamentoCod],[Trn_ProcessamentoDesc]) VALUES ('003800','pagamento com cartão de crédito parcelado emissor ')
INSERT INTO [dbo].[Trn_Processamento] ([Trn_ProcessamentoCod],[Trn_ProcessamentoDesc]) VALUES ('003900','pagamento com cartão de crédito transação recorrente ')
INSERT INTO [dbo].[Trn_Processamento] ([Trn_ProcessamentoCod],[Trn_ProcessamentoDesc]) VALUES ('942000','pagamento com cartão Alimentação PAT ')
INSERT INTO [dbo].[Trn_Processamento] ([Trn_ProcessamentoCod],[Trn_ProcessamentoDesc]) VALUES ('952000','pagamento com cartão Refeição PAT ') 
INSERT INTO [dbo].[Trn_Processamento] ([Trn_ProcessamentoCod],[Trn_ProcessamentoDesc]) VALUES ('962000','pagamento com cartão Vouchers Empresariais ')
INSERT INTO [dbo].[Trn_Processamento] ([Trn_ProcessamentoCod],[Trn_ProcessamentoDesc]) VALUES ('972000','pagamento com cartão Auto ') 

-----------------------------------------------------------------------------------------

CREATE TABLE [Trn_Servico] (
  [Trn_ServicoCod]  VARCHAR(4)    NOT NULL,
  [Trn_ServicoDesc] VARCHAR(100)    NOT NULL,
     PRIMARY KEY ( [Trn_ServicoCod] ))

INSERT INTO [dbo].[Trn_Servico] ([Trn_ServicoCod],[Trn_ServicoDesc]) VALUES ('PGCD','pagamento com cartão de débito ') 
INSERT INTO [dbo].[Trn_Servico] ([Trn_ServicoCod],[Trn_ServicoDesc]) VALUES ('PGCC','pagamento com cartão de crédito ') 
INSERT INTO [dbo].[Trn_Servico] ([Trn_ServicoCod],[Trn_ServicoDesc]) VALUES ('PGAL','pagamento com cartão Alimentação PAT ') 
INSERT INTO [dbo].[Trn_Servico] ([Trn_ServicoCod],[Trn_ServicoDesc]) VALUES ('PGRE','pagamento com cartão Refeição PAT ') 
INSERT INTO [dbo].[Trn_Servico] ([Trn_ServicoCod],[Trn_ServicoDesc]) VALUES ('PGVE','pagamento com cartão Vouchers Empresariais ') 
INSERT INTO [dbo].[Trn_Servico] ([Trn_ServicoCod],[Trn_ServicoDesc]) VALUES ('PGAU','pagamento com cartão Auto ') 

-----------------------------------------------------------------------------------------

CREATE TABLE [Trn_Situacao] (
  [Trn_SituacaoCod]  VARCHAR(2)    NOT NULL,
  [Trn_SituacaoDesc] VARCHAR(100)    NOT NULL,
     PRIMARY KEY ( [Trn_SituacaoCod] ))

INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('00','OK por confirmação ')
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('01','OK pela resolução de pendências on-line ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('02','OK por conciliação ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('03','OK pela resolução de pendências na operação seguinte ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('04','OK pela resolução de pendências manual ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('05','Estorno OK ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('10','Pendente ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('13','Pré-autorização ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('20','Não autorizada ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('21','Não autorizada pela rede destino ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('40','Cancelada pela origem ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('41','Cancelada por resolução de pendências on-line ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('42','Cancelada por conciliação ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('43','Cancelada por resolução de pendências na operação seguinte ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('44','Cancelada por resolução de pendências manual ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('50','Estornada') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('51','Estornada por resolução de pendências on-line ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('52','Estornada por conciliação ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('53','Estornada por solicitação posterior ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('54','Estornada por resolução manual ') 
INSERT INTO [dbo].[Trn_Situacao] ([Trn_SituacaoCod],[Trn_SituacaoDesc]) VALUES ('57','Estornada por Reversão PIX ') 