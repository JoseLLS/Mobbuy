/* TAREFA  #14671 - CARLOS PATRICIO */
use BancoOrigem
use Banese
use BemFacil
use CredInov
use Credpag
use Pronto
use SmartPagamentos


CREATE TABLE [LogUpdArq] (
  [LogUpdArqNum]    INT IDENTITY (1,1)  NOT NULL,
  [LogUpdArqNomArq] CHAR(60)			NOT NULL,
  [LogUpdArqDtaInc] DATETIME			NOT NULL,
  [LogUpdArqIdUsu]  CHAR(20)			NOT NULL,
  [LogUpdArqNomUsu] VARCHAR(50)			NOT NULL,
  [LogUpdArqStsGrv] CHAR(20)			NOT NULL,
  [LogUpdArqMsgErr] CHAR(60)			NULL,
      PRIMARY KEY ( [LogUpdArqNum] ))

/********* TAREFA #14765 - CARLOS PATRICIO - 12/01/2022 ************************/
/********************************************************************************
Use Banese
insert into PARSIS values (
'DIRF_ASSINATURA',
'Imagem da assinatura do responsável por assinar a DIRF',
'IM',
NULL,
NULL,
'N',
'/opt/apache-tomcat-7.0.109/webapps/banese/static/Resources/AssinaturaDirf/assinaturaBanese.jpeg',
'012ADM',
'2022-01-12',
NULL,
NULL,
0)
***********************************************************************************/
/********************************************************************************
Use BemFacil
insert into PARSIS values (
'DIRF_ASSINATURA',
'Imagem da assinatura do responsável por assinar a DIRF',
'IM',
NULL,
NULL,
'N',
'/opt/apache-tomcat-7.0.109/webapps/bemfacil/static/Resources/AssinaturaDirf/assinaturaBemfacil.jpeg',
'006ADM',
'2022-01-12',
NULL,
NULL,
0)
***********************************************************************************/
/********************************************************************************
Use Credinov
insert into PARSIS values (
'DIRF_ASSINATURA',
'Imagem da assinatura do responsável por assinar a DIRF',
'IM',
NULL,
NULL,
'N',
'/opt/apache-tomcat-7.0.109/webapps/credinov/static/Resources/AssinaturaDirf/assinaturaCredinov.jpeg',
'026ADM',
'2022-01-12',
NULL,
NULL,
0)
***********************************************************************************/
/********************************************************************************
Use CredPag
insert into PARSIS values (
'DIRF_ASSINATURA',
'Imagem da assinatura do responsável por assinar a DIRF',
'IM',
NULL,
NULL,
'N',
'/opt/apache-tomcat-7.0.109/webapps/credpag/static/Resources/AssinaturaDirf/assinaturaCredpag.jpeg',
'024ADM',
'2022-01-12',
NULL,
NULL,
0)
***********************************************************************************/
/********************************************************************************
Use Pronto
insert into PARSIS values (
'DIRF_ASSINATURA',
'Imagem da assinatura do responsável por assinar a DIRF',
'IM',
NULL,
NULL,
'N',
'/opt/apache-tomcat-7.0.109/webapps/pronto/static/Resources/AssinaturaDirf/assinaturaPronto.jpeg',
'025ADM',
'2022-01-12',
NULL,
NULL,
0)
***********************************************************************************/
/********************************************************************************
Use SmartPagamentos
insert into PARSIS values (
'DIRF_ASSINATURA',
'Imagem da assinatura do responsável por assinar a DIRF',
'IM',
NULL,
NULL,
'N',
'/opt/apache-tomcat-7.0.109/webapps/smartpagamentos/static/Resources/AssinaturaDirf/assinaturaSmartpagamentos.jpeg',
'018ADM',
'2022-01-12',
NULL,
NULL,
0)
***********************************************************************************/

/* TAREFA #14658 - JOSÉ LUIZ */
USE Banese
USE Bemfacil
USE Credinov
USE Credpag
USE Pronto
USE SmartPagamentos

CREATE TABLE [SolicitacaoCancelamento] (
  [SolCan_Id]                  DECIMAL(10)     NOT NULL     IDENTITY ( 1 , 1 ),
  [SolCan_cd_company]          DECIMAL(12)     NULL,
  [SolCan_dt_hr_cancel_trans]  VARCHAR(40)     NULL,
  [SolCan_alias_name]          VARCHAR(80)     NULL,
  [SolCan_name_company]        VARCHAR(80)     NULL,
  [SolCan_docum_number]        VARCHAR(40)     NULL,
  [SolCan_transaction_number]  DECIMAL(10)     NULL,
  [SolCan_nrTerminal]          VARCHAR(40)     NULL,
  [SolCan_pay_value]           MONEY     NULL,
  [SolCan_quantity_parcel]     SMALLINT     NULL,
  [SolCan_nsu_code]            VARCHAR(40)     NULL,
  [SolCan_authentication_code] VARCHAR(40)     NULL,
  [SolCan_token_number]        VARCHAR(40)     NULL,
  [SolCan_number_trunc_card]   VARCHAR(40)     NULL,
  [SolCan_nm_flag_card]        VARCHAR(40)     NULL,
  [SolCan_dt_hr_trans]         VARCHAR(40)     NULL,
  [EstCod]                     INT     NULL,
  [SolCan_Status]              VARCHAR(40)     NULL,
  [SolCan_UsuAlt]              VARCHAR(40)     NULL,
  [SolCan_UsuAltDta]           DATETIME     NULL,
  [SolCan_DtaTrans]            DATETIME     NULL,
  [SolCan_DtaCancelTrans]      DATETIME     NULL,
      PRIMARY KEY ( [SolCan_Id] ))

CREATE NONCLUSTERED INDEX [ISOLICITACAOCANCELAMENTO1] ON [SolicitacaoCancelamento] (
      [EstCod])

ALTER TABLE [SolicitacaoCancelamento]
 ADD CONSTRAINT [ISOLICITACAOCANCELAMENTO1] FOREIGN KEY ( [EstCod] ) REFERENCES [EST]([EstCod])

 /* SEGUNDO SCRIPT */
 USE Pronto

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('SolCancelMaq_Grid', 'SolCancelMaq_Grid', 'Solicitação de Cancelamento', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'SolCancelMaq_Grid', '', 41, 'REDE_CAP', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'SolCancelMaq_Grid')

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'SolCancelMaq_Grid')

/* TAREFA #14705 - JOSÉ LUIZ */

--Deletar parâmetro que não será mais utilizado
DELETE FROM PARSIS
WHERE ParCod = 'APIGATEWAY_LOGIN'

--Adicionar parâmetro de usuário da API de Gateway
INSERT INTO PARSIS
VALUES ('APIGATEWAY_USER', 'Usuário da API de Gateway', 'VA', 40, NULL, 'N', 'bruno.crocco', 'ADMIN', '2022-01-05 12:04:05.000', NULL, NULL, 0)

--Adicionar parâmetro de senha da API de Gateway
INSERT INTO PARSIS
VALUES ('APIGATEWAY_PASSWORD', 'Senha da API de Gateway', 'VA', 40, NULL, 'N', 'Bemfacil@321', 'ADMIN', '2022-01-05 12:04:05.000', NULL, NULL, 0)

/* TAREFA #14561 - WESLEY */

ALTER TABLE USUEST ADD  [UEstCodGru] INT NULL

/* TAREFA #14637 - WESLEY */

ALTER TABLE [BANCO] ADD [BanPesq] VARCHAR(50) NULL

/* TAREFA #14428 - WESLEY */

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
           ('ControleVendas_CSV' 
           ,'Pasta aonde vai ficar os CSV de controle de vendas.'
           ,'CA'
           ,200
           ,NULL
		   ,'N'
           ,'/mnt/home1/SubAdquirencia/025/BI'
           ,NULL
           ,NULL
           ,'025ADM                           '
           ,'2022-01-12 17:00:36.000'
           ,0)
GO

select * from Pronto..PARSIS where parcod = 'ControleVendas_CSV'
--UPDATE PARSIS SET PARCON = '/mnt/home1/SubAdquirencia/025/BI' WHERE PARCOD = 'ControleVendas_CSV' -- QA
--UPDATE PARSIS SET PARCON = 'C:\Temp'                          WHERE PARCOD = 'ControleVendas_CSV' -- LOCAL

 /* ALTERAÇÃO DA VERSÃO DO BANCO */
USE Banese
USE Bemfacil
USE Credinov
USE Credpag
USE Pronto
USE SmartPagamentos

UPDATE PARSIS
SET ParCon = '2.5.4'
WHERE ParCod = 'VERSAO_BANCO'

UPDATE PARSIS
SET ParCon = '13/01/2022'
WHERE ParCod = 'VERSAO_BANCO_DATA'




 
 

