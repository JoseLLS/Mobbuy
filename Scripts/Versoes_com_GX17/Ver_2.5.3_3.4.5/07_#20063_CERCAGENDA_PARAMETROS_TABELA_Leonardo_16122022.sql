CREATE TABLE [CercAgenda] (
  [CercAgendaId]             DECIMAL(10)    NOT NULL    IDENTITY ( 1 , 1 ),
  [CercAgendaTitular]        VARCHAR(14)    NULL,
  [CercAgendaDataVencimento] DATETIME    NULL,
  [CercAgendaArranjo]        VARCHAR(4)    NULL,
  [CercAgendaValor]          DECIMAL(17,2)    NULL,
  [CercAgendaDataInc]        DATETIME    NULL,
  [CercAgendaStatus]         BIT    NULL,
  [CercAgendaReferencia]     VARCHAR(40)    NULL,
     PRIMARY KEY ( [CercAgendaId] ))
CREATE UNIQUE NONCLUSTERED INDEX [UCERCAGENDACHAVE] ON [CercAgenda] (
      [CercAgendaTitular],
      [CercAgendaArranjo],
      [CercAgendaDataVencimento],
      [CercAgendaValor])
CREATE UNIQUE NONCLUSTERED INDEX [UCERCAGENDAREFERENCIA] ON [CercAgenda] (
      [CercAgendaReferencia])
	  
	  
INSERT INTO PARSIS (PARCOD, ParDsc, ParTipPar, ParTamPar, ParCon)
VALUES ('CERC_AGD_METODO', 'METODO CONSULTA AGENDA CERC', 'CA', 300, 'consultar?online=true')

INSERT INTO PARSIS (PARCOD, ParDsc, ParTipPar, ParTamPar, ParCon)
VALUES ('CERC_AGD_BASE_URL', 'BASE URL CONSULTA AGENDA CERC', 'CA', 300, '/v15/agenda/')

INSERT INTO PARSIS (PARCOD, ParDsc, ParTipPar, ParTamPar, ParCon)
VALUES ('CERC_AGD_DTA_INI', 'DATA INICIAL CONSULTA AGENDA', 'CA', 300, '2022-01-01')

INSERT INTO PARSIS (PARCOD, ParDsc, ParTipPar, ParTamPar, ParCon)
VALUES ('CERC_AGD_DTA_FIM', 'DATA FINAL CONSULTA AGENDA', 'CA', 300, '2022-06-20')

INSERT INTO PARSIS (PARCOD, ParDsc, ParTipPar, ParTamPar, ParCon)
VALUES ('CERC_AGD_TIPO_AVALIACAO', 'TIPO DE AVALIACAO AGENDA', 'CA', 300, 'avaliacao_agenda_completa_ap')

INSERT INTO PARSIS (PARCOD, ParDsc, ParTipPar, ParTamPar, ParCon)
VALUES ('CERC_AGD_ARQ_ESTCOD', 'CAMINHO ARQUIVO TXT ESTABELECIMENTOS', 'CA', 300, 'D:\temp\Estabelecimentos.txt')