/* TAREFA #20864 - JOSÉ */

USE Pronto

--Rodar script em todos os clientes que serão atualizados
CREATE TABLE [MovimentacaoBobina] (
  [MovBobinaId]        INT    NOT NULL    IDENTITY ( 1 , 1 ),
  [MovBobinaTipo]      CHAR(20)    NULL,
  [MovBobinaDtaEnvRem] DATETIME    NULL,
  [MovBobinaQnt]       SMALLINT    NULL,
  [EstCod]             INT    NULL,
     PRIMARY KEY ( [MovBobinaId] ))

ALTER TABLE [MovimentacaoBobina]
ADD CONSTRAINT [IMOVIMENTACAOBOBINA1] FOREIGN KEY ( [EstCod] ) REFERENCES [EST]([EstCod])
 
CREATE NONCLUSTERED INDEX [UMOVIMENTACAOBOBINA] ON [MovimentacaoBobina] (
      [EstCod],
      [MovBobinaTipo],
      [MovBobinaDtaEnvRem] DESC)
 
 ------------------------------------------------------------------------------------------------------------------
 
 CREATE TABLE [BobinaParametro] (
  [BobinaParId]     SMALLINT    NOT NULL,
  [BobinaParQtdEnv] SMALLINT    NULL,
  [BobinaParQtdVen] SMALLINT    NULL,
  [BobinaParQtdMin] SMALLINT    NULL,
     PRIMARY KEY ( [BobinaParId] ))
	 
-------------------------------------------------------------------------------------------------------------------
	 
CREATE TABLE [BobinaEmail] (
  [BobinaEmailId]     INT    NOT NULL    IDENTITY ( 1 , 1 ),
  [BobinaEmailDtaEnv] DATETIME    NULL,
  [MovBobinaId]       INT    NULL,
     PRIMARY KEY ( [BobinaEmailId] ))

CREATE NONCLUSTERED INDEX [IBOBINAEMAIL1] ON [BobinaEmail] (
      [MovBobinaId])

ALTER TABLE [BobinaEmail]
ADD CONSTRAINT [IBOBINAEMAIL1] FOREIGN KEY ( [MovBobinaId] ) REFERENCES [MovimentacaoBobina]([MovBobinaId])
 
--------------------------------------------------------------------------------------------------------------------
 
UPDATE PARSIS
SET ParCon = '<p>Caro Administrador,<br /><br />&emsp;&emsp;&emsp;Acaba de ser registrado em nosso sistema</p><p>&emsp;&emsp;&emsp;Nova Solicita&ccedil;&atilde;o de Bobina&nbsp;</p>&emsp;&emsp;&emsp;Registrada pelo [ORIGEM] <br><br>&emsp;&emsp;&emsp;EC:<br><b>&emsp;&emsp;&emsp;[ESTABELECIMENTO]</b><br><br>&emsp;&emsp;&emsp;Favor Providenciar ou entrar em contato.<P>Atenciosamente<br>Sistema</p><u>Nâo responda essa mensagem ela é automática e gerada pelo sistema de Gestão de SubAdquirentes</u>'
WHERE ParCod = 'SOLICITABOBINA_EMAILMSG'

----------------------------------------------------------------------------------------------------------------------

INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('MovBobina_Grid', 'MovBobina_Grid', 'Movimentação de bobinas', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'MovBobina_Grid', '', 80, 'SUPRIMENTOS', '', '/pronto/servlet/') --Alterar o 'pronto' conforme o projeto do cliente atualizado

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'MovBobina_Grid') --Alterar o '25' conforme a unidade de negócio do cliente atualizado

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'MovBobina_Grid') --Alterar o '25' conforme a unidade de negócio do cliente atualizado

/* TAREFA #21371 - LEONARDO */

USE [Pronto]
GO

/****** Object:  View [dbo].[AgdPag02]    Script Date: 17/03/2023 14:10:19 ******/
DROP VIEW [dbo].[AgdPag02]
GO

/****** Object:  View [dbo].[AgdPag02]    Script Date: 17/03/2023 14:10:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   view [dbo].[AgdPag02] as 
    select 
        AgdPg1Dta    = v.VlpDtaVct ,
        AgdPg2EstCod = v.EstCod ,
        AgdPg2EstNomFanRed = ( select EstNomFan from EST where EstCod = v.EstCod),
		AgdPg2VlrPix	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='P' and isnull(MovTrnParQtd,'') <= 1 then VlpVlrPag Else 0 end ) ,
        AgdPg2VlrDeb	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='D' and isnull(MovTrnParQtd,'') <= 1 then VlpVlrPag Else 0 end ) ,
        AgdPg2VlrCre	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') <= 1 then VlpVlrPag Else 0 end ),
        AgdPg2VlrPrc	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') >  1 then VlpVlrPag Else 0 end ),
        AgdPg2VlrAju	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'')='AJ'then VlpVlrPag Else 0 end ),
        AgdPg2VlrCan	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'')='CC'then VlpVlrPag Else 0 end ),
        AgdPg2VlrOut	= sum( case when v.TidCod>1 or  isnull(MovTrnCod,'')='AL'  then VlpVlrPag Else 0 end ),
        AgdPg2VlrRee	= sum( case when v.VlpStspag=2                           then VlpVlrPag Else 0 end ),
		AgdPg2VlrTotAbe = sum( case when v.VlpStspag=1                            then VlpVlrPag Else 0 end )
    from VlrPag v left join movtrn01 m on (m.movtrnid =  v.VlpMovTrnId ) where v.VlpStspag not in (3,4) 
    group by v.VlpDtaVct , v.estcod    


GO


USE [Pronto]
GO

/****** Object:  View [dbo].[VwAgdPag]    Script Date: 17/03/2023 14:10:45 ******/
DROP VIEW [dbo].[VwAgdPag]
GO

/****** Object:  View [dbo].[VwAgdPag]    Script Date: 17/03/2023 14:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE   View [dbo].[VwAgdPag] as (
Select NewID() AgdSumID,
AgdPg1Dta AdgSumDta,
AgdPg2EstCod EstCod,
Sum(AgdPg2VlrPix) AgpSumVlrPix,
Sum(AgdPg2VlrDeb) AgpSumVlrDeb,
Sum(AgdPg2VlrCre) AgpSumVlrCreVis,
Sum(AgdPg2VlrPrc) AgpSumVlrCrePar,
Sum(AgdPg2VlrAju) + Sum(AgdPg2VlrOut) AgpSumVlrAju,
Sum(AgdPg2VlrCan) AgpSumVlrDes,
Sum(AgdPg2VlrRee) AgpSumVlrTot,
sum(AgdPg2VlrTotAbe) AgpSumVlrTot2
from AgdPag02
Group By AgdPg2EstCod, AgdPg1Dta );
​
GO


USE [Pronto]
GO

/****** Object:  View [dbo].[VlrPag02]    Script Date: 17/03/2023 14:11:05 ******/
DROP VIEW [dbo].[VlrPag02]
GO

/****** Object:  View [dbo].[VlrPag02]    Script Date: 17/03/2023 14:11:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[VlrPag02] as 
	select 
	movtrnid VlpMovTrnId ,
	MovTrnDta VlpMovTrnDta , 
	movtrnvlr VlpMovTrnVlr , 
	MovTrnNsu VlpMovTrnNsu , 
	MovTrnBan VlpMovTrnBan , 
	MovTrnNumCar VlpMovTrnNumCar , 
	MovTrnParIndBemFac VlpMovTrnParIndBemFac , 
	MovTrnParQtd VlpMovTrnParQtd , 
	MovTrnTipPrd VlpMovTrnTipPrd , 
	MovTrnCod VlpMovTrnCod , 
	MovTrnAutCod VlpMovTrnAutCod , 
	MovTrnAutCodStr VlpMovTrnAutCodStr ,
	MovTrnIdeTer    VlpMovTrnIdeTer ,
	MovTrnPosNum    VlpMovTrnPosNum ,
	MovTrnPosApeId  VlpMovTrnPosApeId ,
	AdqCod          VlpMovTrnAdqCod,
	MovTrnTxCobrancaId VlpMovTaxaCobrancaId
	from movtrn01 
	union all
	select
	VlpMovTrnId           =0,
	VlpMovTrnDta          ='01jan1753', 
	VlpMovTrnVlr          =0, 
	VlpMovTrnNsu          =0, 
	VlpMovTrnBan          ='',  
	VlpMovTrnNumCar       ='', 
	VlpMovTrnParIndBemFac ='', 
	VlpMovTrnParQtd       =0, 
	VlpMovTrnTipPrd       ='', 
	VlpMovTrnCod          ='', 
	VlpMovTrnAutCod       =0, 
	VlpMovTrnAutCodStr    ='',
	VlpMovTrnIdeTer       ='',
	VlpMovTrnPosNum       = 0 ,
	VlpMovTrnPosApeId     = 0 ,
	VlpMovTrnAdqCod       = 0 ,
	VlpMovTaxaCobrancaId  = ''

GO

/* TAREFA #21507 - JOSÉ */

CREATE NONCLUSTERED INDEX [UVAN042] ON [VAN04] ( 
      [VanTrnMovId])

/* TAREFA #21447 - LEONARDO */

use credpag
go

insert into parsis(ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon) 
values
('MUDAR_FLAG_BANCO', 'Alterar flag do banco para pagar apenas Transferencia', 'CA', 1, 'N', 'S'),
('BANCOD_FLAG', 'Banco para fazer TED', 'CA', 100, 'N', '237')