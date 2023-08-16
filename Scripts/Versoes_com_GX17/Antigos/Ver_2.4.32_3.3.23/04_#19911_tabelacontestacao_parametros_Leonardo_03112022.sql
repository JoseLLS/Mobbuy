USE PRONTO
GO

CREATE TABLE [Contestacao] (
  [ContestacaoCodigo]    VARCHAR(2)    NOT NULL,
  [ContestacaoDescricao] VARCHAR(255)    NOT NULL,
     PRIMARY KEY ( [ContestacaoCodigo] ))
	 
ALTER TABLE [EfeitoContrato]
ADD [EfeitoContratoDataContestacao] DATETIME    NULL,
    [ContestacaoCodigo] VARCHAR(2)    NULL
CREATE NONCLUSTERED INDEX [IEFEITOCONTRATO2] ON [EfeitoContrato] (
      [ContestacaoCodigo])
ALTER TABLE [EfeitoContrato]
 ADD CONSTRAINT [IEFEITOCONTRATO2] FOREIGN KEY ( [ContestacaoCodigo] ) REFERENCES [Contestacao]([ContestacaoCodigo])



INSERT INTO CONTESTACAO VALUES (
'01', 'Usuário Final Recebedor ou Titular não reconhece a operação'),
('02', 'Duplicidade de lançamento de operação'),
('03', 'Operação em divergência com o instrumento contratual'),
('04', 'Usuário Final Recebedor ou Titular não tem relação com o Financiador ou Não Financeira.'),
('05', 'Divergência entre valor esperado pelo Financiador ou Não Financeira e o valor efetivamente liquidado pela Instituição Credenciadora ou Subcredenciadora devedora da obrigação'),
('99', 'Outros')

INSERT INTO PARSIS (ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES ('CERC_CONST_METODO', 'METODO CONTESTACAO CERC', 'CA', 255, 'N', 'enviar')

INSERT INTO PARSIS (ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES ('CERC_CONST_BASE_URL', 'BASE URL CONTESTACAO CERC', 'CA', 255, 'N', 'contestacao')