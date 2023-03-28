/* TAREFA #16962 - JOSÉ */

--Clientes que irão utilizar o script
USE Banese
USE BemFacil
USE Credinov
USE CredPag
USE Pronto
USE SmartPagamentos

--Script
ALTER TABLE [SOLICITACAOCANCELAMENTO] 
ADD [SolCan_UsuIncDta] DATETIME    NULL, 
    [SolCan_UsuInc] VARCHAR(40)    NULL