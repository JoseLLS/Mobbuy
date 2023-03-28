/* TAREFA #15186 - JOSÉ */

/* AUXILIAR CONTÁBIL */

--Quais bancos precisam do script abaixo
USE auxiliar_contabil

--Criação de Tabela AUXCTBLan
CREATE TABLE [AUXCTBLan] (
  [AUXCTBLanId]        DECIMAL(10)     NOT NULL     IDENTITY ( 1 , 1 ),
  [AUXCTBLanUngId]     SMALLINT     NOT NULL,
  [AUXCTBLanDtaMov]    DATETIME     NOT NULL,
  [AUXCTBLanCCDeb]     VARCHAR(20)     NOT NULL,
  [AUXCTBLanDscCCDeb]  VARCHAR(50)     NOT NULL,
  [AUXCTBLanCCCre]     VARCHAR(20)     NOT NULL,
  [AUXCTBLanDscCCCre]  VARCHAR(50)     NOT NULL,
  [AUXCTBLanNumOpe]    VARCHAR(20)     NOT NULL,
  [AUXCTBLanHistorico] VARCHAR(50)     NOT NULL,
  [AUXCTBLanDtaOpe]    DATETIME     NOT NULL,
  [AUXCTBLanValor]     DECIMAL(17,2)     NOT NULL,
  [AUXCTBLanEstCod]       INT     NOT NULL,
  [AUXCTBLanNomLoja]     VARCHAR(100)     NOT NULL,
      PRIMARY KEY ( [AUXCTBLanId] ))

/* PRONTO */

 --Quais bancos precisam do script abaixo
USE Pronto
 
 CREATE NONCLUSTERED INDEX [UMOVTRN014] ON [MovTrn01] (
      [MovTrnDta] DESC)

--Parâmetro do caminho de onde irá ser gerado o CSV de Lançamentos Auxiliar Contábil
INSERT INTO PARSIS
VALUES ('AUXCTBLancamento_CSV', 'Caminho de onde irá ser gerado o CSV de Lançamentos Auxiliar Contábil', 'VA', 200, NULL, 'N', 
'/mnt/home1/SubAdquirencia/025/contabil/', 'ADMIN', '2022-02-09 00:00:00:000', NULL, NULL, 0)