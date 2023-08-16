CREATE TABLE [ProvedorCom] (
  [ProvedorComId]   SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [ProvedorComNome] VARCHAR(60)    NOT NULL,
     PRIMARY KEY ( [ProvedorComId] ))
CREATE NONCLUSTERED INDEX [UPROVEDORCOM] ON [ProvedorCom] (
      [ProvedorComNome])

ALTER TABLE POS
ALTER COLUMN PosPrvCmn VARCHAR(60)

INSERT INTO Pronto.dbo.ProvedorCom
(ProvedorComNome)
VALUES('Vivo');

INSERT INTO Pronto.dbo.ProvedorCom
(ProvedorComNome)
VALUES('Claro');

INSERT INTO Pronto.dbo.ProvedorCom
(ProvedorComNome)
VALUES('Oi');

INSERT INTO Pronto.dbo.ProvedorCom
(ProvedorComNome)
VALUES('Algar');

INSERT INTO Pronto.dbo.ProvedorCom
(ProvedorComNome)
VALUES('Tim');