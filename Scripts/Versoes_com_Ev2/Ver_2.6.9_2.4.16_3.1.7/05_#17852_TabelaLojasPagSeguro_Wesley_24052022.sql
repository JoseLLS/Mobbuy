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