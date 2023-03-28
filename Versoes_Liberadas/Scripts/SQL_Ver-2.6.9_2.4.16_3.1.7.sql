/* TAREFA #17852 - WESLEY */

use pronto

CREATE TABLE [TrnPagSegLoja] (
  [TrnPagSegLojaId]        SMALLINT     NOT NULL     IDENTITY ( 1 , 1 ),
  [TrnPagSegLojaDescricao] VARCHAR(100)     NOT NULL,
  [TrnPagSegLojaToken]     VARCHAR(9)     NOT NULL,
  [TrnPagSegLojaSenha]     VARCHAR(40)     NOT NULL,
      PRIMARY KEY ( [TrnPagSegLojaId] ))

INSERT INTO [TrnPagSegLoja] ([TrnPagSegLojaDescricao], [TrnPagSegLojaToken], [TrnPagSegLojaSenha])
VALUES ('37983316000150 - padrao@semprepronto.com.br', '169735468', '0fb4449881924f7788006c1199d088ad')

INSERT INTO [TrnPagSegLoja] ([TrnPagSegLojaDescricao], [TrnPagSegLojaToken], [TrnPagSegLojaSenha])
VALUES ('37983316000150 - 7399@semprepronto.com.br', '179539641', '0fb4449881924f7788006c1199d088ad')

INSERT INTO [TrnPagSegLoja] ([TrnPagSegLojaDescricao], [TrnPagSegLojaToken], [TrnPagSegLojaSenha])
VALUES ('37983316000150 - 5983@semprepronto.com.br', '179539503', '0fb4449881924f7788006c1199d088ad')

INSERT INTO [TrnPagSegLoja] ([TrnPagSegLojaDescricao], [TrnPagSegLojaToken], [TrnPagSegLojaSenha])
VALUES ('37983316000150 - 5013@semprepronto.com.br', '179539377', '0fb4449881924f7788006c1199d088ad')

INSERT INTO [TrnPagSegLoja] ([TrnPagSegLojaDescricao], [TrnPagSegLojaToken], [TrnPagSegLojaSenha])
VALUES ('37983316000150 - 5533@semprepronto.com.br', '179539271', '0fb4449881924f7788006c1199d088ad')

INSERT INTO [TrnPagSegLoja] ([TrnPagSegLojaDescricao], [TrnPagSegLojaToken], [TrnPagSegLojaSenha])
VALUES ('37983316000150 - 5999@semprepronto.com.br', '179539130', '0fb4449881924f7788006c1199d088ad')

INSERT INTO [TrnPagSegLoja] ([TrnPagSegLojaDescricao], [TrnPagSegLojaToken], [TrnPagSegLojaSenha])
VALUES ('37983316000150 - 5532@semprepronto.com.br', '179538981', '0fb4449881924f7788006c1199d088ad')

ALTER TABLE [TrnPagSeg]
ADD [TrnPagSegLojaId] SMALLINT     NULL

CREATE NONCLUSTERED INDEX [ITRNPAGSEG] ON [TrnPagSeg] (
      [TrnPagSegLojaId])

ALTER TABLE [TrnPagSeg]
 ADD CONSTRAINT [ITRNPAGSEG] FOREIGN KEY ( [TrnPagSegLojaId] ) REFERENCES [TrnPagSegLoja]([TrnPagSegLojaId])

select * from TrnPagSegLoja

/* TAREFA #17966 - JOSÉ */

--Clientes que irão usar o script
USE Banese
USE BemFacil
USE Credinov
USE CredPag
USE Pronto
USE SmartPagamentos

--Rodar primeiro para apagar a view com o código atual (Comentar a linha para conseguir dar um Create após o Drop)
DROP VIEW RelatorioBaseTributacao

--Rodar em seguida para criar a view reescrita
CREATE VIEW RelatorioBaseTributacao AS
SELECT 	
	M.EstCod AS 'RelBaseTribCodigo',
	E.EstAplPsq AS 'RelBaseTribEstabelecimento',
	E.EstSegmento AS 'RelBaseTribSegmentos',
	E.EstNomFan AS 'RelBaseTribNomeFantasia',
	E.EstCpfCnpj AS 'RelBaseTribCNPJ',
	E.EstTip AS 'RelBaseTribEstTipo',
	M.MovTrnDta AS 'RelBaseTribData',
	SUM(MovTrnVlr) AS 'RelBaseTribValorVenda', 	  
	SUM(MovTrnVlrLiqEst) AS 'RelBaseTribValorEstabelecimento',		
	SUM(MovTrnBfaVlrTxaAdm) AS 'RelBaseTribTaxaAdministracao',	
	SUM(MovTrnBfaVlrTxaFin) AS 'RelBaseTribReceitaAntecipacao',
	SUM(MovTrnGbpVlrTxaInt) AS 'RelBaseTribTaxaAdquirente',
	SUM(MovTrnVlr - MovTrnVlrLiqEst - MovTrnGbpVlrTxaInt) AS 'RelBaseTribReceitaLiquida',
	T.TxAntManualVlr AS 'RelBaseTribTaxaAntManual'
FROM MovTrn01 M
	LEFT JOIN EST E ON E.EstCod = M.EstCod
	LEFT JOIN TxAntManualVw T ON M.EstCod = T.TxAntManualEstCod AND M.MovTrnDta = T.TxAntManualData
	WHERE MovTrnCod IN ('CV', 'CC')
	GROUP BY M.EstCod, E.EstNomFan, E.EstAplPsq, E.EstCpfCnpj, E.EstTip, E.EstSegmento, M.MovTrnDta, T.TxAntManualVlr
GO