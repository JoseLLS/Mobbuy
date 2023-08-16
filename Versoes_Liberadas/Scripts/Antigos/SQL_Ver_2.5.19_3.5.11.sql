/* TAREFA 22351 - FELIPE */

USE pronto

CREATE FUNCTION GetEst(@InEstCod INT)         
    RETURNS  Varchar(100) 
    BEGIN 
      DECLARE @nome Varchar(100); 
      set @nome = (SELECT EstRazSoc FROM Est WHERE Estcod = @InEstCod); 
    RETURN @nome; 
END 

CREATE VIEW [dbo].[VwPOSHist] as
SELECT 
		VwPOSHistId			 = NewID(),
		VwPhPosNum 			 = POS.PosNum, 
		VwPhPosNumSer		 = POS.PosNumSer,
		VwPhPosEstCod		 = POS.PosEstCod, 
		dbo.GetEst(PosEstCod) as 'VwPhEstRazSoc',
		VwPhPosStsPos		 = POS.PosStsPos, 
		VwPhPosEtqCodItm	 = POS.EtqCodItm, 
		VwPhPOSEtqDsc		 = ETQ.EtqDscItm, 
		VwPhPosRedOpe		 = POS.PosRedOpe,
		VwPhPosDscDst		 = POS.PosDscDst,
		VwPhPosIseAlug		 = POS.PosIseAlug,
		VwPhPosIseAlugDtaAlt = POS.PosIseAlugDtaAlt,
		VwPhHipNumSeq		 = HISPOS.HipNumSeq,
		VwPhHipEstCod		 = Est.EstCod,
		VwPhHipEstRazSoc	 = Est.EstRazSoc,
		VwPhHipEstSegmento 	 = Est.EstSegmento, 
		VwPhHipDtaEnv		 = HISPOS.HipDtaEnv,
		VwPhHipDtaRcb		 = HISPOS.HipDtaRcb,  
		VwPhHipDtaDev		 = HISPOS.HipDtaDev,  
		VwPhHipCodMotDev	 = HISPOS.HipCodMotDev,
		VwPhHipDscMotDev	 = HISPOS.HipDscMotDev,
		VwPhHipMotDevId		 = HISPOS.MotDevId,
		VwPhHipMotDevDesc	 = MotDev.MotDevDesc,
		VwPhHipAlugMotivoId  = HISPOS.AlugMotivoId,
		VwPhHipAlugMotivoDsc = AlugMotivo.AlugMotivoDsc
FROM POS
LEFT JOIN HISPOS 
ON HISPOS.HipNumPos = POS.PosNum 
LEFT JOIN ETQ 
ON ETQ.EtqCodItm = POS.EtqCodItm
LEFT JOIN EST
ON EST.EstCod = HISPOS.HipCodEst
LEFT JOIN MotDev
on MotDev.MotDevId = HISPOS.MotDevId
LEFT JOIN AlugMotivo
ON AlugMotivo.AlugMotivoId = HISPOS.AlugMotivoId;

/* SEM TAREFA - LEONARDO */

alter table movtrn01
add MovTrnTxaComVlrPrv numeric(12,2) null,
	MovTrnTxaEstVlrPrv NUMERIC(12,2) null,
	MovTrnEstTxaAdmPrv NUMERIC(6,2) null,
	MovTrnEstTxaAntPrv NUMERIC(6,2) null,
	MovTrnEstTarCredPrv NUMERIC(6,2) null,
	MovTrnEstCusTrnPrv NUMERIC(6,2) null,
	MovTrnTxaEstCond BIT NULL 

/* SCRIPTS NECESSÁRIOS PARA FUNCIONALIDADE DA VERSÂO */

CREATE TABLE [AlugMotivo] (
  [AlugMotivoId]   SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [AlugMotivoDsc]  VARCHAR(40)    NULL,
  [AlugMotivoDias] SMALLINT    NULL,
     PRIMARY KEY ( [AlugMotivoId] ));

ALTER TABLE [GrupoComercial]
ADD [GrupoComercialIseAlug] BIT    NULL;

ALTER TABLE [GrupoComercialEst]
ADD [GrupoComercialEstCobCen] BIT    NULL;

ALTER TABLE [POS]
ADD [PosIseAlugDtaAlt] DATETIME    NULL;

ALTER TABLE [POS]
ADD [PosNumMultiECPai] INT    NULL,
    [PosMultiEC] SMALLINT    NULL
	
DROP INDEX [IPOS5] ON [POS]
CREATE NONCLUSTERED INDEX [IPOS5] ON [POS] (
      [PosNumSer])

CREATE TABLE [MotDev] (
  [MotDevId]   SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [MotDevDesc] VARCHAR(255)    NOT NULL,
     PRIMARY KEY ( [MotDevId] ))

ALTER TABLE [HISPOS]
ADD [MotDevId] SMALLINT    NULL
CREATE NONCLUSTERED INDEX [IHISPOS2] ON [HISPOS] (
      [MotDevId])
ALTER TABLE [HISPOS]
 ADD CONSTRAINT [IHISPOS2] FOREIGN KEY ( [MotDevId] ) REFERENCES [MotDev]([MotDevId])
 
 ALTER TABLE [POS]
ADD [MotDevId] SMALLINT    NULL
CREATE NONCLUSTERED INDEX [IPOS6] ON [POS] (
      [MotDevId])
ALTER TABLE [POS]
 ADD CONSTRAINT [IPOS6] FOREIGN KEY ( [MotDevId] ) REFERENCES [MotDev]([MotDevId])

--Inserir esse registro primeiro
INSERT INTO MotDev
(MotDevDesc)
values
(N'Problema Técnico');

INSERT INTO MotDev
(MotDevDesc)
values
(N'Sem Utilização');
