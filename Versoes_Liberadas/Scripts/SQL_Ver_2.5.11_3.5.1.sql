/* SEM TAREFA - JOSÉ */

USE Seguranca;

CREATE NONCLUSTERED INDEX [USESSION1] ON [GAM].[Session] ([UserGUID]);

DELETE FROM [GAM].[Session];

/* SEM TAREFA - JOSÉ */

USE MonitorPronto

UPDATE ParmMotorEmail
SET ParmMotorEmailSenha = 'oouxprcsmahozxhz'

/* TAREFA #20725 - JOSÉ */

--Rodar script em todos os clientes que irá ser atualizada a versão
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('MovContabilGrid', 'MovContabilGrid', 'Movimentação Contábil', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'MovContabilGrid', '', 11, 'CONTABIL', '', '/pronto/servlet/') --Mudar onde está 'pronto' conforme cliente

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'MovContabilGrid') --Verificar a unidade de negócio para modificar de '25' se for diferente da Pronto

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'MovContabilGrid') --Verificar a unidade de negócio para modificar de '25' se for diferente da Pronto

/* TAREFA #21686 - JOSÉ */

CREATE NONCLUSTERED INDEX [UVLRPAG14] ON [VLRPAG] (
      [VlpArbNum],
      [VlpArbLotNum],
      [VlpArbDetSeq],
      [TidCod]);

/* TAREFA #21735 - FELIPE */

ALTER view [dbo].[AgdRec01] as
select
AgdRc1Dta = v.VlrDtaPrvLiqAnt,
AgdRc1VlrDeb = sum( case when isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('D','S') and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ) ,
AgdRc1VlrCre = sum( case when isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('C','S') and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ),
AgdRc1VlrPrc = sum( case when isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('C','S') and isnull(MovTrnParQtd,'') >  1 then VlrVlrRec Else 0 end ),
AgdRc1VlrAju = sum( case when isnull(MovTrnCod,'') = 'AJ'then VlrVlrRec Else 0 end ),
AgdRc1VlrCan = sum( case when isnull(MovTrnCod,'') = 'CC'then VlrVlrRec Else 0 end ),
AgdRc1VlrOut = sum( case when isnull(MovTrnCod,'') = ''  then VlrVlrRec Else 0 end ),
AgdRc1VlrPix = sum( case when MovTrnTipPrd = 'P'  then VlrVlrRec Else 0 end )
from vlrrec v left join movtrn01 m on (m.movtrnid =  v.VlrMovTrnId ) where v.VlrStsRec not in (4,5)
group by v.VlrDtaPrvLiqAnt;


ALTER VIEW [dbo].[AgdRec02] as 
	select 
		AgdRc1Dta = v.VlrDtaPrvLiqAnt ,
		EstCod    = v.EstCod,
		AgdRc2VlrDeb = sum( case when isnull(MovTrnCod,'')IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('D','S') and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ) ,
		AgdRc2VlrCre = sum( case when isnull(MovTrnCod,'')IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('C','S') and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ),
		AgdRc2VlrPrc = sum( case when isnull(MovTrnCod,'')IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('C','S') and isnull(MovTrnParQtd,'') >  1 then VlrVlrRec Else 0 end ),
		AgdRc2VlrAju = sum( case when isnull(MovTrnCod,'')='AJ'then VlrVlrRec Else 0 end ),
		AgdRc2VlrCan = sum( case when isnull(MovTrnCod,'')='CC'then VlrVlrRec Else 0 end ),
		AgdRc2VlrOut = sum( case when isnull(MovTrnCod,'')=''  then VlrVlrRec Else 0 end ),
		AgdRc2VlrPix = sum( case when m.MovTrnTipPrd ='P'  then VlrVlrRec Else 0 end)
from vlrrec v left join movtrn01 m on (m.movtrnid =  v.VlrMovTrnId ) where v.VlrStsRec not in (4,5) 
	group by v.VlrDtaPrvLiqAnt , v.estcod;
		
CREATE view [dbo].[AgdRec03] as 
	select 
		AgdRc1Dta 		= v.VlrDtaPrvLiqAnt ,
		AdqCod	  		= m.AdqCod,
		AgdRc3VlrDeb 	= sum( case when isnull(MovTrnCod,'')IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('D','S') and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ),
		AgdRc3VlrCre 	= sum( case when isnull(MovTrnCod,'')IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('C','S') and isnull(MovTrnParQtd,'') <= 1 then VlrVlrRec Else 0 end ),
		AgdRc3VlrPrc 	= sum( case when isnull(MovTrnCod,'')IN ('CV','PS') and isnull(MovTrnTipPrd,'')in('C','S') and isnull(MovTrnParQtd,'') >  1 then VlrVlrRec Else 0 end ),
		AgdRc3VlrAju 	= sum( case when isnull(MovTrnCod,'')='AJ'then VlrVlrRec Else 0 end ),
		AgdRc3VlrCan 	= sum( case when isnull(MovTrnCod,'')='CC'then VlrVlrRec Else 0 end ),
		AgdRc3VlrOut 	= sum( case when isnull(MovTrnCod,'')=''  then VlrVlrRec Else 0 end ),
		AgdRc3VlrPix 	= sum( case when m.MovTrnTipPrd ='P'  then VlrVlrRec Else 0 end)
from vlrrec v inner join movtrn01 m on (m.movtrnid =  v.VlrMovTrnId ) 
inner join ADQ0001 a
on (a.AdqCod = m.AdqCod)
where v.VlrStsRec not in (4,5) 
group by v.VlrDtaPrvLiqAnt , m.AdqCod;

-- dbo.View0002 source

ALTER VIEW [dbo].[View0002]
AS
SELECT
dbo.VLRREC.VlrNumLan,
iif(dbo.MovTrn01.MovTrnId is null, 0, dbo.MovTrn01.MovTrnId) as 
'MovTrnId',
iif(dbo.MovTrn01.EstCod is null, 0, dbo.MovTrn01.EstCod) as 'EstCod',
iif(dbo.MovTrn01.MovTrnCod is null, '', dbo.MovTrn01.MovTrnCod) as 
'MovTrnCod',
iif(dbo.MovTrn01.MovTrnNsu is null, 0, dbo.MovTrn01.MovTrnNsu) as 
'MovTrnNsu',
iif(dbo.MovTrn01.MovTrnAutCod is null, 0, dbo.MovTrn01.MovTrnAutCod) as 'MovTrnAutCod',
isnull(dbo.MovTrn01.MovTrnAutCodStr,'') as MovTrnAutCodStr ,
iif(dbo.MovTrn01.MovTrnNsuMovOri is null, 0, 
dbo.MovTrn01.MovTrnNsuMovOri) as 'MovTrnNsuMovOri',
iif(dbo.MovTrn01.MovTrnDta is null, '01-01-1753', 
dbo.MovTrn01.MovTrnDta) as 'MovTrnDta',
iif(dbo.MovTrn01.MovTrnVlr is null, 0, dbo.MovTrn01.MovTrnVlr) as 
'MovTrnVlr',
iif(dbo.MovTrn01.MovTrnVlrLiqBemFac is null, 0, 
dbo.MovTrn01.MovTrnVlrLiqBemFac) as 'MovTrnVlrLiqBemFac',
iif(dbo.MovTrn01.MovTrnVlrLiqEst is null, 0, 
dbo.MovTrn01.MovTrnVlrLiqEst) as 'MovTrnVlrLiqEst',
iif(dbo.MovTrn01.MovTrnParQtd is null, 0, 
dbo.MovTrn01.MovTrnParQtd) as 'MovTrnParQtd',
iif(dbo.MovTrn01.MovTrnParVlr is null, 0, 
dbo.MovTrn01.MovTrnParVlr) as 'MovTrnParVlr',
iif(dbo.MovTrn01.MovTrnBfaVlrTxaAnt is null, 0, 
dbo.MovTrn01.MovTrnBfaVlrTxaAnt) as 'MovTrnBfaVlrTxaAnt',
iif(dbo.MovTrn01.MovTrnBfaVlrTarCre is null, 0, 
dbo.MovTrn01.MovTrnBfaVlrTarCre) as 'MovTrnBfaVlrTarCre',
iif(dbo.MovTrn01.MovTrnBfaVlrCusTrn is null, 0, 
dbo.MovTrn01.MovTrnBfaVlrCusTrn) as 'MovTrnBfaVlrCusTrn',
iif(dbo.MovTrn01.MovTrnBfaVlrTxaFin is null, 0, 
dbo.MovTrn01.MovTrnBfaVlrTxaFin) as 'MovTrnBfaVlrTxaFin',
iif(dbo.MovTrn01.MovTrnBfaVlrTxaAdm is null, 0, 
dbo.MovTrn01.MovTrnBfaVlrTxaAdm) as 'MovTrnBfaVlrTxaAdm',
iif(dbo.MovTrn01.MovTrnBfaVlrCusCap is null, 0, 
dbo.MovTrn01.MovTrnBfaVlrCusCap) as 'MovTrnBfaVlrCusCap',
iif(dbo.MovTrn01.MovTrnGbpVlrTxaAnt is null, 0, 
dbo.MovTrn01.MovTrnGbpVlrTxaAnt) as 'MovTrnGbpVlrTxaAnt',
iif(dbo.MovTrn01.MovTrnGbpVlrTxaInt is null, 0, 
dbo.MovTrn01.MovTrnGbpVlrTxaInt) as 'MovTrnGbpVlrTxaInt',
iif(dbo.MovTrn01.MovTrnGbpVlrTxaAdm is null, 0, 
dbo.MovTrn01.MovTrnGbpVlrTxaAdm) as 'MovTrnGbpVlrTxaAdm',
iif(dbo.MovTrn01.MovTrnTipPrd is null, '', 
dbo.MovTrn01.MovTrnTipPrd) as 'MovTrnTipPrd',
iif(dbo.VLRREC.VlrDtaPrvLiqAnt is null, '01-01-1753', 
dbo.VLRREC.VlrDtaPrvLiqAnt) as 'VlrDtaPrvLiqAnt',
iif(dbo.VLRREC.VlrVlrRec is null, 0, dbo.VLRREC.VlrVlrRec) as 
'VlrVlrRec',
iif(dbo.VLRREC.VlrDtaLiqBco is null, '01-01-1753', 
dbo.VLRREC.VlrDtaLiqBco) as 'VlrDtaLiqBco',
iif(dbo.VLRREC.VlrVlrLiqBco is null, 0, dbo.VLRREC.VlrVlrLiqBco) as 
'VlrVlrLiqBco',
iif(dbo.VLRREC.VlrStsRec is null, 0, dbo.VLRREC.VlrStsRec) as 
'VlrStsRec',
iif(dbo.VLRREC.VlrCcoRcc is null, 0, dbo.VLRREC.VlrCcoRcc) as 
'VlrCcoRcc',
iif(dbo.VLRREC.VlrAgeRcc is null, 0, dbo.VLRREC.VlrAgeRcc) as 
'VlrAgeRcc',
iif(dbo.VLRREC.VlrBcoRcc is null, 0, dbo.VLRREC.VlrBcoRcc) as 
'VlrBcoRcc',
iif(dbo.MovTrn01.MovTrnParIndBemFac is null, '', 
dbo.MovTrn01.MovTrnParIndBemFac) as 'MovTrnParIndBemFac' ,
BanCod = isnull( MovTrnBan , '' ) ,

PrvTrnMov = isnull(VlrNumMovPrv , 0 ) ,
PrvTrnReg = isnull(VlrNumRegPrv , 0 ) ,

LiqTrnMov = isnull(VlrNumMovLiq , 0 ) ,
LiqTrnReg = isnull(VlrNumRegLiq , 0 ) ,
CanTrnMov = isnull(VlrNumMovCan , 0 ) ,
CanTrnReg = isnull(VlrNumRegCan , 0 ) ,
MovTrnPacCod = isnull( MovTrnPacCod , 0 ),
AdqCod		= ADQ0001.AdqCod,
AdqNom		= ADQ0001.AdqNom,
VlrVlrBru	= VlrVlrBru,
VlrParNum	= VlrParNum
FROM
dbo.VLRREC
LEFT JOIN
dbo.MovTrn01 ON dbo.VLRREC.VlrMovTrnId = dbo.MovTrn01.MovTrnId
LEFT JOIN 
dbo.ADQ0001 ON dbo.ADQ0001.AdqCod = dbo.MovTrn01.AdqCod;

/* TAREFA #21834 */

--Script da base Retaguarda
DROP INDEX [UVAN042] ON [VAN04];

CREATE NONCLUSTERED INDEX [UVAN042] ON [VAN04] (
      [VanTrnDta],
      [VanTrnExpVerNova]);

--Script da base Monitoramento	  
INSERT INTO PARSIS
VALUES ('MNT_TRN_DATA', 'Hoje + D- á ser considerado no filtro da tabela VAN04', 'VA', 1, NULL, 'N', '2', 'ADM', '2023-05-04 16:32:00.000', NULL, NULL, 0);

INSERT INTO Variavel
VALUES (17, 'Data transação', 'A');

INSERT INTO VariavelOperador
VALUES (17, '=');

INSERT INTO VariavelOperador
VALUES (17, '<');

INSERT INTO VariavelOperador
VALUES (17, '<=');

INSERT INTO VariavelOperador
VALUES (17, '>');

INSERT INTO VariavelOperador
VALUES (17, '>=');

ALTER VIEW VwEcCartao AS
SELECT 
       NEWID()             AS 'VwEcCartao_Guid',
       TransacaoMonitorada AS 'VwEcCartao_TransacaoMonitorada',
	   TransacaoData       AS 'VwEcCartao_TransacaoData',
	   TransacaoEc         AS 'VwEcCartao_TransacaoEc',
	   TransacaoNumCar     AS 'VwEcCartao_TransacaoNumCar',
	   COUNT(*)            AS 'VwEcCartao_TransacaoQtd'
	   FROM TRANSACAO WITH(NOLOCK) 
WHERE TransacaoMonitorada = 0 AND TransacaotrnCod <> 'CC' AND TransacaoStatus <> 'Cancelada'
GROUP BY TransacaoMonitorada, 
         TransacaoData, 
		 TransacaoEc, 
		 TransacaoNumCar;
		 
ALTER VIEW VwEcCartaoValor AS
SELECT 
       NEWID()             AS 'VwEcCartaoValor_Guid',
       TransacaoMonitorada AS 'VwEcCartaoValor_TransacaoMonitorada',
	   TransacaoData       AS 'VwEcCartaoValor_TransacaoData',
	   TransacaoEc         AS 'VwEcCartaoValor_TransacaoEc',
	   TransacaoNumCar     AS 'VwEcCartaoValor_TransacaoNumCa',
	   TransacaoValor      AS 'VwEcCartaoValor_TransacaoValor',
	   COUNT(*)            AS 'VwEcCartaoValor_TransacaoQtd'
	   FROM TRANSACAO WITH(NOLOCK) 
WHERE TransacaoMonitorada = 0 AND TransacaotrnCod <> 'CC' AND TransacaoStatus <> 'Cancelada'
GROUP BY TransacaoMonitorada, 
         TransacaoData, 
		 TransacaoEc, 
		 TransacaoNumCar,
		 TransacaoValor;

/* TAREFA #21996 */

USE Pronto

INSERT INTO PARSIS
VALUES ('SALDOCONSOLIDA_EC', 'Intervalo de estabelecimentos para o robô SaldoConsolida, padrão parâmetro: EstCod-EstCod', 'VA', 3, NULL, 'N', '1-1', 'ADM', '2023-05-18 09:18:00.000', NULL, NULL, 0)