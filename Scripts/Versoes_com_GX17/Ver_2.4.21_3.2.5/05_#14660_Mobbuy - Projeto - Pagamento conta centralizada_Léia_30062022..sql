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