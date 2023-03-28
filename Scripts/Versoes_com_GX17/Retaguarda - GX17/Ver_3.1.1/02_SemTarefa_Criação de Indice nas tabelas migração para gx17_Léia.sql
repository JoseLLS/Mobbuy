

	  
--Table name: TRN05	  
CREATE NONCLUSTERED INDEX [UTRN052] ON [TRN05] (
      [TrnBrsFecSeqArq],
      [TrnBrsOprSeqReg],
      [TrnBrsOprMovNsuCrr],
      [TrnBrsOprParNum])
CREATE NONCLUSTERED INDEX [UTRN054] ON [TRN05] (
      [TrnBrsFecSeqArq] DESC,
      [TrnBrsOprSeqReg] DESC,
      [TrnBrsOprMovNsuCrr],
      [TrnBrsOprParNum])
CREATE NONCLUSTERED INDEX [UTRN055] ON [TRN05] (
      [TrnBrsFecSeqArq],
      [TrnBrsOprSeqReg],
      [TrnBrsOprSitPrc])
	  
--Table name: TABVEN02
CREATE NONCLUSTERED INDEX [UTABVEN02] ON [TABVEN02] (
      [TavNum],
      [TavVigDtaIni] DESC)

--Table name: FchRes04
CREATE NONCLUSTERED INDEX [UFCHRES04] ON [FchRes04] (
      [FchResPacCod],
      [FchResDta])

--Table name: MovTrn01
CREATE NONCLUSTERED INDEX [UMOVTRN017] ON [MovTrn01] (
      [EstCod],
      [MovTrnDta])
	  
--Table name: REMMAN
CREATE NONCLUSTERED INDEX [UREMMAN2] ON [REMMAN] (
      [RemDtaEfe],
      [RemCodEst])

--Table name: VAN04	  
CREATE NONCLUSTERED INDEX [UVAN050] ON [VAN04] (
      [VanTrnRegSts],
      [EstCod],
      [VanTrnDta],
      [VanTrnHra])
	  
CREATE NONCLUSTERED INDEX [UVAN051] ON [VAN04] (
      [VanTrnPosNumSer])	  
	  
--Table name: VAN02	  

CREATE NONCLUSTERED INDEX [UVAN02] ON [VAN02] (
      [VanWbsDat] DESC,
      [VanWbsDsc],
      [VanWbsVlr],
      [VanWbsPosIde],
      [VanWbsNumCrt],
      [VanWbsAdqIde])
CREATE NONCLUSTERED INDEX [UVAN021] ON [VAN02] (
      [VanWbsDat] DESC,
      [VanWbsDsc],
      [VanWbsNsu],
      [VanWbsAtz])
	  
--Table name: ARQRET	  
CREATE NONCLUSTERED INDEX [UARQRET] ON [ARQRET] (
      [ArbNum],
      [ArbLotNum],
      [ArbDetSeq],
      [ArbRetSeq] DESC)
	  
--Table name: ARQDET
CREATE NONCLUSTERED INDEX [UARQDET3] ON [ARQDET] (
      [ArbDetDtaCre],
      [ArbDetEstCod])
	  
  CREATE NONCLUSTERED INDEX [UARQDET5] ON [ARQDET] (
  [ArbDetEstCod],
  [ArbDetCodSit])

--Table name: PLNVEN
CREATE NONCLUSTERED INDEX [UPLNVEN1] ON [PLNVEN] (
      [TavNum],
      [PlvTipPln],
      [PlvQtdPar])

--Table name: LOGCON
CREATE NONCLUSTERED INDEX [ULOGCON1] ON [LOGCON] (
      [LocDtaMov])
	  
--Table name: ADQ0001
CREATE NONCLUSTERED INDEX [UADQ00011] ON [ADQ0001] (
      [AdqNom])	  
	  
	  
-- Tabela de configuracao
CREATE TABLE [Configuracao] (
  [ConfigId]                INT    NOT NULL,
  [ConfigLimpezaDiariaData] DATETIME    NULL,
     PRIMARY KEY ( [ConfigId] ));

insert into Configuracao (ConfigId) VALUES (1);

-- Table name: TRN07
CREATE NONCLUSTERED INDEX [UTRN07] ON [TRN07] (
      [TrnBrsFecSeqArq] DESC,
      [TrnAntOprSeqReg] DESC,
      [TrnAntOprMovNsuCrr],
      [TrnAntOprParNum])

--Alteração na tabela de processo
ALTER TABLE [Processo]
ALTER COLUMN [ProcessoRotina] VARCHAR(250) NULL

--Table name: ADQ0004
CREATE NONCLUSTERED INDEX [UADQ0004] ON [ADQ0004] (
      [AdqCod],
      [AdqArqNum] DESC)
	  
	  
--Table name: TermoUsuario	  
CREATE NONCLUSTERED INDEX [UTERMOUSUARIO] ON [TermoUsuario] (
      [TermoUsuarioAceitoDtaHr] DESC)	  
	  
--Table name: Cessao	  
CREATE NONCLUSTERED INDEX [UCESSAO5] ON [Cessao] (
      [CessaoEstCodOri],
      [CessaoStatusId],
      [CessaoEstCodBen],
      [CessaoDtaLiq])	  
	  
-- Table name: EST05	  
CREATE NONCLUSTERED INDEX [UEST05] ON [EST05] (
[EstCod],
[EstRemTip])

-- Table name: MovTrn01
CREATE NONCLUSTERED INDEX [UMOVTRN019] ON [MovTrn01] (
      [MovTrnDta],
      [MovTrnVlr] DESC)
	  
	  
--Table name: SOLBOB
CREATE NONCLUSTERED INDEX [USOLBOB1] ON [SOLBOB] (
      [EstCod],
      [SobNumSol] DESC)

--Table name: CNTBAN
CREATE NONCLUSTERED INDEX [UCNTBAN1] ON [CNTBAN] (
      [CntSts])
	  
--Table name: REMBOB	  
CREATE NONCLUSTERED INDEX [UREMBOB] ON [REMBOB] (
      [EstCod],
      [RebNumSeq] DESC)