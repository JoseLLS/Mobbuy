/* TAREFA #17808 - JOSÉ */

--Script para ser executado no banco Monitor

CREATE TABLE [TipoReferencia] (
  [TipoReferenciaId]        INT    NOT NULL,
  [TipoReferenciaDescricao] NVARCHAR(80)    NULL,
     PRIMARY KEY ( [TipoReferenciaId] ))
	 
CREATE TABLE [MovimentacaoTransferencia] (
  [MovTransferenciaId]     INT    NOT NULL    IDENTITY ( 1 , 1 ),
  [MovTransferenciaEstCod] INT    NULL,
  [MovTransferenciaAno]    NCHAR(4)    NULL,
  [MovTransferenciaMes]    NCHAR(2)    NULL,
  [MovTransferenciaValor]  MONEY    NULL,
  [TipoReferenciaId]       INT    NULL,
     PRIMARY KEY ( [MovTransferenciaId] ))
CREATE NONCLUSTERED INDEX [IMOVIMENTACAOTRANSFERENCIA1] ON [MovimentacaoTransferencia] (
      [TipoReferenciaId])
ALTER TABLE [MovimentacaoTransferencia]
 ADD CONSTRAINT [IMOVIMENTACAOTRANSFERENCIA1] FOREIGN KEY ( [TipoReferenciaId] ) REFERENCES [TipoReferencia]([TipoReferenciaId])
 
INSERT INTO TipoReferencia
VALUES (1, 'Venda Média por Dia')

INSERT INTO TipoReferencia
VALUES (2, 'Ticket Médio')

INSERT INTO TipoReferencia
VALUES (3, 'Quantidade de Transações por Dia')

/* TAREFA #17816 - JOSÉ */

--Bancos para ser executado o script
USE Pronto

INSERT INTO PARSIS
VALUES ('MNT_MOV_TRANSF', 'Url da API prMovTransferenciaInsere do Monitor', 'VA', 80, NULL, 'N', 
'https://app.semprepronto.com.br/MonitoramentoPronto/rest/prMovTransferenciaInsere', 'ADMIN', '2022-05-24 00:00:00', NULL, NULL, 0)

/* TAREFA #14585 - JOSÉ */

USE Pronto

--Parâmetro para chamar a API do Monitor
INSERT INTO PARSIS
VALUES ('MNT_TRN_N_CONF', 'Url da API prTrnNaoConfirmadasIns do Monitor', 'VA', 80, NULL, 'N', 
'https://app.semprepronto.com.br/MonitoramentoPronto/rest/prTrnNaoConfirmadasIns', 'ADMIN', '2022-06-10 00:00:00', NULL, NULL, 0)

USE MonitorPronto

--Tabela nova de transações não confirmadas e índices do Monitor
CREATE TABLE [TrnNaoConf] (
  [TrnNaoConfId]              DECIMAL(10)    NOT NULL    IDENTITY ( 1 , 1 ),
  [TrnNaoConfData]            DATETIME    NULL,
  [TrnNaoConfHora]            NVARCHAR(10)    NULL,
  [TrnNaoConfAdquirente]      NVARCHAR(40)    NULL,
  [TrnNaoConfVan]             SMALLINT    NULL,
  [TrnNaoConfStatus]          NVARCHAR(40)    NULL,
  [TrnNaoConfCodRetTrn]       NVARCHAR(80)    NULL,
  [TrnNaoConfTipo]            NVARCHAR(40)    NULL,
  [TrnNaoConfIdTerminal]      NVARCHAR(40)    NULL,
  [TrnNaoConfEstabelecimento] NVARCHAR(80)    NULL,
  [TrnNaoConfAutorizacao]     NVARCHAR(40)    NULL,
  [TrnNaoConfNsu]             NVARCHAR(40)    NULL,
  [TrnNaoConfNroSerie]        NVARCHAR(40)    NULL,
  [TrnNaoConfValor]           DECIMAL(17,2)    NULL,
     PRIMARY KEY ( [TrnNaoConfId] ))
	 
CREATE NONCLUSTERED INDEX [UTRNNAOCONF] ON [TrnNaoConf] (
      [TrnNaoConfData],
      [TrnNaoConfHora],
      [TrnNaoConfIdTerminal],
      [TrnNaoConfAutorizacao],
      [TrnNaoConfNsu])

/* TAREFA #14660 - Léia */

INSERT INTO PARSIS
VALUES ('wsmbps_empresa_Mobbuy', 'Código genérico utilizado pela Empresa Na MobBuy.', 'CA', 1, NULL, 'N', '1002', NULL, NULL, 'ADMIN', 
'2022-06-24 14:46:00.000', 0)


-- Criação da tabela [ContaSICOOB]
CREATE TABLE [dbo].[ContaSICOOB](
	[ContaSICOOBCodCompany] [decimal](10, 0) NOT NULL,
	[ContaSICOOBNumeroConta] [varchar](40) NOT NULL,
	[ContaSICOOBSaldoAtual] [decimal](17, 2) NULL,
	[ContaSICOOBVlAprovacaoDeposito] [decimal](17, 2) NULL,
	[ContaSICOOBDataAtualizacao] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ContaSICOOBCodCompany] ASC,
	[ContaSICOOBNumeroConta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- Criação da tabela [ContaSICOOBLancamentos]
CREATE TABLE [dbo].[ContaSICOOBLancamentos](
	[ContaSICOOBLanCodCompany] [decimal](10, 0) NOT NULL,
	[ContaSICOOBLanNumeroConta] [varchar](40) NOT NULL,
	[ContaSICOOBLanCodCompanyMovto] [decimal](10, 0) NOT NULL,
	[ContaSICOOBLancamentoData] [datetime] NOT NULL,
	[ContaSICOOBLancamentosValor] [decimal](17, 2) NULL,
	[ContaSICOOBLanTarifaComissao] [smallmoney] NULL,
	[ContaSICOOBLancamentosTipo] [char](1) NULL,
	[ContaSICOOBLancamentosSaldo] [decimal](17, 2) NULL,
	[ContaSICOOBLancamentosNumNSU] [varchar](40) NULL,
	[ContaSICOOBLanNumAutenticacao] [varchar](40) NULL,
	[ContaSICOOBLanNumCupom] [varchar](40) NULL,
	[ContaSICOOBLanCodigoBarras] [varchar](100) NULL,
	[ContaSICOOBLanTextoRecibo] [varchar](max) NULL,
	[ContaSICOOBLanEstCod] INT    NULL,
PRIMARY KEY CLUSTERED 
(
	[ContaSICOOBLanCodCompany] ASC,
	[ContaSICOOBLanNumeroConta] ASC,
	[ContaSICOOBLanCodCompanyMovto] ASC,
	[ContaSICOOBLancamentoData] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[ContaSICOOBLancamentos]  WITH CHECK ADD  CONSTRAINT [ICONTASICOOBLANCAMENTOS1] FOREIGN KEY([ContaSICOOBLanCodCompany], [ContaSICOOBLanNumeroConta])
REFERENCES [dbo].[ContaSICOOB] ([ContaSICOOBCodCompany], [ContaSICOOBNumeroConta])
GO

ALTER TABLE [dbo].[ContaSICOOBLancamentos] CHECK CONSTRAINT [ICONTASICOOBLANCAMENTOS1]
GO
	 
	 
-- 	Criação da tabela  ContaSICOOBFechamento
CREATE TABLE [dbo].[ContaSICOOBFechamento](
	[ContaSICOOBFechamentoCodCompany] [decimal](10, 0) NOT NULL,
	[ContaSICOOBFechamentoNumeroConta] [varchar](40) NOT NULL,
	[ContaSICOOBFechamentoData] [datetime] NOT NULL,
	[ContaSICOOBFechamentoSaldo] [decimal](17, 2) NULL,
	[ContaSICOOBFecSaldoComissao] [decimal](17, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ContaSICOOBFechamentoCodCompany] ASC,
	[ContaSICOOBFechamentoNumeroConta] ASC,
	[ContaSICOOBFechamentoData] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ContaSICOOBFechamento]  WITH CHECK ADD  CONSTRAINT [ICONTASICOOBFECHAMENTO1] FOREIGN KEY([ContaSICOOBFechamentoCodCompany], [ContaSICOOBFechamentoNumeroConta])
REFERENCES [dbo].[ContaSICOOB] ([ContaSICOOBCodCompany], [ContaSICOOBNumeroConta])
GO

ALTER TABLE [dbo].[ContaSICOOBFechamento] CHECK CONSTRAINT [ICONTASICOOBFECHAMENTO1]
GO

-- Insere Menu novo

--Rodar primeiro
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('WPCONTASICOOB', 'WPCONTASICOOB', 'Consulta Extrato da Conta Parceiro', '', '', 0, 1, '')

SELECT * FROM sse2_mnu02 where MnuiteIde = 'HTRN08PS_GRID' ORDER BY MnuIteIdRoot, MnuIteOrd
 --SELECT para ver a ordenação (MnuIteOrd) que a tela vai ficar no menu no INSERT abaixo
--A ordenação é em ordem crescente

--Rodar segundo
INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'WPCONTASICOOB', '', 41, 'REDE_CAP', '', '/credpag/servlet/') --Alterar "/cliente/servlet/"

--Rodar terceiro
INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (24, 'WPCONTASICOOB') --Dar o SELECT de baixo na sse2_ung e pegar o UNG2Cod e alterar conforme o valor de cada cliente

SELECT * FROM sse2_ung

--Rodar quarto
INSERT INTO sse2_grp_mod
VALUES (24, 'ADM', 'WPCONTASICOOB') --Dar o SELECT de cima na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente

/* TAREFA #14703 - CARLOS */

--use Banese
--use BemFacil
--use Smartpagamentos
--use CredInov
--use CredPag
--use Pronto
--use ThePay
INSERT INTO PARSIS VALUES ('BOTAO_TAXA_COMISSOES','Exibe ou oculta botão Comissões na tela de Tabela de Planos','CA',1,NULL,'N','N','018ADM','2022-07-07',NULL,NULL,0)

/* TAREFA #18418 - JOSÉ */

--Rodar em todos os bancos, inclusive os novos (Thepay...)
ALTER TABLE [SolicitacaoCancelamento]
ADD [SolCan_Origem] CHAR(20)    NULL