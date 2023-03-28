CREATE TABLE [TipoArquivoVero] (
  [TipoArquivoVeroCod]  VARCHAR(20)     NOT NULL,
  [TipoArquivoVeroDesc] VARCHAR(200)     NOT NULL,
  [TipoArquivoVeroTabela] VARCHAR(40)     NULL,
      PRIMARY KEY ( [TipoArquivoVeroCod] ))

INSERT INTO [TipoArquivoVero] ([TipoArquivoVeroCod], [TipoArquivoVeroDesc],[TipoArquivoVeroTabela]) VALUES ('BJRVCA8','ARQUIVO CONCILIACAO ANTECIPACAO','TRN07')
INSERT INTO [TipoArquivoVero] ([TipoArquivoVeroCod], [TipoArquivoVeroDesc],[TipoArquivoVeroTabela]) VALUES ('BJRVCM8','ARQUIVO GERAL DE OPERACOES ACQUIRER','TRN05')
INSERT INTO [TipoArquivoVero] ([TipoArquivoVeroCod], [TipoArquivoVeroDesc],[TipoArquivoVeroTabela]) VALUES ('BJRVCMB','ARQUIVO PREVISAO DE CREDITO ACQUIRER','TRN06')
INSERT INTO [TipoArquivoVero] ([TipoArquivoVeroCod], [TipoArquivoVeroDesc],[TipoArquivoVeroTabela]) VALUES ('BJRVCB1','ARQUIVO DE OPERACOES CANCELADAS','TRN05')
INSERT INTO [TipoArquivoVero] ([TipoArquivoVeroCod], [TipoArquivoVeroDesc],[TipoArquivoVeroTabela]) VALUES ('BKNFIN1','ARQUIVO CONCILIACAO FINANCEIRA - Não processado',null)
INSERT INTO [TipoArquivoVero] ([TipoArquivoVeroCod], [TipoArquivoVeroDesc],[TipoArquivoVeroTabela]) VALUES ('BKNFIN2','ARQUIVO CONCILIACAO FINANCEIRA - Não processado',null)
INSERT INTO [TipoArquivoVero] ([TipoArquivoVeroCod], [TipoArquivoVeroDesc],[TipoArquivoVeroTabela]) VALUES ('BJRVCM9','ARQUIVO PENDENCIAS RESOLVIDAS ACQUIRER - Não processado',null)