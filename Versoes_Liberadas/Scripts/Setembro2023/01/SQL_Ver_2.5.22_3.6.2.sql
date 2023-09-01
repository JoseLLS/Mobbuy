/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.2','2.5.22',GETDATE())

/* TAREFA #22538 - FELIPE */

ALTER TABLE [POS]
ADD [PosNumMultiECPai] INT    NULL,
    [PosMultiEC] SMALLINT    NULL

    DROP INDEX [IPOS5] ON [POS]
CREATE NONCLUSTERED INDEX [UPOS2] ON [POS] (
      [PosNumSer])

INSERT INTO Pronto.dbo.PARSIS
(ParCod, ParDsc, ParTipPar, ParTamPar, ParQtdDec, ParIndSin, ParCon, ParUsuInc, ParDtiInc, ParUsuAlt, ParDtiAlt, ParFlgInt)
VALUES(N'wsmbps_url3', N'Complemento da URL do serviço Multi EC', N'CA', 256, 0, NULL, N'/InterfaceManagerMobbuy/interface/api/estrutura', N'Sistema             ', '2023-08-09 16:16:17.463', NULL, NULL, 0);

/* TAREFA #22798 e #22807 - FELIPE */

ALTER TABLE [POS]
ADD [PosOrigem] SMALLINT    NULL

/* TAREFA #22814 - FELIPE */

INSERT INTO Pronto.dbo.PARSIS
(ParCod, ParDsc, ParTipPar, ParTamPar, ParQtdDec, ParIndSin, ParCon, ParUsuInc, ParDtiInc, ParUsuAlt, ParDtiAlt, ParFlgInt)
VALUES(N'Link_Relatorio_Manager', N'Link da API Operação Gateway', N'VA', 100, NULL, N'N', N'https://apigateway-qa.mobbuyapp.com/Consultas/Operacoesgateway', N'ADMIN', '2023-08-23 00:00:00.000', NULL, NULL, 0);

/* TAREFA #22817 - FELIPE */

alter VIEW VwPOSHist as
SELECT 
		VwPOSHistId			= NewID(),
		VwPhPosNum 			= POS.PosNum, 
		VwPhPosNumSer		= POS.PosNumSer,
		VwPhPosEstCod		= POS.PosEstCod, 
		dbo.GetEst(PosEstCod) as 'VwPhEstRazSoc',
		VwPhPosStsPos		= POS.PosStsPos, 
		VwPhPosEtqCodItm	= POS.EtqCodItm, 
		VwPhPOSEtqDsc		= ETQ.EtqDscItm, 
		VwPhPosRedOpe		= POS.PosRedOpe,
		VwPhPosDscDst		= POS.PosDscDst,
		VwPhHipNumSeq		= HISPOS.HipNumSeq,
		VwPhHipEstCod		= Est.EstCod,
		VwPhHipEstRazSoc	= Est.EstRazSoc,
		VwPhHipEstSegmento 	= Est.EstSegmento, 
		VwPhHipDtaEnv		= HISPOS.HipDtaEnv,
		VwPhHipDtaRcb		= HISPOS.HipDtaRcb,  
		VwPhHipDtaDev		= HISPOS.HipDtaDev,  
		VwPhHipCodMotDev	= HISPOS.HipCodMotDev,
		VwPhHipDscMotDev	= HISPOS.HipDscMotDev,
		VwPhHipMotDevId		= HISPOS.MotDevId,
		VwPhHipMotDevDesc	= MotDev.MotDevDesc,
		VwPhPosIseAlug		= POS.PosIseAlug,
		VwPhPosIseAlugDtaAlt = POS.PosIseAlugDtaAlt,
		VwPhHipAlugMotivoId = POS.AlugMotivoId,
		VwPhHipAlugMotivoDsc = Alu.AlugMotivoDsc,
		VwPhHipPosOrigem	= Pos.PosOrigem,
		VwPhHipPosMultiEC	= Pos.PosMultiEC,
		VwPhHipPosNumMultiECPai	= Pos.PosNumMultiECPai
FROM POS
LEFT JOIN HISPOS 
ON HISPOS.HipNumPos = POS.PosNum 
LEFT JOIN ETQ 
ON ETQ.EtqCodItm = POS.EtqCodItm
LEFT JOIN EST
ON EST.EstCod = HISPOS.HipCodEst
LEFT JOIN MotDev
on MotDev.MotDevId = HISPOS.MotDevId
LEFT JOIN AlugMotivo Alu
on Alu.AlugMotivoId = POS.AlugMotivoId 

/* SCRIPT DE OUTRAS TAREFAS QUE AS TAREFAS DESSA VERSÃO PEGOU */

ALTER TABLE [EST]
ADD [EstDtaAltTab] DATETIME    NULL;

CREATE TABLE [AlugParm] (
  [AlugParmId]      SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [AlugParmDtaVct]  SMALLINT    NULL,
  [AlugParmDiasCar] SMALLINT    NULL,
  [AlugParmDiasInat] SMALLINT    NULL,
  [AlugParmDiasIsePOS] SMALLINT    NULL,
  [AlugParmDiasIseEC] SMALLINT    NULL,
     PRIMARY KEY ( [AlugParmId] ));