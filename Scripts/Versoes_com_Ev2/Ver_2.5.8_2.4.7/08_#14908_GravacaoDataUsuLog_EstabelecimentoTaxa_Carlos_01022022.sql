/*****TAREFA #14908 - CARLOS PATRICIO - 01/02/2022******/
/*
--Use BancoOrigem
--Use Banese
--Use BemFacil
--Use CredInov
--Use CredPag
--Use Pronto
--Use Smartpagamentos
INSERT INTO TLog0002 VALUES ('TabVen02', 'TabVen02',0)
select top 1 * from TLog0002 ORDER BY TLOGID DESC /*VERIFICAR QUAL TLogID*/
INSERT INTO TLog0003 VALUES (/*Inserir TLogID*/,1,'TavVigDtaIni', 'Nova Vigência')

INSERT INTO TLog0002 VALUES ('TabVen05', 'TabVen05',0)
select top 1 * from TLog0002 ORDER BY TLOGID DESC /*VERIFICAR QUAL TLogID*/
INSERT INTO TLog0003 VALUES (/*Inserir TLogID*/,1,'TavNum', 'Taxas')

INSERT INTO TLog0002 VALUES ('TabVen07', 'TabVen07',0)
select top 1 * from TLog0002 ORDER BY TLOGID DESC /*VERIFICAR QUAL TLogID*/
INSERT INTO TLog0003 VALUES (28,1,'TavComNum', 'Comissões')


/*VERIFICAR SE GRAVOU*/
select top 3 * from TLog0002 ORDER BY TLOGID DESC 
select top 3 * from TLog0003 ORDER BY TLOGID DESC
*/