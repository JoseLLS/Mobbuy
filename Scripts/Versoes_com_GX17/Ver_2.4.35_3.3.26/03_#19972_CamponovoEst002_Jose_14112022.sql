/* TAREFA #19972 - JOS� */

--Rodar script em todos os clientes atualizados
ALTER TABLE [Est002]
ADD [EstDocExt] CHAR(10)    NOT NULL CONSTRAINT EstDocExtEst002_DEFAULT DEFAULT ''

ALTER TABLE [Est002]
DROP CONSTRAINT EstDocExtEst002_DEFAULT