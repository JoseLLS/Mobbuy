CREATE TABLE [MotDev] (
  [MotDevId]   SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [MotDevDesc] VARCHAR(255)    NOT NULL,
     PRIMARY KEY ( [MotDevId] ))

INSERT INTO Pronto.dbo.sse2_mnu02
(MnuCod, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES(10, 1, N'HMOTDEV_GRID', N'Cadastro Motivo Devolução POS', 21, N'SUPRIMENTOS', N'', N'/pronto/servlet/');

 INSERT INTO Pronto.dbo.sse2_mod
(MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES(N'HMOTDEV_GRID', N'HMOTDEV_GRID', N'Cadastro Motivo Devolução POS', N'', N'', 0, 1, N'');

INSERT INTO Pronto.dbo.sse2_ung_mod
(UNG2Cod, MOD2Id)
VALUES(25, N'HMOTDEV_GRID');

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



ALTER VIEW VwPOSHist as
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
		VwPhHipMotDevDesc	= MotDev.MotDevDesc
FROM POS
LEFT JOIN HISPOS 
ON HISPOS.HipNumPos = POS.PosNum 
LEFT JOIN ETQ 
ON ETQ.EtqCodItm = POS.EtqCodItm
LEFT JOIN EST
ON EST.EstCod = HISPOS.HipCodEst
LEFT JOIN MotDev
on MotDev.MotDevId = HISPOS.MotDevId