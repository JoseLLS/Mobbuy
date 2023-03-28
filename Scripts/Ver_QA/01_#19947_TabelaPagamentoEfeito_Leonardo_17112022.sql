

CREATE TABLE [dbo].[PagamentoEfeito](
	[PagamentoEfeitoEstCod] [int] NOT NULL,
	[PagamentoEfeitoBeneficiario] [varchar](15) NULL,
	[PagamentoEfeitoNrConta] [varchar](20) NULL,
	[PagamentoEfeitoDigConta] [varchar](1) NULL,
	[PagamentoEfeitoAgencia] [varchar](20) NULL,
	[PagamentoEfeitoISPB] [varchar](20) NULL,
	[PagamentoEfeitoCompe] [varchar](20) NULL,
	[PagamentoEfeitoDataAlt] DATETIME    NULL,
    [PagamentoEfeitoDataInc] DATETIME    NULL
PRIMARY KEY CLUSTERED 
(
	[PagamentoEfeitoEstCod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [EST]
ADD [EstBcoEfeito] INT NULL

INSERT INTO PARSIS (ParCod, ParCon, ParDsc, ParTipPar, ParTamPar)
VALUES 
('BANCO_V2', 'S', 'ROTINA EFEITO CONTRATO V2', 'CA', 255)


/*RODAR APENAS PARA BANESE*/
USE BANESE
GO

ALTER TABLE [PagamentoEfeito]
ADD [PagamentoEfeitoDataAlt] DATETIME    NULL,
    [PagamentoEfeitoDataInc] DATETIME    NULL