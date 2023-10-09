CREATE TABLE [dbo].[TRN14](
	[TRN14Id] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[TRN14DataTrn] [datetime] NOT NULL,
	[TRN14DataInc] [datetime] NOT NULL,
	[TRN14StatusPrc] [smallint] NOT NULL,
	[TRN14DescPrc] [varchar](60) NOT NULL,
	[TRN14Adq] [varchar](20) NOT NULL,
	[TRN14CdCompany] [varchar](10) NOT NULL,
	[TRN14CdCompanyGrp] [varchar](20) NOT NULL,
	[TRN14AliasName] [varchar](60) NOT NULL,
	[TRN14NameCompany] [varchar](120) NOT NULL,
	[TRN14DocNumber] [varchar](20) NOT NULL,
	[TRN14TrnNumber] [varchar](20) NOT NULL,
	[TRN14DtHrTrans] [varchar](30) NOT NULL,
	[TRN14LocationName] [varchar](60) NOT NULL,
	[TRN14NrTerminal] [varchar](20) NOT NULL,
	[TRN14IdValue] [varchar](40) NOT NULL,
	[TRN14PayValue] [decimal](17, 2) NOT NULL,
	[TRN14PayLiquid] [decimal](17, 2) NOT NULL,
	[TRN14FeeValue] [decimal](17, 2) NOT NULL,
	[TRN14QtnParcel] [smallint] NOT NULL,
	[TRN14NsuCode] [varchar](20) NOT NULL,
	[TRN14NsuHost] [varchar](20) NOT NULL,
	[TRN14OpType] [varchar](40) NOT NULL,
	[TRN14AuthCode] [varchar](20) NOT NULL,
	[TRN14TokenNumber] [varchar](40) NOT NULL,
	[TRN14CardType] [varchar](40) NOT NULL,
	[TRN14NmFlagCard] [varchar](40) NOT NULL,
	[TRN14CardStsTrans] [smallint] NOT NULL,
	[TRN14OrderNumber] [varchar](40) NOT NULL,
	[TRN14ReferenceNumber] [varchar](40) NOT NULL,
	[TRN14Renavam] [varchar](40) NOT NULL,
	[TRN14EmailCustomer] [varchar](40) NOT NULL,
	[MovTrnId] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[TRN14Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TRN14]  WITH CHECK ADD  CONSTRAINT [ITRN20] FOREIGN KEY([MovTrnId])
REFERENCES [dbo].[MovTrn01] ([MovTrnId])
GO

ALTER TABLE [dbo].[TRN14] CHECK CONSTRAINT [ITRN20]
GO