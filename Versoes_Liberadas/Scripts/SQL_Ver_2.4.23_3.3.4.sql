/* TAREFA #18488 - WESLEY */

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
           ('PER_USU_MANUTENCAO' 
           ,'Usuário(s) com permissão para fazer manutenção da movtrn01 e vlrpag.Separa cada usuário por |'
           ,'CA'
           ,1
           ,NULL
           ,'N'
           ,'S'
           ,NULL
           ,NULL
           ,'025ADM                           '
           ,'2022-07-18 10:00:36.000'
           ,0)
GO

--select * from parsis where parcod = 'PER_USU_CAN_MANUAL'
--select * from parsis where parcod = 'PER_USU_MANUTENCAO'
--update parsis set ParCon = '012suporte' where parcod = 'PER_USU_MANUTENCAO'

CREATE TABLE [LOG_MOVTRN01] ( 
  [Log_MovTrn01Id]         DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ), 
  [Log_MovTrnId]           DECIMAL(18)    NULL, 
  [Log_EstCod]             INT    NULL, 
  [Log_MovTrnCod]          VARCHAR(2)    NULL, 
  [Log_MovTrnNumMov]       INT    NULL, 
  [Log_MovTrnNumReg]       INT    NULL, 
  [Log_MovTrnNsu]          DECIMAL(18)    NULL, 
  [Log_MovTrnAutCod]       DECIMAL(12)    NULL, 
  [Log_MovTrnAutCodStr]    VARCHAR(12)    NULL, 
  [Log_MovTrnNsuMovOri]    DECIMAL(12)    NULL, 
  [Log_MovTrnDta]          DATETIME    NULL, 
  [Log_MovTrnVlr]          DECIMAL(17,2)    NULL, 
  [Log_MovTrnVlrLiqBemFac] DECIMAL(17,2)    NULL, 
  [Log_MovTrnVlrLiqEst]    DECIMAL(17,2)    NULL, 
  [Log_MovTrnParQtd]       SMALLINT    NULL, 
  [Log_MovTrnParVlr]       DECIMAL(17,2)    NULL, 
  [Log_MovTrnParIndBemFac] CHAR(1)    NULL, 
  [Log_MovTrnTipPrd]       CHAR(1)    NULL, 
  [Log_MovTrnConId]        DECIMAL(17,2)    NULL, 
  [Log_MovTrnBan]          CHAR(1)    NULL, 
  [Log_MovTrnGbpVlrTxaAdm] DECIMAL(17,2)    NULL, 
  [Log_MovTrnGbpVlrTxaInt] DECIMAL(17,2)    NULL, 
  [Log_MovTrnGbpVlrTxaAnt] DECIMAL(17,2)    NULL, 
  [Log_MovTrnBfaVlrCusCap] DECIMAL(17,2)    NULL, 
  [Log_MovTrnBfaVlrTxaAdm] DECIMAL(17,2)    NULL, 
  [Log_MovTrnBfaVlrTxaFin] DECIMAL(17,2)    NULL, 
  [Log_MovTrnBfaVlrCusTrn] DECIMAL(17,2)    NULL, 
  [Log_MovTrnBfaVlrTarCre] DECIMAL(17,2)    NULL, 
  [Log_MovTrnBfaVlrTxaAnt] DECIMAL(17,2)    NULL, 
  [Log_MovTrnPacCod]       INT    NULL, 
  [Log_MovTrnIdOri]        DECIMAL(17,2)    NULL, 
  [Log_MovTrnIdCan]        DECIMAL(18)    NULL, 
  [Log_MovTrnVanSeq]       DECIMAL(18)    NULL, 
  [Log_MovTrnIndExpCtb]    CHAR(1)    NULL, 
  [Log_MovTrnDtaExpCtb]    DATETIME    NULL, 
  [Log_MovTrnIndAnaPla]    CHAR(1)    NULL, 
  [Log_MovTrnDtaAnaPla]    DATETIME    NULL, 
  [Log_MovTrnStaAnaPla]    CHAR(1)    NULL, 
  [Log_MovTrnTxaCom]       SMALLMONEY    NULL, 
  [Log_MovTrnPosNum]       INT    NULL, 
  [Log_MovTrnPosApeId]     INT    NULL, 
  [Log_MovTrnIdAjt]        DECIMAL(18)    NULL, 
  [Log_MovTrnInsTimStp]    DATETIME    NULL, 
  [Log_MovTrnIdeTer]       CHAR(16)    NULL, 
  [Log_AdqCod]             SMALLINT    NULL, 
  [Log_MovTrnNumCar]       CHAR(32)    NULL, 
  [Log_MovTrnHra]          INT    NULL, 
  [Log_MovTrnUsuCan]       VARCHAR(128)    NULL, 
  [Log_MovTrnDtaHraCan]    DATETIME    NULL, 
  [Log_MovtrnAnt]          VARCHAR(1)    NULL, 
  [Log_MovTrnExpCom]       BIT    NULL, 
  [Log_MovTrnUsuAlt]       VARCHAR(128)    NULL, 
  [Log_MovTrnDtaAlt]       DATETIME    NULL, 
     PRIMARY KEY ( [Log_MovTrn01Id] ))

CREATE TABLE [LOG_VLRPAG] ( 
  [Log_VlrPagId]                  DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ), 
  [Log_VlpNumLan]                 DECIMAL(18)    NULL, 
  [Log_VlpNumLanOri]              DECIMAL(18)    NULL, 
  [Log_VlpNumLanCan]              DECIMAL(18)    NULL, 
  [Log_VlpDtaVct]                 DATETIME    NULL, 
  [Log_VlpDtaOriVct]              DATETIME    NULL, 
  [Log_VlpVlrPag]                 MONEY    NULL, 
  [Log_VlpVlrOriPag]              MONEY    NULL, 
  [Log_VlpVlrTaxAdm]              MONEY    NULL, 
  [Log_VlpPerVlrAluPos]           SMALLMONEY    NULL, 
  [Log_VlpVlrEfeito]              MONEY    NULL, 
  [Log_VlpNumMovPrv]              INT    NULL, 
  [Log_VlpNumRegPrv]              INT    NULL, 
  [Log_VlpNumRegLiq]              INT    NULL, 
  [Log_VlpNumMovCan]              INT    NULL, 
  [Log_VlpNumRegCan]              INT    NULL, 
  [Log_VlpDtaEnvBco]              DATETIME    NULL, 
  [Log_VlpMovTrnId]               DECIMAL(18)    NULL, 
  [Log_VlpBan]                    SMALLINT    NOT NULL, 
  [Log_VlpTipPrd]                 CHAR(1)    NULL, 
  [Log_VlpDtaLiq]                 DATETIME    NULL, 
  [Log_VlpVlrPagLiq]              MONEY    NULL, 
  [Log_VlpArbNum]                 INT    NULL, 
  [Log_VlpArbLotNum]              SMALLINT    NULL, 
  [Log_VlpArbDetSeq]              INT    NULL, 
  [Log_VlrPag_EstCod]             INT    NULL, 
  [Log_VlpStspag]                 SMALLINT    NULL, 
  [Log_TidCod]                    SMALLINT    NULL, 
  [Log_VlpVlrCstTrnPln]           MONEY    NULL, 
  [Log_VlpVlrCstTrnEst]           MONEY    NULL, 
  [Log_VlpVlrTaxFinBF]            MONEY    NULL, 
  [Log_VlpVlrTarCreBF]            MONEY    NULL, 
  [Log_VlpNumTotPar]              SMALLINT    NULL, 
  [Log_VlpUsuInc]                 VARCHAR(128)    NULL, 
  [Log_VlpDtiInc]                 DATETIME    NULL, 
  [Log_VlpUsuAlt]                 VARCHAR(128)    NULL, 
  [Log_VlpDtiAlt]                 DATETIME    NULL, 
  [Log_VlpMesRefAlu]              SMALLINT    NULL, 
  [Log_VlpIndExpCtb]              VARCHAR(1)    NULL, 
  [Log_VlpDtaExpCtb]              DATETIME    NULL, 
  [Log_VlpAnpTip]                 CHAR(1)    NULL, 
  [Log_VlpAnpNum]                 DECIMAL(18)    NULL, 
  [Log_VlpVlrParBru]              MONEY    NULL, 
  [Log_VlpUng2Cod]                INT    NULL, 
  [Log_VlpBnfTip]                 CHAR(1)    NULL, 
  [Log_VlpBnfCod]                 DECIMAL(18)    NULL, 
  [Log_VlpTrnCod]                 CHAR(2)    NULL, 
  [Log_VlpNumPar]                 SMALLINT    NULL, 
  [Log_VlpNsu]                    DECIMAL(12)    NULL, 
  [Log_VlpAutCodStr]              VARCHAR(12)    NULL, 
  [Log_VlpEnvTrn]                 DATETIME    NULL, 
  [Log_VlpIdTransation]           DECIMAL(18)    NULL, 
  [Log_VlpVanWbsSeq]              INT    NULL, 
  [Log_VlpIdCreditTransaction]    DECIMAL(18)    NULL, 
  [Log_VlpIdCreditTransactionPai] DECIMAL(18)    NULL, 
  [Log_VlrPagRegRec]              BIT    NULL, 
  [Log_VlpAltTrn]                 DATETIME    NULL, 
  [Log_VlpCreditoCessao]          SMALLINT    NULL, 
  [Log_VlrPagEnvJson]             VARCHAR(MAX)    NULL, 
  [Log_VlrPagRetJson]             VARCHAR(MAX)    NULL, 
  [Log_VlrMesComp]                VARCHAR(7)    NULL, 
  [Log_VlrIdExt]                  VARCHAR(8)    NULL, 
  [Log_VlrUsuAlt]                 VARCHAR(128)    NULL, 
  [Log_VlpDtaAlt]                 DATETIME    NULL, 
     PRIMARY KEY ( [Log_VlrPagId] ))

	 SELECT distinct(VlpBnfTip) FROM VLRPAG