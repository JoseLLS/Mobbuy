use pronto
go

insert into parsis (ParCod, ParDsc, ParTipPar, ParTamPar, ParIndSin, ParCon)
values 
('DIRETORIO_RENDIMENTO', 'diretorio arquivo edi rendimento', 'CA', '255', 'N', '/mnt/home1/subadquirencia/')


INSERT INTO sse2_mod (MOD2Id, MOD2IdInt, MOD2Dsc, MOD2Url, MOD2MtdLib, MOD2Aux, MOD2Sts, Mod2LstSub)
VALUES ('TransacoesPix_IMP', 'TransacoesPix_IMP', 'Conciliação Rendimento', '', '', 0, 1, '')

INSERT INTO sse2_mnu02 (MnucOd, MnuIteModFlg, MnuIteIde, MnuIteDsc, MnuIteOrd, MnuIteIdRoot, MnuIteTxt, MnuItePth)
VALUES (10, 1, 'TransacoesPix_IMP', '', 160, 'PROC_EDI', '', '/pronto/servlet/') --Mudar onde está 'pronto' conforme cliente

INSERT INTO sse2_ung_mod (ung2cod, mod2id)
VALUES (25, 'TransacoesPix_IMP') --Verificar a unidade de negócio para modificar de '25' se for diferente da Pronto

INSERT INTO sse2_grp_mod
VALUES (25, 'CADASTROS', 'TransacoesPix_IMP') --Verificar a unidade de negócio para modificar de '25' se for diferente da Pronto
--CADASTROS

INSERT INTO sse2_grp_mod
VALUES (25, 'FINANCEIRO', 'TransacoesPix_IMP') --Verificar a unidade de negócio para modificar de '25' se for diferente da Pronto

INSERT INTO sse2_grp_mod
VALUES (25, 'ADM', 'TransacoesPix_IMP') --Verificar a unidade de negócio para modificar de '25' se for diferente da Pronto


CREATE TABLE [StatusConciliacao] (
  [StatusConciliacaoId]   INT    NOT NULL,
  [StatusConciliacaoDesc] VARCHAR(100)    NOT NULL,
     PRIMARY KEY ( [StatusConciliacaoId] ))

	 
CREATE TABLE [PixCon] (
  [PixConId]            DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [PixConNomeArq]       VARCHAR(150)    NOT NULL,
  [PixConDataInc]       DATETIME    NOT NULL,
  [PixConDataCon]       DATETIME    NULL,
  [StatusConciliacaoId] INT    NOT NULL,
     PRIMARY KEY ( [PixConId] ))
CREATE NONCLUSTERED INDEX [IPIXCON1] ON [PixCon] (
      [StatusConciliacaoId])
ALTER TABLE [PixCon]
 ADD CONSTRAINT [IPIXCON1] FOREIGN KEY ( [StatusConciliacaoId] ) REFERENCES [StatusConciliacao]([StatusConciliacaoId])

 
CREATE TABLE [Trn13] (
  [Trn13Id]             DECIMAL(18)    NOT NULL    IDENTITY ( 1 , 1 ),
  [Trn13NomeArq]        VARCHAR(100)    NOT NULL,
  [Trn13IdLancamento]   DECIMAL(10)    NOT NULL,
  [Trn13NumReg]         INT    NOT NULL,
  [Trn13DataTrn]        DATETIME    NOT NULL,
  [Trn13ValorTrn]       DECIMAL(15)    NOT NULL,
  [Trn13TipoLancamento] VARCHAR(1)    NOT NULL,
  [Trn13Documento]      VARCHAR(10)    NOT NULL,
  [Trn13Descricao]      VARCHAR(50)    NOT NULL,
  [Trn13Autenticacao]   VARCHAR(10)    NOT NULL,
  [Trn13DataInc]        DATETIME    NOT NULL,
  [PixConId]            DECIMAL(18)    NULL,
     PRIMARY KEY ( [Trn13Id] ))
CREATE NONCLUSTERED INDEX [ITRN17] ON [Trn13] (
      [PixConId])
ALTER TABLE [Trn13]
 ADD CONSTRAINT [ITRN17] FOREIGN KEY ( [PixConId] ) REFERENCES [PixCon]([PixConId])

 ALTER TABLE [Trn12]
ADD [PixConId] DECIMAL(18)    NULL
CREATE NONCLUSTERED INDEX [ITRN18] ON [Trn12] (
      [PixConId])
ALTER TABLE [Trn12]
 ADD CONSTRAINT [ITRN18] FOREIGN KEY ( [PixConId] ) REFERENCES [PixCon]([PixConId])