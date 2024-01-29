/* VERSIONAMENTO DE SCRIPTS */

INSERT INTO SQLHistorico
VALUES ('3.6.30','2.5.32',GETDATE());

/* TAREFA #23433 - JOSÉ */

CREATE TABLE [AjusteManualMot] (
  [AjusteManualMotId]  SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [AjusteManualMotDsc] VARCHAR(100)    NULL,
  [AjusteManualMotSts] BIT    NULL,
  [AjusteManualMotDtaAlt] DATETIME    NULL,
  [AjusteManualMotDtaInc] DATETIME    NULL,
  [AjusteManualMotUsuAlt] VARCHAR(40)    NULL,
  [AjusteManualMotUsuInc] VARCHAR(40)    NULL,
     PRIMARY KEY ( [AjusteManualMotId] ));
	 
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('MotAjusteManual', 'MotAjusteManual', 'Ajuste Manual - Motivo', '', '', 0, 1, '');

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'MotAjusteManual', '', 220, 'TAB_GER', '', '/pronto/servlet/');

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'MotAjusteManual');

INSERT INTO sse2_grp_mod (UNG2Cod, USR2GrpId, MOD2Id)
VALUES (25, 'ADM', 'MotAjusteManual');

ALTER TABLE [AJM0001]
ADD [AjmMotObs] VARCHAR(1024)    NULL,
    [AjusteManualMotId] SMALLINT    NULL;
CREATE NONCLUSTERED INDEX [IAJM2] ON [AJM0001] (
      [AjusteManualMotId]);
ALTER TABLE [AJM0001]
 ADD CONSTRAINT [IAJM2] FOREIGN KEY ( [AjusteManualMotId] ) REFERENCES [AjusteManualMot]([AjusteManualMotId]);

 /* TAREFA #23737 - JOSÉ */

--Rodar em todos os clientes

ALTER TABLE [AJM0001]
ADD [AjmCodAtz] VARCHAR(12)    NULL;

/* TAREFA #23420 - CARLOS */

USE EstBank

GO
/****** Object:  StoredProcedure CarregaLanBoaVista   Script Date: 01/12/2023 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC CarregaLanBoaVista(@DATAVENDA DATE) 
AS
BEGIN
	INSERT INTO LANCAMENTOSBOAVISTA 
		(LanBoaVistaDtaVen,
		LanBoaVistaHraVen,
		LanBoaVistaDtaCre,
		LanBoaVistaNSU,
		LanBoaVistaAut,
		LanBoaVistaPlano,
		LanBoaVistaBan,
		LanBoaVistaProd,
		LanBoaVistaVlrVen,
		LanBoaVistaVlrBru,
		LanBoaVistaCodEst,
		LanBoaVistaVlrLiq,
		LanBoaVistaStatus,
		LanBoaVistaModCap,
		LanBoaVistaParc,
		LanBoaVistaVlrTax,
		LanBoaVistaAge,
		LanBoaVistaBanco,
		LanBoaVistaConta,
		LanBoaVistaStatusEnviado)
		SELECT 
			V.VanTrnDta 'DtaVenda',
			CONCAT(SUBSTRING(cast(V.VanTrnHra as varchar(6)),1, 2),':',
					SUBSTRING(cast(V.VanTrnHra as varchar(6)),3, 2),':',
					SUBSTRING(cast(V.VanTrnHra as varchar(6)),5, 2)) 'HraVenda',
			M.MovTrnDta 'DtaCredito',
			M.MovTrnNsu 'NSU',
			M.MovTrnAutCod 'Autorização',
			IIF(M.MovTrnParQtd = 0, 1, M.MovTrnParQtd) 'Plano',
			CASE
				WHEN M.MovTrnBan = 'V' THEN '1'
				WHEN M.MovTrnBan = 'M' THEN '2'
				WHEN M.MovTrnBan = 'E' THEN '7'
			ELSE '0'
			END 'Bandeira',
			CASE
				WHEN M.MOVTRNTIPPRD = 'D'/*1*/ AND M.MovTrnBan = 'V'/*1*/ THEN '2'
				WHEN M.MOVTRNTIPPRD = 'C'/*2*/ AND M.MovTrnBan = 'V'/*1*/ THEN '1'
				WHEN M.MOVTRNTIPPRD = 'D'/*1*/ AND M.MovTrnBan = 'M'/*2*/ THEN '343'
				WHEN M.MOVTRNTIPPRD = 'C'/*2*/ AND M.MovTrnBan = 'M'/*2*/ THEN '6'
				WHEN M.MOVTRNTIPPRD = 'D'/*1*/ AND M.MovTrnBan = 'E'/*7*/ THEN '197'
				WHEN M.MOVTRNTIPPRD = 'C'/*2*/ AND M.MovTrnBan = 'E'/*7*/ THEN '196'
			ELSE '0'
			END 'Produto',
			V.VanTrnVlr 'Valor Venda',
			M.MOVTRNVLR 'Valor Bruto',
			E.ESTCPFCNPJ 'Cod. Estabelecimento',
			M.MOVTRNVLRLIQEST 'Valor Líquido',
			'1' 'Status',
			'1' 'Modo Captura',
			IIF(M.MovTrnParQtd = 0, 1, M.MovTrnParQtd) 'Parcela',
			(M.MOVTRNVLR - M.MOVTRNVLRLIQEST) 'Valor Taxa',
			E.EstAge1 'Agência',
			E.EstBco1 'Banco',
			E.EstCco1 'Conta',
			'1' 'Ststus Enviado' /*Pendente*/
		FROM MOVTRN01 M INNER JOIN VAN04 V
		ON M.MOVTRNID = V.VanTrnMovId
		INNER JOIN EST E
		ON M.ESTCOD = E.ESTCOD
		WHERE V.VANTRNDTA = @DATAVENDA
		and E.EstCod in (89,90,91,92)
END

/*
DECLARE @DATAVENDA DATE
SET @DATAVENDA  = '2023-11-22'
EXEC CARREGALANBOAVISTA @DATAVENDA
*/