/* SEM TAREFA - LEONARDO */

Create View Trn05Aux
AS

SELECT A.*,
B.MovTrnId,
B.MovTrnNsu,
B.MovTrnAutCod,
B.MovTrnAutCodStr,
B.MovTrnCod
FROM (
SELECT TrnBrsFecSeqArq,
SUBSTRING(TrnBrsOprIdeSer, 4, 1) 'TipoProduto',
CASE
	WHEN SUBSTRING(TrnBrsOprIdeSer, 4, 1) = 'D' AND TrnBrsOprParQtd < 2 THEN 0
	WHEN SUBSTRING(TrnBrsOprIdeSer, 4, 1) = 'D' AND TrnBrsOprParQtd >= 2 THEN TrnBrsOprParQtd
	WHEN SUBSTRING(TrnBrsOprIdeSer, 4, 1) = 'C' AND TrnBrsOprParQtd < 2 THEN 1
	WHEN SUBSTRING(TrnBrsOprIdeSer, 4, 1) = 'C' AND TrnBrsOprParQtd >= 2 THEN TrnBrsOprParQtd
END
'ParQtd',
CASE
	WHEN TrnBrsOprCodPrc = '002000' THEN 'D'
	WHEN TrnBrsOprCodPrc IN ('003000','003100', '003800') THEN 'C'
	WHEN TrnBrsOprCodPrc = '962000' THEN 'V'
END 'MovTrnTipPrd',
CASE
	WHEN TrnBrsOprBan = '002' THEN 'M'
	WHEN TrnBrsOprBan = '003' THEN 'V'
	WHEN TrnBrsOprBan = '004' THEN 'E'
	WHEN TrnBrsOprBan = '010' THEN 'C'
	WHEN TrnBrsOprBan = '006' THEN 'D'
END 'MovTrnBan',
CASE
	WHEN TrnBrsRdeSit in ('00','01','03','04') THEN 'VENDA'
	WHEN TrnBrsRdeSit IN ('10','13') THEN 'PRE AUT'
	WHEN TrnBrsRdeSit in ('20','21','40','41','43','44') THEN 'CANCELAMENTO'
	WHEN TrnBrsRdeSit in ('50', '54') THEN 'CANCELAMENTO ADQ'
END 'Situacao',
TrnBrsOprOriDat,
TrnBrsOprVlr,
TrnBrsOprMovNsu
FROM TRN05 
) A
LEFT JOIN MovTrn01 B
ON A.TrnBrsOprOriDat = B.MovTrnDta
AND B.MovTrnVlr = A.TrnBrsOprVlr
AND B.MovTrnParQtd = A.ParQtd
AND B.MovTrnBan = A.MovTrnBan
AND STR(B.MovTrnNsu) LIKE '%' + A.TrnBrsOprMovNsu + '%'

/* SEM TAREFA - JOSÉ */

CREATE NONCLUSTERED INDEX [UVAN026] ON [VAN02] (
      [VanWbsDatSrv],
      [VanWbsNsu])

/* SEM TAREFA - JOSÉ */

--Rodar em todos os clientes que será atualizado o sistema
CREATE NONCLUSTERED INDEX [UVLRPAG12] ON [VLRPAG] ( 
      [EstCod], 
      [VlpBnfCod], 
      [VlpNumLanOri]);
	  
CREATE NONCLUSTERED INDEX [UVLRPAG13] ON [VLRPAG] ( 
      [VlpDtaVct] DESC,
	  [EstCod],
      [VlpBnfCod], 
      [VlpAnpNum], 
      [VlpStspag], 
      [VlpNumLanCan], 
      [VlpNumLanOri]);

/* TAREFA #20552 - WESLEY */

USE [Pronto]
GO

/****** Object:  View [dbo].[TABVEN06]    Script Date: 06/01/2023 16:45:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[TABVEN06] as 

select 
       NewID() EstTaxGuid,
       B.ADQUIRENTE AS 'EstTaxAdq',
	   C.TavNum AS 'EstTaxPlaNum',
       C.TavDsc AS 'EstTaxPlaDesc',
	   B.MAIOR_VIGENCIA AS 'EstTaxDtaVig',
	   CASE  
			  WHEN B.BANDEIRA = 'V' then 'Visa'
			  WHEN B.BANDEIRA = 'M' then 'Mastercard'
			  WHEN B.BANDEIRA = 'H' then 'Hipercard'
			  WHEN B.BANDEIRA = 'E' then 'Elo'
			  WHEN B.BANDEIRA = 'A' then 'Amex'
			  WHEN B.BANDEIRA = 'C' then 'Cabal'
			  WHEN B.BANDEIRA = 'D' then 'Verdecard'
			  WHEN B.BANDEIRA = 'L' then 'Alelo'
			  WHEN B.BANDEIRA = 'S' then 'Sodexo'
			  WHEN B.BANDEIRA = 'P' then 'Pix'

			  ELSE 'Outros'
	   END            AS 'EstTaxBan',
	   CASE
	   WHEN A.tavdettippln = 'D' THEN 'Débito'
	   WHEN A.tavdettippln = 'A' THEN 'Crédito à Vista'
	   WHEN A.tavdettippln = 'C' THEN 'Credito Parcelado'
	   WHEN A.tavdettippln = 'P' THEN 'Pix'
	   END AS 'EstTaxTip',   
       A.tavdetqtdpar    AS 'EstTaxPar',
	   A.tavdettxaadm    AS 'EstTaxVlrAdm',
	   A.tavdettxafin    AS 'EstTaxVlrAnt',
	   CASE
	   WHEN C.TavIndParBF = 'S' THEN 'Sim'
	   ELSE 'Não'
	   END  AS 'EstTaxParAce',   
	   A.TavDetTarCre    AS 'EstTaxTarCred',
	   A.TavDetVlrCusTrn AS 'EstTaxCusTrn',
	   A.przcodprz       AS 'EstTaxDiaCond'
from TABVEN05 A
     INNER JOIN tabven06_Aux02 B
ON  A.TavNum = B.PLANO 
     INNER JOIN TABVEN C
ON A.TavNum = C.TavNum
AND A.TavVigDtaIni = B.MAIOR_VIGENCIA
AND A.TavAdqCod    = B.ADQUIRENTE
AND A.TavBanCod    = B.BANDEIRA
AND A.TavDetSeq    = B.SEQUENCIA

GO

------------------------------------------------------------------------

CREATE TABLE [ADQ0012] (
  [AdqPixBanCod]        INT    NOT NULL,
  [AdqPixTipo]          VARCHAR(1)    NOT NULL,
  [AdqPixValorCusto]    DECIMAL(17,2)    NOT NULL,
  [AdqPixDataInclusao]  DATETIME    NOT NULL,
  [AdqPixDataAlteracao] DATETIME    NULL,
     PRIMARY KEY ( [AdqPixBanCod] ))

------------------------------------------------------------------------

insert into TblBan values (20, 'Pix', 'Pix', 'P', '055', 55, 'S')

--------------------------------------------------------------------------------------------------------------------

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('BancoPix_Grid', 'BancoPix_Grid', 'Cadastro Banco PIX', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'BancoPix_Grid', '', 5, 'ADQ', '', '/pronto/servlet/')

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'BancoPix_Grid')

--Insere tela no grupo
INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'BancoPix_Grid')

---------------------------------------------------------------------------------------------------------------------

--SELECT ParCon FROM PARSIS WHERE PARCOD = 'ADI_PIX_HOST'
--SELECT ParCon FROM PARSIS WHERE PARCOD = 'ADI_PIX_BASEURL'
--SELECT ParCon FROM PARSIS WHERE PARCOD = 'ADI_PIX_CODSUBEMPRESA'
--SELECT ParCon FROM PARSIS WHERE PARCOD = 'ADI_PIX_CLIENTID'
--SELECT ParCon FROM PARSIS WHERE PARCOD = 'ADI_PIX_USUARIO'
--SELECT ParCon FROM PARSIS WHERE PARCOD = 'ADI_PIX_SENHA'

INSERT INTO PARSIS 
(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES
('ADI_PIX_HOST', 'Host da API de transações PIX', 'CA', 80, 'N', 'www.mobbuyapp.com:10443')

INSERT INTO PARSIS 
(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES
('ADI_PIX_BASEURL', 'BaseUrl da API de transações PIX', 'CA', 80, 'N', '/InterfaceManagerMobbuy/interface/processos/apipix/')

INSERT INTO PARSIS 
(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES
('ADI_PIX_CODSUBEMPRESA', 'CodSubEmpresa da API de transações PIX', 'CA', 80, 'N', '1002')

INSERT INTO PARSIS 
(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES
('ADI_PIX_CLIENTID', 'ClientId da API de transações PIX', 'CA', 80, 'N', 'c11863329d7eca1d8f8172a9578ae9f5')

INSERT INTO PARSIS 
(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES
('ADI_PIX_USUARIO', 'Usuario da API de transações PIX', 'CA', 80, 'N', 'mobbuyguest')

INSERT INTO PARSIS 
(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
VALUES
('ADI_PIX_SENHA', 'Senha da API de transações PIX', 'CA', 80, 'N', '8f543df1d7571e92db14b5fa067552e6')

-------------------------------------------------------------------------------------------------------------------------------------

--drop table [Trn12]

CREATE TABLE [Trn12] (
  [Transaction_pix]         DECIMAL(18)    NOT NULL,
  [Dt_hr_trans]             DATETIME    NULL,
  [Cd_company]              DECIMAL(18)    NULL,
  [Cd_partner]              SMALLINT    NULL,
  [Cnpj_terminal]           VARCHAR(14)    NULL,
  [Cd_terminal_physical]    VARCHAR(10)    NULL,
  [Pay_value]               DECIMAL(17,2)    NULL,
  [Pay_liquid]              DECIMAL(17,2)    NULL,
  [Quantity_parcel]         SMALLINT    NULL,
  [Dt_hr_inclusao_cobranca] DATETIME    NULL,
  [Txid_cobranca]           VARCHAR(40)    NULL,
  [Valor_cobranca]          DECIMAL(17,2)    NULL,
  [Valor_tarifa_cobranca]   DECIMAL(17,2)    NULL,
  [Situacao_cobranca]       VARCHAR(20)    NULL,
  [Dt_hr_pagamento]         DATETIME    NULL,
  [Valor_pagamento]         DECIMAL(17,2)    NULL,
  [Nsu_pagamento]           VARCHAR(20)    NULL,
  [Valor_tarifa_pagamento]  DECIMAL(17,2)    NULL,
  [Situacao_pagamento]      VARCHAR(20)    NULL,
  [Json_Entrada]            VARCHAR(MAX)    NULL,
  [Loc_Num_Log]             DECIMAL(18)    NULL,
  [Dt_hr_Importacao]        DATETIME    NULL,
  [Status_Movimento]        VARCHAR(40)    NULL,
  [MovTrnId]                DECIMAL(18)    NULL,
  [Status_Lancamento]       VARCHAR(40)    NULL,
  [VlpNumLan]               DECIMAL(18)    NULL,
    [Dt_hr_Processamento]     DATETIME    NULL,
     PRIMARY KEY ( [Transaction_pix] ))
CREATE NONCLUSTERED INDEX [UTRN12] ON [Trn12] (
      [Transaction_pix],
      [Status_Movimento],
      [Status_Lancamento],
      [Situacao_cobranca])
CREATE NONCLUSTERED INDEX [ITRN13] ON [Trn12] (
      [MovTrnId])
CREATE NONCLUSTERED INDEX [UTRN121] ON [Trn12] (
      [Status_Movimento],
      [Status_Lancamento])
CREATE NONCLUSTERED INDEX [ITRN14] ON [Trn12] (
      [VlpNumLan])
ALTER TABLE [Trn12]
 ADD CONSTRAINT [ITRN13] FOREIGN KEY ( [MovTrnId] ) REFERENCES [MovTrn01]([MovTrnId])
ALTER TABLE [Trn12]
 ADD CONSTRAINT [ITRN14] FOREIGN KEY ( [VlpNumLan] ) REFERENCES [VLRPAG]([VlpNumLan])

 ----------------------------------------------------------------------------------------------

 INSERT INTO ADQ0001 VALUES (9, 'Pix', 0, 'Pix', '', '', 'Pix', 1)

 ----------------------------------------------------------------------------------------------

 ALTER TABLE [MovTrn01]
ADD [MovTrnTxCobrancaId] VARCHAR(100) NULL

/* SEM TAREFA - LEONARDO */

use pronto
go

create view ArquivoEfeitoRecusado
as
select * from (
	select b.EfeitoContratoEstCod, b.EfeitoContratoDtaVenc, sum(b.EfeitoContratoVlrRepasse) 'repasse'
	from arqdet a
	inner join EfeitoContrato b
	on a.ArbNum = b.EfeitoContratoArbNum and a.ArbLotNum = b.EfeitoContratoArbLotNum and a.ArbDetSeq = b.EfeitoContratoArbDetSeq
	where a.ArbDetCodSit not in (0, 4) and b.EfeitoContratoVlrRepasse <> 0
	group by b.EfeitoContratoEstCod, b.EfeitoContratoDtaVenc
) a inner join (
	select EstCod, VlpDtaVct, sum(VlpVlrEfeito) 'vlr_efeito'
	from VLRPAG
	group by EstCod, VlpDtaVct
) b 
on a.EfeitoContratoEstCod = b.EstCod and a.EfeitoContratoDtaVenc = b.VlpDtaVct

/* SEM TAREFA - LEONARDO */

use credpag
go
insert into PARSIS (parcod, ParDsc, ParTipPar, ParTamPar, ParCon)
values ('DIR_LOG_TMP',	'Arquivo geral de log',	'CA',	300, '/mnt/home1/SubAdquirencia/024/')
go

use Banese
go
insert into PARSIS (parcod, ParDsc, ParTipPar, ParTamPar, ParCon)
values ('DIR_LOG_TMP',	'Arquivo geral de log',	'CA',	300, '/mnt/home1/SubAdquirencia/012/')
go

use Pronto
go
insert into PARSIS (parcod, ParDsc, ParTipPar, ParTamPar, ParCon)
values ('DIR_LOG_TMP',	'Arquivo geral de log',	'CA',	300, '/mnt/home1/SubAdquirencia/025/')
go

use smartpagamentos
go
insert into PARSIS (parcod, ParDsc, ParTipPar, ParTamPar, ParCon)
values ('DIR_LOG_TMP',	'Arquivo geral de log',	'CA',	300, '/mnt/home1/SubAdquirencia/018/')
go

use Credinov
go
insert into PARSIS (parcod, ParDsc, ParTipPar, ParTamPar, ParCon)
values ('DIR_LOG_TMP',	'Arquivo geral de log',	'CA',	300, '/mnt/home1/SubAdquirencia/026/')
go

use thepay
go
insert into PARSIS (parcod, ParDsc, ParTipPar, ParTamPar, ParCon)
values ('DIR_LOG_TMP',	'Arquivo geral de log',	'CA',	300, '/mnt/home1/SubAdquirencia/027/')
go

use estbank
go
insert into PARSIS (parcod, ParDsc, ParTipPar, ParTamPar, ParCon)
values ('DIR_LOG_TMP',	'Arquivo geral de log',	'CA',	300, '/mnt/home1/SubAdquirencia/028/')
go

/* TAREFA #20867 - JOSÉ */

--Rodar script em todos os clientes que for ser atualizada a versão
INSERT INTO PARSIS
VALUES ('ANT_CONSIDERA_NEGATIVO', 'Considera valor negativo (Ajuste e Cancelamento) na antecipação ou não', 'VA', 40, NULL, 'N', 'N', 'ADMIN', '2023-01-23 10:19:57.000', NULL, NULL, 0);

/* TAREFA #20984 - LEONARDO */

CREATE NONCLUSTERED INDEX [UVAN02] ON [VAN02] (
      [VanWbsHraTrn])

/* TAREFA #21092 - JOSÉ */

--Rodar em todos os clientes que serão atualizados
CREATE NONCLUSTERED INDEX [UMOVTRN0112] ON [MovTrn01] (
      [EstCod],
      [MovTrnCod],
      [MovTrnDta] DESC);

/* TAREFA #20994 - JOSÉ */

--Rodar script em todos os clientes que serão atualizados
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('PromocaoTaxa_imp', 'PromocaoTaxa_imp', 'Promoção de Taxas', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'PromocaoTaxa_imp', '', 115, 'CRED_ESTAB', '', '/pronto/servlet/');--Alterar o '/pronto/servlet/' conforme o cliente

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'PromocaoTaxa_imp');--Alterar o '25' conforme a unidade de negócio do cliente

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'PromocaoTaxa_imp');--Alterar o '25' conforme a unidade de negócio do cliente

---------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE [TABVEN]
ADD [TavTipTab] CHAR(1)    NULL;

ALTER TABLE [TABVEN02]
ADD [TavVigDtaFim] DATETIME    NULL

----------------------------------------------------------------------------------------------------------------------------------------

CREATE NONCLUSTERED INDEX [UTABVEN1] ON [TABVEN] (
      [TavDsc]);
	  
CREATE NONCLUSTERED INDEX [UTABVEN053] ON [TABVEN05] (
      [TavNum],
      [TavVigDtaIni],
      [TavAdqCod],
      [TavBanCod],
      [TavDetTipPln],
      [TavDetQtdPar]);
	  
CREATE NONCLUSTERED INDEX [UTABVEN054] ON [TABVEN05] (
      [TavNum],
      [TavVigDtaIni],
      [TavAdqCod],
      [TavBanCod],
      [TavDetSeq] DESC);
	  
-----------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('TabVenEst_imp', 'TabVenEst_imp', 'Vinculo Tabela Promoções', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'TabVenEst_imp', '', 120, 'CRED_ESTAB', '', '/pronto/servlet/');--Alterar o '/pronto/servlet/' conforme o cliente

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'TabVenEst_imp');--Alterar o '25' conforme a unidade de negócio do cliente

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'TabVenEst_imp');--Alterar o '25' conforme a unidade de negócio do cliente

------------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE [EstPromocao] (
  [EstPromId]          INT    NOT NULL    IDENTITY ( 1 , 1 ),
  [EstCod]             INT    NULL,
  [EstPromDtaInc]      DATETIME    NULL,
  [EstPromDtaAlt]      DATETIME    NULL,
  [EstPromTavAnterior] SMALLINT    NULL,
  [EstPromTavNum]      SMALLINT    NULL,
  [EstPromStatus]      CHAR(20)    NULL,
  [EstPromUsuInc]      VARCHAR(40)    NULL,
  [EstPromUsuAlt]      VARCHAR(40)    NULL,
     PRIMARY KEY ( [EstPromId] ));

CREATE NONCLUSTERED INDEX [IESTPROMOCAO1] ON [EstPromocao] (
      [EstCod]);

ALTER TABLE [EstPromocao]
 ADD CONSTRAINT [IESTPROMOCAO1] FOREIGN KEY ( [EstCod] ) REFERENCES [EST]([EstCod]);

 CREATE NONCLUSTERED INDEX [UESTPROMOCAO] ON [EstPromocao] (
      [EstPromTavNum],
      [EstCod]);

