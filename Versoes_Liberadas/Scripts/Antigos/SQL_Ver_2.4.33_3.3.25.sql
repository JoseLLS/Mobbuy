/* TAREFA #19910 - JOSÉ */

CREATE NONCLUSTERED INDEX [UVLRPAG9] ON [VLRPAG] ( 
      [EstCod], 
      [VlpStspag], 
      [VlpDtaVct])

/* TAREFA #19938 - JOSÉ */

--Rodar o script em todos os clientes atualizados
INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('ProcessoGrid', 'ProcessoGrid', 'Processo', '', '', 0, 1, '')

SELECT * FROM sse2_mod

SELECT * FROM sse2_mnu02 ORDER BY MnuIteIdRoot, MnuIteOrd --SELECT para ver a ordenação (MnuIteOrd) que a tela vai ficar no menu no INSERT abaixo
--A ordenação é em ordem crescente

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'ProcessoGrid', '', 150, 'TAB_GER', '', '/pronto/servlet/') --Alterar "/cliente/servlet/"

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'ProcessoGrid') --Dar o SELECT de baixo na sse2_ung e pegar o UNG2Cod e alterar conforme o valor de cada cliente

SELECT * FROM sse2_ung

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'ProcessoGrid') --Dar o SELECT de cima na sse2_ung e pagar o UNG2Cod e alterar conforme o valor de cada cliente

---------------------------------------------------------------------------------------------------------------------------------

CREATE NONCLUSTERED INDEX [UPROCESSO1] ON [Processo] (
      [ProcessoDataInicial],
      [ProcessoDataFinal],
      [ProcessoStatus])

/* TAREFA #19955 - WESLEY */

ALTER TABLE [TrnPagSeg]
ALTER COLUMN [TrnPagSegCVCodigo] DECIMAL(18) NULL

/* SEM TAREFA - JOSÉ */

--Rodar script em todos os clientes atualizados com a versão
ALTER view [dbo].[AgdPag01] as
select
AgdPg1Dta = v.VlpDtaVct ,
AgdPg1VlrDeb	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='D' and isnull(MovTrnParQtd,'') <= 1 then VlpVlrPag Else 0 end ) ,
AgdPg1VlrCre	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') <= 1 then VlpVlrPag Else 0 end ),
AgdPg1VlrPrc	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'') IN ('CV','PS') and isnull(MovTrnTipPrd,'')='C' and isnull(MovTrnParQtd,'') >  1 then VlpVlrPag Else 0 end ),
AgdPg1VlrAju	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'')='AJ' then VlpVlrPag Else 0 end ),
AgdPg1VlrCan	= sum( case when v.TidCod=1 and isnull(MovTrnCod,'')='CC' then VlpVlrPag Else 0 end ),
AgdPg1VlrOut	= sum( case when v.TidCod>1 or  isnull(MovTrnCod,'')='AL'   then VlpVlrPag Else 0 end ),
AgdPg1VlrRee	= sum( case when v.VlpStspag=2                           then VlpVlrPag Else 0 end ),
AgdPg1VlrTotAbe = sum( case when v.VlpStspag=1                            then VlpVlrPag Else 0 end ),
AgdPg1VlrCom	= sum( case when v.TidCod=1 and isnull(MovTrnTipPrd,'')='S' then VlpVlrPag Else 0 end )
from VlrPag v left join movtrn01 m on (m.movtrnid =  v.VlpMovTrnId ) where v.VlpStspag not in (3,4)
group by v.VlpDtaVct
GO