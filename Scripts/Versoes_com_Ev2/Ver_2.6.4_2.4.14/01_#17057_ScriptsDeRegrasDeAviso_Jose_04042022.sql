/* TAREFA #17057 - JOSÉ */

--Clientes que irão usar os Scripts
USE BemFacil
USE Credinov
USE CredPag
USE Pronto

--Scripts

CREATE TABLE [AvisoRegra] (
  [AvisoRegraId]               INT     NOT NULL     IDENTITY ( 1 , 1 ),
  [AvisoRegraDescricao]        VARCHAR(40)     NULL,
  [AvisoRegraStatus]           BIT     NULL,
  [AvisoRegraUsuarioInclusao]  VARCHAR(40)     NULL,
  [AvisoRegraUsuarioAlteracao] VARCHAR(40)     NULL,
  [AvisoRegraDataInclusao]     DATETIME     NULL,
  [AvisoRegraDataAlteracao]    DATETIME     NULL,
      PRIMARY KEY ( [AvisoRegraId] ))

--------------------------------------------------------------------------------------

CREATE TABLE [AvisoRegraCondicao] (
  [AvisoRegraCondicaoId]     INT     NOT NULL     IDENTITY ( 1 , 1 ),
  [AvisoId]                  INT     NULL,
  [AvisoRegraCondicaoItem]   VARCHAR(40)     NULL,
  [AvisoRegraCondicaoStatus] BIT     NULL,
  [AvisoRegraCondicaoUsuInc] VARCHAR(40)     NULL,
  [AvisoRegraCondicaoUsuAlt] VARCHAR(40)     NULL,
  [AvisoRegraCondicaoDatInc] DATETIME     NULL,
  [AvisoRegraCondicaoDatAlt] DATETIME     NULL,
      PRIMARY KEY ( [AvisoRegraCondicaoId] ))

CREATE NONCLUSTERED INDEX [IAVISOREGRACONDICAO1] ON [AvisoRegraCondicao] (
      [AvisoId])

ALTER TABLE [AvisoRegraCondicao]
 ADD CONSTRAINT [IAVISOREGRACONDICAO1] FOREIGN KEY ( [AvisoId] ) REFERENCES [Aviso]([AvisoId])
 
--------------------------------------------------------------------------------------

ALTER TABLE [Aviso]
ADD [AvisoRegraId] INT     NULL

CREATE NONCLUSTERED INDEX [IAVISO1] ON [Aviso] (
      [AvisoRegraId])

ALTER TABLE [Aviso]
 ADD CONSTRAINT [IAVISO1] FOREIGN KEY ( [AvisoRegraId] ) REFERENCES [AvisoRegra]([AvisoRegraId])
 
 --------------------------------------------------------------------------------------
 
INSERT INTO AvisoRegra
VALUES ('Habilitado para todos', 1, 'ADMIN', NULL, '2022-04-02 11:53:00', NULL)

INSERT INTO AvisoRegra
VALUES ('Segmento', 1, 'ADMIN', NULL, '2022-04-02 11:53:00', NULL)

INSERT INTO AvisoRegra
VALUES ('Estado', 1, 'ADMIN', NULL, '2022-04-02 11:53:00', NULL)

INSERT INTO AvisoRegra
VALUES ('Estabelecimento', 1, 'ADMIN', NULL, '2022-04-02 11:53:00', NULL)