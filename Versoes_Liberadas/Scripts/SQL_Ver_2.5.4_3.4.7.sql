/* TAREFA #20559 - LEONARDO */

INSERT INTO PARSIS 
(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES
('HORA_REDECAP', 'TRATAMENTO HORARIO JSON REDECAPTURA (SEGUNDOS)', 'CA', 80, 'N', '3600')

/* TAREFA #20579 - JOSÉ */

--Rodar em todos os clientes que será atualizada a versão
ALTER TABLE [SolicitacaoCancelamento]
ADD [SolCan_adquirente] VARCHAR(40)    NULL