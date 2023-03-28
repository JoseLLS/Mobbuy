/* TAREFA #14775 - WESLEY */

USE pronto

INSERT INTO [dbo].[PARSIS]
           ([ParCod]
           ,[ParDsc]
           ,[ParTipPar]
           ,[ParTamPar]
           ,[ParQtdDec]
           ,[ParIndSin]
           ,[ParCon]
           ,[ParUsuInc]
           ,[ParDtiInc]
           ,[ParUsuAlt]
           ,[ParDtiAlt]
           ,[ParFlgInt])
     VALUES
           ('RELATORIO_DIRF' 
           ,'Usar tela DIRF'
           ,'CA'
           ,200
           ,NULL
		   ,'N'
           ,'S'
           ,NULL
           ,NULL
           ,'025ADM                           '
           ,'2022-01-14 17:00:36.000'
           ,0)
GO

select * from Pronto..PARSIS where parcod = 'RELATORIO_DIRF'

/* TAREFA #14430 - WESLEY */

USE PRONTO

ALTER TABLE CESSAO ADD CessaoNFDistribuidora VARCHAR(128) NULL

/* TAREFA #14737 - CARLOS PATRICIO */

/************************************************************************
use SmartPagamentos

INSERT INTO PARSIS VALUES (
'VENDA_REL_SINTETICO',
'Exibe ou Oculta Checkbox Exportar Relatório Sintético na Tela Venda',
'CA',
1,
NULL,
'N',
'S',
'018ADM',
'2022-01-14',
NULL,
NULL,
0)
************************************************************************/
/************************************************************************
use Banese

INSERT INTO PARSIS VALUES (
'VENDA_REL_SINTETICO',
'Exibe ou Oculta Checkbox Exportar Relatório Sintético na Tela Venda',
'CA',
1,
NULL,
'N',
'N',
'018ADM',
'2022-01-14',
NULL,
NULL,
0)
************************************************************************/
/************************************************************************
use Bemfacil

INSERT INTO PARSIS VALUES (
'VENDA_REL_SINTETICO',
'Exibe ou Oculta Checkbox Exportar Relatório Sintético na Tela Venda',
'CA',
1,
NULL,
'N',
'N',
'018ADM',
'2022-01-14',
NULL,
NULL,
0)
************************************************************************/
/************************************************************************
use Credinov

INSERT INTO PARSIS VALUES (
'VENDA_REL_SINTETICO',
'Exibe ou Oculta Checkbox Exportar Relatório Sintético na Tela Venda',
'CA',
1,
NULL,
'N',
'N',
'018ADM',
'2022-01-14',
NULL,
NULL,
0)
************************************************************************/
/************************************************************************
use Credpag

INSERT INTO PARSIS VALUES (
'VENDA_REL_SINTETICO',
'Exibe ou Oculta Checkbox Exportar Relatório Sintético na Tela Venda',
'CA',
1,
NULL,
'N',
'N',
'018ADM',
'2022-01-14',
NULL,
NULL,
0)
************************************************************************/
/************************************************************************
use Pronto

INSERT INTO PARSIS VALUES (
'VENDA_REL_SINTETICO',
'Exibe ou Oculta Checkbox Exportar Relatório Sintético na Tela Venda',
'CA',
1,
NULL,
'N',
'N',
'018ADM',
'2022-01-14',
NULL,
NULL,
0)
************************************************************************/

/* ALTERAÇÃO DA VERSÃO DO BANCO */
USE Banese
USE Bemfacil
USE Credinov
USE Credpag
USE Pronto
USE SmartPagamentos

UPDATE PARSIS
SET ParCon = '2.5.4 - 2.4.4'
WHERE ParCod = 'VERSAO_BANCO'

UPDATE PARSIS
SET ParCon = '18/01/2022'
WHERE ParCod = 'VERSAO_BANCO_DATA'