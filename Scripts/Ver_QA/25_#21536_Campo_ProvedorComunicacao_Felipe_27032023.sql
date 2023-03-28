CREATE TABLE [ProvedorCom] (
  [ProvedorComId]   SMALLINT    NOT NULL    IDENTITY ( 1 , 1 ),
  [ProvedorComNome] VARCHAR(60)    NOT NULL,
     PRIMARY KEY ( [ProvedorComId] ))
CREATE NONCLUSTERED INDEX [UPROVEDORCOM] ON [ProvedorCom] (
      [ProvedorComNome])

ALTER TABLE [POS]
ADD [GX_AUX] VARCHAR(60)    NOT NULL CONSTRAINT GX_AUXPOS_DEFAULT DEFAULT ''
ALTER TABLE [POS]
DROP CONSTRAINT GX_AUXPOS_DEFAULT
UPDATE [POS]
SET    [GX_AUX] = Rtrim([PosPrvCmn])
ALTER TABLE [POS]
DROP COLUMN [PosPrvCmn]
CALL sp_rename('[POS].GX_AUX', 'PosPrvCmn')


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