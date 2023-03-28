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