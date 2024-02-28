USE EstBank
ALTER TABLE [LancamentosBoaVista]
ADD [LanBoaVistaQuebraPar] BIT    NOT NULL CONSTRAINT LanBoaVistaQuebraParLancamentosBoaVista_DEFAULT DEFAULT Convert(BIT,0)
ALTER TABLE [LancamentosBoaVista]
DROP CONSTRAINT LanBoaVistaQuebraParLancamentosBoaVista_DEFAULT