--USE BANESE
--USE BEMFACIL
--USE CREDINOV
--USE CREDPAG
--USE PRONTO
--USE SMARTPAGAMENTOS
--USE CredPagLeia

CREATE TABLE [CodigoRetornoTransacoes] (
  [CodigoRetornoTransacoesCod] VARCHAR(32)     NOT NULL,
  [CodigoRetornoTransacoesDsc] VARCHAR(500)     NOT NULL,
      PRIMARY KEY ( [CodigoRetornoTransacoesCod] ))